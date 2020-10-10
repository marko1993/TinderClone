//
//  LoginViewModel.swift
//  TinderClone
//
//  Created by Marko on 09/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: BaseViewModel {
    var email: String?
    var password: String?
    var isFormValid: Bool {
        if let email = email, let password = password {
            let isValid = !email.isEmpty && !password.isEmpty
            return isValid
        }
        return false
    }
}
