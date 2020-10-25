//
//  Repository.swift
//  TinderClone
//
//  Created by Marko on 09/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import Foundation
import Firebase

class Repository {
    
    private static var sharedRepository: Repository = {
        let repository = Repository()
        return repository
    }()
    
    private init() {
        
    }
    
    class func shared() -> Repository {
        return sharedRepository
    }
    
    func registerUser(with credentials: AuthCredentials, completionHandler: @escaping (String?, Error?) -> Void) {
        AuthService.registerUser(with: credentials, completionHandler: completionHandler)
    }
    
    func logoutUser(completionHandler: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completionHandler(nil)
        } catch {
            completionHandler(error)
        }
    }
    
    func logUserIn(email: String, password: String,
                   completionHandler: @escaping (AuthDataResult?, Error?) -> Void) {
        AuthService.logUserIn(email: email, password: password, completionHandler: completionHandler)
    }
    
    func getUser(withUid uid: String, completionHandler: @escaping (User?, Error?) -> Void) {
        FirebaseService.fetchUser(withUid: uid, completionHandler: completionHandler)
    }
    
    func getUsers(forCurrentUser user: User, completionHandler: @escaping ([User]?, Error?) -> Void) {
        FirebaseService.fetchUsers(forCurrentUser: user, completionHandler: completionHandler)
    }
    
    func saveUserData(user: User, completionHandler: @escaping (Error?) -> Void) {
        FirebaseService.saveUserData(user: user, completionHandler: completionHandler)
    }
    
    func saveSwipeAndCheckForMatch(for user: User, direction: SwipeDirection, completionHandler: @escaping (User) -> Void) {
        FirebaseService.saveSwipe(for: user, direction: direction) { error in
            guard direction == .right else { return }
            FirebaseService.checkIfMatchExists(forUser: user) { didMatch in
                completionHandler(user)
            }
        }
    }
    
    func uploadMatch(currentUser: User, matchedUser: User) {
        FirebaseService.uploadMatch(currentUser: currentUser, matchedUser: matchedUser)
    }
    
    func getMatches(completionHandler: @escaping ([User], Error?) -> Void) {
        FirebaseService.fetchMatches(completionHandler: completionHandler)
    }
    
}
