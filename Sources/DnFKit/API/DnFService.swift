//
//  DnFService.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation
import Moya

public protocol DnFAPIServiceProtocol {
    func getCharacters(name: String) async throws -> CharacterResponseDTO
    func getCharacterInfo(server: String, id: String) async throws -> CharacterResponseDTO
    func getStatus(server: String, id: String) async throws -> StatusResponseDTO
    func getEquipment(server: String, id: String) async throws -> EquipmentResponseDTO
    func getAvatar(server: String, id: String) async throws -> AvatarResponseDTO
    func getCreature(server: String, id: String) async throws -> CreatureResponseDTO
}

struct CustomURLLoggerPlugin: PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        print("🌐 요청 URL:", request.request?.url?.absoluteString ?? "없음")
    }
}

public final class DnFService: DnFAPIServiceProtocol {
    
    private let provider = MoyaProvider<DnFTarget>(plugins: [CustomURLLoggerPlugin()])

    public init() {}
    
    // 캐릭터 검색
    public func getCharacters(name: String) async throws -> CharacterResponseDTO {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.characters(name: name)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder()
                        let dto = try decoder.decode(CharacterResponseDTO.self, from: response.data)
                        continuation.resume(returning: dto)
                    } catch {
                        print("❌ JSON Decoding Failed:", error)
                        print(String(data: response.data, encoding: .utf8) ?? "No Response")
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }


    // 캐릭터 기본 정보 조회
    public func getCharacterInfo(server: String, id: String) async throws -> CharacterResponseDTO {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.characterInfo(server: server, characterId: id)) { result in
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
    
    // 캐릭터 능력치 정보 조회
    public func getStatus(server: String, id: String) async throws -> StatusResponseDTO {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.status(server: server, characterId: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let dto = try JSONDecoder().decode(StatusResponseDTO.self, from: response.data)
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
    
    // 캐릭터 장비 정보 조회
    public func getEquipment(server: String, id: String) async throws -> EquipmentResponseDTO {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.equipment(server: server, characterId: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let dto = try JSONDecoder().decode(EquipmentResponseDTO.self, from: response.data)
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
    
    // 캐릭터 아바타 정보 조회
    public func getAvatar(server: String, id: String) async throws -> AvatarResponseDTO {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.avatar(server: server, characterId: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let dto = try JSONDecoder().decode(AvatarResponseDTO.self, from: response.data)
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
    
    // 캐릭터 크리쳐 정보 조회
    public func getCreature(server: String, id: String) async throws -> CreatureResponseDTO {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.creature(server: server, characterId: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let dto = try JSONDecoder().decode(CreatureResponseDTO.self, from: response.data)
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
