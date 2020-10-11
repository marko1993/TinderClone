//
//  SettingsViewController.swift
//  TinderClone
//
//  Created by Marko on 11/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsViewController: BaseViewController {
    
    let viewModel = SettingsViewModel()
    let settingsView = SettingsView()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        setupView(settingsView)
        configureNavigationController()
        setupBindings()
    }
    
    func configureNavigationController() {
        navigationItem.title = K.Strings.settingsViewControllerTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingsView.cancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsView.doneButton)
    }
    
    func setupBindings() {
        settingsView.headerView.selectPhotoBtnFirst.onTap(disposeBag: disposeBag) {
            self.presentImagePicker(headerButton: .first)
        }
        
        settingsView.headerView.selectPhotoBtnSecond.onTap(disposeBag: disposeBag) {
            self.presentImagePicker(headerButton: .second)
        }
        
        settingsView.headerView.selectPhotoBtnThird.onTap(disposeBag: disposeBag) {
            self.presentImagePicker(headerButton: .third)
        }
        
        settingsView.cancelButton.onTap(disposeBag: disposeBag) {
            self.dismiss(animated: true, completion: nil)
        }
        
        settingsView.doneButton.onTap(disposeBag: disposeBag) {
            print(K.Strings.done)
        }
    }
    
    private func presentImagePicker(headerButton: SettingsHeaderButtons) {
        settingsView.headerView.buttonToUpdate = headerButton
        present(imagePicker, animated: true, completion: nil)
    }
    
}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        settingsView.headerView.setHeaderImage(image: selectedImage)
        dismiss(animated: true, completion: nil)
    }
}
