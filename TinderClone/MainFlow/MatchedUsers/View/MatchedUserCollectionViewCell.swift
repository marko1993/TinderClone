//
//  MatchedUserCollectionViewCell.swift
//  TinderClone
//
//  Created by Marko on 21/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class MatchedUserCollectionViewCell: BaseCollectionViewCell {
    
    static let reuseIdentifier = "MatchedUserCollectionViewCell"
    private let profileImage = UIImageView()
    private let nameLabel = UILabel()
    private lazy var stack = UIStackView(arrangedSubviews: [profileImage, nameLabel])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    override func addSubviews() {
        addSubview(stack)
    }
    
    override func styleViews() {
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        profileImage.setDimensions(height: 80, width: 80)
        profileImage.layer.cornerRadius = 80 / 2
        
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        nameLabel.textColor = .darkGray
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 6
    }
    
    override func addConstraints() {
        stack.fillSuperview()
    }
    
    func setup(with user: User) {
        nameLabel.text = user.name
        guard let imageURL = user.imageURLs.first else { return }
        profileImage.sd_setImage(with: imageURL)
    }
    
    
}
