//
//  URLRequest+Ext.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 10/11/24.
//

import Foundation

private var httpBodyKey: UInt8 = 0

extension URLRequest {
    var storedHttpBody: Data? {
        get { objc_getAssociatedObject(self, &httpBodyKey) as? Data }
        set { objc_setAssociatedObject(self, &httpBodyKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
