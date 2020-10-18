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
        homeView.navigationStackView.messageButton.onTap(disposeBag: disposeBag) {
            
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
            let controller = ProfileViewController(viewModel: ProfileViewModel(user: cardView.viewModel.user))
            controller.modalPresentationStyle = .fullScreen
            self.setupBindingForProfileController(controller)
            self.present(controller, animated: true, completion: nil)
        }
        
        cardView.swipeCardObservable.subscribe(onNext: { direction in
            if let direction = direction {
                self.saveSwipe(direction: direction, performeSwipeAnimation: false)
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupBindingForProfileController(_ controller: ProfileViewController) {
        controller.bottomButtonPressedObservable.subscribe(onNext: { bottomButton in
            if let bottomButton = bottomButton {
                switch bottomButton {
                case .dislikeButton:
                    self.saveSwipe(direction: .left, performeSwipeAnimation: true)
                case .superLikeButton:
                    self.saveSwipe(direction: .right, performeSwipeAnimation: true)
                case .likeButton:
                    self.saveSwipe(direction: .right, performeSwipeAnimation: true)
                }
            }
        }).disposed(by: disposeBag)
    }
    
    private func saveSwipe(direction: SwipeDirection, performeSwipeAnimation: Bool) {
        if performeSwipeAnimation {
            self.homeView.performSwipe(direction: direction)
        }
        let topCard = self.viewModel.popCardOnTop()
        if let topCard = topCard {
            self.viewModel.saveSwipe(for: topCard.viewModel.user, direction: direction)
        }
    }
    
}
