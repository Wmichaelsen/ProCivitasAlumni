//
//  +UIView.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-17.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit

//MARK:- Constraints

extension UIView {
    
    func addFillInSuperViewConstraint() {
        let viewDict = ["view": self]
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: [], metrics: nil, views: viewDict))
        self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:  "V:|-0-[view]-0-|", options: [], metrics: nil, views: viewDict))
    }
}
