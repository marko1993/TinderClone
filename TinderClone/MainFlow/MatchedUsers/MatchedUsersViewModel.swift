//
//  MatchedUsersViewModel.swift
//  TinderClone
//
//  Created by Marko on 21/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MatchedUsersViewModel: BaseViewModel {
    
    let user: User
    let matchedUsers: BehaviorRelay<[User]> = BehaviorRelay(value: [])
    var matchedUsersObservable: Observable<[User]> {
        return matchedUsers.asObservable()
    }
    
    init(user: User) {
        self.user = user
        super.init()
    }
    
    func getMatchedUsers() {
        getAllUsers(forCurrent: user) { users, error in
            var newUsers: [User] = []
            if let users = users {
                newUsers.append(contentsOf: users)
                newUsers.append(contentsOf: users)
                newUsers.append(contentsOf: users)
                newUsers.append(contentsOf: users)
                self.matchedUsers.accept(newUsers)
            }
        }
    }
    
}
