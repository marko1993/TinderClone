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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        settingsView.headerView.selectPhotoBtn1.onTap(disposeBag: disposeBag) {
            print("SELECT PHOTO 1")
        }
        
        settingsView.headerView.selectPhotoBtn2.onTap(disposeBag: disposeBag) {
            print("SELECT PHOTO 2")
        }
        
        settingsView.headerView.selectPhotoBtn3.onTap(disposeBag: disposeBag) {
            print("SELECT PHOTO 3")
        }
        
        settingsView.cancelButton.onTap(disposeBag: disposeBag) {
            self.dismiss(animated: true, completion: nil)
        }
        
        settingsView.doneButton.onTap(disposeBag: disposeBag) {
            print("DONE")
        }
    }
    
}
