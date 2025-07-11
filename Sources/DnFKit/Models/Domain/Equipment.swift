//
//  Equipment.swift
//  DnFKit
//
//  Created by 라주영 on 7/11/25.
//

import Foundation

public struct Equipment: Sendable {
    public let id: String
    public let name: String
    public let type: String
    public let typeDetail: String
    public let rarity: String
    public let availableLevel: Int
    public let refine: Int          // 재련
    public let enchant: [StatusInfo]
    public let amplificationName: String
    public let tune: [Tune]
    public let fusionOption: [FusionOption]
    public let upgradeInfo: UpgradeInfo?
    
    init(dto: EquipmentElementDTO) {
        self.id = dto.itemId
        self.name = dto.itemName
        self.type = dto.itemType
        self.typeDetail = dto.itemTypeDetail
        self.rarity = dto.itemRarity
        self.availableLevel = dto.itemAvailableLevel
        self.refine = dto.refine
        self.enchant = dto.enchant.status.map { .init(dto: $0) }
        self.amplificationName = dto.amplificationName ?? ""
        self.tune = dto.tune?.compactMap { .init(dto: $0) } ?? []
        self.fusionOption = dto.fusionOption?.options.compactMap { .init(dto: $0) } ?? []
        self.upgradeInfo = dto.upgradeInfo.map { .init(dto: $0) }
    }
}

public struct Tune: Sendable {
    public let setPoint: Int
    public let status: [StatusInfo]
    
    init(dto:TuneDTO) {
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
        self.explain = dto.explain
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
