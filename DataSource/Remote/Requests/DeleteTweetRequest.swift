//
//  DeleteTweetRequest.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 06/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//


import UIKit
import DMNetwork

class DeleteTweetRequest: DMRequest {
    
    var id: String
    
    init(id: String){
        self.id = id
    }
    
    var method: HTTPMethod = .delete
    var endpoint: String {
        return "\(Endpoints.baseURL)\(String(format: Endpoints.delete, id))"
    }
    
}

