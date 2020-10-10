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
                
                self.viewModel.logUserIn(email: email, password: password) { [weak self] error in
                    if let error = error {
                        self?.loginView.setErrorLabel(text: error.localizedDescription)
                        return
                    }
                    self?.dismiss(animated: true, completion: nil)
                }
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
                self.onValueInTextFieldChanged()
        }
        
        loginView
            .passwordTextField
            .onValueChanged(disposeBag: disposeBag) { text in
                self.viewModel.password = text
                self.onValueInTextFieldChanged()
        }
        
    }
    
    private func onValueInTextFieldChanged() {
        self.loginView.loginButtonEnabled(isEnabled: self.viewModel.isFormValid)
        self.loginView.errorLabel.isHidden = true
    }
    
}
