//
//  SettingsHeaderView.swift
//  TinderClone
//
//  Created by Marko on 11/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class SettingsHeaderView: BaseView {
    
    var buttons = [UIButton]()
    lazy var selectPhotoBtn1 = createButton()
    lazy var selectPhotoBtn2 = createButton()
    lazy var selectPhotoBtn3 = createButton()
    lazy var secondaryButtonsStack = UIStackView(arrangedSubviews: [selectPhotoBtn2, selectPhotoBtn3])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGroupedBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubviews() {
        addSubview(selectPhotoBtn1)
        addSubview(secondaryButtonsStack)
    }
    
    override func styleViews() {
        secondaryButtonsStack.axis = .vertical
        secondaryButtonsStack.distribution = .fillEqually
        secondaryButtonsStack.spacing = 16
    }
    
    override func addConstraints() {
        selectPhotoBtn1.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor,
                       paddingTop: 16, paddingLeft: 16, paddingBottom: 16)
        selectPhotoBtn1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45).isActive = true
        
        secondaryButtonsStack.anchor(top: topAnchor, left: selectPhotoBtn1.rightAnchor, bottom: bottomAnchor,
                                     right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
    }
    
    func createButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Select photo", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleToFill
        return button
    }
    
}
