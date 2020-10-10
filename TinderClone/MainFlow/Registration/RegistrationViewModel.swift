//
//  RegistrationViewModel.swift
//  TinderClone
//
//  Created by Marko on 09/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import Foundation

class RegistrationViewModel: BaseViewModel {
    var email: String?
    var fullName: String?
    var password: String?
    var isFormValid: Bool {
        if let email = email, let fullName = fullName, let password = password {
            return !email.isEmpty && !fullName.isEmpty && !password.isEmpty
        }
        return false
    }
}
