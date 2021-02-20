//
//  AuthService.swift
//  TinderClone
//
//  Created by Marko on 10/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullName: String
    let profileImage: UIImage
}

class MainAuthService: BaseService, AuthService {
    
    let firebaseService: MainFirebaseService
    
    init(firebaseService: MainFirebaseService) {
        self.firebaseService = firebaseService
    }
    
    func registerUser(with credentials: AuthCredentials, completionHandler: @escaping (String?, Error?) -> Void) {
        self.firebaseService.uploadImage(image: credentials.profileImage) { url, uploadImageError in
            if let uploadImageError = uploadImageError {
                completionHandler(nil, uploadImageError)
                return
            }
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, createUserError in
                if let createUserError = createUserError {
                    completionHandler(nil, createUserError)
                    return
                }
                guard let uid = result?.user.uid else {return}
                let data = [K.UserDataParams.email: credentials.email,
                            K.UserDataParams.fullName: credentials.fullName,
                            K.UserDataParams.imageURLs: [url!],
                            K.UserDataParams.uid: uid,
                            K.UserDataParams.age: 18] as [String : Any]
                self.getCollection(K.Collection.users).document(uid).setData(data) { setDataError in
                    if let setDataError = setDataError {
                        completionHandler(nil, setDataError)
                        return
                    }
                    completionHandler(uid, nil)
                }
            }
        }
    }
    
    func logUserIn(email: String, password: String,
                          completionHandler: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completionHandler)
    }
    
}
