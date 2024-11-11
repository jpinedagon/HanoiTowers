//
//  HanoiConfigurator.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 10/11/24.
//

import Foundation

protocol HanoiConfigurator {
    func configure() -> HanoiViewModel
}

class HanoiConfiguratorImplementation: @preconcurrency HanoiConfigurator {
    @MainActor func configure() -> HanoiViewModel {
        // ApiClient
        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self]
        let apiClient = APIClient(session: URLSession(configuration: config))
        // ApiGateway
        let apiGateway = HanoiGatewayImplementation(apiClient: apiClient)
        // UseCase
        let useCase = SolveHanoiUseCaseImplementation(apiGateway: apiGateway)
        // ViewModel
        return HanoiViewModel(useCase: useCase,
                              input: HanoiViewModel.Input(),
                              output: HanoiViewModel.Output())
    }
}
