//
//  MatchedUsersHeader.swift
//  TinderClone
//
//  Created by Marko on 21/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class MatchedUsersHeader: BaseCollectionReusableView {
    
    private let headerTitleLabel = UILabel()
    lazy var newMatchesCV = getCollectionView()
    private let tableViewTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubviews() {
        addSubview(headerTitleLabel)
        addSubview(newMatchesCV)
        addSubview(tableViewTitleLabel)
    }
    
    override func styleViews() {
        backgroundColor = .white
        newMatchesCV.register(MatchedUserCollectionViewCell.self, forCellWithReuseIdentifier: MatchedUserCollectionViewCell.reuseIdentifier)
        headerTitleLabel.text = K.Strings.newMatches
        headerTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        headerTitleLabel.textColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        newMatchesCV.backgroundColor = .white
        
        tableViewTitleLabel.text = K.Strings.matches
        tableViewTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        tableViewTitleLabel.textColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }
    
    override func addConstraints() {
        headerTitleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        newMatchesCV.anchor(top: headerTitleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 24, paddingRight: 12)
        tableViewTitleLabel.anchor(top: newMatchesCV.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
    }
    
    private func getCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }
    
}
