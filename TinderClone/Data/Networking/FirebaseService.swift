//
//  FirebaseService.swift
//  TinderClone
//
//  Created by Marko on 20.02.2021..
//  Copyright © 2021 Marko. All rights reserved.
//

import Foundation
import UIKit

protocol FirebaseService {
    func saveUserData(user: User, completionHandler: @escaping (Error?) -> Void)
    func uploadImage(image: UIImage, completionHandler: @escaping (String?, Error?) -> Void)
    func fetchUser(withUid uid: String, completionHandler: @escaping (User?, Error?) -> Void)
    func fetchUsers(forCurrentUser user: User, completionHandler: @escaping ([User]?, Error?) -> Void)
    func saveSwipe(for user: User, direction: SwipeDirection, completionHandler: ((Error?) -> Void)?)
    func fetchSwipes(completionHandler: @escaping ([String: Bool]) -> Void)
    func checkIfMatchExists(forUser user: User, completionHandler: @escaping (Bool) -> Void)
    func uploadMatch(currentUser: User, matchedUser: User)
    func fetchMatches(completionHandler: @escaping ([User], Error?) -> Void)
}
