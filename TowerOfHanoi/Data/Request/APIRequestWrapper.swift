//
//  APIRequestWrapper.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 10/11/24.
//

import Foundation

class APIRequestWrapper {
    static var requestStore: [URLRequest: Data] = [:]
    
    static func save(request: URLRequest, body: Data?) {
        requestStore[request] = body
    }
    
    static func body(for request: URLRequest) -> Data? {
        return requestStore[request]
    }
}
