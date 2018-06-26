//
//  CustomLocationManager.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-26.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import Foundation
import CoreLocation

protocol CustomLocationManagerDelegate {
    func didUpdate(locations: [CLLocation])
    func didUpdate(authorization status: CLAuthorizationStatus)
    func didFail(withError error: Error)
}

class CustomLocationManager: NSObject {
    
    // Shared instance for `LocationManager`
    static let shared: CustomLocationManager = {
        return CustomLocationManager()
    }()
    
    //MARK:- Members
    
    var delegate: CustomLocationManagerDelegate?
    
    private override init() {
        super.init()
    }
    
    var locationManager: CLLocationManager?
    
    var locationAlwaysAllowed: Bool {
        set {
            kUserDefaults.set(newValue, forKey: kLocationAlwaysAllowedKey)
        }
        get {
            return kUserDefaults.bool(forKey: kLocationAlwaysAllowedKey)
        }
    }
    
    //MARK:- Methods
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
    
    func startListening() {
        locationManager?.startUpdatingLocation()
    }
    
    func requestAuthorization() {
        locationManager?.requestAlwaysAuthorization()
    }
}

//MARK:- CLLocation Delegate
extension CustomLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //TODO: Update user location in DB here
        ProfileManager.shared.updateUserLocation(location: locations.last!)
        
        delegate?.didUpdate(locations: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            requestAuthorization()
            locationAlwaysAllowed = false
        } else if status == .authorizedAlways {
            locationAlwaysAllowed = true
            ProfileManager.shared.updateTrackingAllowed(true)
            CustomLocationManager.shared.startListening()
        }
        
        delegate?.didUpdate(authorization: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didFail(withError: error)
    }
}
