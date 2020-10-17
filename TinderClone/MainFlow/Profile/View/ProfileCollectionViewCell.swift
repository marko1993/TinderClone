//
//  ProfileCollectionViewCell.swift
//  TinderClone
//
//  Created by Marko on 17/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: BaseCollectionViewCell {
    
    static let reuseIdentifier = "ProfileCollectionViewCell"
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    override func addSubviews() {
        addSubview(imageView)
    }
    
    override func styleViews() {
        imageView.contentMode = .scaleToFill
    }
    
    override func addConstraints() {
        imageView.fillSuperview()
    }
    
    func setup(with data: URL) {
        imageView.sd_setImage(with: data)
    }
    
}
