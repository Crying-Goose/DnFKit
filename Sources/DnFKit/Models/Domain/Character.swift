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
    public let jobId: String
    public let level: Int
    public let name: String
    public let jobGrowName: String
    public let fame: Int
    
    init(dto: CharacterDTO) {
        self.server = dto.serverId
        self.characterId = dto.characterId
        self.jobId = dto.jobId
        self.level = dto.level
        self.name = dto.characterName
        self.jobGrowName = dto.jobGrowName
        self.fame = dto.fame ?? 0
    }
}

// MARK: - Character
public struct Character: Sendable {
    public let server: String
    public let characterId: String
    public let characterName: String
    public let level: Int
    public let jobId: String
    public let jobGrowId: String
    public let jobName: String
    public let jobGrowName: String
    public let fame: Int
    public let adventureName: String
    public let guildId: String
    public let guildName: String
    
    init(dto: CharacterDTO) {
        self.server = dto.serverId
        self.characterId = dto.characterId
        self.characterName = dto.characterName
        self.level = dto.level
        self.jobId = dto.jobId
        self.jobGrowId = dto.jobGrowId
        self.jobName = dto.jobName
        self.jobGrowName = dto.jobGrowName
        self.fame = dto.fame ?? 0
        self.adventureName = dto.adventureName ?? ""
        self.guildId = dto.guildId ?? ""
        self.guildName = dto.guildName ?? ""
    }
}
