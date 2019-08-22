//
//  FeedViewModel.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 06/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import UIKit
import DMNetwork

protocol FeedViewModelContract{
    func fetchTweets()
    func likeTweet(id: String)
    func dislikeTweet(id: String)
    func deleteTweet(id: String)
    func passLikers(row: Int)
}

struct FeedViewModel: FeedViewModelContract{

  
    weak var service: FeedServiceProtocol?
    weak var feedDataSource: GenericDataSource<Tweet>?
    var finished: Observable<Bool> = Observable(false)
    var likers: Observable<[String?]> = Observable([])

    
    init(service: FeedServiceProtocol, dataSource: FeedDataSource) {
        self.service = service
        self.feedDataSource = dataSource
    }
    
    
    func fetchTweets() {
        service?.updateFeed({ response, errorMessage in
            self.feedDataSource?.data.value = (response ?? []).compactMap({ Tweet(author: $0.author, content: $0.content, likes: $0.likes, likeAuthors: $0.likeAuthors, id: $0._id) } )
        })
    }
    
    func likeTweet(id: String) {
        service?.likeTweet(id: id, { response, errorMessage in
            self.finished.value = true
            //TODO tratar erro
        }
    )}
    
    func dislikeTweet(id: String) {
        service?.dislikeTweet(id: id, { response, errorMessage in
            //TODO tratar erro
            self.finished.value = true
        }
    )}
    
    func deleteTweet(id: String) {
        service?.deleteTweet(id: id, { response, errorMessage in
            //TODO tratar erro
            self.finished.value = true
        }
    )}
    
    func passLikers(row: Int) {
        likers.value = (self.feedDataSource?.data.value[row].likeAuthors)!
    }
    
    
}
