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
        loginView
            .loginButton
            .onTap(disposeBag: disposeBag) {
                guard let email = self.loginView.emailTextField.text else {return}
                guard let password = self.loginView.passwordTextField.text else {return}
                self.viewModel.logUserIn(email: email, password: password)
        }
       
        loginView
            .goToRegistrationButton
            .onTap(disposeBag: disposeBag) {
                self.navigationController?.pushViewController(RegistrationViewController(), animated: true)
        }
        
        loginView
            .emailTextField
            .onValueChanged(disposeBag: disposeBag) { text in
                self.viewModel.email = text
                self.loginView.loginButtonEnabled(isEnabled: self.viewModel.isFormValid)
        }
        
        loginView
            .passwordTextField
            .onValueChanged(disposeBag: disposeBag) { text in
                self.viewModel.password = text
                self.loginView.loginButtonEnabled(isEnabled: self.viewModel.isFormValid)
        }
        
        viewModel.loginStatusObservable.subscribe(onNext: { isSuccessful in
            if let isSuccessful = isSuccessful {
                if isSuccessful {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }).disposed(by: disposeBag)
        
    }
    
}
