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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(homeView)
        configureCards()
    }
    
    private func configureCards() {
        
        viewModel.getCards().forEach { cardView in
            homeView.deckView.addSubview(cardView)
            cardView.fillSuperview()
        }
        
    }
    
}
