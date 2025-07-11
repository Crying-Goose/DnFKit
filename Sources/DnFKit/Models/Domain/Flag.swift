//
//  Flag.swift
//  DnFKit
//
//  Created by 라주영 on 7/11/25.
//

import Foundation

public struct Flag: Sendable {
    public let id: String
    public let name: String
    public let reinforce: Int
    public let status: [StatusInfo]
    public let gems: [Gem]
    
    init(dto: FlagClassDTO) {
        self.id = dto.itemId
        self.name = dto.itemName
        self.reinforce = dto.reinforce
        self.status = dto.reinforceStatus.map { .init(dto: $0) }
        self.gems = dto.gems.map { .init(dto: $0) }
    }
}

public struct Gem: Sendable {
    public let slotNo: Int
    public let id: String
    public let name: String
    public let rarity: String
    
    init(dto: GemDTO) {
        self.slotNo = dto.slotNo
        self.id = dto.itemId
        self.name = dto.itemName
        self.rarity = dto.itemRarity
    }
}
