//
//  UIColor+Ext.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 07/11/24.
//

import UIKit
 
extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
