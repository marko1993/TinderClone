//
//  ButtonWithAttributedString.swift
//  TinderClone
//
//  Created by Marko on 10/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class ButtonWithAttributedString: UIButton {
    
    init(title: String, appendedString: String, type: ButtonType) {
        super.init(frame: .zero)
        
        let attributedTitle = NSMutableAttributedString(string: title, attributes: [.foregroundColor : UIColor.white])
        attributedTitle.append(NSAttributedString(string: appendedString, attributes: [.foregroundColor : UIColor.white, .font: UIFont.boldSystemFont(ofSize: 16)]))
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
}
