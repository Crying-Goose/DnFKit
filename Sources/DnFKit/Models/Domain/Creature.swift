//
//  Creature.swift
//  DnFKit
//
//  Created by 라주영 on 7/11/25.
//

import Foundation

public struct Creature: Sendable {
    public let id: String
    public let name: String
    public let rarity: String
    public let clone: Clone
    public let artifact: [Artifact]
    
    init(dto: CreatureClassDTO) {
        self.id = dto.itemId
        self.name = dto.itemName
        self.rarity = dto.itemRarity
        self.clone = .init(dto: dto.clone)
        self.artifact = dto.artifact.map { .init(dto: $0) }
    }
}

public struct Artifact: Sendable {
    public let id: String
    public let name: String
    public let rarity: String
    public let color: String
    
    init(dto: ArtifactDTO) {
        self.id = dto.itemId
        self.name = dto.itemName
        self.rarity = dto.itemRarity
        self.color = dto.slotColor
    }
}
