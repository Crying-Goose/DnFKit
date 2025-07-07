//
//  BuffEquipments.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - BuffEquipment
struct BuffEquipmentResponseDTO: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobId, jobGrowId, jobName, jobGrowName: String
    let fame: Int
    let adventureName, guildId, guildName: String
    let skill: BuffSkillDTO
}

// MARK: - BuffSkill
struct BuffSkillDTO: Codable {
    let buff: BuffStatisticsDTO
}

// MARK: - BuffStatistics
struct BuffStatisticsDTO: Codable {
    let skillInfo: SkillInfoDTO
    let equipment: [BuffEquipmentDTO]?
    let avatar: [BuffAvatarDTO]?
    let creature: [BuffCreatureDTO]?
}

// MARK: - BuffEquipment
struct BuffEquipmentDTO: Codable {
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
struct BuffAvatarDTO: Codable {
    let slotId, slotName, itemId, itemName: String
    let itemRarity: String
    let clone: CloneDTO
    let optionAbility: String
    let emblems: [EmblemDTO]
}

// MARK: - BuffCreature
struct BuffCreatureDTO: Codable {
    let itemId, itemName, itemRarity: String
    let enchant: BuffEnchantDTO
}

// MARK: - Enchant
struct BuffEnchantDTO: Codable {
    let reinforceSkill: [ReinforceSkillDTO]
}

// MARK: - ReinforceSkill
struct ReinforceSkillDTO: Codable {
    let jobId, jobName: String
    let skills: [SkillElementDTO]
}

// MARK: - SkillElement
struct SkillElementDTO: Codable {
    let skillId, name, value: String
}

// MARK: - SkillInfo
struct SkillInfoDTO: Codable {
    let skillId, name: String
    let option: BuffOptionDTO
}

// MARK: - BuffOption
struct BuffOptionDTO: Codable {
    let level: Int
    let desc: String
    let values: [String]
}
