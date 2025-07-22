//
//  DnFRepository.swift
//  DnFKit
//
//  Created by 라주영 on 7/6/25.
//

import Foundation

public protocol DnFRepositoryProtocol {
    func fetchDnFCharacters(name: String) async throws -> [JustCharacter]
    func fetchDnFCharacter(server: String, name: String) async throws -> JustCharacter
    func fetchDnFCharacterInfo(server: String, id: String) async throws -> Character
    func fetchDnFCharacterStatus(server: String, id: String) async throws -> Status
    func fetchDnFCharacterEquipment(server: String, id: String) async throws -> [Equipment]
    func fetchDnFCharacterSkillStyle(server: String, id: String) async throws -> SkillStyle
    func fetchDnFCharacterAvatar(server: String, id: String) async throws -> [Avatar]
    func fetchDnFCharacterFlag(server: String, id: String) async throws -> Flag?
    func fetchDnFCharacterBuffs(server: String, id: String) async throws -> [Buff]
    func fetchDnFChracterCreature(server: String, id: String) async throws -> Creature?
    func fetchDnFTimeline(server: String, id: String) async throws -> Timeline
}

public final class DnFRepository: DnFRepositoryProtocol {
    
    private let apiService: DnFAPIServiceProtocol
    
    public init(apiService: DnFAPIServiceProtocol = DnFService()) {
        self.apiService = apiService
    }
    
    // 서버 전체 (전문) 캐릭터 검색
    public func fetchDnFCharacters(name: String) async throws -> [JustCharacter] {
        let response = try await apiService.getCharacters(name: name)
        return response.rows.map { JustCharacter(dto: $0) }
    }
    
    // 서버에 맞는 캐릭터 검색
    public func fetchDnFCharacter(server: String, name: String) async throws -> JustCharacter {
        let response = try await apiService.getCharacter(server: server, name: name)
        return JustCharacter(dto: response.rows[0])
    }
    
    // 캐릭터 정보 검색
    public func fetchDnFCharacterInfo(server: String, id: String) async throws -> Character {
        let response = try await apiService.getCharacterInfo(server: server, id: id)
        return .init(dto: response)
    }
    
    // 캐릭터 스탯 검색
    public func fetchDnFCharacterStatus(server: String, id: String) async throws -> Status {
        let response = try await apiService.getStatus(server: server, id: id)
        return .init(dto: response)
    }
    
    // 캐릭터 장비 검색
    public func fetchDnFCharacterEquipment(server: String, id: String) async throws -> [Equipment] {
        let response = try await apiService.getEquipment(server: server, id: id)
        return response.equipment?.compactMap { .init(dto: $0) } ?? []
    }
    
    // 캐릭터 스킬 검색
    public func fetchDnFCharacterSkillStyle(server: String, id: String) async throws -> SkillStyle {
        let response = try await apiService.getSkills(server: server, id: id)
        return .init(dto: response.skill)
    }
    
    // 캐릭터 아바타 검색
    public func fetchDnFCharacterAvatar(server: String, id: String) async throws -> [Avatar] {
        let response = try await apiService.getAvatar(server: server, id: id)
        return response.avatar.compactMap { .init(dto: $0) }
    }
    
    // 캐릭터 휘장 검색
    public func fetchDnFCharacterFlag(server: String, id: String) async throws -> Flag? {
        let response = try await apiService.getFlag(server: server, id: id)
        guard let flag = response.flag else { return nil }
        return .init(dto: flag)
    }
    
    // 캐릭터 버프 강화 검색
    public func fetchDnFCharacterBuffs(server: String, id: String) async throws -> [Buff] {
        let equipmentResponse = try await apiService.getBuffEquipment(server: server, id: id)
        let avatarResponse = try await apiService.getBuffAvatar(server: server, id: id)
        let creatureResponse = try await apiService.getBuffCreature(server: server, id: id)
        var buffs: [Buff] = []
        equipmentResponse.skill.buff.equipment?.forEach {
            buffs.append(.init(equipmentDto: $0))
        }
        avatarResponse.skill.buff.avatar?.forEach {
            buffs.append(.init(avatarDto: $0))
        }
        creatureResponse.skill.buff.creature?.forEach {
            buffs.append(.init(creatureDto: $0))
        }
        return buffs
    }
    
    // 캐릭터 크리쳐 검색
    public func fetchDnFChracterCreature(server: String, id: String) async throws -> Creature? {
        let response = try await apiService.getCreature(server: server, id: id)
        guard let creature = response.creature else { return nil }
        return .init(dto: creature)
    }
    
    // 캐릭터 타임라인 검색
    public func fetchDnFTimeline(server: String, id: String) async throws -> Timeline {
        let date = Date()
        // 날짜 계산해서 캐릭터 생성일 전까지 계속 루프
        let raidsDTO = try await apiService.getTimeline(server: server, id: id, code: [201,210], date: date, next: nil)
        let itemDropsDTO = try await apiService.getTimeline(server: server, id: id, code: [504,505,507], date: date, next: nil)
        // TODO: 초월 (516) 데이터도 필요 (adventureSafeMoveType)
        return .init(
            raids: raidsDTO.timeline.rows.compactMap { .init(dto: $0) },
            itemDrops: itemDropsDTO.timeline.rows.compactMap { .init(dto: $0) }
        )
    }
}
