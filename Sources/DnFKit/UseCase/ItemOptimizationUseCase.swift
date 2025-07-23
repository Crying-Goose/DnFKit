//
//  ItemOptimizationUseCase.swift
//  DnFKit
//
//  Created by 라주영 on 7/23/25.
//

import Foundation

public protocol ItemOptimizationUseCaseDelegate {
    // return: Item 정보, 최저가, 평균가
    func octionLowestPrice(name: String) async throws -> (Item, Int, Int)
}

public final class ItemOptimizationUseCase: ItemOptimizationUseCaseDelegate {
    
    
    private let repository: DnFRepository
    
    public init(repository: DnFRepository) {
        self.repository = repository
    }
    
    public func octionLowestPrice(name: String) async throws -> (Item, Int, Int) {
        let item = try await repository.fetchDnFItem(name: name)
        guard let item = item
        else { throw NSError(domain: "", code: 0, userInfo: nil) }
        
        let auctions = try await repository.fetchDnFAuction(id: item.id)
        guard let auction = auctions.first
        else { throw NSError(domain: "", code: 0, userInfo: nil) }
        let unitPrice = auction.unitPrice
        let averagePrice = auction.averagePrice
        return (item, unitPrice, averagePrice)
    }
}
