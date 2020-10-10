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
            
        }
        
        registrationView.goToLoginButton.onTap(disposeBag: disposeBag) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

//MARK: - UIImagePickerControllerDelegate
extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        registrationView.setPhoto(image: image)
        dismiss(animated: true, completion: nil)
    }
    
}
