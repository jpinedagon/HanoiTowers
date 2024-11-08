//
//  ViewController.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 07/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var towerContainerView: UIView!
    @IBOutlet weak var towerContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var discNumberTextField: UITextField!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var thirdStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let toolBar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: UIScreen.main.bounds.width, height: 30)))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Set", style: .done, target: self, action: #selector(handleSetButtonOnTextfield))
        
        toolBar.setItems([flexSpace, doneBtn], animated: false)
        toolBar.sizeToFit()
        
        discNumberTextField.inputAccessoryView = toolBar
    }
    
    @objc private func handleSetButtonOnTextfield() {
        guard let text = discNumberTextField.text,
              !text.isEmpty else { return }
        setupDisks(numberOfDisks: Int(text) ?? .zero)
        view.endEditing(true)
    }

    @IBAction func solveTower(_ sender: UIButton) {
        
    }
    
    private func setupDisks(numberOfDisks: Int) {
        cleanUI()
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
        adjustContainerHeight(for: numberOfDisks)
    }
    
    private func adjustContainerHeight(for disks: Int) {
        let diskHeight: CGFloat = 20
        let totalHeight: CGFloat = CGFloat(disks) * diskHeight
        
        towerContainerViewHeightConstraint.constant = totalHeight
        towerContainerView.layoutIfNeeded()
    }
    
    private func cleanUI() {
        firstStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        secondStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        thirdStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
    }
}
