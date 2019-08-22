//
//  ViewController.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 05/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var feedNews: UITableView!
   
    let service = FeedService()
    var dataSource : FeedDataSource!
    var likes: LikesCardView?
    
    lazy var viewModel : FeedViewModel = {
        let viewModel = FeedViewModel(service: service, dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = FeedDataSource(viewController: self)
        feedNews.delegate = self
        
        feedNews.tableFooterView = UIView()
        viewModel.finished.addObserver(self, completionHandler: {
            if self.viewModel.finished.value {
                self.viewModel.fetchTweets()
                self.viewModel.finished.value = false
            }
        })
        
        dataSource.data.addAndNotify(observer: self, completionHandler: {
            self.feedNews.reloadData()
            if (self.refreshControl.isRefreshing){
                self.refreshControl.endRefreshing()
            }
        })
        
        viewModel.likers.addObserver(self, completionHandler: {
            var current: String?
            var full: String?
            for liker in self.viewModel.likers.value{
                current = String(format: "%@\n\n%@", full ?? "", liker!)
                full = current
            }
            self.likes?.likesLabel.text = full
            
            DispatchQueue.main.async {
                let window = UIApplication.shared.keyWindow!
                window.addSubview(self.likes!)
                window.bringSubviewToFront(self.likes!)
            }
        })
        
        viewModel.fetchTweets()
        
        self.feedNews.addSubview(self.refreshControl)
        feedNews.dataSource = dataSource
//        feedNews.delegate = self
        setupNavigationBar()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
        
        viewModel.fetchTweets()
    }
    
    private func setupNavigationBar(){
       
        var logo = UIImage(named: "logo")
        logo = self.resizeImage(image: logo!, targetSize: CGSize(width: 28, height: 28))
        let logoItem = UIBarButtonItem(image: logo, landscapeImagePhone: logo, style: .done, target:self, action: #selector(tappedBack))
        
        var add = UIImage(named: "add")
        add = self.resizeImage(image: add!, targetSize: CGSize(width: 28, height: 28))
        let addItem = UIBarButtonItem(image: add, landscapeImagePhone: add, style: .done, target: self, action:  #selector(createButtonTouched))

        
        navigationItem.leftBarButtonItem = logoItem
        navigationItem.rightBarButtonItem = addItem
        navigationItem.title = "Início"
      
    }
    @objc func tappedBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func createButtonTouched(sender: UIBarButtonItem){
        DispatchQueue.main.async {
            
            self.performSegue(withIdentifier: "createTweet", sender: nil)
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func sendLike(id: String){
        viewModel.likeTweet(id: id)
    }
    
    func sendDislike(id: String){
        viewModel.dislikeTweet(id: id)
    }
    
    func delete(id: String){
        viewModel.deleteTweet(id: id)
    }

    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
       viewModel.fetchTweets()
    }


}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.passLikers(row: indexPath.row)
        
        tableView.cellForRow(at: indexPath)?.isSelected = false
        
        
        if likes == nil {
            likes = Bundle.main.loadNibNamed("Likes", owner: nil, options: nil)?[0] as? LikesCardView
            likes?.frame = UIScreen.main.bounds
        }
        
        
    }
}


