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
            let picker = UIImagePickerController()
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        
        registrationView.registerButton.onTap(disposeBag: disposeBag) {
            guard let email = self.registrationView.emailTextField.text else {return}
            guard let password = self.registrationView.passwordTextField.text else {return}
            guard let fullName = self.registrationView.fullNameField.text else {return}
            guard let profileimage = self.viewModel.selectedProfileImage else {return}
            
            let credentials = AuthCredentials(email: email, password: password, fullName: fullName, profileImage: profileimage)
            
            self.viewModel.registerUser(with: credentials)
        }
        
        registrationView.goToLoginButton.onTap(disposeBag: disposeBag) {
            self.navigationController?.popViewController(animated: true)
        }
        
        registrationView.emailTextField.onValueChanged(disposeBag: disposeBag) { text in
            self.viewModel.email = text
            self.registrationView.registerButtonEnabled(isEnabled: self.viewModel.isFormValid)
        }
        
        registrationView.fullNameField.onValueChanged(disposeBag: disposeBag) { text in
            self.viewModel.fullName = text
            self.registrationView.registerButtonEnabled(isEnabled: self.viewModel.isFormValid)
        }
        
        registrationView.passwordTextField.onValueChanged(disposeBag: disposeBag) { text in
            self.viewModel.password = text
            self.registrationView.registerButtonEnabled(isEnabled: self.viewModel.isFormValid)
        }
        
        viewModel.registrationStatusObservable.subscribe(onNext: { [weak self] isSuccessful in
            if let isSuccessful = isSuccessful {
                if isSuccessful {
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }).disposed(by: disposeBag)
    }
    
}

//MARK: - UIImagePickerControllerDelegate
extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        registrationView.setPhoto(image: image)
        viewModel.selectedProfileImage = image
        dismiss(animated: true, completion: nil)
    }
    
}
