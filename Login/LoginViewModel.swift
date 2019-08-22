//
//  LoginViewModel.swift
//  TwitterProjectMVVM
//
//  Created by Lucas Brandão Pereira on 24/06/19.
//  Copyright © 2019 Lucas Brandão Pereira. All rights reserved.
//

import UIKit

protocol LoginViewModelContract{
    func editUsername(username: String?)
}

struct LoginViewModel: LoginViewModelContract{
    
    var validUser: Observable<Bool> = Observable(false)
    
    func editUsername(username: String?) {
        let noSpaceUsername = username?.trimmingCharacters(in: .whitespaces)

        
        if noSpaceUsername?.count ?? 0 > 2{
            validUser.value = true
        }
        else{
            validUser.value = false
        }
    }
    
    
}
