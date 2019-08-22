//
//  HTTPMethod.swift
//  DMNetwork
//
//  Created by Dan Mori on 08/05/19.
//  Copyright © 2019 Daniel Mori. All rights reserved.
//

import Foundation

@objc public enum HTTPMethod: Int {
    case get, post, delete, put, options, trace, patch, connect
    
    func asString() -> String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        case .put:
            return "PUT"
        case .options:
            return "OPTIONS"
        case .trace:
            return "TRACE"
        case .patch:
            return "PATCH"
        case .connect:
            return "CONNECT"
        }
    }
}
