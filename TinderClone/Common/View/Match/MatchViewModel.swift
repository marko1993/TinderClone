//
//  MatchViewModel.swift
//  TinderClone
//
//  Created by Marko on 19/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import Foundation

class MatchViewModel: BaseViewModel {
    
    private let currentUser: User
    private let matchedUser: User
    
    init(currentUser: User, matchedUser: User) {
        self.currentUser = currentUser
        self.matchedUser = matchedUser
        super.init()
    }
    
    func getCurrentUser() -> User {
        return currentUser
    }
    
    func getMachedUser() -> User {
        return matchedUser
    }
    
}
