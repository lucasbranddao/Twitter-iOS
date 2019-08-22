//
//  LikeTweetRequest.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 06/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import UIKit
import DMNetwork

class LikeTweetRequest: DMRequest {
    var id: String
    var type: Int
    var clickAuthor: String
    
    init(id: String, type: Int, clickAuthor: String) {
        self.id = id
        self.type = type
        self.clickAuthor = clickAuthor
    }
    
    var method: HTTPMethod = .post
    var endpoint: String {
        return "\(Endpoints.baseURL)\(String(format: Endpoints.like, id, type, clickAuthor))"
        
    }
    
}
