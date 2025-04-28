//
//  BuffEquipments.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - BuffEquipment
struct BuffEquipments: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobId, jobGrowId, jobName, jobGrowName: String
    let fame: Int
    let adventureName, guildId, guildName: String
    let skill: BuffSkill
}

// MARK: - BuffSkill
struct BuffSkill: Codable {
    let buff: BuffStatistics
}

// MARK: - BuffStatistics
struct BuffStatistics: Codable {
    let skillInfo: SkillInfo
    let equipment: [BuffEquipment]?
    let avatar: [BuffAvatar]?
    let creature: [BuffCreature]?
}

// MARK: - BuffEquipment
struct BuffEquipment: Codable {
    let slotId, slotName, itemId, itemName: String
    let itemTypeId, itemType, itemTypeDetailId, itemTypeDetail: String
    let itemAvailableLevel: Int
    let itemRarity: String
    let setItemId, setItemName: String?
    let reinforce: Int
    let amplificationName: String?
    let refine: Int
}

// MARK: - BuffAvatar
struct BuffAvatar: Codable {
    let slotId, slotName, itemId, itemName: String
    let itemRarity: String
    let clone: Clone
    let optionAbility: String
    let emblems: [Emblem]
}

// MARK: - BuffCreature
struct BuffCreature: Codable {
    let itemId, itemName, itemRarity: String
    let enchant: BuffEnchant
}

// MARK: - Enchant
struct BuffEnchant: Codable {
    let reinforceSkill: [ReinforceSkill]
}

// MARK: - ReinforceSkill
struct ReinforceSkill: Codable {
    let jobId, jobName: String
    let skills: [SkillElement]
}

// MARK: - SkillElement
struct SkillElement: Codable {
    let skillId, name, value: String
}

// MARK: - SkillInfo
struct SkillInfo: Codable {
    let skillId, name: String
    let option: BuffOption
}

// MARK: - BuffOption
struct BuffOption: Codable {
    let level: Int
    let desc: String
    let values: [String]
}
