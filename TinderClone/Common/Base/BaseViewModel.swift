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
    var coordinator: AppCoordinator?
    
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
    
    func getAllUsers(forCurrent user: User, completionHandler: @escaping ([User]?, Error?) -> Void) {
        Repository.shared().getUsers(forCurrentUser: user) { users, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            completionHandler(users, nil)
        }
    }
    
    func saveUser(user: User, completionHandler: @escaping (Error?) -> Void) {
        Repository.shared().saveUserData(user: user, completionHandler: completionHandler)
    }
    
    func getUserInfoTextAttributedString(user: User, textSize: CGFloat, attributedTextSize: CGFloat, textColor: UIColor) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: user.name,
                                                       attributes: [
                                                        .font : UIFont.systemFont(ofSize: textSize, weight: .heavy),
                                                        .foregroundColor: textColor])
        
        attributedText.append(NSAttributedString(string: String(format: "  %d", user.age), attributes: [
        .font : UIFont.systemFont(ofSize: attributedTextSize),
        .foregroundColor: textColor]))
        
        return attributedText
    }
    
    func saveSwipeAndCheckForMatch(for user: User, direction: SwipeDirection, completionHandler: @escaping (User) -> Void) {
        Repository.shared().saveSwipeAndCheckForMatch(for: user, direction: direction, completionHandler: completionHandler)
    }
    
}
