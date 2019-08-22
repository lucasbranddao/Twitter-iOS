//
//  LoginViewController.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 19/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginClicked(_ sender: UIButton) {
        saveUser()
    }
    
    lazy var viewModel : LoginViewModel = {
        let viewModel = LoginViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        
        setup()
        
        viewModel.validUser.addObserver(self, completionHandler: {
            if self.viewModel.validUser.value {
                
                self.loginButton.isEnabled = true
            }
            else{
                self.loginButton.isEnabled = false
            }
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setup(){
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        loginButton.layer.cornerRadius = 6
        loginButton.clipsToBounds = true
        loginButton.isEnabled = false
        
        usernameTextField.delegate = self
        usernameTextField.layer.cornerRadius = 16.0
        usernameTextField.layer.borderWidth = 1.4
        usernameTextField.clipsToBounds = true
        usernameTextField.layer.borderColor = UIColor(displayP3Red: 200/255, green: 200/255, blue: 200/255, alpha: 1).cgColor
        
    }
    
    func saveUser(){
        let keychainUser = KeychainUsername(service: "Username", account: "Twitter-User")
        do {
            if let username = usernameTextField.text {
                try keychainUser.save(username)
                
            }
        } catch {}
    }
}
extension LoginViewController: UITextFieldDelegate{
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)

        switch textField {
        case usernameTextField:
            viewModel.editUsername(username: updatedString)
            break
        default:
            break
        }
        return true
    }
}
