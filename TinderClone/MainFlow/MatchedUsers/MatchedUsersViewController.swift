//
//  MatchedUsersViewController.swift
//  TinderClone
//
//  Created by Marko on 21/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MatchedUsersViewController: BaseViewController, UIScrollViewDelegate {
    
    private let matchedUsersView = MatchedUsersView()
    private let viewModel: MatchedUsersViewModel
    
    init(viewModel: MatchedUsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(matchedUsersView)
        configureNavigationController()
        setupBinding()
        viewModel.getMatchedUsers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        matchedUsersView.tableView.delegate = nil
        matchedUsersView.tableView.dataSource = nil
        viewModel
            .matchedUsersObservable
            .bind(to: matchedUsersView
                .tableView
                .rx
                .items(cellIdentifier: MatchedUserTableViewCell.reuseIdentifier,
                       cellType: MatchedUserTableViewCell.self)) { index, user, cell in
                        cell.setupWithUser(user)
        }.disposed(by: disposeBag)
        
        matchedUsersView.headerView.newMatchesCV.delegate = nil
        matchedUsersView.headerView.newMatchesCV.dataSource = nil
        viewModel.matchedUsersObservable
            .bind(to: matchedUsersView.headerView.newMatchesCV.rx
            .items(cellIdentifier: MatchedUserCollectionViewCell.reuseIdentifier,
                       cellType: MatchedUserCollectionViewCell.self)) { row, user, cell in
                        cell.setup(with: user)
        }.disposed(by: disposeBag)
        matchedUsersView.headerView.newMatchesCV.rx.setDelegate(self).disposed(by: disposeBag)
       
    }
    
    func configureNavigationController() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: matchedUsersView.leftButton)
        navigationItem.titleView = matchedUsersView.centerIcon
    }
    
    private func setupBinding() {
        matchedUsersView.leftButton.onTap(disposeBag: disposeBag) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension MatchedUsersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 108)
    }
}
