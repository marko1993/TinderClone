//
//  HomeViewController.swift
//  TinderClone
//
//  Created by Marko on 03/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private let homeView = HomeView()
    private let viewModel = HomeViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !viewModel.isUserLoggedIn() {
            presentLoginViewController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(homeView)
        setupBinding()
        viewModel.getUsers()
    }
    
    private func configureCards(cards: [CardView]) {
        cards.forEach { cardView in
            homeView.deckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    private func setupBinding() {
        homeView.navigationStackView.messageButton.onTap(disposeBag: disposeBag) {
            self.viewModel.logoutUser()
        }
        
        viewModel.logoutStatusObservable.subscribe(onNext: { successful in
            if let successful = successful {
                if successful {
                    self.presentLoginViewController()
                }
            }
        }).disposed(by: disposeBag)
        
        viewModel.userObservable.subscribe(onNext: { user in
            if let user = user {
                print(user)
            }
        }).disposed(by: disposeBag)
        
        viewModel.cardsObservable.subscribe(onNext: { cards in
            if let cards = cards {
                self.configureCards(cards: cards)
            }
        }).disposed(by: disposeBag)
    }
    
}
