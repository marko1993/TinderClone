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
    let matches: BehaviorRelay<[User]> = BehaviorRelay(value: [])
    var matchesObservable: Observable<[User]> {
        return matches.asObservable()
    }
    
    init(user: User) {
        self.user = user
        super.init()
    }
    
    func getMatches() {
        Repository.shared().getMatches { [weak self] matches, error in
            self?.matches.accept(matches)
        }
    }
    
    func presentProfileScreen(user: User) {
        self.coordinator?.presentProfileViewController(for: user, delegate: nil, hideBottomNavigation: true)
    }
    
}
