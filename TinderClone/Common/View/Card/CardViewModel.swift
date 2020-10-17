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
    var currentImageURL: URL?
    var imageURLs: [URL]?
    
    init(user: User) {
        self.user = user
        self.currentImageURL = user.imageURLs.first
        self.imageURLs = user.imageURLs
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
    
    func showNextPhoto() -> URL? {
        imageIndex += 1
        if imageIndex >= user.images.count {
            imageIndex = 0
        }
        self.currentImageURL = user.imageURLs[imageIndex]
        return self.currentImageURL
    }
    
    func showPreviousPhoto()  -> URL?{
        imageIndex -= 1
        if imageIndex <= -1 {
            imageIndex = user.images.count - 1
        }
        self.currentImageURL = user.imageURLs[imageIndex]
        return self.currentImageURL
    }
    
    func getImageIndex() -> Int {
        return imageIndex
    }
    
}
