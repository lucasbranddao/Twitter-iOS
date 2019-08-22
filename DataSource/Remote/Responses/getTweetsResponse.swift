//
//  getTweetsResponse.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 06/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import Foundation

struct GetTweetsResponse: Decodable {
    let likes: Int
    let likeAuthors: [String?]
    let _id: String
    let author: String
    let content: String
}
