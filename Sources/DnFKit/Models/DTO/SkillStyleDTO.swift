//
//  SkillStyle.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - SkillStyleResponseDTO
struct SkillStyleResponseDTO: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobId, jobGrowId, jobName, jobGrowName: String
    let fame: Int
    let adventureName, guildId, guildName: String
    let skill: SkillDTO
}

// MARK: - SkillDTO
struct SkillDTO: Codable {
    let hash: String
    let style: StyleDTO
}

// MARK: - StyleDTO
struct StyleDTO: Codable {
    let active, passive: [IveDTO]
}

// MARK: - IveDTO
struct IveDTO: Codable {
    let skillId, name: String
    let level, requiredLevel: Int
    let costType: String
}
