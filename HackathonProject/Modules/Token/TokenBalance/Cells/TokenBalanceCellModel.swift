//
//  BalanceModel.swift
//  HackathonProject
//
//  Created by Ksusha on 18.07.2022.
//

import Foundation
import BigInt

struct TokenBalanceCellModel {
    let nameToken: String
    let balance: String
    
    let actionHandler: () -> Void
}
