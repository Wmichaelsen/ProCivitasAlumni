//
//  ProfileAnnotation.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-21.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import Foundation
import MapKit

class ProfileAnnotation: NSObject, MKAnnotation {
    let title: String?
    let profile: Profile
    let coordinate: CLLocationCoordinate2D
    
    init(profile: Profile, coordinate: CLLocationCoordinate2D) {
        self.profile = profile
        self.coordinate = coordinate
        self.title = profile.personalDetails?.name
        super.init()
    }
    
    var subtitle: String? {
        return ""
    }
}
