//
//  Wallet.swift
//  HackathonProject
//
//  Created by Ksusha on 09.07.2022.
//

import Foundation

struct CreateWalletModel {
    let walletName: String
    let walletAddress: String
    let typeWallet: CreateWalletType
    
}

enum CreateWalletType {
    case normal
    case hd(mnemonics: [String])
}
