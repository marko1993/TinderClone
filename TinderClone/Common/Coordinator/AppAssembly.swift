//
//  AppAssembly.swift
//  TinderClone
//
//  Created by Marko on 20.02.2021..
//  Copyright © 2021 Marko. All rights reserved.
//

import Foundation
import Swinject

final class AppAssembly: Assembly {
    
    func assemble(container: Container) {
        self.assembleRepository(container)
        self.assembleHomeViewController(container)
        self.assembleLoginViewController(container)
        self.assembleRegistrationViewController(container)
        self.assembleRepository(container)
        self.assembleSettingsViewController(container)
        self.assembleMatchedUsersViewController(container)
        self.assembleProfileViewController(container)
        self.assembleMatchView(container)
    }
    
    private func assembleRepository(_ container: Container) {
        container.register(FirebaseService.self, name: "main") { r in
            return MainFirebaseService()
        }.inObjectScope(.container)
        
        container.register(AuthService.self, name: "main") { r in
            let firebaseService = container.resolve(FirebaseService.self, name: "main")! as! MainFirebaseService
            return MainAuthService(firebaseService: firebaseService)
        }.inObjectScope(.container)
        
        container.register(Repository.self, name: "main") { r in
            let firebaseService = container.resolve(FirebaseService.self, name: "main")! as! MainFirebaseService
            let authService = container.resolve(AuthService.self, name: "main")! as! MainAuthService
            return MainRepository(firebaseService: firebaseService, authService: authService)
        }.inObjectScope(.container)
    }
    
    private func assembleHomeViewController(_ container: Container) {
        container.register(HomeViewModel.self) { (resolver, coordinator: AppCoordinator) in
            let viewModel = HomeViewModel()
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(HomeViewController.self) { (resolver, coordinator: AppCoordinator) in
            let controller = HomeViewController()
            controller.viewModel = container.resolve(HomeViewModel.self, argument: coordinator)
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleLoginViewController(_ container: Container) {
        container.register(LoginViewModel.self) { (resolver, coordinator: AppCoordinator) in
            let viewModel = LoginViewModel()
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(LoginViewController.self) { (resolver, coordinator: AppCoordinator) in
            let controller = LoginViewController()
            controller.viewModel = container.resolve(LoginViewModel.self, argument: coordinator)
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleRegistrationViewController(_ container: Container) {
        container.register(RegistrationViewModel.self) { (resolver, coordinator: AppCoordinator) in
            let viewModel = RegistrationViewModel()
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(RegistrationViewController.self) { (resolver, coordinator: AppCoordinator) in
            let controller = RegistrationViewController()
            controller.viewModel = container.resolve(RegistrationViewModel.self, argument: coordinator)
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleSettingsViewController(_ container: Container) {
        container.register(SettingsViewModel.self) { (resolver, coordinator: AppCoordinator) in
            let viewModel = SettingsViewModel()
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(SettingsViewController.self) { (resolver, coordinator: AppCoordinator) in
            let controller = SettingsViewController()
            controller.viewModel = container.resolve(SettingsViewModel.self, argument: coordinator)
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleMatchedUsersViewController(_ container: Container) {
        container.register(MatchedUsersViewModel.self) { (resolver, coordinator: AppCoordinator, user: User) in
            let viewModel = MatchedUsersViewModel(user: user)
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(MatchedUsersViewController.self) { (resolver, coordinator: AppCoordinator, user: User) in
            let viewModel = container.resolve(MatchedUsersViewModel.self, arguments: coordinator, user)!
            let controller = MatchedUsersViewController(viewModel: viewModel)
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleProfileViewController(_ container: Container) {
        container.register(ProfileViewModel.self) { (resolver, coordinator: AppCoordinator, user: User) in
            let viewModel = ProfileViewModel(user: user)
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(ProfileViewController.self) { (resolver, coordinator: AppCoordinator, user: User, delegate: ProfileDelegate?, hideBottomNavigation: Bool) in
            let viewModel = container.resolve(ProfileViewModel.self, arguments: coordinator, user)!
            let controller = ProfileViewController(viewModel: viewModel, delegate: delegate, hideBottomNavigation: hideBottomNavigation)
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleMatchView(_ container: Container) {
        container.register(MatchViewModel.self) { (resolver, coordinator: AppCoordinator, currentUser: User, matchedUser: User) in
            let viewModel = MatchViewModel(currentUser: currentUser, matchedUser: matchedUser)
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(MatchView.self) { (resolver, coordinator: AppCoordinator, currentUser: User, matchedUser: User) in
            let viewModel = container.resolve(MatchViewModel.self, arguments: coordinator, currentUser, matchedUser)!
            let controller = MatchView(viewModel: viewModel)
            return controller
        }.inObjectScope(.transient)
    }
    
}
