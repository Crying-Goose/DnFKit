//
//  EquipmentUseCase.swift
//  DnFKit
//
//  Created by 라주영 on 7/25/25.
//

import Foundation

public protocol EquipmentUseCaseDelegate {
    func characterEquipInfo(server: String, id: String) async throws -> [Equipment]
    func characterBuffs(server: String, id: String) async throws -> [Buff]
}

public final class EquipmentUseCase: EquipmentUseCaseDelegate {
    
    private let repository: DnFRepository
    
    public init(repository: DnFRepository) {
        self.repository = repository
    }
    
    func groupedEnchantString(from enchant: [StatusInfo]) -> String {
        let groups: [(name: String, components: [String])] = [
            ("스탯", ["힘", "지능", "정신력", "체력"]),
            ("크리", ["물리 크리티컬 히트", "마법 크리티컬 히트"]),
            ("공격력", ["물리 공격력", "마법 공격력", "독립 공격력"])
        ]
        
        let percentKeywords = ["크리", "최종뎀", "마크", "물크", "쿨감", "스증", "공속", "캐속", "공증"]
        
        var enchantDict = Dictionary(uniqueKeysWithValues: enchant.map { ($0.name, $0.value) })
        var result: [(String, Double)] = []
        
        for group in groups {
            if group.components.allSatisfy({ enchantDict.keys.contains($0) }) {
                let average = group.components.compactMap { enchantDict[$0] }.reduce(0, +) / Double(group.components.count)
                result.append((group.name, average))
                group.components.forEach { enchantDict.removeValue(forKey: $0) }
            }
        }
        
        for (name, value) in enchantDict {
            result.append((name, value))
        }
        
        return result.map { name, value in
            let abbreviatedName = abbreviated(from: name)
            let formattedValue = value.formattedCleanString
            if percentKeywords.contains(where: { abbreviatedName.contains($0) }) {
                return "\(abbreviatedName):\(formattedValue)%"
            } else {
                return "\(abbreviatedName):\(formattedValue)"
            }
        }.joined(separator: ", ")
    }
    
    private func abbreviated(from s: String) -> String {
        for (original, short) in abbreviationMap {
            if s.contains(original) {
                return s.replacingOccurrences(of: original, with: short)
            }
        }
        return s
    }
    
    public func characterEquipInfo(server: String, id: String) async throws -> [Equipment] {
        
        let equipments = try await repository.fetchDnFCharacterEquipment(server: server, id: id)
        var makeEquipments: [Equipment] = []
        equipments.forEach { equip in
            let enchantString = groupedEnchantString(from: mergeEnchants(equip.enchant, equip.skillEnchant))
            makeEquipments.append(equip.with(enchantString: enchantString))
        }
        return makeEquipments
    }
    
    public func characterBuffs(server: String, id: String) async throws -> [Buff] {
        
        let buffs = try await repository.fetchDnFCharacterBuffs(server: server, id: id)
        let jobInfo = try await repository.fetchDnFCharacterJobInfo(server: server, id: id)
        let jobId = jobInfo.0
        let jobGrowName = jobInfo.1
        var makeBuffs: [Buff] = []
        buffs.forEach { buff in
            if !buff.optionAbility.isEmpty {
                makeBuffs.append(buff.with(optionString: buff.optionAbility))
            } else if buff.buffSkill.count > 0 {
                if let skill = buff.buffSkill.first(where: { $0.jobId == jobId })?.skills.first(where: { $0.skillId == findJobGrowName(jobId: jobId, jobGrowName: jobGrowName) }) {
                    makeBuffs.append(buff.with(optionString: "\(skill.name) 스킬Lv +\(skill.value.formattedCleanString)"))
                }
            } else {
                makeBuffs.append(buff)
            }
        }
        
        return makeBuffs
    }
    
    func findJobGrowName(jobId: String, jobGrowName: String) -> String? {
        guard let jobGroup = jobGrowSkillMap[jobId] else {
            return nil
        }
        
        return jobGroup.first(where: { $0.key == jobGrowName })?.value
    }
    
    func mergeEnchants(_ e1: [StatusInfo], _ e2: [StatusInfo]) -> [StatusInfo] {
        var mergedDict: [String: StatusInfo] = [:]

        (e1 + e2).forEach { stat in
            mergedDict[stat.name] = stat
        }

        return Array(mergedDict.values)
    }
    
    // TODO: 나중엔 Constants로 넣어야 됨
    enum AttackType {
        case physical
        case magical
        case conversion                     // 하이브리드
        case bufferMental                   // 버퍼(정신력)
        case bufferMentalOrStrength         // 버퍼(체력 또는 정신력)
        case bufferIntelligence             // 버퍼(지능)
        
        var exceptionStat: [String] {
            switch self {
            case .physical: ["지능", "체력", "정신력", "마법 공격력", "마법 크리티컬 히트"]
            case .magical: ["힘", "체력", "정신력", "물리 공격력", "물리 크리티컬 히트"]
            case .conversion: ["체력", "정신력"]
            case .bufferMental: ["힘", "지능", "체력", "물리 공격력", "마법 공격력"]
            case .bufferMentalOrStrength: ["힘", "지능", "물리 공격력", "마법 공격력"]
            case .bufferIntelligence: ["힘", "정신력", "체력", "물리 공격력", "마법 공격력"]
            }
        }
    }

    enum DamageType {
        case percent
        case fixed
        
        var exceptionStat: [String] {
            switch self {
            case .percent: ["독립 공격력"]
            case .fixed: ["물리 공격력", "마법 공격력"]
            }
        }
    }

    struct JobTypeInfo {
        let attackType: AttackType
        let damageType: DamageType
    }
    
    private let jobGrowSkillMap: [String: [String: String]] = [
        // 귀검사(남)
        "41f1cdc2ff58bb5fdc287be0db2a8df3":
            [
                "眞 웨펀마스터": "762c4e6d030eaf0abbfe1fec2b298574",
                "眞 소울브링어": "d085127b0edd719782bd618d5688f4a1",
                "眞 버서커": "0ed3148658fe37b3336ccb718dc0fdb0",
                "眞 아수라": "d0cdaca82892e54097f22a1f60817048",
                "眞 검귀": "89a4529234904fcbb3abe289e281f2fd"
            ],
        // 귀검사(여)
        "1645c45aabb008c98406b3a16447040d":
            [
                "眞 소드마스터": "8c2379737c5acc935c1731f67f607655",
                "眞 다크템플러": "6a1d1f08a6572be420bb3a256c44c015",
                "眞 데몬슬레이어": "03bb5314ffd41e9458d67ef924fef38f",
                "眞 베가본드": "dcb31a63ef58954f44ff2070c42a9a98",
                "眞 블레이드": "c39c703f72d289fcd5a8f182068140d4"
            ],
        // 격투가(남)
        "ca0f0e0e9e1d55b5f9955b03d9dd213c":
            [
                "眞 넨마스터": "04883563896fe1adac7505c6146b5f59",
                "眞 스트라이커": "dcd536f1674630f01fc9667bb202b851",
                "眞 스트리트파이터": "4b2c90ec226fd40e967875aa5eabefb2",
                "眞 그래플러": "92360eab6e1f378902018eca681ac629"
            ],
        // 격투가(여)
        "a7a059ebe9e6054c0644b40ef316d6e9":
            [
                "眞 넨마스터": "a6c8f69107f8c4f5d1a0c7a57d000290",
                "眞 스트라이커": "dcd536f1674630f01fc9667bb202b851",
                "眞 스트리트파이터": "762c4e6d030eaf0abbfe1fec2b298574",
                "眞 그래플러": "92360eab6e1f378902018eca681ac629"
            ],
        // 거너(남)
        "afdf3b989339de478e85b614d274d1ef":
            [
                "眞 레인저": "bc11d28c04e01923a093d65752c55516",
                "眞 런처": "1721e94897e9961d5c98130a13392f17",
                "眞 메카닉": "fc7a3f4c2852c832a2f20af63d5d212f",
                "眞 스핏파이어": "c47b66efd27845ef14954928ea2f95c8",
                "眞 어썰트": "c9603b05632f362bb23cae18374e37cf"
            ],
        // 거너(여)
        "944b9aab492c15a8474f96947ceeb9e4":
            [
                "眞 레인저": "bc11d28c04e01923a093d65752c55516",
                "眞 런처": "1721e94897e9961d5c98130a13392f17",
                "眞 메카닉": "fc7a3f4c2852c832a2f20af63d5d212f",
                "眞 스핏파이어": "c47b66efd27845ef14954928ea2f95c8",
                "眞 패러메딕": "e73e980e87591bc98940afb1ac0fe522"
            ],
        // 마법사(남)
        "a5ccbaf5538981c6ef99b236c0a60b73":
            [
                "眞 엘레멘탈 바머": "9bff7f2559e003766fee2853dca00631",
                "眞 빙결사": "3829c15bf5f520c13998a3479ba0ce7b",
                "眞 블러드 메이지": "5cac3411ccef1af333953e0ded5e942d",
                "眞 스위프트 마스터": "38612d8f2561edc2eb68d5057a837bfa",
                "眞 디멘션워커": "2c9d9a36c8401bddff6cdb80fab8dc24"
            ],
        // 마법사(여)
        "3909d0b188e9c95311399f776e331da5":
            [
                "眞 엘레멘탈마스터": "da6e37c1e3f0e8867f70007d89c239ff",
                "眞 소환사": "ecc23c980ea71450c0ad0c3fd232f329",
                "眞 배틀메이지": "37cf7b7a269058dc02bef5b5bc9de282",
                "眞 마도학자": "01384bbfc346775d1267fa0bc4ca605f",
                "眞 인챈트리스": "61c8cb33dd20b4ff335e8deed70d3d9c"
            ],
        // 프리스트(남)
        "f6a4ad30555b99b499c07835f87ce522":
            [
                "眞 크루세이더": "e4c354a89c337310aeb7041d5e742828",
                "眞 인파이터": "27bade584bb42fef68148d3a0b72bace",
                "眞 퇴마사": "128b9ddef2262f40723deae4407bdb42",
                "眞 어벤저": "527cdc3ecca985e18ef819d456532b26"
            ],
        // 프리스트(여)
        "0c1b401bb09241570d364420b3ba3fd7":
            [
                "眞 크루세이더": "8c2379737c5acc935c1731f67f607655",
                "眞 이단심판관": "e49e57b2e8fbeceb0a2c56a0c63fe6c5",
                "眞 무녀": "c61f5a010370101402b05b21916c2071",
                "眞 미스트리스": "0b8db1e10b3abbd24d38564e708675d5"
            ],
        // 도적
        "ddc49e9ad1ff72a00b53c6cff5b1e920":
            [
                "眞 로그": "b501ae53638d33a32351904f31cb6aa3",
                "眞 사령술사": "92360eab6e1f378902018eca681ac629",
                "眞 쿠노이치": "8572675ec6a1f50b6eff6a867376c2de",
                "眞 섀도우댄서": "7f80b887a09e88e2c4728c898bd73654"
            ],
        // 나이트
        "0ee8fa5dc525c1a1f23fc6911e921e4a":
            [
                "眞 엘븐나이트": "01384bbfc346775d1267fa0bc4ca605f",
                "眞 카오스": "c77a417c43de80c4ce32c1ed405d174a",
                "眞 팔라딘": "8b08f9504167a9c0f3a1d29d71b7943e",
                "眞 드래곤나이트": "b5e3d014f75f3d17abdea52cca57f7e9"
            ],
        // 마창사
        "3deb7be5f01953ac8b1ecaa1e25e0420":
            [
                "眞 뱅가드": "de3fea2d65c597f4d55c70a02b97fc79",
                "眞 듀얼리스트": "45442bbbe33540b4deeec29437dae70c",
                "眞 드래고니안 랜서": "669f1428193f61f9d92c743b72438c4d",
                "眞 다크 랜서": "fc458e449ee00b01dbf88d09aae65462"
            ],
        // 총검사
        "986c2b3d72ee0e4a0b7fcfbe786d4e02":
            [
                "眞 히트맨": "1721e94897e9961d5c98130a13392f17",
                "眞 요원": "fc7a3f4c2852c832a2f20af63d5d212f",
                "眞 트러블 슈터": "506e7ed77d517419a6e1c437a2cedb17",
                "眞 스페셜리스트": "d53301bb328baf12a3ae482cc6a565dd"
            ],
        // 아처
        "b9cb48777665de22c006fabaf9a560b3":
            [
                "眞 뮤즈": "78be08a3f8c834d3b06fa20c6a08c5a5",
                "眞 트래블러": "9cb6f9ed646fa87f9b7680a42ce83d1a",
                "眞 헌터": "4f2e001e9a19eb7bae50ad1840dfb329",
                "眞 비질란테": "ab6fc3303df03b58911967dfca2b5d07",
                "眞 키메라": "5f75a60c73b72ad60bd4321b96b16662"
            ],
        // 외전
        "17e417b31686389eebff6d754c3401ea":
            [
                "眞 다크나이트": "1c1a9606eb702ebe5a7bb4397f3aeae0"
            ],
        "b522a95d819a5559b775deb9a490e49a":
            [
                "眞 크리에이터": "2ff50c35efcf0f287c4c418c8454da48"
            ]
    ]
    
    private let jobGrowTypeMap: [String: JobTypeInfo] = [
        // 귀검사(남)
        "41f1cdc2ff58bb5fdc287be0db2a8df3|眞 웨펀마스터":.init(attackType: .physical, damageType: .percent),
        "41f1cdc2ff58bb5fdc287be0db2a8df3|眞 소울브링어":.init(attackType: .magical, damageType: .percent),
        "41f1cdc2ff58bb5fdc287be0db2a8df3|眞 버서커":.init(attackType: .physical, damageType: .fixed),
        "41f1cdc2ff58bb5fdc287be0db2a8df3|眞 아수라":.init(attackType: .magical, damageType: .fixed),
        "41f1cdc2ff58bb5fdc287be0db2a8df3|眞 검귀":.init(attackType: .physical, damageType: .percent),
        // 귀검사(여)
        "1645c45aabb008c98406b3a16447040d|眞 소드마스터":.init(attackType: .physical, damageType: .percent),
        "1645c45aabb008c98406b3a16447040d|眞 다크템플러":.init(attackType: .magical, damageType: .percent),
        "1645c45aabb008c98406b3a16447040d|眞 데몬슬레이어":.init(attackType: .physical, damageType: .percent),
        "1645c45aabb008c98406b3a16447040d|眞 베가본드":.init(attackType: .physical, damageType: .percent),
        "1645c45aabb008c98406b3a16447040d|眞 블레이드":.init(attackType: .physical, damageType: .fixed),
        // 격투가(남)
        "ca0f0e0e9e1d55b5f9955b03d9dd213c|眞 넨마스터":.init(attackType: .magical, damageType: .percent),
        "ca0f0e0e9e1d55b5f9955b03d9dd213c|眞 스트라이커":.init(attackType: .physical, damageType: .percent),
        "ca0f0e0e9e1d55b5f9955b03d9dd213c|眞 스트리트파이터":.init(attackType: .conversion, damageType: .percent),
        "ca0f0e0e9e1d55b5f9955b03d9dd213c|眞 그래플러":.init(attackType: .physical, damageType: .percent),
        // 격투가(여)
        "a7a059ebe9e6054c0644b40ef316d6e9|眞 넨마스터":.init(attackType: .magical, damageType: .percent),
        "a7a059ebe9e6054c0644b40ef316d6e9|眞 스트라이커":.init(attackType: .physical, damageType: .percent),
        "a7a059ebe9e6054c0644b40ef316d6e9|眞 스트리트파이터":.init(attackType: .conversion, damageType: .percent),
        "a7a059ebe9e6054c0644b40ef316d6e9|眞 그래플러":.init(attackType: .physical, damageType: .fixed),
        // 거너(남)
        "afdf3b989339de478e85b614d274d1ef|眞 레인저":.init(attackType: .physical, damageType: .percent),
        "afdf3b989339de478e85b614d274d1ef|眞 런처":.init(attackType: .physical, damageType: .percent),
        "afdf3b989339de478e85b614d274d1ef|眞 메카닉":.init(attackType: .magical, damageType: .percent),
        "afdf3b989339de478e85b614d274d1ef|眞 스핏파이어":.init(attackType: .conversion, damageType: .percent),
        "afdf3b989339de478e85b614d274d1ef|眞 어썰트":.init(attackType: .physical, damageType: .percent),
        // 거너(여)
        "944b9aab492c15a8474f96947ceeb9e4|眞 레인저":.init(attackType: .physical, damageType: .percent),
        "944b9aab492c15a8474f96947ceeb9e4|眞 런처":.init(attackType: .physical, damageType: .percent),
        "944b9aab492c15a8474f96947ceeb9e4|眞 메카닉":.init(attackType: .magical, damageType: .percent),
        "944b9aab492c15a8474f96947ceeb9e4|眞 스핏파이어":.init(attackType: .conversion, damageType: .fixed),
        "944b9aab492c15a8474f96947ceeb9e4|眞 패러메딕":.init(attackType: .bufferMental, damageType: .fixed),
        // 마법사(남)
        "a5ccbaf5538981c6ef99b236c0a60b73|眞 엘레멘탈 바머":.init(attackType: .magical, damageType: .percent),
        "a5ccbaf5538981c6ef99b236c0a60b73|眞 빙결사":.init(attackType: .magical, damageType: .percent),
        "a5ccbaf5538981c6ef99b236c0a60b73|眞 블러드 메이지":.init(attackType: .physical, damageType: .percent),
        "a5ccbaf5538981c6ef99b236c0a60b73|眞 스위프트 마스터":.init(attackType: .physical, damageType: .percent),
        "a5ccbaf5538981c6ef99b236c0a60b73|眞 디멘션워커":.init(attackType: .magical, damageType: .fixed),
        // 마법사(여)
        "3909d0b188e9c95311399f776e331da5|眞 엘레멘탈마스터":.init(attackType: .magical, damageType: .percent),
        "3909d0b188e9c95311399f776e331da5|眞 소환사":.init(attackType: .magical, damageType: .percent),
        "3909d0b188e9c95311399f776e331da5|眞 배틀메이지":.init(attackType: .conversion, damageType: .percent),
        "3909d0b188e9c95311399f776e331da5|眞 마도학자":.init(attackType: .magical, damageType: .fixed),
        "3909d0b188e9c95311399f776e331da5|眞 인챈트리스":.init(attackType: .bufferIntelligence, damageType: .fixed),
        // 프리스트(남)
        "f6a4ad30555b99b499c07835f87ce522|眞 크루세이더":.init(attackType: .bufferMentalOrStrength, damageType: .fixed),
        "f6a4ad30555b99b499c07835f87ce522|眞 인파이터":.init(attackType: .physical, damageType: .percent),
        "f6a4ad30555b99b499c07835f87ce522|眞 퇴마사":.init(attackType: .conversion, damageType: .percent),
        "f6a4ad30555b99b499c07835f87ce522|眞 어벤저":.init(attackType: .magical, damageType: .percent),
        // 프리스트(여)
        "0c1b401bb09241570d364420b3ba3fd7|眞 크루세이더":.init(attackType: .bufferIntelligence, damageType: .fixed),
        "0c1b401bb09241570d364420b3ba3fd7|眞 이단심판관":.init(attackType: .physical, damageType: .percent),
        "0c1b401bb09241570d364420b3ba3fd7|眞 무녀":.init(attackType: .magical, damageType: .percent),
        "0c1b401bb09241570d364420b3ba3fd7|眞 미스트리스":.init(attackType: .magical, damageType: .percent),
        // 도적
        "ddc49e9ad1ff72a00b53c6cff5b1e920|眞 로그":.init(attackType: .physical, damageType: .percent),
        "ddc49e9ad1ff72a00b53c6cff5b1e920|眞 사령술사":.init(attackType: .magical, damageType: .percent),
        "ddc49e9ad1ff72a00b53c6cff5b1e920|眞 쿠노이치":.init(attackType: .magical, damageType: .percent),
        "ddc49e9ad1ff72a00b53c6cff5b1e920|眞 섀도우댄서":.init(attackType: .physical, damageType: .percent),
        // 나이트
        "0ee8fa5dc525c1a1f23fc6911e921e4a|眞 엘븐나이트":.init(attackType: .physical, damageType: .percent),
        "0ee8fa5dc525c1a1f23fc6911e921e4a|眞 카오스":.init(attackType: .magical, damageType: .fixed),
        "0ee8fa5dc525c1a1f23fc6911e921e4a|眞 팔라딘":.init(attackType: .physical, damageType: .percent),
        "0ee8fa5dc525c1a1f23fc6911e921e4a|眞 드래곤나이트":.init(attackType: .physical, damageType: .fixed),
        // 마창사
        "3deb7be5f01953ac8b1ecaa1e25e0420|眞 뱅가드":.init(attackType: .physical, damageType: .percent),
        "3deb7be5f01953ac8b1ecaa1e25e0420|眞 듀얼리스트":.init(attackType: .physical, damageType: .percent),
        "3deb7be5f01953ac8b1ecaa1e25e0420|眞 드래고니안 랜서":.init(attackType: .magical, damageType: .percent),
        "3deb7be5f01953ac8b1ecaa1e25e0420|眞 다크 랜서":.init(attackType: .magical, damageType: .percent),
        // 총검사
        "986c2b3d72ee0e4a0b7fcfbe786d4e02|眞 히트맨":.init(attackType: .physical, damageType: .percent),
        "986c2b3d72ee0e4a0b7fcfbe786d4e02|眞 요원":.init(attackType: .physical, damageType: .percent),
        "986c2b3d72ee0e4a0b7fcfbe786d4e02|眞 트러블 슈터":.init(attackType: .physical, damageType: .percent),
        "986c2b3d72ee0e4a0b7fcfbe786d4e02|眞 스페셜리스트":.init(attackType: .magical, damageType: .percent),
        // 아처
        "b9cb48777665de22c006fabaf9a560b3|眞 뮤즈":.init(attackType: .bufferMental, damageType: .fixed),
        "b9cb48777665de22c006fabaf9a560b3|眞 트래블러":.init(attackType: .physical, damageType: .percent),
        "b9cb48777665de22c006fabaf9a560b3|眞 헌터":.init(attackType: .physical, damageType: .percent),
        "b9cb48777665de22c006fabaf9a560b3|眞 비질란테":.init(attackType: .magical, damageType: .percent),
        "b9cb48777665de22c006fabaf9a560b3|眞 키메라":.init(attackType: .physical, damageType: .fixed),
        // 외전
        "17e417b31686389eebff6d754c3401ea|眞 다크나이트":.init(attackType: .conversion, damageType: .percent),
        "b522a95d819a5559b775deb9a490e49a|眞 크리에이터":.init(attackType: .magical, damageType: .fixed)
    ]

    
    private let abbreviationMap: [String: String] = [
        "화속성저항": "화속저",
        "수속성저항": "수속저",
        "명속성저항": "명속저",
        "암속성저항": "암속저",
        "화속성강화": "화속강",
        "수속성강화": "수속강",
        "명속성강화": "명속강",
        "암속성강화": "암속강",
        "물리 공격력": "물공",
        "마법 공격력": "마공",
        "독립 공격력": "독공",
        "공격력 증폭": "공증",
        "최종 데미지": "최종뎀",
        "모든 속성 강화": "모속강",
        "스킬 공격력 증가": "스증",
        "공격속도": "공속",
        "캐스트속도": "캐속",
        "물리 크리티컬 히트": "물크",
        "마법 크리티컬 히트": "마크",
        "스킬 쿨타임 감소": "쿨감",
        "모험가 명성": "명성"
    ]
}

extension Double {
    var cleanString: String {
        return self.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", self)
            : String(self)
    }
    
    var formattedCleanString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = self.truncatingRemainder(dividingBy: 1) == 0 ? 0 : 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? String(self)
    }
}
