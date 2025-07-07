//
//  Character.swift
//  DnFKit
//
//  Created by 라주영 on 3/18/25.
//

import Foundation

// MARK: - JustCharacter
// Character simple information
public struct JustCharacter: Sendable {
    public let server: String
    public let characterId: String
    public let level: Int
    public let name: String
    public let jobGrowName: String
    
    init(dto: CharacterResponseDTO) {
        self.server = dto.serverId
        self.characterId = dto.characterId
        self.level = dto.level
        self.name = dto.characterName
        self.jobGrowName = dto.jobGrowName
    }
}

// MARK: - CharacterInfo
public struct CharacterInfo: Sendable {
    
}

// MARK: - Character
public struct Character: Sendable {
    public let serverId: String        // 서버명 ex) cain
    public let characterId: String     // 캐릭터 고유 코드
    public let characterName: String   // 캐릭터 이름
    public let level: Int16            // 캐릭터 레벨
    public let jobId: String           // 캐릭터 직업 고유 코드
    public let jobGrowId: String       // 캐릭터 전직 직업 고유 코드 (jobId 필요)
    public let jobName: String         // 캐릭터 직업명
    public let jobGrowName: String     // 캐릭터 전직명
    public let fame: Int               // 명성
    public let adventureName: String?  // 캐릭터 모험단명
    public let guildId: String?        // 캐릭터 길드 고유 코드
    public let guildName: String?      // 캐릭터 길드 이름
}
