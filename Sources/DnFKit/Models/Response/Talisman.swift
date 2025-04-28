//
//  Talisman.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - Talisman
struct Talisman: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobId, jobGrowId, jobName, jobGrowName: String
    let fame: Int
    let adventureName, guildId, guildName: String
    let talismans: [PurpleTalisman]
}

// MARK: - PurpleTalisman
struct PurpleTalisman: Codable {
    let talisman: RuneElement
    let runes: [RuneElement]
}

// MARK: - RuneElement
struct RuneElement: Codable {
    let slotNo: Int
    let itemId, itemName: String
}
