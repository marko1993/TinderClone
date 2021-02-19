//
//  BaseViewController.swift
//  TinderClone
//
//  Created by Marko on 03/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupView(_ view: UIView) {
        self.view.addSubview(view)
        view.fillSuperview()
    }
    
    func saveSwipe(direction: SwipeDirection, performeSwipeAnimation: Bool) {
        
    }
    
}
