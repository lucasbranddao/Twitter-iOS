//
//  CreateTweetViewController.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 10/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import UIKit


class CreateTweetViewController: UIViewController{
    
  
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var numberOfChar: UILabel!
    
    let service = CreateService()
    
    lazy var viewModel : CreateTweetViewModel = {
        let viewModel = CreateTweetViewModel(service: service)
        return viewModel
    }()
    
    override func viewDidLoad() {
        
        viewModel.finished.addObserver(self, completionHandler: {
            if self.viewModel.finished.value {
                
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
                self.viewModel.finished.value = false
            }
        })
        
        setupTabBar()
        numberOfChar.text = "0"
    }
    
    private func setupTabBar(){
        
        textView.delegate = self
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        var cancel = UIImage(named: "close")
        cancel = self.resizeImage(image: cancel!, targetSize: CGSize(width: 40, height: 40))
        self.navigationController?.navigationBar.backIndicatorImage = cancel
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = cancel
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        var tweetIcon = UIImage(named: "tweet")
        tweetIcon = self.resizeImage(image: tweetIcon!, targetSize: CGSize(width: 64, height: 48))
        let tweetItem = UIBarButtonItem(image: tweetIcon, landscapeImagePhone: tweetIcon, style: .done, target: self, action: #selector(sendtweet))
        let tweetTitle = UIBarButtonItem(title: "Tweet", style: .done, target: nil, action: nil)
        
        navigationItem.rightBarButtonItems = [tweetItem]
        
        tweetTitle.isEnabled = false
        tweetItem.isEnabled = false

    }
    
 
    
    @objc func sendtweet(){
        viewModel.sendTweet(author: SessionUser.loadUser(), content: textView.text)
    }
    
    func updateUI(){
        numberOfChar.text = "\(textView.text.count)"
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
    
}

extension CreateTweetViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        textView.sizeToFit()
        if text.isEmpty{
            return true
        }
        else{
            return textView.text.count + text.count <= 240
        }
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1)
        navigationItem.rightBarButtonItems?[0].isEnabled = true
//        navigationItem.rightBarButtonItems?[1].isEnabled = true
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty{
            textView.endEditing(true)
            navigationItem.rightBarButtonItems?[0].isEnabled = false
//            navigationItem.rightBarButtonItems?[1].isEnabled = false
            textView.text = "O que está acontecendo?"
            textView.textColor = UIColor.officialApplePlaceholderGray
            numberOfChar.text = "0"
        }
        else if numberOfChar.text?.count == 240{

        }
        else{
            if textView.text.count < 220{
                numberOfChar.textColor = UIColor(displayP3Red: 45/255, green: 123/255, blue: 243/255, alpha: 1)
                updateUI()
            }
            else{
                numberOfChar.textColor = UIColor.red
                updateUI()
            }
        }
    }
    
}

extension UIColor {
    static var officialApplePlaceholderGray: UIColor {
        return UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    }
}
