//
//  Buff.swift
//  DnFKit
//
//  Created by 라주영 on 7/21/25.
//

import Foundation

public struct Buff: Sendable {
    public let id: String
    public let name: String
    public let type: String
    public let typeDetail: String
    public let rarity: String
    public let emblem: [Emblem]
    
    init(equipmentDto dto: BuffEquipmentDTO) {
        self.id = dto.itemId
        self.name = dto.itemName
        self.type = dto.itemType
        self.typeDetail = dto.itemTypeDetail
        self.rarity = dto.itemRarity
        self.emblem = []
    }
    
    init(avatarDto dto: BuffAvatarDTO) {
        self.id = dto.itemId
        self.name = dto.itemName
        self.rarity = dto.itemRarity
        self.type = ""
        self.typeDetail = ""
        self.emblem = dto.emblems.map { .init(dto: $0) }
    }
    
    init(creatureDto dto: BuffCreatureDTO) {
        self.id = dto.itemId
        self.name = dto.itemName
        self.rarity = dto.itemRarity
        self.type = ""
        self.typeDetail = ""
        self.emblem = []
    }
}
