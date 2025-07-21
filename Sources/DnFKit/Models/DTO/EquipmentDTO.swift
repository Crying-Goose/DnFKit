//
//  Equipment.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - EquipmentResponseDTO
public struct EquipmentResponseDTO: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobId, jobGrowId, jobName, jobGrowName: String
    let fame: Int
    let adventureName, guildId, guildName: String?
    let equipment: [EquipmentElementDTO]
    let setItemInfo: [SetItemInfoDTO]
}

// MARK: - EquipmentElementDTO
public struct EquipmentElementDTO: Codable {
    let slotId, slotName, itemId, itemName: String
    let itemTypeId, itemType, itemTypeDetailId, itemTypeDetail: String
    let itemAvailableLevel: Int
    let itemRarity: String
    let setItemId: String?
    let setItemName: String?
    let reinforce: Int
    let itemGradeName: String?
    let enchant: EnchantDTO
    let amplificationName: String?
    let refine: Int
    let tune: [TuneDTO]?
    let fusionOption: FusionOptionDTO?
    let upgradeInfo: UpgradeInfoDTO?
}

// MARK: - EnchantDTO
public struct EnchantDTO: Codable {
    let status: [StatusElementDTO]
}

// MARK: - FusionOptionDTO
public struct FusionOptionDTO: Codable {
    let options: [OptionDTO]
}

// MARK: - OptionDTO
public struct OptionDTO: Codable {
    let buff: Int?
    let explain, explainDetail: String
    let buffExplain, buffExplainDetail: String?
    let engrave: EngraveDTO?
}

// MARK: - EngraveDTO
public struct EngraveDTO: Codable {
    let color: String
    let value: Value
}

// MARK: - TuneDTO
public struct TuneDTO: Codable {
    let level: Int?
    let status: [StatusElementDTO]?
    let setPoint: Int?
    let upgrade: Bool?
}

// MARK: - UpgradeInfoDTO
public struct UpgradeInfoDTO: Codable {
    let itemId, itemName: String
    let itemRarity: String
    let setItemId: String?
    let setItemName: String?
    let setPoint: Int?
}

// MARK: - SetItemInfoDTO
public struct SetItemInfoDTO: Codable {
    let setItemId: String
    let setItemName, setItemRarityName: String
    let active: ActiveDTO
    let slotInfo: [SlotInfoDTO]
}

// MARK: - ActiveDTO
public struct ActiveDTO: Codable {
    let explain, explainDetail: String
    let status: [StatusElementDTO]
    let setPoint: SetPointDTO
}

// MARK: - SetPointDTO
public struct SetPointDTO: Codable {
    let current, min, max: Int
}

// MARK: - SlotInfoDTO
public struct SlotInfoDTO: Codable {
    let itemNo, slotId, slotName: String
    let itemRarity: String
    let fusionStone: Bool?
}
