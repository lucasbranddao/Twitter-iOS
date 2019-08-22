//
//  PostListDataSource.swift
//  DMNetwork Sample
//
//  Created by Dan Mori on 08/05/19.
//  Copyright © 2019 Daniel Mori. All rights reserved.
//

import UIKit

class PostListDataSource : GenericDataSource<Post>, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostItemTableViewCell
        
        let post = self.data.value[indexPath.row]
        cell.postNameLabel.text = post.title
        cell.postIdLabel.text = "\(post.id)"
        
        return cell
    }
}
