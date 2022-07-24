//
//  WalletDefaults.swift
//  HackathonProject
//
//  Created by Ksusha on 09.07.2022.
//

import Foundation

protocol WalletDefaultsStorageProtocol {
    func saveDataCreateWallet(data: CreateWalletModel)
}

final class WalletDefaultsStorage: WalletDefaultsStorageProtocol {
    
    static var shared =  WalletDefaultsStorage()

      private init() {}
    
    private var standard = UserDefaults.standard

    func saveDataCreateWallet(data: CreateWalletModel) {
        standard.set(data.walletAddress, forKey: "walletAddress")
    }
    
    func saveDataRestoreWallet(data: RestoreWalletModel) {
        standard.set(data.walletAddress, forKey: "walletAddress")
    }
    
    func savePrivateKey(key: String) {
        standard.set(key, forKey: "privateKey")
    }
    
    func saveMnemonicPhrase(data: [String]) {
        standard.set(data, forKey: "mnemonicPhrase")
    }
}
