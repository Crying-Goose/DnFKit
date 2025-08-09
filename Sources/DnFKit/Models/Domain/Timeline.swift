//
//  Timeline.swift
//  DnFKit
//
//  Created by 라주영 on 7/15/25.
//

import Foundation

public struct Timeline: Sendable {
    public let raids: [Raid]
    public let itemDrops: [ItemDrop]
    
    init(raids: [Raid], itemDrops: [ItemDrop]) {
        self.raids = raids
        self.itemDrops = itemDrops
    }
}

// 레이드 : 201, 210
public struct Raid: Sendable {
    public let code: Int
    public let date: String
    public let name: String
    public let mode: String
    public let isHard: Bool
    
    init(dto: TimelineRowDTO) {
        self.code = dto.code
        self.date = dto.date
        self.name = dto.data.raidName ?? ""
        self.mode = dto.data.modeName ?? ""
        self.isHard = dto.data.hard ?? false
    }
}

// 아이템 획득 : 504, 505, 516
public struct ItemDrop: Sendable {
    public let code: Int
    public let date: String
    public let itemId: String
    public let itemName: String
    public let rarity: String
    public let channelName: String
    public let cnannelNo: Int
    public let transcend: String?
    public let inTheAbyss: Bool
    
    init(dto: TimelineRowDTO) {
        self.code = dto.code
        self.date = dto.date
        self.itemId = dto.data.itemId ?? ""
        self.itemName = dto.data.itemName ?? ""
        self.rarity = dto.data.itemRarity ?? ""
        self.channelName = dto.data.channelName ?? ""
        self.cnannelNo = dto.data.channelNo ?? 0
        self.transcend = dto.data.adventureSafeMoveType
        self.inTheAbyss = dto.data.dungeonName == "심연 : 종말의 숭배자"
    }
}
