//
//  FeedService.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 06/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import Foundation
import DMNetwork

protocol FeedServiceProtocol: class{
    func updateFeed( _ completion: @escaping (([GetTweetsResponse]?, String?) -> Void))
    func likeTweet(id: String, _ completion: @escaping ((GetTweetsResponse?, String?) -> Void))
    func dislikeTweet(id: String,_ completion: @escaping ((GetTweetsResponse?, String?) -> Void))
    func deleteTweet(id: String, _ completion: @escaping ((DeleteTweetResponse?, String?) -> Void))
}

final class FeedService: FeedServiceProtocol{
    func dislikeTweet(id: String, _ completion: @escaping ((GetTweetsResponse?, String?) -> Void)) {
        let request = LikeTweetRequest(id: id, type: 1, clickAuthor: SessionUser.loadUser())
        DMRemote.makeRequest(request: request, completionHandler: completion)
    }

   
    func deleteTweet(id: String, _ completion: @escaping ((DeleteTweetResponse?, String?) -> Void)) {
        let request = DeleteTweetRequest(id: id)
        DMRemote.makeRequest(request: request, completionHandler: completion)
    }
    
    func likeTweet(id: String, _ completion: @escaping ((GetTweetsResponse?, String?) -> Void)) {
        let request = LikeTweetRequest(id: id, type: 0, clickAuthor: SessionUser.loadUser())
        DMRemote.makeRequest(request: request, completionHandler: completion)
    }
    
    
    func updateFeed(_ completion: @escaping (([GetTweetsResponse]?, String?) -> Void)) {
        let request = GetTweetsRequest()
        DMRemote.makeRequest(request: request, completionHandler: completion)
    }
 
}
