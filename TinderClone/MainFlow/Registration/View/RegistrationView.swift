//
//  RegistrationView.swift
//  TinderClone
//
//  Created by Marko on 09/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class RegistrationView: BaseView {
    
    var selectPhotoButton = UIButton(type: .system)
    var emailTextField = CustomTextField(placeHolder: K.Strings.email)
    var fullNameField = CustomTextField(placeHolder: K.Strings.fullName)
    var passwordTextField = CustomTextField(placeHolder: K.Strings.password)
    var registerButton = CustomButton(title: K.Strings.register, type: .system)
    var stack = UIStackView()
    var goToLoginButton = ButtonWithAttributedString(title: K.Strings.alreadyHaveAccount, appendedString: K.Strings.login, type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    override func addSubviews() {
        addSubview(selectPhotoButton)
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(fullNameField)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(registerButton)
        addSubview(stack)
        addSubview(goToLoginButton)
    }
    
    override func styleViews() {
        selectPhotoButton.tintColor = .white
        selectPhotoButton.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        selectPhotoButton.setDimensions(height: 275, width: 275)
        
        passwordTextField.isSecureTextEntry = true
        
        stack.axis = .vertical
        stack.spacing = 16
    }
    
    override func addConstraints() {
        selectPhotoButton.centerX(inView: self)
        selectPhotoButton.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        stack.anchor(top: selectPhotoButton.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 32, paddingRight: 32)
        goToLoginButton.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingLeft: 32, paddingRight: 32)
    }
    
}
