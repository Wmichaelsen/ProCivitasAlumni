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
    
    func readData(atPath path: String, withType type: DataEventType, withCompletion completion: @escaping (DataSnapshot) -> Void) {
        ref = Database.database().reference()
        ref.child(path).observe(type, with: completion)
    }
    
    func readDataOnce(atPath path: String, withType type: DataEventType, withCompletion completion: @escaping (DataSnapshot) -> Void) {
        ref = Database.database().reference()
        ref.child(path).observeSingleEvent(of: type, with: completion)
    }
    
    func write(data: [String : Any], atPath path: String, withCompletion completion: @escaping (Error?, DatabaseReference) -> Void) {
        ref = Database.database().reference()
        self.ref.child(path).setValue(data, withCompletionBlock: completion)
    }
    
    func update(data: Any, atPath path: String, withCompletion completion: @escaping (Error?, DatabaseReference) -> Void) {
        ref = Database.database().reference()
        ref.child(path).setValue(data, withCompletionBlock: completion)
    }
    
    func query(value: Any, atPath path: String, withType type: DataEventType, withCompletion completion: @escaping (DataSnapshot) -> Void) {
        ref = Database.database().reference()
        ref.child(path).queryOrdered(byChild: "trackingAllowed").queryEqual(toValue: value).observeSingleEvent(of: type, with: completion)
    }
}
