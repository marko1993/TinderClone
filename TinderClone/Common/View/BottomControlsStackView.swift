//
//  BottomControlsStackView.swift
//  TinderClone
//
//  Created by Marko on 03/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class BottomControlsStackView: BaseStackView {
    
    var buttons: [UIButton]
    
    init(buttonImages: [UIImage]) {
        buttons = []
        super.init(frame: .zero)
        buttonImages.forEach { image in
            let button = UIButton(type: .system)
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            buttons.append(button)
            addArrangedSubview(button)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubviews() {
        
    }
    
    override func styleViews() {
        distribution = .fillEqually
    }
    
    override func addConstraints() {
        heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
