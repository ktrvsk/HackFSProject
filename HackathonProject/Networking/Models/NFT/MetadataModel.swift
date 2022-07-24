//
//  ERC721TokenModel.swift
//  HackathonProject
//
//  Created by Ksusha on 16.07.2022.
//

import Foundation

struct Welcome: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let items: [Item]
}

struct Item: Codable {
    let nftData: [NftDatum]
    
    enum CodingKeys: String, CodingKey {
        case nftData = "nft_data"
    }
}

struct NftDatum: Codable {
    let externalData: ExternalData
    
    enum CodingKeys: String, CodingKey {
        case externalData = "external_data"
        
    }
}

struct ExternalData: Codable {
    let image512: String
    
    enum CodingKeys: String, CodingKey {
        case image512 = "image_512"
    }
}
