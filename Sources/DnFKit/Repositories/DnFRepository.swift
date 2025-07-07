//
//  DnFRepository.swift
//  DnFKit
//
//  Created by 라주영 on 7/6/25.
//

import Foundation

public protocol DnFRepositoryProtocol {
    func fetchDnFCharacters(name: String) async throws -> [JustCharacter]
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
    
//    public func fetchDnFCharacterInfo(server: String, id: String) async throws -> CharacterInfo {
//        let baseInfo = try await apiService.getCharacterInfo(server: server, id: id)
//        let status = try await apiService.getStatus(server: server, id: id)
//        let equipment = try await apiService.getEquipment(server: server, id: id)
//        let avatar = try await apiService.getAvatar(server: server, id: id)
//        let creature = try await apiService.getCreature(server: server, id: id)
//        return CharacterInfo()
//    }
}
