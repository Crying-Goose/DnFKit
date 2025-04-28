//
//  DnFService.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import Foundation
import Moya

public final class DnFService {
    private let provider = MoyaProvider<DnFTarget>()

    public init() {}

    public func fetchCharacter(name: String, completion: @escaping (Result<Character, Error>) -> Void) {
        provider.request(.character(name: name)) { result in
            switch result {
            case .success(let response):
                do {
                    let character = try JSONDecoder().decode(Character.self, from: response.data)
                    completion(.success(character))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
