//
//  Coordinator.swift
//  TinderClone
//
//  Created by Marko on 19.02.2021..
//  Copyright © 2021 Marko. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    
}
