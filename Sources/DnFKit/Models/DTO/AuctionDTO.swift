//
//  AuctionDTO.swift
//  DnFKit
//
//  Created by 라주영 on 7/23/25.
//

import Foundation

// MARK: - AuctionResponseDTO
public struct AuctionResponseDTO: Codable {
    public let rows: [AuctionDTO]
}

public struct AuctionDTO: Codable {
    let auctionNo: Int
    let regDate, expireDate: String
    let itemId, itemName, itemRarity: String
    let itemTypeId, itemType: String
    let itemTypeDetailId, itemTypeDetail: String
    let itemAvailableLevel: Int
    let refine, reinforce: Int
    let amplificationName: String?
    let fame, count, regCount: Int
    let price, currentPrice, unitPrice, averagePrice: Int
}
