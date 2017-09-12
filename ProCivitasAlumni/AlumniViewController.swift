//
//  AlumniViewController.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2017-09-07.
//  Copyright © 2017 Wilhelm Michaelsen. All rights reserved.
//

import UIKit

class AlumniViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var currentAlumni: Alumni? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard currentAlumni != nil else {
            print("currentAlumni is nil")
            return
        }
        
        self.nameLabel.text = currentAlumni!.title!
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
