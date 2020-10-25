//
//  ProfileView.swift
//  TinderClone
//
//  Created by Marko on 17/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum ProfileStackButton: Int {
    case dislikeButton = 0
    case superLikeButton = 1
    case likeButton = 2
}

class ProfileView: BaseView {
    
    lazy var imagesCollectionView: UICollectionView = {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width + 100)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        return cv
    }()
    
    let dismissButton = UIButton(type: .system)
    let infoLabel = UILabel()
    let professionLabel = UILabel()
    let bioLabel = UILabel()
    let infoStack = UIStackView()
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    let bottomStackView = BottomControlsStackView(buttonImages: [ #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle")])
    var barStack: SegmentedBarView?
    var hideBottomNavigation: Bool
    
    
    init(hideBottomNavigation: Bool = false) {
        self.hideBottomNavigation = hideBottomNavigation
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    override func addSubviews() {
        addSubview(imagesCollectionView)
        addSubview(dismissButton)
        addSubview(infoStack)
        addSubview(blurView)
        infoStack.addArrangedSubview(infoLabel)
        infoStack.addArrangedSubview(professionLabel)
        infoStack.addArrangedSubview(bioLabel)
        addSubview(bottomStackView)
    }
    
    override func styleViews() {
        dismissButton.setImage(#imageLiteral(resourceName: "dismiss_down_arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        backgroundColor = .white
        
        imagesCollectionView.isPagingEnabled = true
        imagesCollectionView.showsHorizontalScrollIndicator = false
        imagesCollectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier)
        
        infoLabel.numberOfLines = 0
        bioLabel.numberOfLines = 0
        bioLabel.font = UIFont.systemFont(ofSize: 20)
        professionLabel.font = UIFont.systemFont(ofSize: 20)
        
        infoStack.axis = .vertical
        infoStack.spacing = 4
        
        bottomStackView.spacing = 10
        bottomStackView.isHidden = hideBottomNavigation
    }
    
    override func addConstraints() {
        dismissButton.setDimensions(height: 40, width: 40)
        dismissButton.anchor(top: imagesCollectionView.bottomAnchor, right: rightAnchor, paddingTop: -20, paddingRight: 16)
        infoStack.anchor(top: imagesCollectionView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        bottomStackView.anchor(bottom: bottomAnchor, paddingBottom: 20)
        bottomStackView.centerX(inView: self)
        blurView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.topAnchor, right: rightAnchor)
    }
    
    func setupInfo(with user: User, attributedString: NSAttributedString) {
        setStackBar(user: user)
        infoLabel.attributedText = attributedString
        professionLabel.text = user.profession
        bioLabel.text = user.bio
    }
    
    private func setStackBar(user: User) {
        barStack = SegmentedBarView(numberOfSegments: user.imageURLs.count)
        addSubview(barStack!)
        barStack?.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 50, paddingLeft: 8, paddingRight: 8, height: 4)
    }
    
    func updateImageStackBar(index: Int) {
        barStack?.adjustBarStackViews(position: index)
    }
    
    func getBottomStackButton(button: ProfileStackButton) -> UIButton {
        return bottomStackView.buttons[button.rawValue]
    }
    
}
