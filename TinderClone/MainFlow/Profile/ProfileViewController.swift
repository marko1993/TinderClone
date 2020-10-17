//
//  ProfileViewController.swift
//  TinderClone
//
//  Created by Marko on 17/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: BaseViewController {
    
    var viewModel: ProfileViewModel
    let profileView = ProfileView()
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(profileView)
        profileView.setupInfo(with: viewModel.getUser(), attributedString: viewModel.getUserInfoTextAttributedString(user: viewModel.getUser(), textSize: 24, attributedTextSize: 22, textColor: .black))
        setupBindings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileView.imagesCollectionView.delegate = nil
        profileView.imagesCollectionView.dataSource = nil
        viewModel.imageURLsObservable
            .bind(to: profileView.imagesCollectionView.rx
            .items(cellIdentifier: ProfileCollectionViewCell.reuseIdentifier,
                       cellType: ProfileCollectionViewCell.self)) { row, data, cell in
                        cell.setup(with: data)
        }.disposed(by: disposeBag)
        profileView.imagesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func setupBindings() {
        profileView.dismissButton.onTap(disposeBag: disposeBag) {
            self.dismiss(animated: true, completion: nil)
        }
        
        profileView.imagesCollectionView.rx.willDisplayCell.subscribe(onNext: { cell, indexPath in
            self.viewModel.willDisplayImage = indexPath.row
        }).disposed(by: disposeBag)
        
        profileView.imagesCollectionView.rx.didEndDisplayingCell.subscribe(onNext: { cell, indexPath in
            if self.viewModel.willDisplayImage != indexPath.row {
                self.profileView.updateImageStackBar(index: self.viewModel.willDisplayImage)
            }
        }).disposed(by: disposeBag)
        
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width + 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
