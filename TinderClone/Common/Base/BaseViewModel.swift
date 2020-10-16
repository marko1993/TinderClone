//
//  BaseViewModel.swift
//  TinderClone
//
//  Created by Marko on 04/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import RxSwift
import Firebase

class BaseViewModel {
    let disposeBag = DisposeBag()
    
    func isUserLoggedIn() -> Bool {
        if Auth.auth().currentUser == nil {
            return false
        } else {
            return true
        }
    }
    
    func getUser(completionHandler: @escaping (User?, Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Repository.shared().getUser(withUid: uid) { user, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            completionHandler(user, nil)
        }
    }
    
    func logout(completionHandler: @escaping (Error?) -> Void) {
        Repository.shared().logoutUser { error in
            if error != nil {
                completionHandler(error)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func getAllUsers(completionHandler: @escaping ([User]?, Error?) -> Void) {
        Repository.shared().getUsers { users, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            completionHandler(users, nil)
        }
    }
    
    func saveUser(user: User, completionHandler: @escaping (Error?) -> Void) {
        FirebaseService.saveUserData(user: user, completionHandler: completionHandler)
    }
    
}
