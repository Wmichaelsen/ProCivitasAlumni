//
//  Constants.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-14.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Firebase Constants
let kFirebaseAPIKey = "AIzaSyDdsHB9Xw26DTTVjqTLHrSV4RioaYcVQOg"
let kFirebaseAuthDomain = "procivitasalumni.firebaseapp.com"
let kFirebaseProjectId = "procivitasalumni"
let kFirebaseStorageBucket = "procivitasalumni.appspot.com"
let kFirebaseMessagingSenderId = "631637429160"

let kBaseFirebaseURL = "https://procivitasalumni.firebaseio.com"

//MARK:- App Delagate

let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate

//MARK:- UserDefault keys
let kCurrentProfileKey = "currentProfile"

//MARK:- Notification constants
let kDefaultNotificationCenter =  NotificationCenter.default

extension Notification.Name {
    static let kUserSignedOut = Notification.Name("kUserSignedOut")
}
