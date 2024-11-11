//
//  MockURLProtocol.swift
//  TowerOfHanoi
//
//  Created by javier pineda on 08/11/24.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
        return request.url == Constants.mockURL
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        // Simplemente devuelve la misma solicitud sin modificaciones
        return request
    }
    
    override func startLoading() {
        if Constants.disksNumber > .zero {
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                let randomFailure = false
                
                if randomFailure {
                    let error = NSError(domain: "MockAPIError", code: 500, userInfo: [NSLocalizedDescriptionKey : "Server error"])
                    self.client?.urlProtocol(self, didFailWithError: error)
                } else {
                    solveHanoiAPI(numDisk: Constants.disksNumber) { data, error in
                        if let error = error {
                            self.client?.urlProtocol(self, didFailWithError: error)
                        } else {
                            guard let data = data,
                                  let requestUrl = self.request.url,
                                  let response = HTTPURLResponse(url: requestUrl,
                                                                 statusCode: 200,
                                                                 httpVersion: nil,
                                                                 headerFields: nil) else {
                                let error = NSError(domain: "MockAPIError", code: 500, userInfo: [NSLocalizedDescriptionKey : "Response generation failed"])
                                self.client?.urlProtocol(self, didFailWithError: error)
                                return
                            }
                            
                            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                            self.client?.urlProtocol(self, didLoad: data)
                            self.client?.urlProtocolDidFinishLoading(self)
                        }
                    }
                }
            }
        }
    }
    
    override func stopLoading() {
        
    }
}
