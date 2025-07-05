//
//  Avatar.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - Avatar
struct AvatarResponseDTO: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobId, jobGrowId, jobName, jobGrowName: String
    let fame: Int
    let adventureName, guildId, guildName: String
    let avatar: [AvatarElementDTO]
}

// MARK: - AvatarElement
struct AvatarElementDTO: Codable {
    let slotId, slotName, itemId, itemName: String
    let itemRarity: String
    let clone: CloneDTO
    let optionAbility: String?
    let emblems: [EmblemDTO]
}

// MARK: - Clone
struct CloneDTO: Codable {
    let itemId, itemName: String?
}

// MARK: - Emblem
struct EmblemDTO: Codable {
    let slotNo: Int
    let slotColor, itemId, itemName: String
    let itemRarity: String
}
