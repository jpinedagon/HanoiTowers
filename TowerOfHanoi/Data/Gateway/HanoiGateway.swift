//
//  HanoiGateway.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 10/11/24.
//

import Foundation

protocol HanoiGateway {
    var apiClient: APIClient { get set }
    func solveHanoi(parameters: SolveHanoiRequest) async -> APIResult<HanoiResponse>
}

class HanoiGatewayImplementation: HanoiGateway {
    internal var apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func solveHanoi(parameters: SolveHanoiRequest) async -> APIResult<HanoiResponse> {
        guard let urlRequest = parameters.apiRequest else { return .failure(APIError.unknown) }
        Constants.disksNumber = parameters.parameters.disks
        do {
            let response = try await apiClient.fetch(type: HanoiResponse.self, with: urlRequest)
            return .success(response)
        } catch {
            return .failure(APIError.requestFailed(description: error.localizedDescription))
        }
    }
}
