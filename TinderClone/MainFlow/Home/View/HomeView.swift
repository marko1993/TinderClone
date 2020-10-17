//
//  HomeViewController+View.swift
//  TinderClone
//
//  Created by Marko on 03/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class HomeView: BaseView {
    
    let navigationStackView = HomeNavigationStackView()
    let bottomStackView = BottomControlsStackView(buttonImages: [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "boost_circle")])
    let deckView = UIView()
    let stack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    override func addSubviews() {
        stack.addArrangedSubview(navigationStackView)
        stack.addArrangedSubview(deckView)
        stack.addArrangedSubview(bottomStackView)
        addSubview(stack)
    }
    
    override func styleViews() {
        backgroundColor = .white
        
        deckView.backgroundColor = .white
        deckView.layer.cornerRadius = 10
        
        stack.axis = .vertical
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stack.bringSubviewToFront(deckView)
    }
    
    override func addConstraints() {
        stack.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor,
        bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor)
    }
    
}
