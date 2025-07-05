//
//  DnFService.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation
import Moya

public protocol DnFAPIServiceProtocol {
    func getCharacters(name: String) async throws -> [CharacterResponseDTO]
    func getCharacterInfo(server: String, name: String) async throws -> CharacterResponseDTO
}

public final class DnFService: DnFAPIServiceProtocol {
    private let provider = MoyaProvider<DnFTarget>()

    public init() {}
    
    // 캐릭터 검색
    public func getCharacters(name: String) async throws -> [CharacterResponseDTO] {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.characters(name: name)) { result in
                switch result {
                case .success(let response):
                    do {
                        let dto = try JSONDecoder().decode([CharacterResponseDTO].self, from: response.data)
                        continuation.resume(returning: dto)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    // 캐릭터 기본 정보 조회
    public func getCharacterInfo(server: String, name: String) async throws -> CharacterResponseDTO {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.character(server: server, name: name)) { result in
                switch result {
                case .success(let response):
                    do {
                        let dto = try JSONDecoder().decode(CharacterResponseDTO.self, from: response.data)
                        continuation.resume(returning: dto)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
