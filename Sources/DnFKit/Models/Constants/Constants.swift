//
//  Constants.swift
//  DnFKit
//
//  Created by 라주영 on 7/15/25.
//

import Foundation

public enum DnFConstants {
    
    public enum Rarity: String, CaseIterable {
        case common
        case uncommon
        case rare
        case unique
        case legendary
        case epic
        case beginning
        
        public var displayName: String {
            switch self {
            case .common: return "커먼"
            case .uncommon: return "언커먼"
            case .rare: return "레어"
            case .unique: return "유니크"
            case .legendary: return "레전더리"
            case .epic: return "에픽"
            case .beginning: return "태초"
            }
        }
        
        public var hexColor: String {
            switch self {
            case .common: return "FFFFFF"
            case .uncommon: return "68D5ED"
            case .rare: return "B36BFF"
            case .unique: return "FF00FF"
            case .legendary: return "FFB400"
            case .epic: return "FFFFFF"
            case .beginning: return "2EC38E"
            }
        }
        
        public init?(displayName: String) {
            self = Rarity.allCases.first(where: { $0.displayName == displayName }) ?? .common
        }
    }
    
    public enum Server: String, CaseIterable {
        case cain
        case diregie
        case siroco
        case prey
        case casillas
        case hilder
        case anton
        case bakal

        public var displayName: String {
            switch self {
            case .cain: return "카인"
            case .diregie: return "디레지에"
            case .siroco: return "시로코"
            case .prey: return "프레이"
            case .casillas: return "카시야스"
            case .hilder: return "힐더"
            case .anton: return "안톤"
            case .bakal: return "바칼"
            }
        }
        
        public init?(displayName: String) {
            self = Server.allCases.first(where: { $0.displayName == displayName }) ?? .cain
        }
    }
}
