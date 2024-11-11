//
//  UIButton+Ext.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 10/11/24.
//

import UIKit

extension UIButton {
    func setState(isEnabled: Bool) {
        backgroundColor = isEnabled ? .link : .darkGray
        self.isEnabled = isEnabled
    }
}
