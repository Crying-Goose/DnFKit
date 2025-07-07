//
//  CharacterDTO.swift
//  DnFKit
//
//  Created by 라주영 on 4/28/25.
//

import Foundation

public struct CharacterResponseDTO: Codable {
    public let rows: [CharacterDTO]
}

public struct CharacterDTO: Codable {
    public let characterId: String
    public let characterName: String
    public let level: Int
    public let jobId: String
    public let jobGrowId: String
    public let jobName: String
    public let jobGrowName: String
    public let adventureName: String?
    public let guildId: String?
    public let guildName: String?
    public let serverId: String
    public let fame: Int
}
