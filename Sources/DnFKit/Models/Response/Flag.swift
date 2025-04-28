//
//  Flag.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - Flag
struct Flag: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobID, jobGrowId, jobName, jobGrowName: String
    let fame: Int
    let adventureName, guildId, guildName: String
    let flag: FlagClass
}

// MARK: - FlagClass
struct FlagClass: Codable {
    let itemId, itemName, itemRarity: String
    let reinforce: Int
    let reinforceStatus: [ReinforceStatus]
    let gems: [Gem]
}

// MARK: - Gem
struct Gem: Codable {
    let slotNo: Int
    let itemId, itemName, itemRarity: String
}

// MARK: - ReinforceStatus
struct ReinforceStatus: Codable {
    let name: String
    let value: Double
}
