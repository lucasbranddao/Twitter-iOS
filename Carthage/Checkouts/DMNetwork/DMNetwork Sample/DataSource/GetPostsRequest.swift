//
//  GetPostsRequest.swift
//  DMNetwork Sample
//
//  Created by Dan Mori on 08/05/19.
//  Copyright © 2019 Daniel Mori. All rights reserved.
//

import Foundation
import DMNetwork

class GetPostsRequest: DMRequest {
    var endpoint: String = DMEndpoints.getPosts
    var method: HTTPMethod = .get
}
