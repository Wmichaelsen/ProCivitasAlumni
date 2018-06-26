//
//  ExploreProfileViewController.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-25.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit

class ExploreProfileViewController: UIViewController {

    var currentExploreProfile: Profile? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard currentExploreProfile != nil else {
            self.dismiss(animated: true, completion: nil)
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
