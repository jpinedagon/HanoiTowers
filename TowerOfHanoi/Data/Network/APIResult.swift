//
//  APIResult.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 10/11/24.
//

import Foundation

enum APIResult<T> {
    case success(T)
    case failure(APIError)
    
    func dematerialize() throws -> T {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}
