//
//  Status.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - StatusResponseDTO
struct StatusResponseDTO: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobId, jobGrowId, jobName, jobGrowName: String
    let fame: Int
    let adventureName, guildId, guildName: String
    let buff: [BuffDTO]
    let status: [StatusElementDTO]
}

// MARK: - BuffDTO
struct BuffDTO: Codable {
    let name: String
    let level: Int?
    let status: [StatusElementDTO]
}

// MARK: - StatusElementDTO
struct StatusElementDTO: Codable {
    let name: String
    let value: Double
}
