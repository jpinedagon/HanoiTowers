//
//  HanoiViewModel.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 10/11/24.
//

import Combine

@MainActor
class HanoiViewModel {
    var cancelBag = Set<AnyCancellable>()
    let useCase: SolveHanoiUseCase
    let input: Input
    let output: Output
    
    class Input {
        let solveHanoi = PassthroughSubject<Int, Never>()
    }
    
    class Output {
        let showSolution = PassthroughSubject<HanoiSolutionDTO, Never>()
        let showFailureMessage = PassthroughSubject<String, Never>()
    }
    
    init(useCase: SolveHanoiUseCase,
         input: Input,
         output: Output) {
        self.useCase = useCase
        self.input = input
        self.output = output
        bind()
    }
    
    private func bind() {
        input.solveHanoi.sink { [weak self] numberOfDisks in
            guard let self = self else { return }
            let hanoiDisks = HanoiDisks(disks: numberOfDisks)
            let request = SolveHanoiRequest(parameters: hanoiDisks)
            Task {
                let response = await self.useCase.solveHanoi(parameters: request)
                switch response {
                case .success(let solution):
                    self.output.showSolution.send(solution)
                case .failure(let error):
                    self.output.showFailureMessage.send(error.customDescription)
                }
            }
        }.store(in: &cancelBag)
    }
}
