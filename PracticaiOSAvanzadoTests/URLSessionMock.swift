//
//  URLSessionMock.swift
//  PracticaiOSAvanzadoTests
//
//  Created by Rodrigo Latorre on 27/01/23.
//

import Foundation

class URLSessionMock: URLSession {
    override init() {}
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

        return URLSessionDataTaskMock { 
            completionHandler(self.data, self.response, self.error)
        }
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}

//var urlComponents = URLComponents()
//urlComponents.queryItems = [URLQueryItem(name: "id", value: id)]
//        request.httpBody = ""
//        urlComponents.query?.data(using: .utf8)
