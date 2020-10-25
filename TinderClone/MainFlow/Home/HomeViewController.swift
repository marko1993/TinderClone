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
            self.presentMatchesViewController()
        }
        
        homeView.navigationStackView.settingsButton.onTap(disposeBag: disposeBag) {
            let controller = SettingsViewController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
        
        viewModel.logoutStatusObservable.subscribe(onNext: { successful in
            if let successful = successful {
                if successful {
                    self.presentLoginViewController()
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
            print("refresh")
        }
        
        homeView.getBottomStackButton(button: .dislikeButton).onTap(disposeBag: disposeBag) {
            self.saveSwipe(direction: .left, performeSwipeAnimation: true)
        }
        
        homeView.getBottomStackButton(button: .likeButton).onTap(disposeBag: disposeBag) {
            self.saveSwipe(direction: .right, performeSwipeAnimation: true)
        }
        
    }
    
    private func setupBinding(for cardView: CardView) {
        cardView.infoButton.onTap(disposeBag: disposeBag) {
            self.presentProfileViewController(user: cardView.viewModel.user)
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
                self?.presentMatchView(for: userMatched)
                self?.viewModel.uploadMatch(for: userMatched)
            }
        }
    }
    
    private func presentMatchView(for user: User) {
        guard let currentUser = viewModel.getUser() else { return }
        let matchView = MatchView(viewModel: MatchViewModel(currentUser: currentUser, matchedUser: user))
        
        matchView.goToMatchesObservable.subscribe(onNext: { goToMatches in
            if goToMatches == true {
                self.presentMatchesViewController()
            }
        }).disposed(by: disposeBag)
        
        homeView.presentMatchView(view: matchView)
    }
    
    private func presentMatchesViewController() {
        guard let user = self.viewModel.getUser() else { return }
        let controller = MatchedUsersViewController(viewModel: MatchedUsersViewModel(user: user))
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
}
