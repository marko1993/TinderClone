//
//  LoginView.swift
//  TinderClone
//
//  Created by Marko on 09/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class LoginView: BaseView {
    
    var iconImage = UIImageView()
    var emailTextField = CustomTextField(placeHolder: K.Strings.email)
    var passwordTextField = CustomTextField(placeHolder: K.Strings.password)
    var stack = UIStackView()
    var loginButton = CustomButton(title: K.Strings.login, type: .system)
    var goToRegistrationButton = ButtonWithAttributedString(title: K.Strings.dontHaveAccount, appendedString: K.Strings.signUp, type: .system)
    var errorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    override func addSubviews() {
        addSubview(iconImage)
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(loginButton)
        stack.addArrangedSubview(errorLabel)
        addSubview(stack)
        addSubview(goToRegistrationButton)
    }
    
    override func styleViews() {
        iconImage.image = #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysTemplate)
        iconImage.tintColor = .white
        
        passwordTextField.isSecureTextEntry = true
        loginButton.isEnabled = false
        
        stack.axis = .vertical
        stack.spacing = 16
    }
    
    override func addConstraints() {
        iconImage.centerX(inView: self)
        iconImage.setDimensions(height: 100, width: 100)
        iconImage.anchor(top: safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        stack.anchor(top: iconImage.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 32, paddingRight: 32)
        
        goToRegistrationButton.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        errorLabel.font = UIFont.systemFont(ofSize: 10)
        errorLabel.textColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        errorLabel.isHidden = true
        errorLabel.numberOfLines = 2
    }
    
    func loginButtonEnabled(isEnabled: Bool) {
        if isEnabled {
            loginButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            loginButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
        loginButton.isEnabled = isEnabled
    }
    
    func setErrorLabel(text: String) {
        errorLabel.text = text
        errorLabel.isHidden = false
    }
    
}
