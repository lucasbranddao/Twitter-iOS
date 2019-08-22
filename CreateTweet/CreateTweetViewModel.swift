//
//  CreateTweetViewModel.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 11/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import UIKit
import DMNetwork

protocol CreateTweetViewModelContract{
    func sendTweet(author: String, content: String)
}

struct CreateTweetViewModel: CreateTweetViewModelContract{
    
    unowned var service: CreateServiceProtocol
    var finished: Observable<Bool> = Observable(false)

    
    init(service: CreateServiceProtocol){
        self.service = service
    }
    
    
    
    func sendTweet(author: String, content: String) {
        service.sendTweet(author: author, content: content, { response, errorMessage in
            //TODO tratar erro
            self.finished.value = true

        })
    }
    
    
}
