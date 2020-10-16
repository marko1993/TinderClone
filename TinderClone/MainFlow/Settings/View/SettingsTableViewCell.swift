//
//  SettingsTableViewCell.swift
//  TinderClone
//
//  Created by Marko on 13/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class SettingsTableViewCell: BaseTableViewCell {
    
    public static let reuseIdentifier = "SettingsTableViewCell"
    
    let sectionHeaderLabel = CustomLabel(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    let inputTextField = UITextField()
    let minSlider = SliderView(title: "Min", initialValue: 18)
    let maxSlider = SliderView(title: "Max", initialValue: 60)
    let slidersStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubviews() {
        addSubview(sectionHeaderLabel)
        slidersStack.addArrangedSubview(minSlider)
        slidersStack.addArrangedSubview(maxSlider)
    }
    
    override func styleViews() {
        sectionHeaderLabel.font = UIFont.systemFont(ofSize: 24)
        sectionHeaderLabel.backgroundColor = .systemGray6
        
        slidersStack.axis = .vertical
        slidersStack.spacing = 16
        
        inputTextField.borderStyle = .none
        inputTextField.font = UIFont.systemFont(ofSize: 16)
    }
    
    override func addConstraints() {
        sectionHeaderLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
    }
    
    private func addConstraints(to view: UIView) {
        view.anchor(top: sectionHeaderLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 8, paddingRight: 16)
    }
    
    func setup(with data: SettingsData) {
        setupView()
        if data.section == .ageRange {
            addSubview(slidersStack)
            addConstraints(to: slidersStack)
        } else {
            addSubview(inputTextField)
            addConstraints(to: inputTextField)
        }
        sectionHeaderLabel.text = data.section.description
        inputTextField.placeholder = "Enter \(data.section.description)..."
    }
    
}
