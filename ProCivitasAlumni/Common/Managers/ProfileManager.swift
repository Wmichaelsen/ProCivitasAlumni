//
//  ProfileManager.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-04-24.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit
import Foundation

public final class ProfileManager: NSObject {
    
    // Shared instance for `ProfileManager`
    static let shared: ProfileManager = {
        return ProfileManager()
    }()
    
    private override init() {
        super.init()
    }
    
    var profiles: [Profile]?
    var currentProfile: Profile?
    
    /* First creates an authenticated user, then saves user data in database */
    func createProfile(profile: Profile, password: String, withCompletion completion: @escaping (Profile?, Error?) -> Void) {
        FirebaseAuthManager.shared.createUser(email: profile.email, password: password, withCompletion: { (user, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            
            guard let user = user else {
                completion(nil, nil)
                return
            }
            
            FirebaseDBManager.shared.write(data: profile.dictionaryObject, atPath: "/users/\(user.uid)", withCompletion: { (dbError, _) in
                if dbError != nil {
                    completion(nil, dbError)
                    return
                }
                
                completion(profile, nil)
            })
        })
    }
    
    func login(profile: Profile, withCompletion completion: @escaping (Profile?, Error?) -> Void) {
        FirebaseAuthManager.shared.login(email: profile.email, password: profile.password, withCompletion: { (user, error) in
            if error != nil {
                completion(nil, error!)
            } else {
                guard let user = user else {
                    completion(nil, nil)
                    return
                }
                
                profile.set(userID: user.uid)
                self.currentProfile = profile
                self.rememberProfile(profile: profile)
                completion(profile, nil)
            }
        })
    }
    
    func logout() throws {
        do {
            try FirebaseAuthManager.shared.logout()
        } catch(let error) {
            throw error
        }
    }
    
    func resetPassword(forEmail email: String) {
        FirebaseAuthManager.shared.resetPassword(forEmail: email)
    }
    
    func rememberProfile(profile: Profile) {
        UserDefaults.standard.set(profile.dictionaryObject, forKey: kCurrentProfileKey)
    }
    
    func forgetCurrentProfile() {
        UserDefaults.standard.removeObject(forKey: kCurrentProfileKey)
    }
    
    func createProfile(object: [String : Any]) -> Profile {
        return Profile(object: object)
    }
    
    func setCurrentProfile(uid: String? = nil) {
        let profileObj = UserDefaults.standard.object(forKey: kCurrentProfileKey) as? [String : Any] ?? [String : Any]()
        let profile = Profile(object: profileObj)
        
        if let uid = uid {
            profile.set(userID: uid)
        }
        
        self.currentProfile = profile
    }
    
    func listenToAuthStatusChanged() {
        FirebaseAuthManager.shared.authStatusChanged(update: { (auth, user) in
            if user == nil {
                self.forgetCurrentProfile()
                kDefaultNotificationCenter.post(name: .kUserSignedOut, object: nil)
            } else {
                let profile = Profile(email: user!.email!, uid: user?.uid)
                self.currentProfile = profile
                self.rememberProfile(profile: profile)
            }
        })
    }
}
