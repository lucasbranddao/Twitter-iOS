//
//  FeedModel.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 06/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import Foundation

struct Tweet {
    var author: String
    var content: String
    var likes: Int
    var likeAuthors: [String?]
    var id: String
}
