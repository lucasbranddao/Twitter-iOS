//
//  TweetTableViewCell.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 05/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import UIKit


protocol TweetTableViewCellDelegate{
    func didLiked(id: String)
    func didDisliked(id: String)
    func delete(id: String)
}

class TweetTableViewCell: UITableViewCell {
  
    var id: String = ""

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var deletedLabel: UILabel!
    
    @IBAction func likeClicked(_ sender: UIButton) {
        likeButton.isSelected = !likeButton.isSelected
        if (likeButton.isSelected){
            delegate?.didLiked(id: id)
        }
        else{
            delegate?.didDisliked(id: id)
        }
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        deleteButton.isHidden = true
        deletedLabel.alpha = 1.0
        delegate?.delete(id: id)
        
    }
    var delegate: TweetTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeButton.isSelected = false
        
        deletedLabel.alpha = 0.0
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
    
    }

}
