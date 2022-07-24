//
//  Errors.swift
//  HackathonProject
//
//  Created by Ksusha on 09.07.2022.
//

import Foundation

enum WalletInteractorError: Error {
    case errorCreateWallet
    case errorRestoreWallet
}

extension WalletInteractorError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .errorCreateWallet:
            return "Error while creating wallet!"
        case .errorRestoreWallet:
            return "Error while restore wallet!"
        }
    }
}


