//
//  MatchedUserTableViewCell.swift
//  TinderClone
//
//  Created by Marko on 21/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class MatchedUserTableViewCell: BaseTableViewCell {
    
    static let reuseIdentifier = "MatchedUserTableViewCell"
    private let nameLabel = UILabel()
    private let profileImage = UIImageView()
    private lazy var stack = UIStackView(arrangedSubviews: [profileImage, nameLabel])
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubviews() {
        addSubview(stack)
    }
    
    override func styleViews() {
        selectionStyle = .none
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        profileImage.setDimensions(height: 50, width: 50)
        profileImage.layer.cornerRadius = 50 / 2
        
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        nameLabel.textColor = .darkGray
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 1
        
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 16
    }
    
    override func addConstraints() {
        stack.fillSuperview(padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    func setupWithUser(_ user: User) {
        profileImage.sd_setImage(with: user.imageURLs.first)
        nameLabel.text = user.name
    }
    
}
