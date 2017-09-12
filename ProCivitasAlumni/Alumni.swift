//
//  Alumni.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2017-09-01.
//  Copyright © 2017 Wilhelm Michaelsen. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Alumni: NSObject, MKAnnotation {
    let title: String?
    let age: Int
    let locationName: String
    let phone: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, age: Int, locationName: String, phone: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.age = age
        self.locationName = locationName
        self.phone = phone
        self.coordinate = coordinate
        super.init()
    }
    
    class func fromJSON(json: [String:Any]) -> Alumni {
        
        let coord = CLLocationCoordinate2D(latitude: (json["location"] as! [Double])[1], longitude: (json["location"] as! [Double])[0])
        
        guard let ageString = json["age"] as? String, let ageInt = Int(ageString) else {
            return Alumni(title: json["name"] as! String, age: 0, locationName: "No", phone: "0", coordinate: coord)
        }
        
        return Alumni(title: json["name"] as! String, age: ageInt, locationName: "No", phone: "0", coordinate: coord)
    }
    
    var subtitle: String? {
        return locationName
    }
    
    // annotation callout info button opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(CNPostalAddressStreetKey): subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary as Any as? [String : Any])
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
}
