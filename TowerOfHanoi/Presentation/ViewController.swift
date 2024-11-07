//
//  ViewController.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 07/11/24.
//

import UIKit

class ViewController: UIViewController {
    
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
        view.endEditing(true)
    }

    @IBAction func solveTower(_ sender: UIButton) {
        
    }
}
