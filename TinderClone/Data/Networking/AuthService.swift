//
//  AuthService.swift
//  TinderClone
//
//  Created by Marko on 20.02.2021..
//  Copyright © 2021 Marko. All rights reserved.
//

import Foundation
import Firebase

protocol AuthService {
    func registerUser(with credentials: AuthCredentials, completionHandler: @escaping (String?, Error?) -> Void)
    func logUserIn(email: String, password: String, completionHandler: @escaping (AuthDataResult?, Error?) -> Void)
}
