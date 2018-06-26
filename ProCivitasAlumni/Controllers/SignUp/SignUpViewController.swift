//
//  SignUpViewController.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-15.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit
import ILLoginKit
import SwiftOverlays

class SignUpViewController: UIViewController {

    lazy var loginCoordinator: CustomLoginCoordinator = {
        return CustomLoginCoordinator(rootViewController: self)
    }()
    
    fileprivate var signUpComplete: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginCoordinator.delegate = self
        
        kUserDefaults.set(true, forKey: kOnboardCompleteKey)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !signUpComplete {
            loginCoordinator.start()
        } else {
            self.performSegue(withIdentifier: "ToMainSegue", sender: nil)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMainSegue" {
            
        }
    }

}

extension SignUpViewController: CustomLoginCoordinatorDelegate {
    
    func signUp(name: String, email: String, password: String) {
        let profile = Profile(email: email, password: password)
        
        self.showWaitOverlay(window: APP_DELEGATE.window)
        
        ProfileManager.shared.createProfile(profile: profile, password: password, withCompletion: { (profile, error) in
            if error != nil {
                self.removeAllOverlays(window: APP_DELEGATE.window)
                AlertView(title: "Oops", message: error!.localizedDescription).show()
            } else {
                guard let profile = profile else {
                    self.removeAllOverlays(window: APP_DELEGATE.window)
                    AlertView(title: "Oops", message: "An unknown error occurred (code: 101). Please contact administrator").show()
                    return
                }

                ProfileManager.shared.login(profile: profile, withCompletion: { (profile, error) in
                    if error != nil {
                        self.removeAllOverlays(window: APP_DELEGATE.window)
                        AlertView(title: "Oops", message: error!.localizedDescription).show()
                    } else {
                        guard let profile = profile else {
                            self.removeAllOverlays(window: APP_DELEGATE.window)
                            AlertView(title: "Oops", message: "An unknown error occurred (code: 102). Please contact administrator").show()
                            return
                        }
                        
                        self.removeAllOverlays(window: APP_DELEGATE.window)
                        print("SIGNED IN: \(profile.dictionaryObject)")
                        
                        self.signUpComplete = true
                        self.loginCoordinator.finish()
                    }
                })
            }
        })
    }
    
    func signIn(email: String, password: String) {
        let profile = Profile(email: email, password: password)
        
        self.showWaitOverlay(window: APP_DELEGATE.window)
        
        ProfileManager.shared.login(profile: profile, withCompletion: { (profile, error) in
            if error != nil {
                self.removeAllOverlays(window: APP_DELEGATE.window)
                AlertView(title: "Oops", message: error!.localizedDescription).show()
            } else {
                guard profile != nil else {
                    self.removeAllOverlays(window: APP_DELEGATE.window)
                    AlertView(title: "Oops", message: "An unknown error occurred (code: 103). Please contact administrator").show()
                    return
                }
                
                self.removeAllOverlays(window: APP_DELEGATE.window)
                self.signUpComplete = true
                self.loginCoordinator.finish()
            }
        })
    }
    
    func recoverPassword(email: String) {
        ProfileManager.shared.resetPassword(forEmail: email)
    }
    
    
}

