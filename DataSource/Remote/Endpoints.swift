//
//  Endpoints.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 06/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import Foundation

struct Endpoints{
    static let baseURL = "http://localhost:3000"
    
    static let getTweets = "/tweets"
    static let like = "/likes/%@/%d/%@"
    static let delete = "/delete/%@"
    static let create = "/tweets"
}
