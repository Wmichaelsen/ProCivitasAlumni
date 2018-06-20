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
    let password: String
    var uid: String?
    let workHistory: [Work]? = [Work(company: "Framkalla", position: "iOS Developer"),
                                Work(company: "Boldsie", position: "Web Developer")]
    let educationHistory: [Education]? = [Education(school: "ProCivitas", program: "Natural Sciences"),
                                          Education(school: "Lawrenceville", program: "Exchange student")]
    let personalDetails: Details? = Details(name: "Wilhelm Michaelsen", uid: "", address: "", postalCode: "", city: "", country: "", phone: "")
    
    init(email: String, password: String? = nil, uid: String? = nil) {
        self.email = email
        if password != nil {
            self.password = password!
        } else {
            self.password = ""
        }
        self.uid = uid
        super.init()
    }
    
    init(object: [String : Any]) {
        self.email = object["email"] as! String
        self.uid = object["uid"] as? String
        self.password = object["password"] as? String ?? ""
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
        return dict
    }
}

struct Details {
    var name: String
    var uid: String
    var address: String
    var postalCode: String
    var city: String
    var country: String
    var phone: String
}

struct Work {
    var company: String
    var position: String
}

struct Education {
    var school: String
    var program: String
}
