//
//  ProfileViewController.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-18.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let sectionHeaderCellID = "sectionHeaderCell"
    let headerCellID = "headerCell"
    let bodyCellID = "bodyCell"
    
    fileprivate var sections: [Section]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        structureSections()
        subscribeForNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        presentLinkedinIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: - Helpers
extension ProfileViewController {
    
    fileprivate func subscribeForNotifications() {
        kDefaultNotificationCenter.addObserver(self, selector: #selector(ProfileViewController.userSignedOut), name: .kUserSignedOut, object: nil)
    }
    
    func presentLinkedinIfNeeded() {
        if !kUserDefaults.bool(forKey: kLinkedinConnectedKey) {
            self.performSegue(withIdentifier: "ToLinkedinSegue", sender: nil)
        }
    }
    
    fileprivate func structureSections() {
        
        var sections = [Section]()
        
        guard let profile = ProfileManager.shared.currentProfile else {
            return
        }
        
        let headerInfo = HeaderInfo(image: UIImage(), name: "", location: "")
        let headerSec = Section.vertical(nil, [DataSourceItem(identifer: headerCellID, itemType: DataSourceItemType.header(headerInfo))])
        sections.append(headerSec)
        
        let dataSourceItemsWork = profile.workHistory!.map({ (work: Work) -> DataSourceItem in
            return DataSourceItem(identifer: bodyCellID, itemType: DataSourceItemType.work(BodyInfo(headline: work.position, main: work.company, time: "\(work.startDate) to \(work.endDate)")))
        })
        let headerWork = SectionHeader(title: "Work History", image: #imageLiteral(resourceName: "workIcon"))
        let bodySecWork = Section.vertical(headerWork, dataSourceItemsWork)
        sections.append(bodySecWork)
        
        let dataSourceItemsEd = profile.educationHistory!.map({ (education: Education) -> DataSourceItem in
            return DataSourceItem(identifer: "bodyCell", itemType: DataSourceItemType.education(BodyInfo(headline: education.school, main: education.program, time: "\(education.startDate) to \(education.endDate)")))
        })
        let headerEd = SectionHeader(title: "Education", image: #imageLiteral(resourceName: "edIcon"))
        let bodySecEd = Section.vertical(headerEd, dataSourceItemsEd)
        sections.append(bodySecEd)
        
        self.sections = sections
    }
}


//MARK:- Notification handlers
extension ProfileViewController {
    
    @objc func userSignedOut(notification: Notification) {
        self.removeFromParentViewController()
        let signUpSB = UIStoryboard(name: "SignUp", bundle: nil)
        let vc = signUpSB.instantiateViewController(withIdentifier: "SignUpVCID")
        APP_DELEGATE.window!.rootViewController = vc
        APP_DELEGATE.window!.makeKeyAndVisible()
    }
    
}

//MARK: - Table View Data Source
extension ProfileViewController: UITableViewDataSource {
    
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
        
        switch section {
        case .vertical(_, let verticalDataSourceItems):
            identifier = verticalDataSourceItems[indexPath.row].identifer
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ProfileHeaderTableViewCell {
                cell.delegate = self
                return cell
            }
        }
        
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = self.sections[indexPath.section]
        
        switch section {
        case .vertical(_, let verticalDataSourceItems):
            switch verticalDataSourceItems[indexPath.row].itemType {
            case .header(_):
                return 360.0
            default:
                return 65.0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = self.sections[section]
        
        switch section {
        case .vertical(let sectionHeader, _):
            if sectionHeader != nil {
                let header = tableView.dequeueReusableCell(withIdentifier: sectionHeaderCellID)
                return header
            }
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 {
            return 65.0
        }
        
        return 0.0
    }
}

//MARK: - Table View Delegate
extension ProfileViewController: UITableViewDelegate {
    
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

//MARK:- ProfileHeaderTableViewCell Delegate
extension ProfileViewController: ProfileSectionHeaderTableViewCellDelegate {
    func signOutTapped() {
        do {
            try ProfileManager.shared.logout()
        } catch(let error) {
            AlertView(title: "Oops", message: error.localizedDescription).show()
        }
    }
}
