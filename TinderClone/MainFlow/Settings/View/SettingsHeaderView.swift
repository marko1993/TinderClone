//
//  SettingsHeaderView.swift
//  TinderClone
//
//  Created by Marko on 11/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

enum SettingsHeaderButtons: Int {
    case first = 0
    case second = 1
    case third = 2
}

class SettingsHeaderView: BaseView {
    
    lazy var selectPhotoBtnFirst = createButton()
    lazy var selectPhotoBtnSecond = createButton()
    lazy var selectPhotoBtnThird = createButton()
    lazy var secondaryButtonsStack = UIStackView(arrangedSubviews: [selectPhotoBtnSecond, selectPhotoBtnThird])
    lazy var buttons: [UIButton] = [selectPhotoBtnFirst, selectPhotoBtnSecond, selectPhotoBtnThird]
    var buttonToUpdate: SettingsHeaderButtons?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGroupedBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubviews() {
        addSubview(selectPhotoBtnFirst)
        addSubview(secondaryButtonsStack)
    }
    
    override func styleViews() {
        secondaryButtonsStack.axis = .vertical
        secondaryButtonsStack.distribution = .fillEqually
        secondaryButtonsStack.spacing = 16
    }
    
    override func addConstraints() {
        selectPhotoBtnFirst.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor,
                       paddingTop: 16, paddingLeft: 16, paddingBottom: 16)
        selectPhotoBtnFirst.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45).isActive = true
        
        secondaryButtonsStack.anchor(top: topAnchor, left: selectPhotoBtnFirst.rightAnchor, bottom: bottomAnchor,
                                     right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
    }
    
    private func createButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(K.Strings.selectPhoto, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleToFill
        return button
    }
    
    func setHeaderImage(image: UIImage?) {
        if let buttonIndex = buttonToUpdate {
            buttons[buttonIndex.rawValue].setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
}
