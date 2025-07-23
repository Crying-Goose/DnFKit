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
    func getCharacter(server: String, name: String) async throws -> CharacterResponseDTO
    func getCharacterInfo(server: String, id: String) async throws -> CharacterDTO
    func getStatus(server: String, id: String) async throws -> StatusResponseDTO
    func getEquipment(server: String, id: String) async throws -> EquipmentResponseDTO
    func getAvatar(server: String, id: String) async throws -> AvatarResponseDTO
    func getCreature(server: String, id: String) async throws -> CreatureResponseDTO
    func getBuffEquipment(server: String, id: String) async throws -> BuffEquipmentResponseDTO
    func getBuffAvatar(server: String, id: String) async throws -> BuffEquipmentResponseDTO
    func getBuffCreature(server: String, id: String) async throws -> BuffEquipmentResponseDTO
    func getFlag(server: String, id: String) async throws -> FlagResponseDTO
    func getSkills(server: String, id: String) async throws -> SkillStyleResponseDTO
    func getTimeline(server: String, id: String, code: [Int], date: Date, next: String?) async throws -> TimelineResponseDTO
    func getItems(name: String) async throws -> ItemResponseDTO
    func getItem(name: String, workType: String) async throws -> ItemResponseDTO
    func getAuction(id: String) async throws -> AuctionResponseDTO
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
    
    // 캐릭터 검색(서버)
    public func getCharacter(server: String, name: String) async throws -> CharacterResponseDTO {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.character(server: server, name: name)) { result in
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
    public func getCharacterInfo(server: String, id: String) async throws -> CharacterDTO {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.characterInfo(server: server, characterId: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let dto = try JSONDecoder().decode(CharacterDTO.self, from: response.data)
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
    
    // 캐릭터 버프 강화 장비 정보 조회
    public func getBuffEquipment(server: String, id: String) async throws -> BuffEquipmentResponseDTO {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.buffEquipment(server: server, characterId: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let dto = try JSONDecoder().decode(BuffEquipmentResponseDTO.self, from: response.data)
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
    
    // 캐릭터 버프 강화 아바타 정보 조회
    public func getBuffAvatar(server: String, id: String) async throws -> BuffEquipmentResponseDTO {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.buffAvatar(server: server, characterId: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let dto = try JSONDecoder().decode(BuffEquipmentResponseDTO.self, from: response.data)
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
    
    // 캐릭터 버프 강화 크리쳐 정보 조회
    public func getBuffCreature(server: String, id: String) async throws -> BuffEquipmentResponseDTO {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.buffCreature(server: server, characterId: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let dto = try JSONDecoder().decode(BuffEquipmentResponseDTO.self, from: response.data)
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
    
    // 캐릭터(모험단) 휘장 정보 조회
    public func getFlag(server: String, id: String) async throws -> FlagResponseDTO {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.flag(server: server, characterId: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let dto = try JSONDecoder().decode(FlagResponseDTO.self, from: response.data)
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
    
    // 캐릭터 스킬 정보 조회
    public func getSkills(server: String, id: String) async throws -> SkillStyleResponseDTO {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.skill(server: server, characterId: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let dto = try JSONDecoder().decode(SkillStyleResponseDTO.self, from: response.data)
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
    
    // 캐릭터 타임라인 조회
    public func getTimeline(server: String, id: String, code: [Int], date: Date, next: String?) async throws -> TimelineResponseDTO {
        return try await withCheckedThrowingContinuation { continuation in
            let calendar = Calendar.current
            let startDate = calendar.date(byAdding: .month, value: -1, to: date)
            let codeString = code.map { String($0) }.joined(separator: ",")
            provider.request(.timeline(server: server, characterId: id, startDate: startDate ?? date, endDate: date, code: codeString, next: next)) { result in
                switch result {
                case .success(let response):
                    do {
                        let dto = try JSONDecoder().decode(TimelineResponseDTO.self, from: response.data)
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
    
    // 아이템 조회
    public func getItems(name: String) async throws -> ItemResponseDTO {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.item(name: name)) { result in
                switch result {
                case .success(let response):
                    do {
                        let dto = try JSONDecoder().decode(ItemResponseDTO.self, from: response.data)
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
    
    // 아이템 조회(단일)
    public func getItem(name: String, workType: String) async throws -> ItemResponseDTO {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.item(name: name, wordType: workType)) { result in
                switch result {
                case .success(let response):
                    do {
                        let dto = try JSONDecoder().decode(ItemResponseDTO.self, from: response.data)
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
    
    // 경매장 검색
    public func getAuction(id: String) async throws -> AuctionResponseDTO {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.auction(id: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let dto = try JSONDecoder().decode(AuctionResponseDTO.self, from: response.data)
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
