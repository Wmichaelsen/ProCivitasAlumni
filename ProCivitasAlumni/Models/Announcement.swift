//
//  Announcement.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-20.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import Foundation

struct Announcement {
    
    let title: String
    let message: String
    let timestamp: String
    let id: String
    
    init(title: String, message: String, timestamp: String, id: String) {
        self.title = title
        self.message = message
        self.timestamp = timestamp
        self.id = id
    }
    
    init(_ dict: [String : AnyObject], id: String) {
        self.title = dict["title"] as! String
        self.message = dict["message"] as! String
        self.timestamp = dict["timestamp"] as! String
        self.id = id
    }
}
