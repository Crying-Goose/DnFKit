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
    case timeline(server: String, characterId: String, startDate: Date, endDate: Date, code: String, next: String?)
    case status(server: String, characterId: String)
    case equipment(server: String, characterId: String)
    case avatar(server: String, characterId: String)
    case creature(server: String, characterId: String)
    case flag(server: String, characterId: String)
    case skill(server: String, characterId: String)
    case buffEquipment(server: String, characterId: String)
    case buffAvatar(server: String, characterId: String)
    case buffCreature(server: String, characterId: String)
    case item(name: String, wordType: String = "front")
    case itemDetail(id: String)
    case auction(id: String)
}

public enum DnFToken {
    // (임시사용) 내 토큰
    public static let key = "mVSUZGCKHA0wiolBYGyPhRWzG3MicPxS"
}

extension DnFTarget: TargetType {
    public var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    public var baseURL: URL {
        return URL(string: "https://api.neople.co.kr/df")!
    }

    public var path: String {
        switch self {
        case .characters:
            return "/servers/all/characters"
        case .character(let server, _):
            return "/servers/\(server)/characters"
        case .characterInfo(let server, let characterId):
            return "/servers/\(server)/characters/\(characterId)"
        case .timeline(let server, let characterId, _, _, _, _):
            return "/servers/\(server)/characters/\(characterId)/timeline"
        case .status(let server, let characterId):
            return "/servers/\(server)/characters/\(characterId)/status"
        case .equipment(let server, let characterId):
            return "/servers/\(server)/characters/\(characterId)/equip/equipment"
        case .avatar(let server, let characterId):
            return "/servers/\(server)/characters/\(characterId)/equip/avatar"
        case .creature(let server, let characterId):
            return "/servers/\(server)/characters/\(characterId)/equip/creature"
        case .flag(let server, let characterId):
            return "/servers/\(server)/characters/\(characterId)/equip/flag"
        case .skill(let server, let characterId):
            return "/servers/\(server)/characters/\(characterId)/skill/style"
        case .buffEquipment(let server, let characterId):
            return "/servers/\(server)/characters/\(characterId)/skill/buff/equip/equipment"
        case .buffAvatar(let server, let characterId):
            return "/servers/\(server)/characters/\(characterId)/skill/buff/equip/avatar"
        case .buffCreature(let server, let characterId):
            return "/servers/\(server)/characters/\(characterId)/skill/buff/equip/creature"
        case .item:
            return
                "/items"
        case .itemDetail(let id):
            return
                "/items/\(id)"
        case .auction:
            return
                "/auction"
        }
    }

    public var method: Moya.Method {
        return .get
    }

    public var task: Task {
        switch self {
        case .characters(let name):
            return .requestParameters(parameters: [
                "characterName": name,
                "limit": 30,
                "wordType": "full",
                "apikey": DnFToken.key
            ], encoding: URLEncoding.default)
        case .character(_, let name):
            return .requestParameters(parameters: [
                "characterName": name,
                "apikey": DnFToken.key
            ], encoding: URLEncoding.default)
        case .timeline(_, _, let startDate, let endDate, let code, let next):
            return .requestParameters(parameters: [
                "limit": 100,
                "code": code,
                "startDate": startDate,
                "endDate": endDate,
                "next": next ?? "",
                "apikey": DnFToken.key
            ], encoding: URLEncoding.default)
        case .item(let name, let wordType):
            return .requestParameters(parameters: [
                "itemName": name,
                "wordType": wordType,
                "apikey": DnFToken.key
            ], encoding: URLEncoding.default)
        case .auction(let id):
            return .requestParameters(parameters: [
                "itemId": id,
                "sort": "unitPrice:asc",
                "apikey": DnFToken.key
            ], encoding: URLEncoding.default)
        case .characterInfo, .status, .avatar, .equipment, .creature, .flag, .skill, .buffEquipment, .buffAvatar, .buffCreature, .itemDetail:
            return .requestParameters(parameters: [
                "apikey": DnFToken.key
            ], encoding: URLEncoding.default)
        }
    }

    public var sampleData: Data {
        return Data()
    }
}
