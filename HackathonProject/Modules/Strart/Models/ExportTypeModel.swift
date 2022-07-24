//
//  ExportTypeModel.swift
//  HackathonProject
//
//  Created by Ksusha on 16.07.2022.
//

import Foundation

enum ExportedType {
    case privateKey(key: String)
    case mnemonics(mnemonics: [String], key: String)
}
