//
//  DnFStatUseCase.swift
//  DnFKit
//
//  Created by 라주영 on 7/9/25.
//

import Foundation

public protocol CharacterStatUseCaseDelegate {
    
}

public final class CharacterStatUseCase: CharacterStatUseCaseDelegate {
    
    private let repository: DnFRepository
    
    public init(repository: DnFRepository) {
        self.repository = repository
    }
    
    
}
