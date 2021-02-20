//
//  AppCoordinator.swift
//  TinderClone
//
//  Created by Marko on 19.02.2021..
//  Copyright © 2021 Marko. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Swinject

class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var currentViewController: UIViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = Assembler.sharedAssembler.resolver.resolve(HomeViewController.self, argument: self)!
        self.currentViewController = viewController
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    func presentLoginViewController() {
        let controller = Assembler.sharedAssembler.resolver.resolve(LoginViewController.self, argument: self)!
        self.navigationController.pushViewController(controller, animated: true)
    }
    
    func presentRegistrationViewController() {
        let controller = Assembler.sharedAssembler.resolver.resolve(RegistrationViewController.self, argument: self)!
        self.navigationController.pushViewController(controller, animated: true)
    }
    
    func presentSettingsViewController() {
        let controller = Assembler.sharedAssembler.resolver.resolve(SettingsViewController.self, argument: self)!
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.currentViewController?.present(nav, animated: true, completion: nil)
    }
    
    func presentMatchesViewController(user: User) {
        let controller = Assembler.sharedAssembler.resolver.resolve(MatchedUsersViewController.self, arguments: self, user)!
        self.navigationController.pushViewController(controller, animated: true)
    }
    
    func presentProfileViewController(for user: User, delegate: ProfileDelegate?, hideBottomNavigation: Bool = false) {
        let controller = Assembler.sharedAssembler.resolver.resolve(ProfileViewController.self, arguments: self, user, delegate, hideBottomNavigation)!
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.currentViewController?.present(nav, animated: true, completion: nil)
    }
    
    func presentMatchView(for user: User, currentUser: User) {
        let matchView = Assembler.sharedAssembler.resolver.resolve(MatchView.self, arguments: self, currentUser, user)!
        self.currentViewController?.view.addSubview(matchView)
        matchView.fillSuperview()
    }
    
}
