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
    
    private var user: BehaviorRelay<User?> = BehaviorRelay(value: nil)
    var userObservable: Observable<User?> {
        return user.asObservable()
    }
    
    private var cards: BehaviorRelay<[CardView]?> = BehaviorRelay(value: nil)
    var cardsObservable: Observable<[CardView]?> {
        return cards.asObservable()
    }
    
    func isUserLoggedIn() -> Bool {
        if Auth.auth().currentUser == nil {
            return false
        } else {
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
    
    func getCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Repository.shared().getUser(withUid: uid) { [weak self] user, error in
            if let error = error {
                print(error)
                return
            }
            self?.user.accept(user)
        }
    }
    
    func getUsers() {
        Repository.shared().getUsers { [weak self] users, error in
            if let error = error {
                print(error)
                return
            }
            self?.cards.accept(users?
                .map({CardView(viewModel: CardViewModel(user: $0))})
            )
        }
    }
    
}
