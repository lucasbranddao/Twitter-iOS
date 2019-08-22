//
//  LikesCardView.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 24/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import UIKit

class LikesCardView: UIView{
    
    
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBAction func closeButton(_ sender: UIButton) {
        removeFromSuperview()
    }
    
}
