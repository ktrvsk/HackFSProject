//
//  SendTokenPresenter.swift
//  HackathonProject
//
//  Created by Ksusha on 20.07.2022.
//

import Foundation
import Web3
import Web3PromiseKit
import Web3ContractABI

protocol SendTokenPresenterProtocol {
    var controller: SendTokenControllerProtocol? { get set }
    var web3: Web3 { get set }
//    func sendEth(toAddress: String, quantityЕth: String)
    func sendERC20Token(toAddress: String, quantityЕRC20Token: String)
    func getTokenContractAddress(with address: String)
}

class SendTokenPresenter: SendTokenPresenterProtocol {
    
// MARK: - Public propereties
    var controller: SendTokenControllerProtocol?
    var web3: Web3 = URLs.web3
    

// MARK: - Private propereties
    private let key = UserDefaults.standard.string(forKey: "privateKey")
    private var tokenContractAddress: String = ""
    
//MARK: Public method
    
//    func sendEth(toAddress: String, quantityЕth: String) {
//        guard let privateKey = try? EthereumPrivateKey(hexPrivateKey: key ?? "") else { return }
//        firstly {
//            web3.eth.getTransactionCount(address: privateKey.address , block: .latest)
//        }.then { nonce in
//            return try EthereumTransaction(
//                nonce: nonce,
//                gasPrice: EthereumQuantity(quantity: 21.gwei),
//                gas: 21000,
//                from: privateKey.address,
//                to: EthereumAddress(hex: toAddress, eip55: true),
//                value: EthereumQuantity(quantity: BigUInt(quantityЕth)) //как правильно конвертировать в валюту
//            ).sign(with: privateKey, chainId: 80001).promise
//        }.then { tx in
//            self.web3.eth.sendRawTransaction(transaction: tx)
//        }.done { hash in
//            print(hash)
//        }.catch { error in
//            print(error)
//        }
//    }
    
    func sendERC20Token(toAddress: String, quantityЕRC20Token: String) {
        let contractAddress = try? EthereumAddress(hex: tokenContractAddress, eip55: false)
        
       // toChecksumAddress(string)
        
        let contract = web3.eth.Contract(type: GenericERC20Contract.self, address: contractAddress)
        guard let privateKey = try? EthereumPrivateKey(hexPrivateKey: key ?? "") else { return }
        
        firstly {
            web3.eth.getTransactionCount(address: privateKey.address, block: .latest)
        }.then { nonce in
            try contract.transfer(to: EthereumAddress(hex: toAddress, eip55: true), value: BigUInt(quantityЕRC20Token)).createTransaction(
                nonce: nonce,
                from: privateKey.address,
                value: 0,
                gas: 100000,
                gasPrice: EthereumQuantity(quantity: 21.gwei)
            )!.sign(with: privateKey, chainId: Constants.chainId).promise
        }.then { tx in
            self.web3.eth.sendRawTransaction(transaction: tx)
        }.done { txHash in
            print(txHash)
        }.catch { error in
            print(error)
        }
    }
    
    func getTokenContractAddress(with address: String) {
        tokenContractAddress = address
    }
}
