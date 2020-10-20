//
//  MatchView.swift
//  TinderClone
//
//  Created by Marko on 19/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift

enum MatchViewButton {
    case sendMessage, keepSwiping
}

class MatchView: BaseView {
    
    private let viewModel: MatchViewModel
    private let matchImage = UIImageView()
    private let descriptionLabel = UILabel()
    private lazy var currentUserImage = getUserImage()
    private lazy var matchedUserImage = getUserImage()
    private lazy var sendMessageButton = getButton(title: K.Strings.sendMessage, button: .sendMessage)
    private lazy var keepSwipingButton = getButton(title: K.Strings.keepSwiping, button: .keepSwiping)
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    private lazy var views = [matchImage, descriptionLabel,
                              currentUserImage, matchedUserImage,
                              sendMessageButton, keepSwipingButton]
    
    init(viewModel: MatchViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configureAnimations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubviews() {
        configureBlurView()
        views.forEach { view in
            addSubview(view)
            view.alpha = 0
        }
    }
    
    override func styleViews() {
        matchImage.image = #imageLiteral(resourceName: "itsamatch")
        matchImage.contentMode = .scaleAspectFill
        
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.systemFont(ofSize: 20)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = String(format: K.Strings.matchDescriptionLabel, viewModel.getMachedUser().name)
        
        currentUserImage.image = #imageLiteral(resourceName: "lady4c")
        matchedUserImage.image = #imageLiteral(resourceName: "kelly1")
        
    }
    
    override func addConstraints() {
        currentUserImage.anchor(right: centerXAnchor, paddingRight: 16)
        configureImage(currentUserImage)
        
        matchedUserImage.anchor(left: centerXAnchor, paddingLeft: 16)
        configureImage(matchedUserImage)
        
        sendMessageButton.anchor(top: currentUserImage.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 32, paddingLeft: 48, paddingRight: 48)
        keepSwipingButton.anchor(top: sendMessageButton.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 48, paddingRight: 48)
        
        descriptionLabel.anchor(left: leftAnchor, bottom: currentUserImage.topAnchor, right: rightAnchor, paddingBottom: 32)
        
        matchImage.anchor(bottom: descriptionLabel.topAnchor, paddingBottom: 16)
        matchImage.setDimensions(height: 80, width: 300)
        matchImage.centerX(inView: self)
        
        sendMessageButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        keepSwipingButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    override func setupBinding() {
        
    }
    
    private func getUserImage() -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }
    
    private func getButton(title: String, button: MatchViewButton) -> UIButton {
        let btn = button == .sendMessage ? ButtonGradientBackground(type: .system) : ButtonGradientBorder(type: .system)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }
    
    private func configureBlurView() {
        addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        visualEffectView.alpha = 0
        
        setAnimation(animation: {
            self.visualEffectView.alpha = 1
        }, completion: nil)
        
        let tap = UITapGestureRecognizer()
        tap
            .rx
            .event
            .subscribe(onNext: { _ in
                self.setAnimation(animation: {
                    self.alpha = 0
                }) {
                    self.removeFromSuperview()
                }
            }).disposed(by: disposeBag)
        visualEffectView.addGestureRecognizer(tap)
    }
    
    private func configureImage(_ image: UIImageView) {
        image.setDimensions(height: 140, width: 140)
        image.layer.cornerRadius = 140 / 2
        image.centerY(inView: self)
    }
    
    private func configureAnimations() {
        views.forEach({ $0.alpha = 1 })
        let angle = 30 * CGFloat.pi / 360
        
        currentUserImage.transform = CGAffineTransform(rotationAngle: -angle).concatenating(CGAffineTransform(translationX: 200, y: 0))
        matchedUserImage.transform = CGAffineTransform(rotationAngle: angle).concatenating(CGAffineTransform(translationX: -200, y: 0))
        
        UIView.animateKeyframes(withDuration: 1.3, delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.45) {
                self.currentUserImage.transform = CGAffineTransform(rotationAngle: -angle)
                self.matchedUserImage.transform = CGAffineTransform(rotationAngle: angle)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) {
                self.currentUserImage.transform = .identity
                self.matchedUserImage.transform = .identity
            }
        }, completion: nil)
    }
    
    private func setAnimation(animation: @escaping () -> Void, completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            animation()
        }) { _ in
            if let completion = completion {
                completion()
            }
        }
    }
    
}
