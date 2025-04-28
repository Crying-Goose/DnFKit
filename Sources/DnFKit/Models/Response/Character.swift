//
//  Character.swift
//  DnFKit
//
//  Created by 라주영 on 3/18/25.
//

import Foundation

public struct Characters: Codable {
    let rows: [Character]
}

public struct Character: Codable {
    let serverId: String        // 서버명 ex) cain
    let characterId: String     // 캐릭터 고유 코드
    let characterName: String   // 캐릭터 이름
    let level: Int16            // 캐릭터 레벨
    let jobId: String           // 캐릭터 직업 고유 코드
    let jobGrowId: String       // 캐릭터 전직 직업 고유 코드 (jobId 필요)
    let jobName: String         // 캐릭터 직업명
    let jobGrowName: String     // 캐릭터 전직명
    let fame: Int               //
    let adventureName: String?  // 캐릭터 모험단명
    let guildId: String?        // 캐릭터 길드 고유 코드
    let guildName: String?      // 캐릭터 길드 이름
}
