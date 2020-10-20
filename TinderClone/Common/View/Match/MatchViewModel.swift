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
    let matchLabeltext: String
    
    var currentUserImageUrl: URL?
    var matchedUserImageUrl: URL?
    
    init(currentUser: User, matchedUser: User) {
        self.currentUser = currentUser
        self.matchedUser = matchedUser
        self.matchLabeltext = String(format: K.Strings.matchDescriptionLabel, matchedUser.name)
        
        currentUserImageUrl = currentUser.imageURLs.first
        matchedUserImageUrl = matchedUser.imageURLs.first
        
        super.init()
    }
    
    func getMatchedUser() -> User {
        return matchedUser
    }
    
}
