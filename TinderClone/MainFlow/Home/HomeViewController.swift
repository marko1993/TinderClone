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
    var viewModel: HomeViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if !viewModel.isUserLoggedIn() {
            self.viewModel.presentLoginScreen()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(homeView)
        setupBinding()
        homeView.isProgressVisible(true, title: K.Strings.fetchingData)
        viewModel.getCurrentUser()
    }
    
    private func configureCards(cards: [CardView]) {
        if !homeView.deckView.subviews.isEmpty { return }
        cards.forEach { cardView in
            homeView.deckView.addSubview(cardView)
            setupBinding(for: cardView)
            cardView.fillSuperview()
        }
    }
    
    private func setupBinding() {
        homeView.navigationStackView.matchesButton.onTap(disposeBag: disposeBag) {
            self.viewModel.presentUsersMatches()
        }
        
        homeView.navigationStackView.settingsButton.onTap(disposeBag: disposeBag) {
            self.viewModel.presentSettings()
        }
        
        viewModel.logoutStatusObservable.subscribe(onNext: { successful in
            if let successful = successful {
                if successful {
                    self.viewModel.presentLoginScreen()
                }
            }
        }).disposed(by: disposeBag)
        
        viewModel.userObservable.subscribe(onNext: { user in
            if user != nil {
                self.viewModel.getUsers()
            } else {
                self.homeView.isProgressVisible(false)
            }
        }).disposed(by: disposeBag)
        
        viewModel.cardsObservable.subscribe(onNext: { cards in
            if let cards = cards {
                self.configureCards(cards: cards)
            }
            self.homeView.isProgressVisible(false)
        }).disposed(by: disposeBag)
        
        homeView.getBottomStackButton(button: .refreshButton).onTap(disposeBag: disposeBag) {
            self.homeView.isProgressVisible(true)
            self.homeView.deckView.subviews.forEach { view in
                view.removeFromSuperview()
            }
            self.viewModel.getUsers()
        }
        
        homeView.getBottomStackButton(button: .dislikeButton).onTap(disposeBag: disposeBag) {
            self.saveSwipe(direction: .left, performeSwipeAnimation: true)
        }
        
        homeView.getBottomStackButton(button: .likeButton).onTap(disposeBag: disposeBag) {
            self.saveSwipe(direction: .right, performeSwipeAnimation: true)
        }
        
    }
    
    private func setupBinding(for cardView: CardView) {
        cardView.infoButton.onTap(disposeBag: disposeBag) { [weak self] in
            guard let self = self else { return }
            self.viewModel.presentProfileViewController(user: cardView.viewModel.user, delegate: self)
        }
        
        cardView.swipeCardObservable.subscribe(onNext: { direction in
            if let direction = direction {
                self.saveSwipe(direction: direction, performeSwipeAnimation: false)
            }
        }).disposed(by: disposeBag)
    }
    
    override func saveSwipe(direction: SwipeDirection, performeSwipeAnimation: Bool) {
        if performeSwipeAnimation {
            self.homeView.performSwipe(direction: direction)
        }
        let topCard = self.viewModel.popCardOnTop()
        if let topCard = topCard {
            self.viewModel.saveSwipeAndCheckForMatch(for: topCard.viewModel.user, direction: direction) { [weak self] userMatched in
                self?.viewModel.presentMatchView(for: userMatched)
                self?.viewModel.uploadMatch(for: userMatched)
            }
        }
    }
    
}

extension HomeViewController: ProfileDelegate {
    func bottomButton(didSelect profileButton: ProfileStackButton) {
        self.saveSwipe(direction: profileButton == .likeButton ? .right : .left, performeSwipeAnimation: true)
    }
}
