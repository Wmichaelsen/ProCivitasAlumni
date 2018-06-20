//
//  FirebaseAuthManager.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-14.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit
import Firebase

class FirebaseAuthManager: NSObject {
    
    // Shared instance for `FirebaseAuthManager`
    static let shared: FirebaseAuthManager = {
        return FirebaseAuthManager()
    }()
    
    var currentUser: User? {
        return Auth.auth().currentUser
    }
    
    func createUser(email: String, password: String, withCompletion completion: @escaping (User?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (authResult, error) in
            completion(authResult, error)
        })
    }

    func login(email: String, password: String, withCompletion completion: @escaping (User?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func logout() throws {
        do {
            try Auth.auth().signOut()
        } catch(let error) {
            throw error
        }
    }
    
    func resetPassword(forEmail email: String) {
        
    }
    
    func authStatusChanged(update: @escaping (Auth, User?) -> Void) {
        Auth.auth().addStateDidChangeListener(update)
    }
}
