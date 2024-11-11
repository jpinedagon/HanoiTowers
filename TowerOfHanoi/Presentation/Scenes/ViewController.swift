//
//  ViewController.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 07/11/24.
//

import UIKit
import Combine

class ViewController: UIViewController {
    /// MARK: - Outlets
    @IBOutlet weak var discNumberTextField: UITextField!
    @IBOutlet weak var solveButton: UIButton!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var thirdStackView: UIStackView!
    /// MARK: - Properties
    private var viewModel: HanoiViewModel?
    private var cancelBag = Set<AnyCancellable>()
    private let configurator = HanoiConfiguratorImplementation()
    private var numberOfDisks: Int = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = configurator.configure()
        setupView()
    }
    
    private func setupView() {
        let toolBar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: UIScreen.main.bounds.width, height: 30)))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Set", style: .done, target: self, action: #selector(handleSetButtonOnTextfield))
        
        toolBar.setItems([flexSpace, doneBtn], animated: false)
        toolBar.sizeToFit()
        
        discNumberTextField.inputAccessoryView = toolBar
        solveButton.setState(isEnabled: false)
        bind()
    }
    
    @objc private func handleSetButtonOnTextfield() {
        guard let text = discNumberTextField.text,
              !text.isEmpty else { return }
        setupDisks(numberOfDisks: Int(text) ?? .zero)
        solveButton.setState(isEnabled: true)
        view.endEditing(true)
    }
    
    private func bind() {
        viewModel?.output.showFailureMessage.sink(receiveValue: { [weak self] message in
            guard let self = self else { return }
            self.solveButton.setState(isEnabled: true)
        }).store(in: &cancelBag)
        viewModel?.output.showSolution.sink(receiveValue: { [weak self] solution in
            guard let self = self else { return }
            self.showSolution(steps: solution.steps)
        }).store(in: &cancelBag)
    }
    
    @IBAction func solveTower(_ sender: UIButton) {
        viewModel?.input.solveHanoi.send(numberOfDisks)
        solveButton.setState(isEnabled: false)
    }
    
    private func showSolution(steps: [String]) {
        var stepIndex: Int = .zero
        let rods: [Character: UIStackView] = [
            "A": firstStackView,
            "B": secondStackView,
            "C": thirdStackView
        ]
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
            guard stepIndex < steps.count else {
                timer.invalidate()
                return
            }
            let step = steps[stepIndex]
            let components = step.components(separatedBy: " ")
            guard
                components.count >= 7,
                let fromRod = components[5].last,
                let toRod = components[8].last,
                let originTower = rods[fromRod],
                let destinationTower = rods[toRod] else {
                return
            }
            
            if let diskView = originTower.arrangedSubviews.first {
                self.moveDisk(disk: diskView, from: originTower, to: destinationTower)
            }
            stepIndex += 1
        }
    }
    
    
    private func moveDisk(disk: UIView,
                          from origin: UIStackView,
                          to destination: UIStackView) {
        origin.removeArrangedSubview(disk)
        disk.removeFromSuperview()
        
        destination.insertArrangedSubview(disk, at: .zero)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupDisks(numberOfDisks: Int) {
        cleanUI()
        self.numberOfDisks = numberOfDisks
        let maxWidth = firstStackView.frame.width
        let diskHeight: CGFloat = 20
        
        for i in (0..<numberOfDisks).reversed() {
            let width = maxWidth - (CGFloat(i) * (maxWidth / CGFloat(numberOfDisks) * 0.4))
            let diskView = UIView()
            diskView.backgroundColor = .random
            diskView.layer.cornerRadius = diskHeight / 4
            diskView.translatesAutoresizingMaskIntoConstraints = false
            
            diskView.heightAnchor.constraint(equalToConstant: diskHeight).isActive = true
            diskView.widthAnchor.constraint(equalToConstant: width).isActive = true
            
            firstStackView.addArrangedSubview(diskView)
        }
    }
    
    private func cleanUI() {
        numberOfDisks = .zero
        firstStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        secondStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        thirdStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
