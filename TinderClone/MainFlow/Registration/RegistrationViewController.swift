//
//  RegistrationViewController.swift
//  TinderClone
//
//  Created by Marko on 09/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegistrationViewController: BaseViewController {
    
    let viewModel = RegistrationViewModel()
    let registrationView = RegistrationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGradientLayer()
        setupView(registrationView)
        setupBinding()
    }
    
    private func setupBinding() {
        let selectPhotoTap = UITapGestureRecognizer()
        selectPhotoTap
            .rx
            .event
            .subscribe(onNext: { _ in
                
            }).disposed(by: disposeBag)
        registrationView.selectPhotoButton.addGestureRecognizer(selectPhotoTap)
        
        let registerButtonTap = UITapGestureRecognizer()
        registerButtonTap
            .rx
            .event
            .subscribe(onNext: { _ in
                
            }).disposed(by: disposeBag)
        registrationView.registerButton.addGestureRecognizer(registerButtonTap)
        
        let goToLoginTap = UITapGestureRecognizer()
        goToLoginTap
            .rx
            .event
            .subscribe(onNext: { _ in
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        registrationView.goToLoginButton.addGestureRecognizer(goToLoginTap)
    }
    
}
