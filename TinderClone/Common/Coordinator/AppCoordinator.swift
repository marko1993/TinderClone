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

class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var currentViewController: UIViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel()
        viewModel.coordinator = self
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        self.currentViewController = viewController
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    func presentLoginViewController() {
        let viewModel = LoginViewModel()
        viewModel.coordinator = self
        let controller = LoginViewController()
        controller.viewModel = viewModel
        self.navigationController.pushViewController(controller, animated: true)
    }
    
    func presentMatchesViewController(user: User) {
        let viewModel = MatchedUsersViewModel(user: user)
        viewModel.coordinator = self
        let controller = MatchedUsersViewController(viewModel: viewModel)
        self.navigationController.pushViewController(controller, animated: true)
    }
    
    func presentSettingsViewController() {
        let viewModel = SettingsViewModel()
        viewModel.coordinator = self
        let controller = SettingsViewController()
        controller.viewModel = viewModel
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.currentViewController?.present(nav, animated: true, completion: nil)
    }
    
    func presentMatchView(for user: User, currentUser: User) {
        let viewModel = MatchViewModel(currentUser: currentUser, matchedUser: user)
        viewModel.coordinator = self
        let matchView = MatchView(viewModel: viewModel)
        self.currentViewController?.view.addSubview(matchView)
        matchView.fillSuperview()
    }
    
    func presentProfileViewController(for user: User, delegate: ProfileDelegate?, hideBottomNavigation: Bool = false) {
        let viewModel = ProfileViewModel(user: user)
        viewModel.coordinator = self
        let controller = ProfileViewController(viewModel: viewModel, delegate: delegate, hideBottomNavigation: hideBottomNavigation)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.currentViewController?.present(nav, animated: true, completion: nil)
    }
    
    func presentRegistrationViewController() {
        let viewModel = RegistrationViewModel()
        viewModel.coordinator = self
        let controller = RegistrationViewController()
        controller.viewModel = viewModel
        self.navigationController.pushViewController(controller, animated: true)
    }
    
}
