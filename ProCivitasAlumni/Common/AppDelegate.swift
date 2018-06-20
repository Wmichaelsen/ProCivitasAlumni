//
//  AppDelegate.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2017-09-01.
//  Copyright © 2017 Wilhelm Michaelsen. All rights reserved.
//

import UIKit
import Firebase
import LinkedInSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        /* Load data for onboarding screen */
        OnboardingItemInfoManager.shared.loadOnboardingItems()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let onboardStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let signUpStoryboard = UIStoryboard(name: "SignUp", bundle: nil)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        
        if !UserDefaults.standard.bool(forKey: "onboardComplete") {
            vc = onboardStoryboard.instantiateViewController(withIdentifier: "OnboardVCID")
        } else {
            if let currentUser = FirebaseAuthManager.shared.currentUser {
                ProfileManager.shared.setCurrentProfile(uid: currentUser.uid)
                vc = mainStoryboard.instantiateViewController(withIdentifier: "MainTBC")
            } else {
                /* Delete locally saved profile */
                ProfileManager.shared.forgetCurrentProfile()
                
                vc = signUpStoryboard.instantiateViewController(withIdentifier: "SignUpVCID")
            }
        }
        
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        ProfileManager.shared.listenToAuthStatusChanged()
                
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return LinkedIn.application(app,
                                    open: url,
                                    options: options)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

