//
//  BalanceWalletModel.swift
//  HackathonProject
//
//  Created by Ksusha on 18.07.2022.
//

import Foundation

struct TokenDataModel: Codable {
    let data: DataClassBalance
}

struct DataClassBalance: Codable {
    let items: [ItemBalance]
}

struct ItemBalance: Codable {
    let contractAddress: String
    let contractName: String
    let balance: String
    
    enum CodingKeys: String, CodingKey {
        case contractName = "contract_name"
        case contractAddress = "contract_address"
        case balance
    }
}
