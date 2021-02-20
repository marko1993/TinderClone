//
//  Repository.swift
//  TinderClone
//
//  Created by Marko on 20.02.2021..
//  Copyright © 2021 Marko. All rights reserved.
//

import Foundation
import Firebase

protocol Repository {
    func registerUser(with credentials: AuthCredentials, completionHandler: @escaping (String?, Error?) -> Void)
    func logoutUser(completionHandler: @escaping (Error?) -> Void)
    func logUserIn(email: String, password: String, completionHandler: @escaping (AuthDataResult?, Error?) -> Void)
    func getUser(withUid uid: String, completionHandler: @escaping (User?, Error?) -> Void)
    func getUsers(forCurrentUser user: User, completionHandler: @escaping ([User]?, Error?) -> Void)
    func saveUserData(user: User, completionHandler: @escaping (Error?) -> Void)
    func saveSwipeAndCheckForMatch(for user: User, direction: SwipeDirection, completionHandler: @escaping (User) -> Void)
    func uploadMatch(currentUser: User, matchedUser: User)
    func getMatches(completionHandler: @escaping ([User], Error?) -> Void)
}
