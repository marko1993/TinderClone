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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    override func addSubviews() {
        addSubview(tableView)
    }
    
    override func styleViews() {
        tableView.separatorStyle = .none
        tableView.tableHeaderView = self.headerView
        headerView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 300)
        
        cancelButton.setTitle(K.Strings.cancel, for: .normal)
        doneButton.setTitle(K.Strings.done, for: .normal)
    }
    
    override func addConstraints() {
        tableView.fillSuperview()
    }
}
