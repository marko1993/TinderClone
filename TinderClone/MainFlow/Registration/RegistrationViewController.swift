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
        registrationView.selectPhotoButton.onTap(disposeBag: disposeBag) {
            
        }
        
        registrationView.registerButton.onTap(disposeBag: disposeBag) {
            
        }
        
        registrationView.goToLoginButton.onTap(disposeBag: disposeBag) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
