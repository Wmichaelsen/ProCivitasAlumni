//
//  ProfileHeaderTableViewCell.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-19.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit

protocol ProfileSectionHeaderTableViewCellDelegate {
    func signOutTapped()
}

class ProfileHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var delegate: ProfileSectionHeaderTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        self.delegate?.signOutTapped()
    }
    
}

extension ProfileHeaderTableViewCell: Renderable {
    func render(with header: SectionHeader) {
        
    }
    
    func render(with item: DataSourceItemType) {
        switch item {
        case .header(let headerInfo):
            self.nameLabel.text = headerInfo.name
        default:
            break
        }
    }
}
