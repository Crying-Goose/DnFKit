//
//  BuffEquipments.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - BuffEquipment
public struct BuffEquipmentResponseDTO: Codable {
    public let serverId, characterId, characterName: String
    public let level: Int
    public let jobId, jobGrowId, jobName, jobGrowName: String
    public let fame: Int
    public let adventureName, guildId, guildName: String
    public let skill: BuffSkillDTO
}

// MARK: - BuffSkill
public struct BuffSkillDTO: Codable {
    public let buff: BuffStatisticsDTO
}

// MARK: - BuffStatistics
public struct BuffStatisticsDTO: Codable {
    public let skillInfo: SkillInfoDTO
    public let equipment: [BuffEquipmentDTO]?
    public let avatar: [BuffAvatarDTO]?
    public let creature: [BuffCreatureDTO]?
}

// MARK: - BuffEquipment
public struct BuffEquipmentDTO: Codable {
    public let slotId, slotName, itemId, itemName: String
    public let itemTypeId, itemType, itemTypeDetailId, itemTypeDetail: String
    public let itemAvailableLevel: Int
    public let itemRarity: String
    public let setItemId, setItemName: String?
    public let reinforce: Int
    public let amplificationName: String?
    public let refine: Int
}

// MARK: - BuffAvatar
public struct BuffAvatarDTO: Codable {
    public let slotId, slotName, itemId, itemName: String
    public let itemRarity: String
    public let clone: CloneDTO
    public let optionAbility: String
    public let emblems: [EmblemDTO]
}

// MARK: - BuffCreature
public struct BuffCreatureDTO: Codable {
    public let itemId, itemName, itemRarity: String
    public let enchant: BuffEnchantDTO
}

// MARK: - Enchant
public struct BuffEnchantDTO: Codable {
    public let reinforceSkill: [ReinforceSkillDTO]
}

// MARK: - ReinforceSkill
public struct ReinforceSkillDTO: Codable {
    public let jobId, jobName: String
    public let skills: [SkillElementDTO]
}

// MARK: - SkillElement
public struct SkillElementDTO: Codable {
    public let skillId, name, value: String
}

// MARK: - SkillInfo
public struct SkillInfoDTO: Codable {
    public let skillId, name: String
    public let option: BuffOptionDTO
}

// MARK: - BuffOption
public struct BuffOptionDTO: Codable {
    public let level: Int
    public let desc: String
    public let values: [String]
}
