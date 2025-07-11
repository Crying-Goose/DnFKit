//
//  Status.swift
//  DnFKit
//
//  Created by 라주영 on 7/9/25.
//

import Foundation

public struct Status: Sendable {
    public let id: String
    public let buffs: [CommonBuff]
    public let status: [StatusInfo]
    
    init(dto: StatusResponseDTO) {
        self.id = dto.characterId
        self.buffs = dto.buff.map { .init(dto: $0) }
        self.status = dto.status.map { .init(dto: $0) }
    }
}

public struct CommonBuff: Sendable {
    public let name: String
    public let level: Int
    public let status: [StatusInfo]
    
    init(dto: BuffDTO) {
        self.name = dto.name
        self.level = dto.level ?? 0
        self.status = dto.status.map { .init(dto: $0) }
    }
}

public struct StatusInfo: Sendable {
    public let name: String
    public let value: Double
    
    init(dto: StatusElementDTO) {
        self.name = dto.name
        self.value = dto.value.doubleValue
    }
}
