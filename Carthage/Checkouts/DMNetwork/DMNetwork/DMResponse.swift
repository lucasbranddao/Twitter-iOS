//
//  DMResponse.swift
//  DMNetwork
//
//  Created by Dan Mori on 08/05/19.
//  Copyright © 2019 Daniel Mori. All rights reserved.
//

import Foundation

// Encapsules server response to request
public struct DMResponse {
    public var data: Data?
    public var response: URLResponse?
    public var error: Error?
    public var statusCode: Int?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    init(data: Data?, response: URLResponse?, error: Error?, statusCode: Int) {
        self.data = data
        self.response = response
        self.error = error
        self.statusCode = statusCode
    }
    
    public var isSuccessful: Bool {
        return error == nil
    }
}
