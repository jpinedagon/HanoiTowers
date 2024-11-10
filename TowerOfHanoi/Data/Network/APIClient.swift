//
//  APIClient.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 10/11/24.
//

import Foundation

final class APIClient: GenericAPI {
    var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
}
