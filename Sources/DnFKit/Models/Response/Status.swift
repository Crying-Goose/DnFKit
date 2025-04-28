//
//  Status.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - Status
struct Status: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobId, jobGrowId, jobName, jobGrowName: String
    let fame: Int
    let adventureName, guildId, guildName: String
    let buff: [Buff]
    let status: [StatusElement]
}

// MARK: - Buff
struct Buff: Codable {
    let name: String
    let level: Int?
    let status: [StatusElement]
}

// MARK: - StatusElement
struct StatusElement: Codable {
    let name: String
    let value: Double
}
