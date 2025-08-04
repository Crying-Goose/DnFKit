//
//  Avatar.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - Avatar
public struct AvatarResponseDTO: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobId, jobGrowId, jobName, jobGrowName: String
    let fame: Int?
    let adventureName, guildId, guildName: String?
    let avatar: [AvatarElementDTO]
}

// MARK: - AvatarElement
public struct AvatarElementDTO: Codable {
    let slotId, slotName, itemId, itemName: String
    let itemRarity: String
    let clone: CloneDTO
    let optionAbility: String?
    let emblems: [EmblemDTO]?
}

// MARK: - Clone
public struct CloneDTO: Codable {
    let itemId, itemName: String?
}

// MARK: - Emblem
public struct EmblemDTO: Codable {
    let slotNo: Int
    let slotColor, itemId, itemName: String
    let itemRarity: String
}
