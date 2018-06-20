//
//  RoundedButton.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-17.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
}
