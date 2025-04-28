//
//  SkillStyle.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - SkillStyle
struct SkillStyle: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobId, jobGrowId, jobName, jobGrowName: String
    let fame: Int
    let adventureName, guildId, guildName: String
    let skill: Skill
}

// MARK: - Skill
struct Skill: Codable {
    let hash: String
    let style: Style
}

// MARK: - Style
struct Style: Codable {
    let active, passive: [Ive]
}

// MARK: - Ive
struct Ive: Codable {
    let skillId, name: String
    let level, requiredLevel: Int
    let costType: String
}
