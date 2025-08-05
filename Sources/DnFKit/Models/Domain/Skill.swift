//
//  Skill.swift
//  DnFKit
//
//  Created by 라주영 on 7/11/25.
//

import Foundation

public struct SkillStyle: Sendable {
    public let hash: String?
    public let active: [Skill]
    public let passive: [Skill]
    public let evolution: [SkillStage]
    public let enhancement: [SkillStage]
    
    init(dto: SkillDTO) {
        self.hash = dto.hash
        self.active = dto.style.active.map { .init(dto: $0) }
        self.passive = dto.style.passive.map { .init(dto: $0) }
        self.evolution = dto.style.evolution?.compactMap { .init(dto: $0) } ?? []
        self.enhancement = dto.style.enhancement?.compactMap { .init(dto: $0) } ?? []
    }
}

public struct Skill: Sendable {
    public let id: String
    public let name: String
    public let level: Int
    public let requiredLevel: Int
    
    init(dto: IveDTO) {
        self.id = dto.skillId
        self.name = dto.name
        self.level = dto.level
        self.requiredLevel = dto.requiredLevel ?? 0
    }
}

public struct SkillStage: Sendable {
    public let id: String
    public let type: Int
    
    init(dto: SkillStageDTO) {
        self.id = dto.skillId
        self.type = dto.type
    }
}
