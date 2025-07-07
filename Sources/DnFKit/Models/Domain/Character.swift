//
//  Character.swift
//  DnFKit
//
//  Created by 라주영 on 3/18/25.
//

import Foundation

// MARK: - JustCharacter
// Character simple information
public struct JustCharacter {
    let server: String
    let characterId: String
    let level: Int
    let name: String
    let jobGrowName: String
    
    init(dto: CharacterResponseDTO) {
        self.server = dto.serverId
        self.characterId = dto.characterId
        self.level = dto.level
        self.name = dto.characterName
        self.jobGrowName = dto.jobGrowName
    }
}

// MARK: - CharacterInfo
public struct CharacterInfo {
    
}

// MARK: - Character
public struct Character {
    let serverId: String        // 서버명 ex) cain
    let characterId: String     // 캐릭터 고유 코드
    let characterName: String   // 캐릭터 이름
    let level: Int16            // 캐릭터 레벨
    let jobId: String           // 캐릭터 직업 고유 코드
    let jobGrowId: String       // 캐릭터 전직 직업 고유 코드 (jobId 필요)
    let jobName: String         // 캐릭터 직업명
    let jobGrowName: String     // 캐릭터 전직명
    let fame: Int               // 명성
    let adventureName: String?  // 캐릭터 모험단명
    let guildId: String?        // 캐릭터 길드 고유 코드
    let guildName: String?      // 캐릭터 길드 이름
}
