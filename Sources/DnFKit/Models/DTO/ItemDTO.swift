//
//  ItemDTO.swift
//  DnFKit
//
//  Created by 라주영 on 7/23/25.
//

import Foundation

// MARK: - ItemResponseDTO
public struct ItemResponseDTO: Codable {
    public let rows: [ItemDTO]
}

// MARK: - ItemDTO
public struct ItemDTO: Codable {
    let itemId, itemName, itemRarity: String
    let itemTypeId, itemType: String
    let itemTypeDetailId, itemTypeDetail: String
    let itemAvailableLevel: Int
    let fame: Int
}
