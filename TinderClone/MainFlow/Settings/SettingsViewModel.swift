//
//  SettingsViewModel.swift
//  TinderClone
//
//  Created by Marko on 11/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class SettingsViewModel: BaseViewModel {
    var settingsData: BehaviorRelay<[SettingsData]> = BehaviorRelay(value: [])
    var user: User?
    private var headerImages: BehaviorRelay<[UIImage]?> = BehaviorRelay(value: nil)
    var headerImagesObservable: Observable<[UIImage]?> {
        return headerImages.asObservable()
    }
    
    func setSettingsData() {
        var data: [SettingsData] = []
        getUser { [weak self] user, error in
            if let error = error {
                print(error)
                return
            }
            self?.user = user
            guard let user = user else {return}
            SettingsSection.allCases.forEach { section in
                let element = SettingsData(section: section, user: user)
                data.append(element)
            }
            self?.settingsData.accept(data)
            self?.getHeaderImages(user: user)
        }
        
    }
    
    func updateUser(with value: String, for section: SettingsSection)  {
        switch section {
        case .name:
            user?.name = value
        case .profession:
            user?.profession = value
        case .age:
            user?.age = Int(value) ?? user?.age ?? 0
        case .bio:
            user?.bio = value
        case .ageRange:
            return
        }
    }
    
    func getHeaderImages(user: User) {
        var images: [UIImage] = []
        if user.imageURLs.count == 0 {
            headerImages.accept([])
        }
        user.imageURLs.enumerated().forEach({ index, url in
            SDWebImageManager.shared().loadImage(with: url, options: .continueInBackground, progress: nil) { [weak self] (image, _, _, _, _, _) in
                if let image = image {
                    images.append(image)
                }
                if index == user.images.count - 1 {
                    self?.headerImages.accept(images)
                }
            }
        })
    }
    
    func updateUser(with value: Int, forMin: Bool) {
        if forMin {
            user?.minSeekingAge = value
        } else {
            user?.maxSeekingAge = value
        }
    }
    
    func uploadImage(image: UIImage, imageIndex: Int, completionHandler: @escaping (String?, Error?) -> Void) {
        FirebaseService.uploadImage(image: image) { [weak self] url, error in
            guard let url = url else {return}
            completionHandler(url, error)
            self?.user?.images.append(url)
            guard let imageURL = URL(string: url) else {return}
            self?.user?.imageURLs.append(imageURL)
        }
    }
    
    func saveUser(completionHandler: @escaping (Error?) -> Void) {
        guard let user = user else {
            fatalError("No user")
        }
        saveUser(user: user, completionHandler: completionHandler)
    }
    
    func presentLoginScreen() {
        self.coordinator?.presentLoginViewController()
    }
    
}
