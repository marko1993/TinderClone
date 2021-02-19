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
    
    var viewModel: SettingsViewModel!
    let settingsView = SettingsView()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        setupView(settingsView)
        configureNavigationController()
        setupBindings()
        settingsView.isProgressVisible(true, title: K.Strings.fetchingData)
        viewModel.setSettingsData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        settingsView.tableView.delegate = nil
        settingsView.tableView.dataSource = nil
        viewModel
            .settingsData
            .bind(to: settingsView
                .tableView
                .rx
                .items(cellIdentifier: SettingsTableViewCell.reuseIdentifier,
                       cellType: SettingsTableViewCell.self)) { index, data, cell in
                        cell.setup(with: data)
                        cell.delegate = self
        }.disposed(by: disposeBag)
    }
    
    func configureNavigationController() {
        navigationItem.title = K.Strings.settingsViewControllerTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backgroundColor = .systemGroupedBackground
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
            self.settingsView.isProgressVisible(true, title: K.Strings.savingData)
            self.viewModel.saveUser { [weak self] error in
                self?.dismiss(animated: true, completion: nil)
                self?.settingsView.isProgressVisible(false)
            }
        }
        
        settingsView.logoutButton.onTap(disposeBag: disposeBag) {
            self.viewModel.logout { error in
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
        viewModel.headerImagesObservable.subscribe(onNext: { images in
            if let images = images {
                images.enumerated().forEach { [weak self] index, image in
                    self?.settingsView.headerView.setHeaderImage(image: image, for: index)
                }
            }
            self.settingsView.isProgressVisible(false)
        }).disposed(by: disposeBag)
        
    }
    
    private func presentImagePicker(headerButton: SettingsHeaderButton) {
        settingsView.headerView.buttonToUpdate = headerButton
        present(imagePicker, animated: true, completion: nil)
    }
    
}

//MARK: - UIImagePickerControllerDelegate methods

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        dismiss(animated: true, completion: nil)
        settingsView.isProgressVisible(true, title: K.Strings.savingData)
        
        if let selectedImage = info[.originalImage] as? UIImage {
            settingsView.headerView.setHeaderImage(image: selectedImage)
            viewModel.uploadImage(image: selectedImage,imageIndex: settingsView.headerView.buttonToUpdate!.rawValue)
            { [weak self] url, error in
                self?.settingsView.isProgressVisible(false)
            }
        }
    }
}

//MARK: - SettingsCellDelegate methods

extension SettingsViewController: SettingsCellDelegate {
    func settingsCell(_ cell: SettingsTableViewCell, wantsToUpdateAgeRangeWith value: Int, forMin: Bool) {
        self.viewModel.updateUser(with: value, forMin: forMin)
    }
    
    func settingsCell(_ cell: SettingsTableViewCell, wantsToUpdateWith value: String, for section: SettingsSection) {
        self.viewModel.updateUser(with: value, for: section)
    }
}
