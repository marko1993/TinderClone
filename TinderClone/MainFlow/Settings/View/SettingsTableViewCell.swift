//
//  SettingsTableViewCell.swift
//  TinderClone
//
//  Created by Marko on 13/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

protocol SettingsCellDelegate: class {
    func settingsCell(_ cell: SettingsTableViewCell, wantsToUpdateWith value: String, for section: SettingsSection)
    func settingsCell(_ cell: SettingsTableViewCell, wantsToUpdateAgeRangeWith value: Int, forMin: Bool)
}

class SettingsTableViewCell: BaseTableViewCell {
    
    public static let reuseIdentifier = "SettingsTableViewCell"
    weak var delegate: SettingsCellDelegate?
    
    let sectionHeaderLabel = CustomLabel(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    let inputTextField = UITextField()
    let minSlider = SliderView(title: K.Strings.min, initialValue: 18)
    let maxSlider = SliderView(title: K.Strings.max, initialValue: 60)
    let slidersStack = UIStackView()
    var section: SettingsSection?
    
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
        selectionStyle = .none
        
        sectionHeaderLabel.font = UIFont.systemFont(ofSize: 24)
        sectionHeaderLabel.backgroundColor = .systemGray4
        
        slidersStack.axis = .vertical
        slidersStack.spacing = 16
        
        inputTextField.borderStyle = .none
        inputTextField.font = UIFont.systemFont(ofSize: 16)
    }
    
    override func addConstraints() {
        sectionHeaderLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
    }
    
    override func setupBinding() {
        inputTextField.rx.controlEvent(.editingDidEnd).subscribe { _ in
            self.endEditing(true)
            guard let value = self.inputTextField.text else { return }
            guard let section = self.section else { return }
            self.delegate?.settingsCell(self, wantsToUpdateWith: value, for: section)
        }.disposed(by: disposeBag)
        
        minSlider.getSlider().rx.value.subscribe (onNext: { value in
            self.delegate?.settingsCell(self, wantsToUpdateAgeRangeWith: Int(value), forMin: true)
        }).disposed(by: disposeBag)
        
        maxSlider.getSlider().rx.value.subscribe (onNext: { value in
            self.delegate?.settingsCell(self, wantsToUpdateAgeRangeWith: Int(value), forMin: false)
        }).disposed(by: disposeBag)
    }
    
    private func addConstraints(to view: UIView) {
        view.anchor(top: sectionHeaderLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 8, paddingRight: 16)
    }
    
    func setup(with data: SettingsData) {
        setupView()
        if data.section == .ageRange {
            addSubview(slidersStack)
            inputTextField.removeFromSuperview()
            addConstraints(to: slidersStack)
        } else {
            addSubview(inputTextField)
            slidersStack.removeFromSuperview()
            addConstraints(to: inputTextField)
        }
        self.section = data.section
        updateViews(with: data)
    }
    
    private func updateViews(with data: SettingsData) {
        sectionHeaderLabel.text = data.section.description
        inputTextField.placeholder = "Enter \(data.section.description)..."
        
        switch data.section {
        case .name:
            inputTextField.text = data.user.name
        case .profession:
            inputTextField.text = data.user.profession
        case .age:
            inputTextField.text = "\(data.user.age)"
        case .bio:
            inputTextField.text = data.user.bio
        case .ageRange:
            minSlider.setSliderValue(value: Float(data.user.minSeekingAge))
            minSlider.setSliderLabel(title: K.Strings.min, value: Float(data.user.minSeekingAge))
            maxSlider.setSliderValue(value: Float(data.user.maxSeekingAge))
            maxSlider.setSliderLabel(title: K.Strings.max, value: Float(data.user.maxSeekingAge))
        }
    }
    
}
