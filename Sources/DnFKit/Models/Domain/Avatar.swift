//
//  Avatar.swift
//  DnFKit
//
//  Created by 라주영 on 7/11/25.
//

import Foundation

public struct Avatar: Sendable {
    public let slotId: String
    public let id: String
    public let name: String
    public let rarity: String
    public let option: String?
    public let clone: Clone
    public let emblems: [Emblem]
    
    init(dto: AvatarElementDTO) {
        self.slotId = dto.slotId
        self.id = dto.itemId
        self.name = dto.itemName
        self.rarity = dto.itemRarity
        self.option = dto.optionAbility
        self.clone = .init(dto: dto.clone)
        self.emblems = dto.emblems?.compactMap { .init(dto: $0) } ?? []
    }
}

public struct Clone: Sendable {
    public let id: String
    public let name: String
    
    init(dto: CloneDTO) {
        self.id = dto.itemId ?? ""
        self.name = dto.itemName ?? ""
    }
}

public struct Emblem: Sendable {
    let slotNo: Int
    let id: String
    let name: String
    let rarity: String
    
    init(dto: EmblemDTO) {
        self.slotNo = dto.slotNo
        self.id = dto.itemId
        self.name = dto.itemName
        self.rarity = dto.itemRarity
    }
}
