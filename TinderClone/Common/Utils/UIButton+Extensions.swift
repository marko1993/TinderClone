//
//  UIButton+Extensions.swift
//  TinderClone
//
//  Created by Marko on 10/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift

extension UIButton {
    func onTap(disposeBag: DisposeBag, completionHandler: @escaping () -> ()) {
        let tap = UITapGestureRecognizer()
        tap
            .rx
            .event
            .subscribe(onNext: { _ in
                completionHandler()
            }).disposed(by: disposeBag)
        self.addGestureRecognizer(tap)
    }
}
