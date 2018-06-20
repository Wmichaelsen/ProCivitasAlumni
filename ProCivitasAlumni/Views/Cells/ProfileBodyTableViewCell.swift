//
//  ProfileBodyTableViewCell.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-19.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit

class ProfileBodyTableViewCell: UITableViewCell {

    @IBOutlet weak var companyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension ProfileBodyTableViewCell: Renderable {
    func render(with header: SectionHeader) {
        
    }
    
    func render(with item: DataSourceItemType) {
        switch item {
        case .work(let bodyInfo), .education(let bodyInfo):
            self.companyLabel.text = bodyInfo.headline
        default:
            break
        }
    }
}

