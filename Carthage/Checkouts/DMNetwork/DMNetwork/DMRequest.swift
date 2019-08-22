//
//  DMRequest.swift
//  DMNetwork
//
//  Created by Dan Mori on 08/05/19.
//  Copyright © 2019 Daniel Mori. All rights reserved.
//

import Foundation

// Base protocol
@objc public protocol DMRequest {
    var endpoint: String { get }
    var method: HTTPMethod { get }
    @objc optional var body: Any { get }
    @objc optional var headers: [String : String] { get }
    @objc optional var timeoutInterval: TimeInterval { get }
    @objc optional var cachePolicy: URLRequest.CachePolicy { get }
}

extension DMRequest {
    /**
     Extension that turns protocol into needed URLRequest
     
     - Returns: A URLRequest object from DMRequest protocol,
                or nil if it can't craete a URL from given endpoint
     */
    func asURLRequest() -> URLRequest? {
        // creates URL and guarantees that it isn't nil
        guard let url = URL(string: self.endpoint) else {
            return nil
        }
        
        // create request from URL and set properties
        var urlRequest = URLRequest(url: url)
        
        // if timeout isn't set, make it 1 minute (60 seconds)
        urlRequest.timeoutInterval = self.timeoutInterval ?? 60.0
        urlRequest.cachePolicy = self.cachePolicy ?? .useProtocolCachePolicy
        
        // run through header dictionary and add values into request
        if let headers = self.headers, headers.count  > 0 {
            for header in headers {
                urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        // set additional headers for REST request
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // Set HTTP method
        urlRequest.httpMethod = self.method.asString()
        
        // Make body, if has any
        if self.body != nil {
            let jsonData: Data
            do {
                jsonData = try JSONSerialization.data(withJSONObject: self.body!, options: [])
                urlRequest.httpBody = jsonData
            } catch {
                return nil
            }
        }
        
        return urlRequest
    }
}
