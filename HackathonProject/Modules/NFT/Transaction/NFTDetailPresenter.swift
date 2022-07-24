//
//  NFTDetailPresenter.swift
//  HackathonProject
//
//  Created by Ksusha on 21.07.2022.
//

import Foundation
import Web3
import Web3PromiseKit
import Web3ContractABI

protocol NFTDetailPresenterProtocol {
    func sendERC721Token(toAddres: String)
    func getNftContractAddress(with address: String)
    var controller: NFTDetailControllerProtocol? { get set }
    var web3: Web3 { get set }
}

class NFTDetailPresenter: NFTDetailPresenterProtocol {

// MARK: - Public propereties
    var controller: NFTDetailControllerProtocol?
    var web3 = URLs.web3
    
// MARK: - Private propereties
    private let key = UserDefaults.standard.string(forKey: "privateKey")
    private var tokenContractAddress: String = ""
    
// MARK: - Public method
    
    func sendERC721Token(toAddres: String) {
        let contractAddress = try? EthereumAddress(hex: tokenContractAddress, eip55: true)
        let contract = web3.eth.Contract(type: GenericERC721Contract.self, address: contractAddress)
        guard let privateKey = try? EthereumPrivateKey(hexPrivateKey: key ?? "") else { return }
        
        firstly {
            web3.eth.getTransactionCount(address: privateKey.address, block: .latest)
        }.then { nonce in
            try contract.transfer(to: EthereumAddress(hex: toAddres, eip55: true), tokenId: 37).createTransaction(
                nonce: nonce,
                from: privateKey.address,
                value: 1,
                gas: 100000,
                gasPrice: EthereumQuantity(quantity: 21.gwei)
            )!.sign(with: privateKey, chainId: 80001).promise
        }.then { tx in
            self.web3.eth.sendRawTransaction(transaction: tx)
        }.done { txHash in
            print(txHash)
        }.catch { error in
            print(error)
        }
    }
    
    func getNftContractAddress(with address: String) {
        tokenContractAddress = address
    }
}
