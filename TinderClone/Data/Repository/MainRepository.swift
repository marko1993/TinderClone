//
//  Repository.swift
//  TinderClone
//
//  Created by Marko on 09/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import Foundation
import Firebase

class MainRepository: Repository {
    
    let firebaseService: FirebaseService
    let authService: AuthService
    
    init(firebaseService: MainFirebaseService, authService: MainAuthService) {
        self.firebaseService = firebaseService
        self.authService = authService
    }
    
    func registerUser(with credentials: AuthCredentials, completionHandler: @escaping (String?, Error?) -> Void) {
        self.authService.registerUser(with: credentials, completionHandler: completionHandler)
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
        self.authService.logUserIn(email: email, password: password, completionHandler: completionHandler)
    }
    
    func getUser(withUid uid: String, completionHandler: @escaping (User?, Error?) -> Void) {
        self.firebaseService.fetchUser(withUid: uid, completionHandler: completionHandler)
    }
    
    func getUsers(forCurrentUser user: User, completionHandler: @escaping ([User]?, Error?) -> Void) {
        self.firebaseService.fetchUsers(forCurrentUser: user, completionHandler: completionHandler)
    }
    
    func saveUserData(user: User, completionHandler: @escaping (Error?) -> Void) {
        self.firebaseService.saveUserData(user: user, completionHandler: completionHandler)
    }
    
    func saveSwipeAndCheckForMatch(for user: User, direction: SwipeDirection, completionHandler: @escaping (User) -> Void) {
        self.firebaseService.saveSwipe(for: user, direction: direction) { error in
            guard direction == .right else { return }
            self.firebaseService.checkIfMatchExists(forUser: user) { didMatch in
                completionHandler(user)
            }
        }
    }
    
    func uploadMatch(currentUser: User, matchedUser: User) {
        self.firebaseService.uploadMatch(currentUser: currentUser, matchedUser: matchedUser)
    }
    
    func getMatches(completionHandler: @escaping ([User], Error?) -> Void) {
        self.firebaseService.fetchMatches(completionHandler: completionHandler)
    }
    
    func uploadImage(image: UIImage, completionHandler: @escaping (String?, Error?) -> Void) {
        self.firebaseService.uploadImage(image: image, completionHandler: completionHandler)
    }
    
}
