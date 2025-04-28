//
//  DnFTarget.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Moya
import Foundation

public enum DnFTarget {
    case characters(name: String)
    case character(server: String, name: String)
    case characterInfo(server: String, characterId: String)
    case timeline(server: String, characterId: String, startDate: Date?, endDate: Date?, limit: Int?, code: String, next: String?)
    case status(server: String, characterId: String)
    case equipmant(server: String, characterId: String)
    case avatar(server: String, characterId: String)
    case creature(server: String, characterId: String)
    case flag(server: String, characterId: String)
    case talisman(server: String, characterId: String)
    case skill(server: String, characterId: String)
    case buff(server: String, characterId: String)
}

public enum DnFToken {
    // 임시 내 토큰
    public static let key = "mVSUZGCKHA0wiolBYGyPhRWzG3MicPxS"
}

extension DnFTarget: TargetType {
    public var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(DnFToken.key)"
        ]
    }
    
    public var baseURL: URL {
        return URL(string: "https://api.neople.co.kr")!
    }

    public var path: String {
        switch self {
        case .characters(let name):
            return "df/servers/all/characters?name=\(name)"
        case .character(let server,let name):
            return "df/servers/\(server)/characters?name=\(name)"
        case .characterInfo(let server, let characterId):
            return "df/servers/\(server)/characters/\(characterId)"
        case .timeline(let server, let characterId, let startDate, let endDate, let limit, let code, let next):
            return "df/servers/\(server)/characters/\(characterId)/timeline?limit=\(limit ?? 10)&code=\(code)&startDate=\(startDate)&endDate=\(endDate)&next=\(next)"
        case .status(let server, let characterId):
            return "df/servers/\(server)/characters/\(characterId)/status"
        case .equipmant(let server, let characterId):
            return "df/servers/\(server)/characters/\(characterId)/equip/equipment"
        case .avatar(let server, let characterId):
            return "df/servers/\(server)/characters/\(characterId)/equip/avatar"
        case .creature(let server, let characterId):
            return "df/servers/\(server)/characters/\(characterId)/equip/creature"
        case .flag(let server, let characterId):
            return "df/servers/\(server)/characters/\(characterId)/equip/flag"
        case .talisman(let server, let characterId):
            return "df/servers/\(server)/characters/\(characterId)/equip/talisman"
        case .skill(let server, let characterId):
            return "df/servers/\(server)/characters/\(characterId)/skill/style"
        case .buff(let server, let characterId):
            return "df/servers/\(server)/characters/\(characterId)/skill/buff/equip/equipment"
        }
    }

    public var method: Moya.Method {
        return .get
    }

    public var task: Task {
        return .requestPlain
    }

    public var sampleData: Data {
        return Data()
    }
}
