//
//  MatchedUsersView.swift
//  TinderClone
//
//  Created by Marko on 21/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class MatchedUsersView: BaseView {
    
    var tableView = UITableView()
    let leftButton = UIImageView()
    let centerIcon = UIImageView(image: #imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysTemplate))
    let headerView = MatchedUsersHeader()
    
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
        headerView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 200)
        
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headerView
        tableView.register(MatchedUserTableViewCell.self, forCellReuseIdentifier: MatchedUserTableViewCell.reuseIdentifier)
        
        leftButton.setDimensions(height: 28, width: 28)
        leftButton.image = #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysTemplate)
        leftButton.tintColor = .lightGray
        
        centerIcon.tintColor = .systemPink
    }
    
    override func addConstraints() {
        tableView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
}
