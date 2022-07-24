//
//  KeyStorageManager.swift
//  HackathonProject
//
//  Created by Ksusha on 16.07.2022.
//

//import Foundation
//import web3swift
//
//protocol KeyStorageManagerProtocol {
//    func exportAccount(wallet: RestoreWalletModel) throws -> ExportedType
//}
//
//final class KeyStorageManager: KeyStorageManagerProtocol {
//    
//    func exportAccount(wallet: RestoreWalletModel) throws -> ExportedType {
//        let keyStoreManager = try fetchKeyStoreManager(wallet: wallet)
//        guard let ethereumAddress = EthereumAddress(wallet.walletAddress)
//        else {
//            throw WalletInteractorError.errorRestoreWallet
//        }
//        let key = try keyStoreManager.UNSAFE_getPrivateKeyData(password: Constants.password, account: ethereumAddress).toHexString()
//        WalletDefaultsStorage.shared.savePrivateKey(key: key)
//        switch wallet.typeWallet {
//          case .normal:
//            return .privateKey(key: key)
//          case .hd(let mnemonics):
//            return .mnemonics(mnemonics: mnemonics, key: key)
//          }
//    }
//    
//    private func fetchKeyStoreManager(wallet: RestoreWalletModel) throws -> KeystoreManager {
//        switch wallet.typeWallet {
//        case .normal:
//            guard let keystore = EthereumKeystoreV3(wallet.data) else {
//                throw WalletInteractorError.errorRestoreWallet
//            }
//            return KeystoreManager([keystore])
//        case .hd:
//            guard let keystore = BIP32Keystore(wallet.data) else {
//                throw WalletInteractorError.errorRestoreWallet
//            }
//            return KeystoreManager([keystore])
//        }
//    }
//}
