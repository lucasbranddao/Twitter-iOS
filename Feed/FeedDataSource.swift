//
//  FeedDataSource.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 06/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import UIKit

class FeedDataSource : GenericDataSource<Tweet>, UITableViewDataSource, TweetTableViewCellDelegate{
  
    
    weak var controller: ViewController?
    
    init(viewController: ViewController){
        self.controller = viewController
    }
    
    func didLiked(id: String) {
        controller?.sendLike(id: id)
    }
    
    func didDisliked(id: String) {
        controller?.sendDislike(id: id)
    }
    
    func delete(id: String) {
        controller?.delete(id: id)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath) as! TweetTableViewCell
        
        let tweet = self.data.value[indexPath.row]
        cell.authorLabel.text = tweet.author
        if (tweet.likes != 1){
            cell.likesLabel.text = "\(tweet.likes) Likes"
        }
        else{
            cell.likesLabel.text = "\(tweet.likes) Like"
        }
        
        if !(tweet.author == SessionUser.loadUser()){
            cell.deleteButton.isHidden = true
            cell.deletedLabel.isHidden = true
        }
        else{
            cell.deleteButton.isHidden = false
            cell.deletedLabel.isHidden = false
        }
        
        cell.deletedLabel.alpha = 0.0
        
        cell.tweetContent.text = "\(tweet.content)"
        cell.id = tweet.id
        cell.delegate = self
        
        if tweet.likeAuthors.contains(SessionUser.loadUser()){
            cell.likeButton.isSelected = true
        }
        else{
            cell.likeButton.isSelected = false
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return UITableView.automaticDimension
    }
    
    
    
    
    
}
