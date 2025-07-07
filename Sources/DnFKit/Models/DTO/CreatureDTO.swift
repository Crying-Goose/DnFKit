//
//  CreatureDTO.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - CreatureDTO
struct CreatureResponseDTO: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobId, jobGrowId, jobName, jobGrowName: String
    let fame: Int
    let adventureName, guildId, guildName: String
    let creature: CreatureClassDTO
}

// MARK: - CreatureClassDTO
struct CreatureClassDTO: Codable {
    let itemId, itemName, itemRarity: String
    let clone: CloneDTO
    let artifact: [ArtifactDTO]
}

// MARK: - ArtifactDTO
struct ArtifactDTO: Codable {
    let slotColor, itemId, itemName: String
    let itemAvailableLevel: Int
    let itemRarity: String
}
