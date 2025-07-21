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
    func fetchDnFCharacterInfo(server: String, id: String) async throws -> CharacterInfo
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
    
    public func fetchDnFCharacterInfo(server: String, id: String) async throws -> CharacterInfo {
        let baseInfoDTO = try await apiService.getCharacterInfo(server: server, id: id)
        let statusDTO = try await apiService.getStatus(server: server, id: id)
        let equipmentDTO = try await apiService.getEquipment(server: server, id: id)
        let avatarDTO = try await apiService.getAvatar(server: server, id: id)
        let creatureDTO = try await apiService.getCreature(server: server, id: id)
        let flagDTO = try await apiService.getFlag(server: server, id: id)
        let skillDTO = try await apiService.getSkills(server: server, id: id)
        let buffEquipmentDTO = try await apiService.getBuffEquipment(server: server, id: id)
        let buffAvalarDTO = try await apiService.getBuffAvatar(server: server, id: id)
        let buffCreatureDTO = try await apiService.getBuffCreature(server: server, id: id)
        var buffs: [Buff] = []
        buffEquipmentDTO.skill.buff.equipment?.forEach {
            buffs.append(.init(equipmentDto: $0))
        }
        buffAvalarDTO.skill.buff.avatar?.forEach {
            buffs.append(.init(avatarDto: $0))
        }
        buffCreatureDTO.skill.buff.creature?.forEach {
            buffs.append(.init(creatureDto: $0))
        }
        return .init(
            baseInfo: .init(dto: baseInfoDTO),
            status: .init(dto: statusDTO),
            equipment: equipmentDTO.equipment.map { .init(dto: $0) },
            avatar: avatarDTO.avatar.map { .init(dto: $0) },
            creature: .init(dto: creatureDTO.creature),
            flag: .init(dto: flagDTO.flag),
            buffs: buffs,
            skill: .init(dto: skillDTO.skill)
        )
    }
    
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
