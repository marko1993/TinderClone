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
    var errorLabel = UILabel()
    
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
        stack.addArrangedSubview(errorLabel)
        addSubview(stack)
        addSubview(goToLoginButton)
    }
    
    override func styleViews() {
        selectPhotoButton.tintColor = .white
        selectPhotoButton.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        selectPhotoButton.setDimensions(height: 275, width: 275)
        selectPhotoButton.clipsToBounds = true
        
        registerButton.isEnabled = false
        
        passwordTextField.isSecureTextEntry = true
        
        stack.axis = .vertical
        stack.spacing = 16
        
        errorLabel.font = UIFont.systemFont(ofSize: 10)
        errorLabel.textColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        errorLabel.isHidden = true
        errorLabel.numberOfLines = 2
    }
    
    override func addConstraints() {
        selectPhotoButton.centerX(inView: self)
        selectPhotoButton.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        stack.anchor(top: selectPhotoButton.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 32, paddingRight: 32)
        goToLoginButton.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingLeft: 32, paddingRight: 32)
    }
    
    func setPhoto(image: UIImage?) {
        selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        selectPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        selectPhotoButton.layer.borderWidth = 3
        selectPhotoButton.layer.cornerRadius = 3
        selectPhotoButton.imageView?.contentMode = .scaleAspectFill
    }
    
    func registerButtonEnabled(isEnabled: Bool) {
        if isEnabled {
            registerButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            registerButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
        registerButton.isEnabled = isEnabled
    }
    
    func setErrorLabel(text: String) {
        errorLabel.text = text
        errorLabel.isHidden = false
    }
    
}
