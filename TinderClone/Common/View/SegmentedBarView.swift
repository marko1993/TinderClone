//
//  SegmentedBarView.swift
//  TinderClone
//
//  Created by Marko on 17/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class SegmentedBarView: BaseStackView {
    
    private var numberOfSegments: Int
    
    init(numberOfSegments: Int) {
        self.numberOfSegments = numberOfSegments
        super.init(frame: .zero)
        configureBarStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBarStackView() {
        (0..<numberOfSegments).forEach({ _ in
            let barView = UIView()
            barView.backgroundColor = .barDeselectedColor
            barView.layer.cornerRadius = 5
            addArrangedSubview(barView)
        })
        arrangedSubviews.first?.backgroundColor = .white
    }
    
    func adjustBarStackViews(position: Int) {
        arrangedSubviews.forEach({ $0.backgroundColor = .barDeselectedColor })
        arrangedSubviews[position].backgroundColor = .white
    }
    
    override func styleViews() {
        spacing = 4
        distribution = .fillEqually
    }
    
    override func addConstraints() {
        heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
}
