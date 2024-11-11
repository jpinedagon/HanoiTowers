//
//  SolveHanoiRequest.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 10/11/24.
//

import Foundation

class SolveHanoiRequest: APIRequest {
    let parameters: HanoiDisks
    
    init(parameters: HanoiDisks) {
        self.parameters = parameters
    }
    
    var apiRequest: URLRequest? {
        var request = URLRequest(url: Constants.mockURL)
        request.httpMethod = HTTPMethod.POST
        do {
            let bodyData = try JSONEncoder().encode(parameters)
            request.httpBody = bodyData
            request.storedHttpBody = bodyData
            return request
        } catch {
            return nil
        }
    }
}
