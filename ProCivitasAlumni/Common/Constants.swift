//
//  Constants.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-14.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import Foundation
import UIKit
import MapKit

//MARK:- Firebase Constants
let kFirebaseAPIKey = "AIzaSyDdsHB9Xw26DTTVjqTLHrSV4RioaYcVQOg"
let kFirebaseAuthDomain = "procivitasalumni.firebaseapp.com"
let kFirebaseProjectId = "procivitasalumni"
let kFirebaseStorageBucket = "procivitasalumni.appspot.com"
let kFirebaseMessagingSenderId = "631637429160"

let kBaseFirebaseURL = "https://procivitasalumni.firebaseio.com"

//MARK:- Paths
let kUsersPath = "/users"

//MARK:- App Delagate

let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate

//MARK:- UserDefault keys
let kUserDefaults = UserDefaults.standard

let kCurrentProfileKey = "currentProfile"
let kLinkedinConnectedKey = "kLinkedInConnectedKey"
let kLocationAlwaysAllowedKey = "kLocationAlwaysAllowedKey"
let kOnboardCompleteKey = "onboardComplete"

//MARK:- Notification constants
let kDefaultNotificationCenter =  NotificationCenter.default

extension Notification.Name {
    static let kUserSignedOut = Notification.Name("kUserSignedOut")
}

//MARK:- Map contants
let kMapRegionRadius: CLLocationDistance = 1000
let kDefaultInitialLocation = CLLocation(latitude: 56.046180, longitude: 12.697655)

//MARK:- Core Location contants
let kLocationUpdateThreshold: Double = 100.0
