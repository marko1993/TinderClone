//
//  UILabel+Extensions.swift
//  TinderClone
//
//  Created by Marko on 17/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift

extension UILabel {
    func onTap(disposeBag: DisposeBag, completionHandler: @escaping () -> Void) {
        isUserInteractionEnabled = true
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
