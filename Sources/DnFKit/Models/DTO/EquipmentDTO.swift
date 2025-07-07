//
//  Equipment.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - EquipmentResponseDTO
struct EquipmentResponseDTO: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobId, jobGrowId, jobName, jobGrowName: String
    let fame: Int
    let adventureName, guildId, guildName: String
    let equipment: [EquipmentElementDTO]
    let setItemInfo: [SetItemInfoDTO]
}

// MARK: - EquipmentElementDTO
struct EquipmentElementDTO: Codable {
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
struct EnchantDTO: Codable {
    let status: [EnchantStatusDTO]
}

// MARK: - EnchantStatusDTO
struct EnchantStatusDTO: Codable {
    let name: String
    let value: Value
}

enum Value: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Value.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Value"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - FusionOptionDTO
struct FusionOptionDTO: Codable {
    let options: [OptionDTO]
}

// MARK: - OptionDTO
struct OptionDTO: Codable {
    let buff: Int?
    let explain, explainDetail: String
    let buffExplain, buffExplainDetail: String?
    let engrave: EngraveDTO?
}

// MARK: - EngraveDTO
struct EngraveDTO: Codable {
    let color: String
    let value: Int
}

// MARK: - TuneDTO
struct TuneDTO: Codable {
    let level: Int
    let status: [TuneStatusDTO]?
    let setPoint: Int?
    let upgrade: Bool?
}

// MARK: - TuneStatusDTO
struct TuneStatusDTO: Codable {
    let name, value: String
}

// MARK: - UpgradeInfoDTO
struct UpgradeInfoDTO: Codable {
    let itemId, itemName: String
    let itemRarity: String
    let setItemId: String
    let setItemName: String?
    let setPoint: Int?
}

// MARK: - SetItemInfoDTO
struct SetItemInfoDTO: Codable {
    let setItemId: String
    let setItemName, setItemRarityName: String
    let active: ActiveDTO
    let slotInfo: [SlotInfoDTO]
}

// MARK: - ActiveDTO
struct Active: Codable {
    let explain, explainDetail: String
    let status: [EnchantStatusDTO]
    let setPoint: SetPointDTO
}

// MARK: - SetPointDTO
struct SetPointDTO: Codable {
    let current, min, max: Int
}

// MARK: - SlotInfoDTO
struct SlotInfoDTO: Codable {
    let itemNo, slotId, slotName: String
    let itemRarity: String
    let fusionStone: Bool?
}
