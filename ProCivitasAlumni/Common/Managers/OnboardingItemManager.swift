//
//  OnboardingItemManager.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-14.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit
import PaperOnboarding

class OnboardingItemInfoManager: NSObject {

    // Shared instance for `OnboardingItemInfoManager`
    static let shared: OnboardingItemInfoManager = {
        return OnboardingItemInfoManager()
    }()
    
    var onboardingItemInfos: [OnboardingItemInfo]?
    
    func loadOnboardingItems(withCompletion completion: @escaping ([OnboardingItemInfo]) -> Void = {_ in return}) {
        
        // TODO: Fetch content from backend in future
        
        let tempItems: [OnboardingItemInfo] = [
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "icon1"),
                               title: "Discover",
                               description: "Find classmates and what they are currently doing in life",
                               pageIcon: #imageLiteral(resourceName: "icon1"),
                               color: UIColor.white,
                               titleColor: UIColor.black,
                               descriptionColor: UIColor.black,
                               titleFont: UIFont(name: "Arial", size: 24.0)!,
                               descriptionFont: UIFont(name: "Arial", size: 12.0)!),
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "icon2"),
                               title: "Connect",
                               description: "Find and connect with people for a project, job or simply a beer",
                               pageIcon: #imageLiteral(resourceName: "icon2"),
                               color: UIColor.white,
                               titleColor: UIColor.black,
                               descriptionColor: UIColor.black,
                               titleFont: UIFont(name: "Arial", size: 24.0)!,
                               descriptionFont: UIFont(name: "Arial", size: 12.0)!),
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "icon3"),
                               title: "Contact",
                               description: "Get contact information of old classmates",
                               pageIcon: #imageLiteral(resourceName: "icon3"),
                               color: UIColor.white,
                               titleColor: UIColor.black,
                               descriptionColor: UIColor.black,
                               titleFont: UIFont(name: "Arial", size: 24.0)!,
                               descriptionFont: UIFont(name: "Arial", size: 12.0)!),
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "icon4"),
                               title: "",
                               description: "",
                               pageIcon: #imageLiteral(resourceName: "icon4"),
                               color: UIColor.white,
                               titleColor: UIColor.black,
                               descriptionColor: UIColor.black,
                               titleFont: UIFont(name: "Arial", size: 24.0)!,
                               descriptionFont: UIFont(name: "Arial", size: 12.0)!)
        ]
        
        self.onboardingItemInfos = tempItems
        completion(tempItems)
    }
    
}
