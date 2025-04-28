//
//  Equipment.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - Equipment
struct Equipment: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobId, jobGrowId, jobName, jobGrowName: String
    let fame: Int
    let adventureName, guildId, guildName: String
    let equipment: [EquipmentElement]
    let setItemInfo: [SetItemInfo]
}

// MARK: - EquipmentElement
struct EquipmentElement: Codable {
    let slotId, slotName, itemId, itemName: String
    let itemTypeId, itemType, itemTypeDetailId, itemTypeDetail: String
    let itemAvailableLevel: Int
    let itemRarity: String
    let setItemId: String?
    let setItemName: String?
    let reinforce: Int
    let itemGradeName: String?
    let enchant: Enchant
    let amplificationName: String?
    let refine: Int
    let tune: [Tune]?
    let fusionOption: FusionOption?
    let upgradeInfo: UpgradeInfo?
}

// MARK: - Enchant
struct Enchant: Codable {
    let status: [EnchantStatus]
}

// MARK: - EnchantStatus
struct EnchantStatus: Codable {
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

// MARK: - FusionOption
struct FusionOption: Codable {
    let options: [Option]
}

// MARK: - Option
struct Option: Codable {
    let buff: Int?
    let explain, explainDetail: String
    let buffExplain, buffExplainDetail: String?
    let engrave: Engrave?
}

// MARK: - Engrave
struct Engrave: Codable {
    let color: String
    let value: Int
}

// MARK: - Tune
struct Tune: Codable {
    let level: Int
    let status: [TuneStatus]?
    let setPoint: Int?
    let upgrade: Bool?
}

// MARK: - TuneStatus
struct TuneStatus: Codable {
    let name, value: String
}

// MARK: - UpgradeInfo
struct UpgradeInfo: Codable {
    let itemId, itemName: String
    let itemRarity: String
    let setItemId: String
    let setItemName: String?
    let setPoint: Int?
}

// MARK: - SetItemInfo
struct SetItemInfo: Codable {
    let setItemId: String
    let setItemName, setItemRarityName: String
    let active: Active
    let slotInfo: [SlotInfo]
}

// MARK: - Active
struct Active: Codable {
    let explain, explainDetail: String
    let status: [EnchantStatus]
    let setPoint: SetPoint
}

// MARK: - SetPoint
struct SetPoint: Codable {
    let current, min, max: Int
}

// MARK: - SlotInfo
struct SlotInfo: Codable {
    let itemNo, slotId, slotName: String
    let itemRarity: String
    let fusionStone: Bool?
}
