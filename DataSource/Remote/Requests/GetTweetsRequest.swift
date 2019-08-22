//
//  GetTweetsRequest.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 06/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//


import UIKit
import DMNetwork

class GetTweetsRequest: DMRequest {
    
    
    var method: HTTPMethod = .get
    var endpoint: String {
        return "\(Endpoints.baseURL)\(Endpoints.getTweets)"
    }
    
}
