//
//  BaseTableViewCell.swift
//  TinderClone
//
//  Created by Marko on 13/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
