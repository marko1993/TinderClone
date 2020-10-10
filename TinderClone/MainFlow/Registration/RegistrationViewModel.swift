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
    
    private var registrationSucceded: BehaviorRelay<Bool?> = BehaviorRelay(value: nil)
    var registrationStatusObservable: Observable<Bool?> {
        return registrationSucceded.asObservable()
    }
    
    func registerUser(with credentials: AuthCredentials) {
        Repository.shared().registerUser(with: credentials) { [weak self] uid, error in
            if error != nil {
                self?.registrationSucceded.accept(false)
                print(error!.localizedDescription)
            } else {
                self?.registrationSucceded.accept(true)
                print("Successfully registered user with id: \(uid ?? "Error")")
            }
            
        }
    }
    
}
