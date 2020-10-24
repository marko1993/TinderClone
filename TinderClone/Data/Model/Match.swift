//
//  Match.swift
//  TinderClone
//
//  Created by Marko on 24/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import Foundation

struct Match {
    let fullName: String
    let profileImageUrl: String
    let uid: String
    
    init(data: [String: Any]) {
        self.fullName = data[K.UserDataParams.fullName] as? String ?? ""
        self.profileImageUrl = data[K.UserDataParams.profileImageUrl] as? String ?? ""
        self.uid = data[K.UserDataParams.uid] as? String ?? ""
    }
    
}
