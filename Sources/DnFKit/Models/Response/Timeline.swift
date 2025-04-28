//
//  Timelin.swift
//  DnFKit
//
//  Created by 라주영 on 3/18/25.
//

struct CharacterTimeline: Codable {
    let serverId: String        // 서버명 ex) cain
    let characterId: String     // 캐릭터 고유 코드
    let characterName: String   // 캐릭터 이름
    let timeline: Timeline    // 캐릭터 타임라인
}

struct Timeline: Codable {
    let date: DateClass
    let next: String
    let rows: [TimelineRow]
}

// MARK: - DateClass
struct DateClass: Codable {
    let start, end: String
}

// MARK: - Row
struct TimelineRow: Codable {
    let code: Int
    let name, date: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let regionName, itemId, itemName, itemRarity: String?
    let channelName: String?
    let channelNo: Int?
    let dungeonName: String?
    let mistGear: Bool?
    let raidName, raidPartyName, modeName: String?
    let hard: Bool?
}
