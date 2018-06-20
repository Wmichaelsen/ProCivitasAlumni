//
//  CustomTableViewCell.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2017-09-16.
//  Copyright © 2017 Wilhelm Michaelsen. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
