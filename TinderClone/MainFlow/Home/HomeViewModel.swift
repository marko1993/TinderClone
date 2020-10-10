//
//  HomeViewModel.swift
//  TinderClone
//
//  Created by Marko on 09/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    
    private var logoutSuccessful: BehaviorRelay<Bool?> = BehaviorRelay(value: nil)
    var logoutStatusObservable: Observable<Bool?> {
        return logoutSuccessful.asObservable()
    }
    
    func getCards() -> [CardView] {
        return Repository.shared().getCards()
    }
    
    func isUserLoggedIn() -> Bool {
        if Auth.auth().currentUser == nil {
            print("User not logged in")
            return false
        } else {
            print("User logged in")
            return true
        }
    }
    
    func logoutUser() {
        Repository.shared().logoutUser { [weak self] error in
            if error != nil {
                self?.logoutSuccessful.accept(false)
            } else {
                self?.logoutSuccessful.accept(true)
            }
        }
    }
    
}
