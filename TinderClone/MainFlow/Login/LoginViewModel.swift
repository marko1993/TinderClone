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
    
    func logUserIn(email: String, password: String, completionHandler: @escaping (Error?) -> Void) {
        Repository.shared().logUserIn(email: email, password: password) { authDataResult, error in
            if let error = error {
                completionHandler(error)
            } else {
                completionHandler(nil)
            }
        }
    }
    
}
