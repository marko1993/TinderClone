//
//  SliderView.swift
//  TinderClone
//
//  Created by Marko on 14/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SliderView: BaseView {
    
    private let label = UILabel()
    private lazy var slider = createRangeSlider()
    private let stack = UIStackView()
    private var title: String
    
    init(title: String, initialValue: Float) {
        self.title = title
        super.init(frame: .zero)
        setSliderLabel(title: title, value: initialValue)
        setSliderValue(value: initialValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    override func addSubviews() {
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(slider)
        addSubview(stack)
    }
    
    override func styleViews() {
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 16
        stack.distribution = .fill
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
    }
    
    override func addConstraints() {
        stack.fillSuperview()
        slider.anchor()
    }
    
    override func setupBinding() {
        slider.rx.value.subscribe(onNext: { value in
            self.setSliderLabel(title: self.title, value: value)
        }).disposed(by: disposeBag)
    }
    
    
    func createRangeSlider() -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 60
        return slider
    }
    
    func setSliderLabel(title: String, value: Float) {
        label.text = "\(title): \(Int(value))"
    }
    
    func setSliderValue(value: Float) {
        slider.value = value
    }
    
}
