//
//  CreateService.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 11/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import Foundation
import DMNetwork

protocol CreateServiceProtocol: class{
    func sendTweet(author: String, content: String, _ completion: @escaping((GetTweetsResponse?, String?) -> Void))
}

final class CreateService: CreateServiceProtocol{
    
    func sendTweet(author: String, content: String, _ completion: @escaping ((GetTweetsResponse?, String?) -> Void)) {
        let request = CreateTweetRequest(author: author, content: content)
        DMRemote.makeRequest(request: request, completionHandler: completion)
    }
    
}
