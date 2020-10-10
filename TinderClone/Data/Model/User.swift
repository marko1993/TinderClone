//
//  User.swift
//  TinderClone
//
//  Created by Marko on 04/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

struct User {
    var name: String
    var age: Int
    var email: String
    let uid: String
    var profileImageUrl: String
    var images: [URL]
    
    init(data: [String: Any]) {
        self.name = data[K.UserDataParams.fullName] as? String ?? ""
        self.email = data[K.UserDataParams.email] as? String ?? ""
        self.age = data[K.UserDataParams.age] as? Int ?? 0
        self.uid = data[K.UserDataParams.uid] as? String ?? ""
        self.profileImageUrl = data[K.UserDataParams.imageUrl] as? String ?? ""
        self.images = []
        guard let profileURL = URL(string: profileImageUrl) else {return}
        self.images.append(profileURL)
    }
    
}
