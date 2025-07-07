//
//  Flag.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - FlagResponseDTO
struct FlagResponseDTO: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobID, jobGrowId, jobName, jobGrowName: String
    let fame: Int
    let adventureName, guildId, guildName: String
    let flag: FlagClassDTO
}

// MARK: - FlagClassDTO
struct FlagClassDTO: Codable {
    let itemId, itemName, itemRarity: String
    let reinforce: Int
    let reinforceStatus: [ReinforceStatusDTO]
    let gems: [GemDTO]
}

// MARK: - GemDTO
struct GemDTO: Codable {
    let slotNo: Int
    let itemId, itemName, itemRarity: String
}

// MARK: - ReinforceStatusDTO
struct ReinforceStatusDTO: Codable {
    let name: String
    let value: Double
}
