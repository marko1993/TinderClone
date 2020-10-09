//
//  CardViewModel.swift
//  TinderClone
//
//  Created by Marko on 04/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class CardViewModel: BaseViewModel {
    
    let user: User
    private var imageIndex = 0
    private lazy var currentImage = user.images.first
    
    init(user: User) {
        self.user = user
    }
    
    func getUserInfoTextAttributedString() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: user.name,
                                                       attributes: [
                                                        .font : UIFont.systemFont(ofSize: 32, weight: .heavy),
                                                        .foregroundColor: UIColor.white])
        
        attributedText.append(NSAttributedString(string: String(format: "  %d", user.age), attributes: [
        .font : UIFont.systemFont(ofSize: 24),
        .foregroundColor: UIColor.white]))
        
        return attributedText
    }
    
    func showNextPhoto() -> UIImage {
        imageIndex += 1
        if imageIndex >= user.images.count {
            imageIndex = 0
        }
        self.currentImage = user.images[imageIndex]
        return self.currentImage!
    }
    
    func showPreviousPhoto()  -> UIImage{
        imageIndex -= 1
        if imageIndex <= -1 {
            imageIndex = user.images.count - 1
        }
        self.currentImage = user.images[imageIndex]
        return self.currentImage!
    }
    
}
