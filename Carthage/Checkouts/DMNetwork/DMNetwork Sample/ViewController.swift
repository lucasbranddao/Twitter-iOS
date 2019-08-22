//
//  ViewController.swift
//  DMNetwork Sample
//
//  Created by Dan Mori on 08/05/19.
//  Copyright © 2019 Daniel Mori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let dataSource = PostListDataSource()
    var activityIndicator: UIActivityIndicatorView!
    
    lazy var viewModel : PostViewModel = {
        let viewModel = PostViewModel(dataSource: dataSource, activityIndicator: activityIndicator)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Posts"
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        
        tableView.register(UINib(nibName: "PostItemTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "PostCell")
        self.tableView.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.tableView.reloadData()
        }
        
        self.viewModel.fetchCurrencies()
    }
}

