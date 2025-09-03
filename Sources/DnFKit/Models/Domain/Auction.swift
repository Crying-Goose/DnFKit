//
//  Auction.swift
//  DnFKit
//
//  Created by 라주영 on 7/23/25.
//

import Foundation

public struct Auction: Sendable {
    public let itemId: String
    public let itemName: String
    public let auctionNo: Int
    public let regDate: String
    public let expireDate: String
    public let count: Int
    public let unitPrice: Int
    public let averagePrice: Int
    
    init(dto: AuctionDTO) {
        self.itemId = dto.itemId
        self.itemName = dto.itemName
        self.auctionNo = dto.auctionNo
        self.regDate = dto.regDate
        self.expireDate = dto.expireDate
        self.count = dto.count
        self.unitPrice = dto.unitPrice
        self.averagePrice = dto.averagePrice
    }
}
