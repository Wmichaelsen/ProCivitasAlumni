//
//  FeedManager.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-20.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit
import Foundation

public final class FeedManager: NSObject {
    
    // Shared instance for `FeedManager`
    static let shared: FeedManager = {
        return FeedManager()
    }()
    
    var announcements: [Announcement]?
    
    private override init() {
        super.init()
    }
    
    func fetchAnnouncements(withCompletion completion: @escaping ([Announcement]?, Error?) -> Void) {
        FirebaseDBManager.shared.readData(atPath: "adminContent/announcements", withType: .value, withCompletion: { (snap) in
            guard let value = snap.value as? [String : AnyObject] else {
                completion(nil, CustomError(title: nil, description: "Could not fetch announcements", code: 104))
                return
            }
            
            let announcements = value.map({ Announcement($0.value as! [String : AnyObject], id: $0.key) })
            self.announcements = announcements
            completion(announcements, nil)
        })
    }
}
