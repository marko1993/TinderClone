//
//  UIImageView+Extension.swift
//  TinderClone
//
//  Created by Marko on 21/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift

extension UIImageView {
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
