//
//  RestoreWalletPresenter.swift
//  HackathonProject
//
//  Created by Ksusha on 10.07.2022.
//

import Foundation
import web3swift

protocol RestoreWalletPresenterProtocol {
    var controller: RestoreWalletControllerProtocol? { get set }
    func restoreWalletByMnemonic(by mnemonics: [String]) throws -> RestoreWalletModel
}

final class RestoreWalletPresenter: RestoreWalletPresenterProtocol {

//MARK: - Properties
    var controller: RestoreWalletControllerProtocol?

//MARK: - Public method
    func restoreWalletByMnemonic(by mnemonics: [String]) throws -> RestoreWalletModel {
        
        let mnemonicsString = mnemonics.joined(separator: " ")
        
        guard let keystore = try BIP32Keystore(mnemonics: mnemonicsString,
                                               mnemonicsPassword: "",
                                               language: .english,
                                               prefixPath: HDNode.defaultPathMetamaskPrefix,
                                               aesMode: "aes-128-cbc")
        else {
            throw WalletInteractorError.errorRestoreWallet
        }
        
        guard let publicAddress = keystore.addresses?.first?.address
        else {
            throw WalletInteractorError.errorRestoreWallet
        }

        let keyData = try JSONEncoder().encode(keystore.keystoreParams)
        
        let restoreWallet = RestoreWalletModel(walletAddress: publicAddress, typeWallet: .hd(mnemonics: mnemonics), data: keyData)
        WalletDefaultsStorage.shared.saveDataRestoreWallet(data: restoreWallet)
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
