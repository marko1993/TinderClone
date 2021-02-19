//
//  BaseView.swift
//  TinderClone
//
//  Created by Marko on 03/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift
import JGProgressHUD

class BaseView: UIView {
    
    let disposeBag = DisposeBag()
    let progress = JGProgressHUD(style: .dark)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubviews()
        styleViews()
        addConstraints()
        setupBinding()
    }
    
    func addSubviews() {
        
    }
    
    func styleViews() {
        
    }
    
    func addConstraints() {
        
    }
    
    func setupBinding() {
        
    }
    
    func isProgressVisible(_ isVisible: Bool, title: String? = "") {
        if let title = title {
            progress.textLabel.text = title
        }
        if isVisible {
            progress.show(in: self)
        } else {
            progress.dismiss()
        }
    }
    
}
