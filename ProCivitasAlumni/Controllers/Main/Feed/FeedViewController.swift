//
//  FeedViewController.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-20.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var sections: [Section] = [Section]()
    
    fileprivate let announcementCellID = "announcementCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 135
        
        fetchAnnouncements()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK:- Helpers
extension FeedViewController {
    
    fileprivate func structureSections(withAnnouncements announcements: [Announcement]?) {
        var sections = [Section]()
        
        guard let announcements = announcements else {
            self.tableView.reloadData()
            return
        }
        
        let dataSourceItems = announcements.map({ DataSourceItem(identifer: announcementCellID, itemType: DataSourceItemType.announcement(BodyInfo(headline: $0.title, main: $0.message, time: $0.timestamp))) })
        let section = Section.vertical(nil, dataSourceItems)
        sections.append(section)
        
        self.sections = sections
        self.tableView.reloadData()
    }
    
    fileprivate func fetchAnnouncements() {
        FeedManager.shared.fetchAnnouncements(withCompletion: { (announcements, _) in
            self.structureSections(withAnnouncements: announcements)
        })
    }
    
}

//MARK:- Table View Data Source
extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.sections[section]
        
        switch section {
        case .vertical(_, let verticalDataSourceItems):
            return verticalDataSourceItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.sections[indexPath.section]
        var identifier: String
        var dataSourceItemType: DataSourceItemType
        
        switch section {
        case .vertical(_, let verticalDataSourceItems):
            identifier = verticalDataSourceItems[indexPath.row].identifer
            dataSourceItemType = verticalDataSourceItems[indexPath.row].itemType
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FeedAnnouncementTableViewCell {
            cell.render(with: dataSourceItemType)
            return cell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let section = self.sections[indexPath.section]
//
//        switch section {
//        case .vertical(_, let verticalDataSourceItems):
//            switch verticalDataSourceItems[indexPath.row].itemType {
//            case .header(_):
//                return 360.0
//            default:
//                return UITableViewAutomaticDimension
//            }
//        }
        return UITableViewAutomaticDimension
    }
}

//MARK:- Table View Delegaate
extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var dataSourceItemType: DataSourceItemType
        let section = self.sections[indexPath.section]
        
        switch section {
        case .vertical(_, let verticalDataSourceItems):
            dataSourceItemType = verticalDataSourceItems[indexPath.row].itemType
        }
        
        (cell as? Renderable)?.render(with: dataSourceItemType)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let section = self.sections[section]
        
        switch section {
        case .vertical(let sectionHeader, _):
            if let secHead = sectionHeader {
                (view as? Renderable)?.render(with: secHead)
            }
        }
    }
    
}
