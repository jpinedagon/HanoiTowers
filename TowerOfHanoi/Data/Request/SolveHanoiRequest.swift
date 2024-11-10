//
//  SolveHanoiRequest.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 10/11/24.
//

import Foundation

struct SolveHanoiRequest: APIRequest {
    let parameters: HanoiDisks
    
    var apiRequest: URLRequest? {
        var request = URLRequest(url: Constants.mockURL)
        request.httpMethod = HTTPMethod.POST
        request.httpBody = try? JSONEncoder().encode(parameters)
        return request
    }
}
