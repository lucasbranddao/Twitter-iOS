//
//  DeleteTweetResponse.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 06/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import Foundation

struct DeleteTweetResponse: Decodable {
    let status: Bool?
    let message: String?
}
