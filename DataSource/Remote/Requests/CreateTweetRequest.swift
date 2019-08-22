//
//  CreateTweetRequest.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 06/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import UIKit
import DMNetwork

class CreateTweetRequest: DMRequest {
    var author: String
    var content: String
    
    init(author: String, content: String) {
        self.author = author
        self.content = content
    }
    
    var method: HTTPMethod = .post
    var endpoint: String {
        return "\(Endpoints.baseURL)\(Endpoints.create)"
    }
    var body: Any {
        return ["author": author,
                "content": content]
    }
}
