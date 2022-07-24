//
//  Model.swift
//  HackathonProject
//
//  Created by Ksusha on 20.07.2022.
//

import Foundation

struct NftDataModel: Codable {
    let data: NFTData
}

struct NFTData: Codable {
    let items: [NFTItem]
}

struct NFTItem: Codable {
    
    let contractName: String
    let contractAddress: String
    let nftData: [NFTDatum]?
    
    enum CodingKeys: String, CodingKey {
        case contractName = "contract_name"
        case contractAddress = "contract_address"
        case nftData = "nft_data"
    }
}

struct NFTDatum: Codable {
    let tokenID: String

    enum CodingKeys: String, CodingKey {
        case tokenID = "token_id"
    }
}

