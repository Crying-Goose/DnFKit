//
//  DnFTarget.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Moya
import Foundation

public enum DnFTarget {
    case character(name: String)
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
        case .character(let name):
            return "df/servers/all/characters?name=\(name)"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .character:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .character:
            return .requestPlain
        }
    }

    public var sampleData: Data {
        return Data()
    }
}
