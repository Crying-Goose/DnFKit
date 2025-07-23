//
//  Item.swift
//  DnFKit
//
//  Created by 라주영 on 7/23/25.
//

import Foundation

public struct Item: Sendable {
    public let id: String
    public let name: String
    public let rarity: String
    public let type: String
    public let typeDetail: String
    
    init(dto: ItemDTO) {
        self.id = dto.itemId
        self.name = dto.itemName
        self.type = dto.itemType
        self.rarity = dto.itemRarity
        self.typeDetail = dto.itemTypeDetail
    }
}
