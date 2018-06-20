//
//  BorderedView.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-17.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit

@IBDesignable
class BorderedView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
