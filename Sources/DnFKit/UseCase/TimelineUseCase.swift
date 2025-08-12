//
//  TimelineUseCase.swift
//  DnFKit
//
//  Created by 라주영 on 8/13/25.
//

import Foundation

public protocol TimelineUseCaseDelegate {
    func timelines(server: String, id: String, date: Date?) async throws -> [Timeline]
}

public final class TimelineUseCase: TimelineUseCaseDelegate {
    
    private let calendar = Calendar.current
    private let minDate: Date = {
        var components = DateComponents()
        components.year = 2025
        components.month = 1
        components.day = 9
        return Calendar.current.date(from: components)!
    }()
    
    private let repository: DnFRepository
    
    public init(repository: DnFRepository) {
        self.repository = repository
    }
    
    // 타임라인 조회 요청
    public func timelines(server: String, id: String, date: Date?) async throws -> [Timeline] {
        
        var results: [Timeline] = []
        let today = Date()
        var currentDate = date ?? minDate
        
        while currentDate < today {
            let range = dateRange(from: currentDate)
            let timeline = try await repository.fetchDnFTimeline(
                server: server,
                id: id,
                startDate: range.start,
                endDate: range.end
            )
            results.append(timeline)
            
            if today < range.start {
                break
            }
            
            currentDate = range.end
        }
        
        if results.isEmpty {
            throw NSError(domain: "타임라인 정보 없음", code: 0, userInfo: nil)
        }

        return results
    }
    
    // 주간 단위 조회
    func dateRange(from date: Date) -> (start: Date, end: Date) {
        
        let today = Date()
        let reference = date
        
        // 시작일 보정
        let start = max(reference, minDate)

        var end = calendar.date(byAdding: .day, value: 6, to: start)!

        if end > today {
            end = today
        }
        
        return (start, end)
    }
}
