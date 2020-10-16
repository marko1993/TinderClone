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
    var profession: String
    var bio: String
    var minSeekingAge: Int = 18
    var maxSeekingAge: Int = 60
    var email: String
    let uid: String
    var images: [String]
    var imageURLs: [URL]
    
    init(data: [String: Any]) {
        self.name = data[K.UserDataParams.fullName] as? String ?? ""
        self.email = data[K.UserDataParams.email] as? String ?? ""
        self.profession = data[K.UserDataParams.profession] as? String ?? ""
        self.bio = data[K.UserDataParams.bio] as? String ?? ""
        self.age = data[K.UserDataParams.age] as? Int ?? 0
        self.minSeekingAge = data[K.UserDataParams.minSeekingAge] as? Int ?? 18
        self.maxSeekingAge = data[K.UserDataParams.maxSeekingAge] as? Int ?? 60
        self.uid = data[K.UserDataParams.uid] as? String ?? ""
        self.images = data[K.UserDataParams.imageURLs] as? [String] ?? []
        self.imageURLs = []
        images.forEach { url in
            guard let imageURL = URL(string: url) else {return}
            self.imageURLs.append(imageURL)
        }
    }
    
}
