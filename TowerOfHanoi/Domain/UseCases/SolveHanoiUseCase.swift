//
//  SolveHanoiUseCase.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 10/11/24.
//

import Foundation

protocol SolveHanoiUseCase {
    var apiGateway: HanoiGateway { get set }
    func solveHanoi(parameters: SolveHanoiRequest) async -> APIResult<HanoiSolutionDTO>
}

class SolveHanoiUseCaseImplementation: SolveHanoiUseCase {
    var apiGateway: HanoiGateway
    
    init(apiGateway: HanoiGateway) {
        self.apiGateway = apiGateway
    }
    
    func solveHanoi(parameters: SolveHanoiRequest) async -> APIResult<HanoiSolutionDTO> {
        let response = await apiGateway.solveHanoi(parameters: parameters)
        switch response {
        case .success(let solution):
            return .success(HanoiSolutionDTO(steps: solution.solution))
        case .failure(let error):
            return .failure(error)
        }
    }
}
