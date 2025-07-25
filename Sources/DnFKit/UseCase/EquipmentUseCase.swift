//
//  EquipmentUseCase.swift
//  DnFKit
//
//  Created by 라주영 on 7/25/25.
//

import Foundation

public protocol EquipmentUseCaseDelegate {
    static func enchantToStirng(enchant: [StatusInfo], jobCode: String) -> String
}

public final class EquipmentUseCase: EquipmentUseCaseDelegate {
    
    public static func enchantToStirng(enchant: [StatusInfo], jobCode: String) -> String {
        var result: String = ""
        guard let jobInfo = EquipmentUseCase.jobGrowTypeMap[jobCode] else { return "" }
        let typeExceptionStats = jobInfo.attackType.exceptionStat
        let damageExceptionStats = jobInfo.damageType.exceptionStat
        let typeFilteredEnchant = enchant.filter { !typeExceptionStats.contains($0.name)}
        let damageFilteredEnchant = typeFilteredEnchant.filter { !damageExceptionStats.contains($0.name)}
        for (index, stat) in damageFilteredEnchant.enumerated() {
            let abbreviatedName = abbreviated(from: stat.name)
            result += "\(abbreviatedName):\(stat.value.formattedCleanString)"
            if index < damageFilteredEnchant.count - 1 {
                result += ", "
            }
        }
        return result
    }
    
    private static func abbreviated(from s: String) -> String {
        for (original, short) in abbreviationMap {
            if s.contains(original) {
                return s.replacingOccurrences(of: original, with: short)
            }
        }
        return s
    }
}

extension EquipmentUseCase {
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
            case .physical: ["지능", "체력", "정신력", "마법 공격력", "마법 크리티컬"]
            case .magical: ["힘", "체력", "정신력", "물리 공격력", "물리 크리티컬"]
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
    
    private static let jobGrowTypeMap: [String: JobTypeInfo] = [
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

    
    private static let abbreviationMap: [String: String] = [
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
        "공격 속도": "공속",
        "캐스팅 속도": "캐속",
        "물리 크리티컬": "물크",
        "마법 크리티컬": "마크",
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
