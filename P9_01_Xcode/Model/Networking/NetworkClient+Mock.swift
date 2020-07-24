//
//  NetworkClient+Mock.swift
//  URLMockDemo
//
//  Created by Sébastien Kothé on 24/07/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

// MARK: - DataTask
protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    func resume() {}
}

// MARK: - URLSession
protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }

}

class MockURLSession: URLSessionProtocol {
    
    var dataTask = MockURLSessionDataTask()
    
    var completionHandler: (Data?, URLResponse?, Error?)
    
    init(completionHandler: (Data?, URLResponse?, Error?)) {
        self.completionHandler = completionHandler
    }
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        completionHandler(
            self.completionHandler.0,
            self.completionHandler.1,
            self.completionHandler.2
        )
        return dataTask
    }
}
