//
//  CustomLoginCoordinator.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-15.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import Foundation
import ILLoginKit

protocol CustomLoginCoordinatorDelegate {
    func signUp(name: String, email: String, password: String)
    func signIn(email: String, password: String)
    func recoverPassword(email: String)
}

class CustomLoginCoordinator: ILLoginKit.LoginCoordinator {
    
    var delegate: CustomLoginCoordinatorDelegate?
    
    // MARK: - LoginCoordinator
    
    override func start(animated: Bool = true) {
        configureAppearance()
        super.start(animated: animated)
        
    }
    
    override func finish(animated: Bool = true) {
        super.finish(animated: animated)
    }
    
    // MARK: - Setup
    
    // Customize LoginKit. All properties have defaults, only set the ones you want.
    func configureAppearance() {
        
        configuration.backgroundImage = #imageLiteral(resourceName: "bg")
        configuration.mainLogoImage = #imageLiteral(resourceName: "procceLogo")
        configuration.backgroundImageGradient = false
        
        // Change colors
        configuration.tintColor = UIColor(red: 52.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1)
        configuration.errorTintColor = UIColor(red: 253.0/255.0, green: 227.0/255.0, blue: 167.0/255.0, alpha: 1)
        
        // Change placeholder & button texts, useful for different marketing style or language.
        configuration.loginButtonText = "Sign In"
        configuration.signupButtonText = "Sign Up"
        configuration.shouldShowFacebookButton = false
        configuration.forgotPasswordButtonText = "Forgot password?"
        configuration.recoverPasswordButtonText = "Recover"
        configuration.namePlaceholder = "Name"
        configuration.emailPlaceholder = "E-Mail"
        configuration.passwordPlaceholder = "Password!"
        configuration.repeatPasswordPlaceholder = "Confirm password!"
    }
    
    // MARK: - Completion Callbacks
    
    // Handle login via your API
    override func login(email: String, password: String) {
        self.delegate?.signIn(email: email, password: password)
    }
    
    // Handle signup via your API
    override func signup(name: String, email: String, password: String) {
        self.delegate?.signUp(name: name, email: email, password: password)
    }
    
    // Handle Facebook login/signup via your API
    override func enterWithFacebook(profile: FacebookProfile) {
    }
    
    // Handle password recovery via your API
    override func recoverPassword(email: String) {
        self.delegate?.recoverPassword(email: email)
    }
    
}
