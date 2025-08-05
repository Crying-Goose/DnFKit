//
//  Buff.swift
//  DnFKit
//
//  Created by 라주영 on 7/21/25.
//

import Foundation

public struct Buff: Sendable {
    public let id: String
    public let name: String
    public let type: String
    public let typeDetail: String
    public let rarity: String
    public let optionAbility: String
    public let emblem: [Emblem]
    public let buffSkill: [ReinforceSkill]
    public var optionString: String
    
    init(equipmentDto dto: BuffEquipmentDTO) {
        self.id = dto.itemId
        self.name = dto.itemName
        self.type = dto.itemType
        self.typeDetail = dto.itemTypeDetail
        self.rarity = dto.itemRarity
        self.optionAbility = ""
        self.buffSkill = dto.enchant?.reinforceSkill?.compactMap { .init(dto: $0) } ?? []
        self.emblem = []
        self.optionString = ""
    }
    
    init(avatarDto dto: BuffAvatarDTO) {
        self.id = dto.itemId
        self.name = dto.itemName
        self.rarity = dto.itemRarity
        self.optionAbility = dto.optionAbility ?? ""
        self.emblem = dto.emblems?.compactMap { .init(dto: $0) } ?? []
        self.type = ""
        self.typeDetail = ""
        self.buffSkill = []
        self.optionString = ""
    }
    
    init(creatureDto dto: BuffCreatureDTO) {
        self.id = dto.itemId
        self.name = dto.itemName
        self.rarity = dto.itemRarity
        self.buffSkill = dto.enchant?.reinforceSkill?.compactMap { .init(dto: $0) } ?? []
        self.type = ""
        self.typeDetail = ""
        self.optionAbility = ""
        self.emblem = []
        self.optionString = ""
    }
    
    func with(optionString: String) -> Buff {
        var copy = self
        copy.optionString = optionString
        return copy
    }
}

public struct ReinforceSkill: Sendable {
    public let jobId: String
    public let jobName: String
    public let skills: [BuffSkill]
    
    init(dto: ReinforceSkillDTO) {
        self.jobId = dto.jobId
        self.jobName = dto.jobName
        self.skills = dto.skills.map { .init(dto: $0) }
    }
}

public struct BuffSkill: Sendable {
    public let skillId: String
    public let name: String
    public let value: Double
    
    init(dto: SkillElementDTO) {
        self.skillId = dto.skillId
        self.name = dto.name
        self.value = dto.value.doubleValue
    }
}
