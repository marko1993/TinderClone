//
//  ProfileViewModel.swift
//  TinderClone
//
//  Created by Marko on 17/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel: BaseViewModel {
    private var user: User
    private var imageURLs: BehaviorRelay<[URL]> = BehaviorRelay(value: [])
    var imageURLsObservable: Observable<[URL]> {
        return imageURLs.asObservable()
    }
    
    var willDisplayImage: Int = 0
    
    init(user: User) {
        self.user = user
        super.init()
        imageURLs.accept(user.imageURLs)
    }
    
    func getUser() -> User {
        return user
    }
    
}
