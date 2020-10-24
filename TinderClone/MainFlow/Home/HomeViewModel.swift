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
    
    func popCardOnTop() -> CardView? {
        guard var cardStack = cards.value else { return nil }
        if cardStack.isEmpty { return nil }
        
        let topCard = cardStack.popLast()
        cards.accept(cardStack)
        return topCard
    }
    
    func logoutUser() {
        logout { [weak self] error in
            if error != nil {
                self?.logoutSuccessful.accept(false)
            } else {
                self?.logoutSuccessful.accept(true)
            }
        }
    }
    
    func getCurrentUser() {
        getUser { [weak self] user, error in
            if let error = error {
                self?.user.accept(nil)
                print(error)
                return
            }
            self?.user.accept(user)
        }
    }
    
    func getUsers() {
        guard let user = user.value else { return }
        getAllUsers(forCurrent: user) { [weak self] users, error in
            if let error = error {
                print(error)
                return
            }
            self?.cards.accept(users?
                .map({CardView(viewModel: CardViewModel(user: $0))})
            )
        }
    }
    
    func getUser() -> User? {
        return user.value
    }
    
    func uploadMatch(for user: User) {
        guard let currentUser = getUser() else { return }
        Repository.shared().uploadMatch(currentUser: currentUser, matchedUser: user)
    }
    
}
