//
//  SettingsView.swift
//  TinderClone
//
//  Created by Marko on 11/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class SettingsView: BaseView {
    
    var tableView = UITableView()
    let headerView = SettingsHeaderView()
    var cancelButton = UIButton(type: .system)
    var doneButton = UIButton(type: .system)
    var logoutButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    override func addSubviews() {
        addSubview(tableView)
        addSubview(logoutButton)
    }
    
    override func styleViews() {
        tableView.separatorStyle = .none
        tableView.tableHeaderView = self.headerView
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.reuseIdentifier)
        headerView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 300)
        
        cancelButton.setTitle(K.Strings.cancel, for: .normal)
        doneButton.setTitle(K.Strings.done, for: .normal)
        
        logoutButton.setTitle(K.Strings.logout, for: .normal)
        logoutButton.setTitleColor(.systemRed, for: .normal)
        logoutButton.backgroundColor = .systemGray6
    }
    
    override func addConstraints() {
        tableView.anchor(top: topAnchor, left: leftAnchor, bottom: logoutButton.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        logoutButton.anchor(top: tableView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingBottom: 16, height: 50)
    }
    
}
