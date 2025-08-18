//
//  EquipmentUseCase.swift
//  DnFKit
//
//  Created by 라주영 on 7/25/25.
//

import Foundation

public protocol EquipmentUseCaseDelegate {
    func characterEquipInfo(server: String, id: String) async throws -> Equipments
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
    
    public func characterEquipInfo(server: String, id: String) async throws -> Equipments {
        
        let equipments = try await repository.fetchDnFCharacterEquipment(
            server: server,
            id: id
        )
        var makeEquipments: [Equipment] = []
        equipments.equipments.forEach { equip in
            let enchantString = groupedEnchantString(
                from: mergeEnchants(
                    equip.enchant,
                    equip.skillEnchant
                )
            )
            makeEquipments.append(equip.with(enchantString: enchantString))
        }
        return equipments.with(equipments: makeEquipments)
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
