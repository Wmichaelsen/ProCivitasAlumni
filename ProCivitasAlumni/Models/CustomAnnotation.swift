//
//  CustomAnnotation.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-25.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    let profile: Profile
    let coordinate: CLLocationCoordinate2D
    let title: String?
    
    init(profile: Profile, coordinate: CLLocationCoordinate2D) {
        self.profile = profile
        self.coordinate = coordinate
        
        if profile.uid == ProfileManager.shared.currentProfile?.uid {
            self.title = "You"
        } else {
            self.title = profile.personalDetails?.name
        }
        super.init()
    }
    
    var subtitle: String? {
        return profile.personalDetails?.name
    }
}
