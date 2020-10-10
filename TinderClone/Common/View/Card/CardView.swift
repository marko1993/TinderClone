//
//  CardView.swift
//  TinderClone
//
//  Created by Marko on 03/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

enum SwipeDirection: Int {
    case left = -1
    case right = 1
}

class CardView: BaseView {
    
    private let viewModel: CardViewModel
    internal let gradient = CAGradientLayer()
    private let imageView = UIImageView()
    private let infoLabel = UILabel()
    private lazy var infoButton = UIButton()
    
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    override func layoutSubviews() {
        gradient.frame = self.frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubviews() {
        addSubview(imageView)
        configureGradientLayer()
        addSubview(infoLabel)
        addSubview(infoButton)
    }
    
    override func styleViews() {
        backgroundColor = .systemPurple
        layer.cornerRadius = 10
        clipsToBounds = true
        
        infoButton.setDimensions(height: 40, width: 40)
        infoButton.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: viewModel.currentImageURL)
        
        infoLabel.attributedText = viewModel.getUserInfoTextAttributedString()
        infoLabel.numberOfLines = 2
    }
    
    override func addConstraints() {
        imageView.fillSuperview()
        infoLabel.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)

        infoButton.centerY(inView: infoLabel)
        infoButton.anchor(right: rightAnchor, paddingRight: 16)
    }
    
    override func setupBinding() {
        let pan = UIPanGestureRecognizer()
        pan
            .rx
            .event
            .subscribe(onNext: { gestureRecognizer in
                self.handlePanGesture(sender: gestureRecognizer)
            }).disposed(by: disposeBag)
        addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer()
        tap
            .rx
            .event
            .subscribe(onNext: { gestureRecognizer in
                self.handleChangePhoto(sender: gestureRecognizer)
            }).disposed(by: disposeBag)
        addGestureRecognizer(tap)
    }
    
    //MARK: - Actions
    
    private func handlePanGesture(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            superview?.subviews.forEach({$0.layer.removeAllAnimations()})
        case .changed:
            panCard(sender: sender)
        case .ended:
            resetCardPosition(sender: sender)
        default:
            break
        }
    }
    
    private func handleChangePhoto(sender: UITapGestureRecognizer) {
        let location = sender.location(in: nil).x
        let shouldShowNextPhoto = location > self.frame.width / 2
        if shouldShowNextPhoto {
            imageView.sd_setImage(with: viewModel.showNextPhoto())
        } else {
            imageView.sd_setImage(with: viewModel.showPreviousPhoto())
        }
    }
    
}
