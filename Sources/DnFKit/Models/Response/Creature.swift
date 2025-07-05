//
//  Creature.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - Creature
struct Creature: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobId, jobGrowId, jobName, jobGrowName: String
    let fame: Int
    let adventureName, guildId, guildName: String
    let creature: CreatureClass
}

// MARK: - CreatureClass
struct CreatureClass: Codable {
    let itemId, itemName, itemRarity: String
    let clone: CloneDTO
    let artifact: [Artifact]
}

// MARK: - Artifact
struct Artifact: Codable {
    let slotColor, itemId, itemName: String
    let itemAvailableLevel: Int
    let itemRarity: String
}
