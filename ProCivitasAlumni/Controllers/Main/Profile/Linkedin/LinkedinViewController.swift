//
//  LinkedinViewController.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-20.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit
import CoreLocation

class LinkedinViewController: UIViewController {

    @IBOutlet weak var linkedinOverlay: UIView!
    @IBOutlet weak var locationOverlay: UIView!
    @IBOutlet weak var finishOverlay: UIView!
    @IBOutlet weak var finishBtn: RoundedButton!
    
    var linkedinConnected: Bool {
        get {
            return kUserDefaults.bool(forKey: kLinkedinConnectedKey)
        }
        set {
            kUserDefaults.set(newValue, forKey: kLinkedinConnectedKey)
        }
    }
    var locationAllowed: Bool {
        return kUserDefaults.bool(forKey: kLocationAlwaysAllowedKey)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomLocationManager.shared.delegate = self
        finishBtn.isEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func connectTapped(_ sender: Any) {
        guard !linkedinConnected else { return }
        
        startLinkedin() {
            UIView.animate(withDuration: 0.5, animations: {
                self.linkedinOverlay.alpha = 0.0
                self.linkedinConnected = true
                self.checkFinished()
            })
        }
    }
    
    @IBAction func showLocationTapped(_ sender: Any) {
        guard !locationAllowed else { return }
        
        CustomLocationManager.shared.requestAuthorization()
    }
    
    @IBAction func finishTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK:- Helpers
extension LinkedinViewController {
    
    fileprivate func checkFinished() {
        if linkedinConnected && locationAllowed {
            UIView.animate(withDuration: 0.5, animations: {
                self.finishOverlay.alpha = 0.0
                self.finishBtn.isEnabled = true
            })
        }
    }
    
    fileprivate func startLinkedin(completion: @escaping () -> Void) {
        completion()
    }
    
    fileprivate func checkLinkedin() {
        if kUserDefaults.bool(forKey: kLinkedinConnectedKey) {
            UIView.animate(withDuration: 0.5, animations: {
                self.linkedinOverlay.alpha = 0.0
                self.linkedinConnected = true
                self.checkFinished()
            })
            checkFinished()
        }
    }
}

extension LinkedinViewController: CustomLocationManagerDelegate {
    func didUpdate(locations: [CLLocation]) {
        
    }
    
    func didFail(withError error: Error) {
        
    }
    
    func didUpdate(authorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            UIView.animate(withDuration: 0.5, animations: {
                self.locationOverlay.alpha = 0.0
                self.checkFinished()
            })
        }
    }

}
