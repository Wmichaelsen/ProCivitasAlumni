//
//  FeedAnnouncementTableViewCell.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-20.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit

class FeedAnnouncementTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension FeedAnnouncementTableViewCell: Renderable {
    func render(with header: SectionHeader) {
        
    }
    
    func render(with item: DataSourceItemType) {
        switch item {
        case .announcement(let bodyInfo):
            self.titleLabel.text = bodyInfo.headline
            self.messageLabel.text = bodyInfo.main
            self.dateLabel.text = bodyInfo.time
        default:
            break
        }
    }
}
