//
//  BaseViewController.swift
//  TinderClone
//
//  Created by Marko on 03/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupView(_ view: UIView) {
        self.view.addSubview(view)
        view.fillSuperview()
    }
    
    func presentLoginViewController() {
        DispatchQueue.main.async {
            let controller = LoginViewController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    func presentProfileViewController(user: User, hideBottomNavigation: Bool = false) {
        let controller = ProfileViewController(viewModel: ProfileViewModel(user: user), hideBottomNavigation: hideBottomNavigation)
        controller.modalPresentationStyle = .fullScreen
        self.setupBindingForProfileController(controller)
        self.present(controller, animated: true, completion: nil)
    }
    
    private func setupBindingForProfileController(_ controller: ProfileViewController) {
        controller.bottomButtonPressedObservable.subscribe(onNext: { bottomButton in
            if let bottomButton = bottomButton {
                switch bottomButton {
                case .dislikeButton:
                    self.saveSwipe(direction: .left, performeSwipeAnimation: true)
                case .likeButton:
                    self.saveSwipe(direction: .right, performeSwipeAnimation: true)
                }
            }
        }).disposed(by: disposeBag)
    }
    
    func saveSwipe(direction: SwipeDirection, performeSwipeAnimation: Bool) {
        
    }
    
}
