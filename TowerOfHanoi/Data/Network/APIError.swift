//
//  APIError.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 10/11/24.
//

import Foundation

enum APIError: Error {
    case requestFailed(description: String)
    case jsonDecodeFailed(description: String)
    case unknown
    
    var customDescription: String {
        switch self {
        case let .requestFailed(description):
            return "The request has failed due to: \(description)"
        case let .jsonDecodeFailed(description):
            return "Couldn't parse data due \(description)"
        case .unknown:
            return "The request has failed"
        }
    }
}
