//
//  Equipment.swift
//  DnFKit
//
//  Created by 라주영 on 7/11/25.
//

import Foundation

public struct Equipments: Sendable {
    public var equipments: [Equipment]
    public let setItemInfo: SetItemInfo?
    
    func with(equipments: [Equipment]) -> Equipments {
        var copy = self
        copy.equipments = equipments
        return copy
    }
}

public struct Equipment: Sendable {
    public let id: String
    public let name: String
    public let type: String
    public let typeDetail: String
    public let rarity: String
    public let availableLevel: Int
    public let refine: Int          // 재련
    public let reinforce: Int       // 증폭 or 강화
    public let enchant: [StatusInfo]
    public let skillEnchant: [StatusInfo]
    public var enchantString: String
    public let amplificationName: String
    public let tune: [Tune]
    public let fusionOption: [FusionOption]
    public let upgradeInfo: UpgradeInfo?
    
    init(dto: EquipmentElementDTO, jobId: String) {
        self.id = dto.itemId
        self.name = dto.itemName
        self.type = dto.itemType
        self.typeDetail = dto.itemTypeDetail
        self.rarity = dto.itemRarity
        self.availableLevel = dto.itemAvailableLevel
        self.refine = dto.refine
        self.reinforce = dto.reinforce
        self.enchant = dto.enchant?.status.compactMap { .init(dto: $0) } ?? []
        var skillEnchant: [StatusInfo] = []
        if let reinforceSkills = dto.enchant?.reinforceSkill {
            reinforceSkills.forEach { skill in
                if (skill.jobId == jobId) {
                    skillEnchant = skill.skills.map { .init(name: $0.name, value: $0.value.doubleValue) }
                }
            }
        }
        self.skillEnchant = skillEnchant
        self.enchantString = ""
        self.amplificationName = dto.amplificationName ?? ""
        self.tune = dto.tune?.compactMap { .init(dto: $0) } ?? []
        self.fusionOption = dto.fusionOption?.options.compactMap { .init(dto: $0) } ?? []
        self.upgradeInfo = dto.upgradeInfo.map { .init(dto: $0) }
    }
    
    func with(enchantString: String) -> Equipment {
        var copy = self
        copy.enchantString = enchantString
        return copy
    }
}

public struct Tune: Sendable {
    public let level: Int?
    public let setPoint: Int
    public let status: [StatusInfo]
    
    init(dto:TuneDTO) {
        self.level = dto.level
        self.setPoint = dto.setPoint ?? 0
        var status: [StatusInfo] = []
        dto.status?.forEach { status.append(.init(dto: $0)) }
        self.status = status
    }
}

public struct FusionOption: Sendable {
    public let buffStat: Int
    public let explain: String
    
    init(dto: OptionDTO) {
        self.buffStat = dto.buff ?? 0
        self.explain = dto.explain ?? ""
    }
}

public struct UpgradeInfo: Sendable {
    public let id: String
    public let name: String
    public let rarity: String
    
    init(dto: UpgradeInfoDTO) {
        self.id = dto.itemId
        self.name = dto.itemName
        self.rarity = dto.itemRarity
    }
}

public struct SetItemInfo: Sendable {
    public let id: String
    public let name: String
    public let rarity: String
    public let setPoint: Int
    
    init(dto: SetItemInfoDTO) {
        self.id = dto.setItemId
        self.name = dto.setItemName ?? ""
        self.rarity = dto.setItemRarityName ?? ""
        self.setPoint = dto.active.setPoint.current
    }
}
