//
//  LoginViewController.swift
//  TinderClone
//
//  Created by Marko on 09/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {
    
    let viewModel = LoginViewModel()
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer()
        setupView(loginView)
        setupBindings()
    }
    
    func setupBindings() {
        let loginTap = UITapGestureRecognizer()
        loginTap
            .rx
            .event
            .subscribe(onNext: { _ in
                self.navigationController?.pushViewController(HomeViewController(), animated: true)
            }).disposed(by: disposeBag)
        loginView.loginButton.addGestureRecognizer(loginTap)
        
        let goToRegistrationTap = UITapGestureRecognizer()
        goToRegistrationTap
            .rx
            .event
            .subscribe(onNext: { _ in
                self.navigationController?.pushViewController(RegistrationViewController(), animated: true)
            }).disposed(by: disposeBag)
        loginView.goToRegistrationButton.addGestureRecognizer(goToRegistrationTap)
    }
    
}
