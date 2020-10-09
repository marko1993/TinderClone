//
//  RegistrationViewController.swift
//  TinderClone
//
//  Created by Marko on 09/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class RegistrationViewController: BaseViewController {
    
    let viewModel = RegistrationViewModel()
    let registrationView = RegistrationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(registrationView)
        view.backgroundColor = .purple
    }
    
}
