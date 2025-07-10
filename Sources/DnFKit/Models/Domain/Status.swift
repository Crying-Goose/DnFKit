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
        var buffs: [CommonBuff] = []
        dto.buff.forEach { buffs.append(.init(dto: $0)) }
        self.buffs = buffs
        var status: [StatusInfo] = []
        dto.status.forEach { status.append(.init(dto: $0)) }
        self.status = status
    }
}

public struct CommonBuff: Sendable {
    public let name: String
    public let level: Int?
    public let status: [StatusInfo]
    
    init(dto: BuffDTO) {
        self.name = dto.name
        self.level = dto.level
        var status: [StatusInfo] = []
        dto.status.forEach { status.append(.init(dto: $0)) }
        self.status = status
    }
}

public struct StatusInfo: Sendable {
    public let name: String
    public let value: Double
    
    init(dto: StatusElementDTO) {
        self.name = dto.name
        self.value = dto.value
    }
}
