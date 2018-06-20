//
//  OnboardingViewController.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-14.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit
import PaperOnboarding

class OnboardingViewController: UIViewController {

    @IBOutlet weak var onboardingView: OnboardingView!
    @IBOutlet weak var clickHere: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.onboardingView.delegate = self
        self.onboardingView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func clickHereTapped(_ sender: Any) {
        performSegue(withIdentifier: "getStartedSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension OnboardingViewController: PaperOnboardingDelegate {
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 2 {
            if self.clickHere.alpha == 1 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.clickHere.alpha = 0
                })
            }
        }
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 3 {
            UIView.animate(withDuration: 0.2, animations: {
                self.clickHere.alpha = 1
            })
        }
    }
}

extension OnboardingViewController: PaperOnboardingDataSource {
    func onboardingItemsCount() -> Int {
        guard let onboardingItems = OnboardingItemInfoManager.shared.onboardingItemInfos else { return 0 }
        
        return onboardingItems.count
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        guard let onboardingItems = OnboardingItemInfoManager.shared.onboardingItemInfos else {
            return OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "icon1"),
                                      title: "Oops",
                                      description: "Failed to retrieve onboarding data",
                                      pageIcon: UIImage(),
                                      color: UIColor.red,
                                      titleColor: UIColor.white,
                                      descriptionColor: UIColor.white,
                                      titleFont: UIFont(name: "Arial", size: 24.0)!,
                                      descriptionFont: UIFont(name: "Arial", size: 12.0)!)
        }
        
        return onboardingItems[index]
    }
    
    
}
