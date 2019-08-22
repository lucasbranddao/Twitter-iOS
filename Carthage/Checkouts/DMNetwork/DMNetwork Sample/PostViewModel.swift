//
//  PostViewModel.swift
//  DMNetwork Sample
//
//  Created by Dan Mori on 08/05/19.
//  Copyright © 2019 Daniel Mori. All rights reserved.
//

import Foundation
import DMNetwork

struct PostViewModel {
    
    weak var dataSource : GenericDataSource<Post>?
    weak var activityIndicator: UIActivityIndicatorView?
    
    init(dataSource : GenericDataSource<Post>?, activityIndicator: UIActivityIndicatorView?) {
        self.dataSource = dataSource
        self.activityIndicator = activityIndicator
    }
    
    func fetchCurrencies() {
        self.activityIndicator?.startAnimating()
        DMRemote.makeRequest(request: GetPostsRequest()) { (posts: [Post]?, error: String?) in
            self.activityIndicator?.stopAnimating()
            guard let posts = posts else {
                // handle error
                print(error ?? "")
                return
            }
            
            self.dataSource?.data.value = posts
        }
    }
}
