//
//  FirebaseManager.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-14.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit
import Firebase

class FirebaseDBManager: NSObject {
    
    // Shared instance for `FirebaseDBManager`
    static let shared: FirebaseDBManager = {
        return FirebaseDBManager()
    }()
    
    var ref: DatabaseReference!
    
    func readData(atPath path: String, type: String, completion: @escaping ([String : Any]) -> Void) {
        
    }
    
    func readDataOnce(atPath path: String, completion: @escaping ([String : Any]) -> Void) {
        
    }
    
    func write(data: [String : Any], atPath path: String, withCompletion completion: @escaping (Error?, DatabaseReference) -> Void) {
        var newData = data
        newData["signUpDevice"] = "ios"
        
        ref = Database.database().reference()
        self.ref.child(path).setValue(newData, withCompletionBlock: completion)
    }
    
}
