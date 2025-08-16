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
            case .legendary: return "FF7800"
            case .epic: return "FFB400"
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

public let jobGrowSkillMap: [String: [String: String]] = [
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

// TODO: 추후 S3 서버에서 가져오는 방식으로 처리할 수 있도록 수정 필요.
public let jobGrowImageMap: [String: [String: String]] = [
    // 귀검사(남)
    "41f1cdc2ff58bb5fdc287be0db2a8df3":
        [
            "眞 웨펀마스터": "01_3",
            "眞 소울브링어": "02_3",
            "眞 버서커": "03_3",
            "眞 아수라": "04_3",
            "眞 검귀": "05_3"
        ],
    // 귀검사(여)
    "1645c45aabb008c98406b3a16447040d":
        [
            "眞 소드마스터": "06_3",
            "眞 다크템플러": "07_3",
            "眞 데몬슬레이어": "07_3",
            "眞 베가본드": "08_3",
            "眞 블레이드": "62_3"
        ],
    // 격투가(남)
    "ca0f0e0e9e1d55b5f9955b03d9dd213c":
        [
            "眞 넨마스터": "10_3",
            "眞 스트라이커": "11_3",
            "眞 스트리트파이터": "12_3",
            "眞 그래플러": "13_3"
        ],
    // 격투가(여)
    "a7a059ebe9e6054c0644b40ef316d6e9":
        [
            "眞 넨마스터": "14_3",
            "眞 스트라이커": "15_3",
            "眞 스트리트파이터": "16_3",
            "眞 그래플러": "17_3"
        ],
    // 거너(남)
    "afdf3b989339de478e85b614d274d1ef":
        [
            "眞 레인저": "18_3",
            "眞 런처": "19_3",
            "眞 메카닉": "20_3",
            "眞 스핏파이어": "21_3",
            "眞 어썰트": "63_3"
        ],
    // 거너(여)
    "944b9aab492c15a8474f96947ceeb9e4":
        [
            "眞 레인저": "22_3",
            "眞 런처": "23_3",
            "眞 메카닉": "24_3",
            "眞 스핏파이어": "25_3",
            "眞 패러메딕": "69_3"
        ],
    // 마법사(남)
    "a5ccbaf5538981c6ef99b236c0a60b73":
        [
            "眞 엘레멘탈 바머": "26_3",
            "眞 빙결사": "27_3",
            "眞 블러드 메이지": "28_3",
            "眞 스위프트 마스터": "29_3",
            "眞 디멘션워커": "30_3"
        ],
    // 마법사(여)
    "3909d0b188e9c95311399f776e331da5":
        [
            "眞 엘레멘탈마스터": "31_3",
            "眞 소환사": "32_3",
            "眞 배틀메이지": "33_3",
            "眞 마도학자": "34_3",
            "眞 인챈트리스": "35_3"
        ],
    // 프리스트(남)
    "f6a4ad30555b99b499c07835f87ce522":
        [
            "眞 크루세이더": "36_3",
            "眞 인파이터": "37_3",
            "眞 퇴마사": "38_3",
            "眞 어벤저": "39_3"
        ],
    // 프리스트(여)
    "0c1b401bb09241570d364420b3ba3fd7":
        [
            "眞 크루세이더": "40_3",
            "眞 이단심판관": "41_3",
            "眞 무녀": "42_3",
            "眞 미스트리스": "43_3"
        ],
    // 도적
    "ddc49e9ad1ff72a00b53c6cff5b1e920":
        [
            "眞 로그": "44_3",
            "眞 사령술사": "45_3",
            "眞 쿠노이치": "46_3",
            "眞 섀도우댄서": "47_3"
        ],
    // 나이트
    "0ee8fa5dc525c1a1f23fc6911e921e4a":
        [
            "眞 엘븐나이트": "48_3",
            "眞 카오스": "49_3",
            "眞 팔라딘": "50_3",
            "眞 드래곤나이트": "51_3"
        ],
    // 마창사
    "3deb7be5f01953ac8b1ecaa1e25e0420":
        [
            "眞 뱅가드": "52_3",
            "眞 듀얼리스트": "53_3",
            "眞 드래고니안 랜서": "54_3",
            "眞 다크 랜서": "55_3"
        ],
    // 총검사
    "986c2b3d72ee0e4a0b7fcfbe786d4e02":
        [
            "眞 히트맨": "56_3",
            "眞 트러블 슈터": "57_3",
            "眞 요원": "58_3",
            "眞 스페셜리스트": "59_3"
        ],
    // 아처
    "b9cb48777665de22c006fabaf9a560b3":
        [
            "眞 뮤즈": "64_3",
            "眞 트래블러": "65_3",
            "眞 헌터": "66_3",
            "眞 비질란테": "67_3",
            "眞 키메라": "68_3"
        ],
    // 외전
    "17e417b31686389eebff6d754c3401ea":
        [
            "眞 다크나이트": "60_3"
        ],
    "b522a95d819a5559b775deb9a490e49a":
        [
            "眞 크리에이터": "61_3"
        ]
]

public let jobGrowTypeMap: [String: JobTypeInfo] = [
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

public enum AttackType: Sendable {
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

public enum DamageType: Sendable {
    case percent
    case fixed
    
    var exceptionStat: [String] {
        switch self {
        case .percent: ["독립 공격력"]
        case .fixed: ["물리 공격력", "마법 공격력"]
        }
    }
}

public struct JobTypeInfo: Sendable{
    let attackType: AttackType
    let damageType: DamageType
}

public let abbreviationMap: [String: String] = [
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
