//
//  Status.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation

// MARK: - StatusResponseDTO
public struct StatusResponseDTO: Codable {
    let serverId, characterId, characterName: String
    let level: Int
    let jobId, jobGrowId, jobName, jobGrowName: String
    let fame: Int
    let adventureName, guildId, guildName: String?
    let buff: [BuffDTO]
    let status: [StatusElementDTO]
}

// MARK: - BuffDTO
public struct BuffDTO: Codable {
    let name: String
    let level: Int?
    let status: [StatusElementDTO]
}

// MARK: - StatusElementDTO
public struct StatusElementDTO: Codable {
    let name: String
    let value: Value
}

enum Value: Codable {
  case int(Int)
  case double(Double)
  case string(String)
  case bool(Bool)
  case none

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            self = .none
        } else if let intVal = try? container.decode(Int.self) {
            self = .int(intVal)
        } else if let doubleVal = try? container.decode(Double.self) {
            self = .double(doubleVal)
        } else if let boolVal = try? container.decode(Bool.self) {
            self = .bool(boolVal)
        } else if let strVal = try? container.decode(String.self) {
            self = .string(strVal)
        } else {
            throw DecodingError.typeMismatch(
                Value.self,
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Wrong type for Value"
                )
            )
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let intVal):
            try container.encode(intVal)
        case .double(let doubleVal):
            try container.encode(doubleVal)
        case .string(let strVal):
            try container.encode(strVal)
        case .bool(let boolVal):
            try container.encode(boolVal)
        case .none:
            try container.encodeNil()
        }
    }
}

extension Value {
    var doubleValue: Double {
        switch self {
        case .int(let intValue):
            return Double(intValue)
        case.double(let doubleValue):
            return doubleValue
        case .string(let stringValue):
            let cleaned = stringValue
                .replacingOccurrences(of: "%", with: "")
                .replacingOccurrences(of: ",", with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
            
            return Double(cleaned) ?? 0.0
        case .bool(let boolValue):
            return boolValue ? 1.0 : 0.0
        case .none:
            return 0.0
        }
    }
}
