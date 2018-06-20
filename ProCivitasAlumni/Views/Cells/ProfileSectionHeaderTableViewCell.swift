//
//  ProfileSectionHeaderTableViewCell.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-19.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit

class ProfileSectionHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension ProfileSectionHeaderTableViewCell: Renderable {
    func render(with header: SectionHeader) {
        self.headerLabel.text = header.title
        self.headerImage.image = header.image
    }
    
    func render(with item: DataSourceItemType) {
        
    }
}
