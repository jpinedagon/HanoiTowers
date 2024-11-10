//
//  APIRequestProtocol.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 10/11/24.
//

import Foundation

protocol GenericAPI {
    var session: URLSession { get }
    func fetch<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T
}

extension GenericAPI {
    func fetch<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        print("JSON String: \(String(describing: String(data: data, encoding: .utf8)))")
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed(description: "Invalid response")
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APIError.requestFailed(description: "Response code \(httpResponse.statusCode)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            throw APIError.jsonDecodeFailed(description: error.localizedDescription)
        }
    }
}
