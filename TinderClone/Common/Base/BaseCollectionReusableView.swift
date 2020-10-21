//
//  BaseCollectionReusableView.swift
//  TinderClone
//
//  Created by Marko on 21/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift

class BaseCollectionReusableView: UICollectionReusableView {
    
    let disposeBag = DisposeBag()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     func setupView() {
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
    
}
