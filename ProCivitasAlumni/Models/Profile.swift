//
//  Profile.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-04-24.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import SwiftyJSON

protocol DictionaryConvertible {
    var dictionaryObject: [String: Any] { get }
}

class Profile: NSObject {
    
    let email: String
    var password: String?
    var uid: String?
    let workHistory: [Work]? = [Work(company: "Framkalla", position: "iOS Developer", startDate: "Aug 2017", endDate: "May 2018"),
                                Work(company: "Boldsie", position: "Web Developer", startDate: "Jun 2017", endDate: "Aug 2017")]
    let educationHistory: [Education]? = [Education(school: "ProCivitas", program: "Natural Sciences", startDate: "Aug 2014", endDate: "Jun 2018"),
                                          Education(school: "Lawrenceville", program: "Exchange student", startDate: "Sep 2016", endDate: "May 2017")]
    var personalDetails: Details?
    
    init(email: String, password: String? = nil, uid: String? = nil) {
        self.email = email
        self.password = password
        self.uid = uid
        self.personalDetails = Details(name: "Wilhelm Michaelsen", address: "", postalCode: "", city: "", country: "", phone: "", coordinate: [55.962409, 12.861474])
        
        super.init()
    }
    
    init(object: [String : Any]) {
        self.email = object["email"] as! String
        self.uid = object["uid"] as? String
        self.password = object["password"] as? String
        self.personalDetails = Details(name: (object["name"] as? String) ?? "",
                                       address: (object["address"] as? String) ?? "",
                                       postalCode: (object["postalCode"] as? String) ?? "",
                                       city: (object["city"] as? String) ?? "",
                                       country: (object["country"] as? String) ?? "",
                                       phone: (object["phone"] as? String) ?? "",
                                       coordinate: (object["coordinate"] as? [Double]) ?? [0,0])
    }
    
    func set(userID: String) {
        self.uid = userID
    }
}

extension Profile: DictionaryConvertible {
    var dictionaryObject: [String : Any] {
        var dict = [String: Any]()
        dict["email"] = self.email
        dict["uid"] = self.uid
        dict["password"] = self.password
        dict["signUpDevice"] = "ios"
        return dict
    }
}

struct Details {
    var name: String
    var address: String
    var postalCode: String
    var city: String
    var country: String
    var phone: String
    var coordinate: [Double]
}

struct Work {
    var company: String
    var position: String
    var startDate: String
    var endDate: String
}

struct Education {
    var school: String
    var program: String
    var startDate: String
    var endDate: String
}
