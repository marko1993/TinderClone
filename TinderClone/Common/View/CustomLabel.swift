//
//  CustomLabel.swift
//  TinderClone
//
//  Created by Marko on 16/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {
    
    let insets: UIEdgeInsets
    
    init(insets: UIEdgeInsets) {
        self.insets = insets
        super.init(frame: .zero)
        self.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
}
