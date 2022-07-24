//
//  WalletInteractor.swift
//  HackathonProject
//
//  Created by Ksusha on 09.07.2022.
//

import web3swift
import Foundation

protocol CreateWalletPresenterProtocol {
    var controller: CreateWalletControllerProtocol? { get set }
    func createWallet(name: String) throws -> CreateWalletModel
}

class CreateWalletPresenter: CreateWalletPresenterProtocol {
    
    var controller: CreateWalletControllerProtocol?
    
    func createWallet(name: String) throws -> CreateWalletModel {
        guard let mnemonicsString = try BIP39.generateMnemonics(bitsOfEntropy: 128)
        else {
            throw Web3Error.keystoreError(err: .noEntropyError)
        }
        
        guard let keystore = try BIP32Keystore(mnemonics: mnemonicsString,
                                               password: Constants.password,
                                               mnemonicsPassword: "",
                                               language: .english,
                                               prefixPath: HDNode.defaultPathMetamaskPrefix,
                                               aesMode: "aes-128-cbc")
        else {
            throw WalletInteractorError.errorCreateWallet
        }
    
        guard let address = keystore.addresses?.first?.address else {
            throw WalletInteractorError.errorCreateWallet
        }
        
        let mnemonics = mnemonicsString.split(separator: " ").map(String.init)
        WalletDefaultsStorage.shared.saveMnemonicPhrase(data: mnemonics)
        
        let createWallet = CreateWalletModel(walletName: name, walletAddress: address, typeWallet: .hd(mnemonics: mnemonics))
        WalletDefaultsStorage.shared.saveDataCreateWallet(data: createWallet)
        DispatchQueue.main.async {
            self.controller?.openNext()
        }
        
        return createWallet
    }
}

