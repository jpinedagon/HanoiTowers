//
//  SolveHanoiAPI.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 07/11/24.
//

import Foundation

func solveHanoiAPI(numDisk: Int, completion: @escaping (Data?, Error?) -> Void) {
    var steps: [String] = []
    
    func hanoi(disk: Int, from: String, to: String, via: String) {
        if disk == 1 {
            steps.append("Take disk \(disk) from rod \(from) to rod \(to)")
        } else {
            hanoi(disk: disk - 1, from: from, to: via, via: to)
            steps.append("Take disk \(disk) from rod \(from) to rod \(to)")
            hanoi(disk: disk - 1, from: via, to: to, via: from)
        }
    }
    
    hanoi(disk: numDisk, from: "A", to: "C", via: "B")
    
    let jsonResponse: [String: Any] = ["solution": steps]
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: jsonResponse)
        completion(jsonData, nil)
    } catch {
        completion(nil, error)
    }
}
