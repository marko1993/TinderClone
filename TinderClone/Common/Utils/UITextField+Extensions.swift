//
//  UITextField+Extensions.swift
//  TinderClone
//
//  Created by Marko on 10/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UITextField {
    func onValueChanged(disposeBag: DisposeBag, completionHandler: @escaping (String?) -> Void) {
        self
            .rx
            .value
            .subscribe(onNext: { text in
                completionHandler(text)
            }).disposed(by: disposeBag)
    }
}
