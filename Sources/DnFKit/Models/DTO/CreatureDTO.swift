//
//  CreatureDTO.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - CreatureDTO
public struct CreatureResponseDTO: Codable {
    public let serverId, characterId, characterName: String
    public let level: Int
    public let jobId, jobGrowId, jobName, jobGrowName: String
    public let fame: Int
    public let adventureName, guildId, guildName: String?
    public let creature: CreatureClassDTO
}

// MARK: - CreatureClassDTO
public struct CreatureClassDTO: Codable {
    public let itemId, itemName, itemRarity: String
    public let clone: CloneDTO
    public let artifact: [ArtifactDTO]
}

// MARK: - ArtifactDTO
public struct ArtifactDTO: Codable {
    public let slotColor, itemId, itemName: String
    public let itemAvailableLevel: Int
    public let itemRarity: String
}
