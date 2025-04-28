//
//  Avatar.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - Avatar
struct AvatarResponse: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobId, jobGrowId, jobName, jobGrowName: String
    let fame: Int
    let adventureName, guildId, guildName: String
    let avatar: [AvatarElement]
}

// MARK: - AvatarElement
struct AvatarElement: Codable {
    let slotId, slotName, itemId, itemName: String
    let itemRarity: String
    let clone: Clone
    let optionAbility: String?
    let emblems: [Emblem]
}

// MARK: - Clone
struct Clone: Codable {
    let itemId, itemName: String?
}

// MARK: - Emblem
struct Emblem: Codable {
    let slotNo: Int
    let slotColor, itemId, itemName: String
    let itemRarity: String
}
