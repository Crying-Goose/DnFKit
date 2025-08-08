//
//  Timelin.swift
//  DnFKit
//
//  Created by 라주영 on 3/18/25.
//

// MARK: - TimelineResponseDTO
public struct TimelineResponseDTO: Codable {
    let serverId: String        // 서버명 ex) cain
    let characterId: String     // 캐릭터 고유 코드
    let characterName: String   // 캐릭터 이름
    let timeline: TimelineDTO    // 캐릭터 타임라인
}

// MARK: - TimelineDTO
struct TimelineDTO: Codable {
    let date: DateClassDTO
    let next: String?
    let rows: [TimelineRowDTO]
}

// MARK: - DateClassDTO
struct DateClassDTO: Codable {
    let start, end: String
}

// MARK: - TimelineRowDTO
struct TimelineRowDTO: Codable {
    let code: Int
    let name, date: String
    let data: DataClassDTO
}

// MARK: - DataClassDTO
struct DataClassDTO: Codable {
    let regionName, itemId, itemName, itemRarity: String?
    let channelName: String?
    let channelNo: Int?
    let adventureSafeMoveType: String?
    let dungeonName: String?
    let mistGear: Bool?
    let raidName, raidPartyName, modeName: String?
    let hard: Bool?
}
