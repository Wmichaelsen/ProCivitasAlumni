//
//  ProfileManager.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-04-24.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

public final class ProfileManager: NSObject {
    
    // Shared instance for `ProfileManager`
    static let shared: ProfileManager = {
        return ProfileManager()
    }()
    
    //MARK:- Members
    var currentProfile: Profile?
    
    //MARK:- Methods
    
    private override init() {
        super.init()
    }
    
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
            
            var data: [String : Any] = profile.dictionaryObject
            data["trackingAllowed"] = false
            
            FirebaseDBManager.shared.write(data: data, atPath: "/users/\(user.uid)", withCompletion: { (dbError, _) in
                if dbError != nil {
                    completion(nil, dbError)
                    return
                }
                let prof = profile
                prof.password = password
                completion(prof, nil)
            })
        })
    }
    
    func login(profile: Profile, withCompletion completion: @escaping (Profile?, Error?) -> Void) {
        FirebaseAuthManager.shared.login(email: profile.email, password: profile.password!, withCompletion: { (user, error) in
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
        kUserDefaults.set(profile.dictionaryObject, forKey: kCurrentProfileKey)
    }
    
    func forgetCurrentProfile() {
        kUserDefaults.removeObject(forKey: kCurrentProfileKey)
    }
    
    func createProfile(object: [String : Any]) -> Profile {
        return Profile(object: object)
    }
    
    func setCurrentProfile(uid: String? = nil) {
        let profileObj = kUserDefaults.object(forKey: kCurrentProfileKey) as? [String : Any] ?? [String : Any]()
        let profile = Profile(object: profileObj)
        
        if let uid = uid {
            profile.set(userID: uid)
        }
        
        self.currentProfile = profile
    }
    
    func updateTrackingAllowed(_ allowed: Bool) {
        guard let currentUID = self.currentProfile?.uid else { return }
        
        FirebaseDBManager.shared.update(data: allowed, atPath: "/users/\(currentUID)/trackingAllowed", withCompletion: { (error, ref) in
            if let error = error {
                DispatchQueue.main.async {
                    AlertView(title: "Oops", message: error.localizedDescription).show()
                }
            }
        })
    }
    
    func listenToAuthStatusChanged() {
        FirebaseAuthManager.shared.authStatusChanged(update: { (auth, user) in
            if user == nil {
                self.forgetCurrentProfile()
                kDefaultNotificationCenter.post(name: .kUserSignedOut, object: nil)
            } else {
                let profile = Profile(email: user!.email!, uid: user?.uid)
                self.currentProfile = profile
                self.fetchOldUserLocation()
                self.rememberProfile(profile: profile)
            }
        })
    }
    
    func updateUserLocation(location: CLLocation) {
        guard let currentUID = currentProfile?.uid else { return }
        
        if let oldLocationCoordinates = currentProfile?.personalDetails?.coordinate {
            let oldLocation = CLLocation(latitude: oldLocationCoordinates.first!, longitude: oldLocationCoordinates.last!)
            let distance = location.distance(from: oldLocation)
            
            if distance < kLocationUpdateThreshold {
                return
            }
        }
        
        let path = "users/\(currentUID)/coordinate"
        FirebaseDBManager.shared.update(data: [location.coordinate.latitude, location.coordinate.longitude], atPath: path, withCompletion: { (error, ref) in
            guard error == nil else {
                //TODO: track error (analytics)
                return
            }
            
            self.currentProfile?.personalDetails?.coordinate = [location.coordinate.latitude, location.coordinate.longitude]
        })
    }
    
}

//MARK:- Helpers
extension ProfileManager {
    
    func fetchOldUserLocation() {
        guard let currentUID = self.currentProfile?.uid else { return }
        let path = "users/\(currentUID)/coordinate"
        FirebaseDBManager.shared.readDataOnce(atPath: path, withType: .value, withCompletion: { (snapshot) in
            self.currentProfile?.personalDetails?.coordinate = snapshot.value as! [Double]
        })
    }
    
}
