//
//  RestoreWalletByKeyPresenter.swift
//  HackathonProject
//
//  Created by Ksusha on 22.07.2022.
//

import Foundation
import web3swift

protocol RestoreWalletByKeyPresenterProtocol {
    var controller: RestoreWalletByKeyControllerProtocol? { get set }
    func restoreWalletByPrivateKey(by privateKey: String) throws -> RestoreWalletModel
}

class RestoreWalletByKeyPresenter: RestoreWalletByKeyPresenterProtocol {
    
    var controller: RestoreWalletByKeyControllerProtocol?
    
    func restoreWalletByPrivateKey(by key: String) throws -> RestoreWalletModel {
        let formattedKey = key.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard let dataKey = Data.fromHex(formattedKey),
              let keystore = try EthereumKeystoreV3(privateKey: dataKey,
                                                    password: Constants.password)
        else {
            throw WalletInteractorError.errorRestoreWallet
            
        }
        guard let address = keystore.addresses?.first?.address
                
        else {
            throw WalletInteractorError.errorRestoreWallet
        }
        let keyData = try JSONEncoder().encode(keystore.keystoreParams)
        
        let restoreWallet = RestoreWalletModel(walletAddress: address, typeWallet: .normal, data: keyData)
        try exportAccount(wallet: restoreWallet)
        
        DispatchQueue.main.async {
            self.controller?.openNext()
        }
        
        return restoreWallet
    }
    
    //MARK: - Private method
    func exportAccount(wallet: RestoreWalletModel) throws -> ExportedType {
        let keyStoreManager = try fetchKeyStoreManager(wallet: wallet)
        guard let ethereumAddress = EthereumAddress(wallet.walletAddress)
        else {
            throw WalletInteractorError.errorRestoreWallet
        }
        let key = try keyStoreManager.UNSAFE_getPrivateKeyData(password: Constants.password, account: ethereumAddress).toHexString()
        WalletDefaultsStorage.shared.savePrivateKey(key: key)
        switch wallet.typeWallet {
        case .normal:
            return .privateKey(key: key)
        case .hd(let mnemonics):
            WalletDefaultsStorage.shared.saveMnemonicPhrase(data: mnemonics)
            return .mnemonics(mnemonics: mnemonics, key: key)
        }
    }
    
    func fetchKeyStoreManager(wallet: RestoreWalletModel) throws -> KeystoreManager {
        switch wallet.typeWallet {
        case .normal:
            guard let keystore = EthereumKeystoreV3(wallet.data) else {
                throw WalletInteractorError.errorRestoreWallet
            }
            return KeystoreManager([keystore])
        case .hd:
            guard let keystore = BIP32Keystore(wallet.data) else {
                throw WalletInteractorError.errorRestoreWallet
            }
            return KeystoreManager([keystore])
        }
    }
}
