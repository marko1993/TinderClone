//
//  RegistrationViewModel.swift
//  TinderClone
//
//  Created by Marko on 09/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegistrationViewModel: BaseViewModel {
    var email: String?
    var fullName: String?
    var password: String?
    var selectedProfileImage: UIImage?
    var isFormValid: Bool {
        if let email = email, let fullName = fullName, let password = password {
            return !email.isEmpty && !fullName.isEmpty && !password.isEmpty
        }
        return false
    }
    
    func registerUser(with credentials: AuthCredentials, completionHandler: @escaping (Error?) -> Void) {
        self.repository?.registerUser(with: credentials) { uid, error in
            if let error = error {
                completionHandler(error)
                print(error.localizedDescription)
            } else {
                completionHandler(nil)
            }
            
        }
    }
    
}
