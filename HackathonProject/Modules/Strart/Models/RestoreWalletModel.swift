//
//  TestModel.swift
//  HackathonProject
//
//  Created by Ksusha on 10.07.2022.
//

import Foundation

struct RestoreWalletModel {
    let walletAddress: String
    let typeWallet: RestoreWalletType
    let data: Data
    
}

enum RestoreWalletType {
    case normal
    case hd(mnemonics: [String])
}
