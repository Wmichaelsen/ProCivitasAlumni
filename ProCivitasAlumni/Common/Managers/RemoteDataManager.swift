//
//  RemoteDataManager.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-25.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import Foundation
import UIKit

public final class RemoteDataManager: NSObject {
    
    // Shared instance for `RemoteDataManager`
    static let shared: RemoteDataManager = {
        return RemoteDataManager()
    }()
    
    //MARK:- Members
    var profiles: [Profile]?
    
    
    //MARK:- Methods
    
    private override init() {
        super.init()
    }
    
    func fetchProfiles(withCompletion completion: @escaping ([Profile]?) -> Void) {
        
        FirebaseDBManager.shared.query(value: true, atPath: "users/", withType: .value, withCompletion: { (snapshot) in
            var profiles: [Profile] = [Profile]()
            
            guard let responseDict = snapshot.value as? [String : Any] else {
                completion(nil)
                return
            }
            
            for element in responseDict {
                if let dict = element.value as? [String : Any] {
                    var dict = dict
                    dict["uid"] = element.key
                    profiles.append(Profile(object: dict))
                }
            }
            
            self.profiles = profiles
            completion(profiles)
        })
    }
}
