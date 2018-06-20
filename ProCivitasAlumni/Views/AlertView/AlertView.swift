//
//  AlertView.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-17.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//


import UIKit

public typealias AlertAction = () -> Void


private let kAlertViewTag = 1111

public enum AlertViewButtons {
  case ok(okAction: AlertAction?)
  case ok_cancel(okAction: AlertAction?, cancelAction: AlertAction?)
}


open class AlertView: UIView {
  
  
  //MARK:- Outlets
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var btnOk: RoundedThemedOkButton!
    @IBOutlet weak var btnCancel: RoundedThemedCancelButton!
    
    @IBOutlet weak var container: BorderedView!
    @IBOutlet weak var messageBoxContainerHeightConstraint: NSLayoutConstraint!
    
    //MARK:- Actions

    @IBAction func okTapped(_ sender: RoundedThemedOkButton) {
        dismiss {
            sender.action?()
        }
    }
    
    @IBAction func cancelTapped(_ sender: RoundedThemedCancelButton) {
        dismiss {
            sender.action?()
        }
    }
    
  //MARK:- Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.loadSubview()
  }
  
  fileprivate func loadSubview() {
    
    if self.subviews.isEmpty {
      
      let alerView = Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)!.first as! AlertView
      
      self.addSubview(alerView)
      alerView.translatesAutoresizingMaskIntoConstraints = false
      alerView.addFillInSuperViewConstraint()
      
      self.setNeedsLayout()
      self.layoutIfNeeded()
    }
  }
  
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  public init(title: String,
              message: String?,
              buttons: AlertViewButtons = .ok(okAction: nil),
              cancelButtonTitle: String? = nil,
              okButtonTitle: String? = nil) {
    
    super.init(frame: UIScreen.main.bounds)
    self.loadSubview()
    
    lblTitle.text = title
    lblMessage.text = message
    
    lblTitle.sizeToFit()
    lblMessage.sizeToFit()
    
    let okButtonTitleString = okButtonTitle

    self.btnOk.setTitle("Ok", for: .normal)
    self.btnCancel.setTitle("Cancel", for: .normal)
    
    switch buttons {
    case .ok(let action):
      btnCancel.isHidden = true
      btnCancel.isUserInteractionEnabled = false
      btnOk.action = action
    case .ok_cancel(let okAction, let cancelAction):
      btnOk.action = okAction
      btnCancel.action = cancelAction
    }
    
    self.setNeedsLayout()
    self.layoutIfNeeded()
    
    self.messageBoxContainerHeightConstraint.constant = 156 + self.lblTitle.frame.size.height + lblMessage.frame.size.height
  }
  
  open func show() {
    
    // Add self to keyWindow
    if let window = APP_DELEGATE.window , window.viewWithTag(kAlertViewTag) == nil {
      self.tag = kAlertViewTag
      window.addSubview(self)
    } else {
      return
    }
    
    // Apply a fade-in animation
    self.alpha     = 0.0
    self.container.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    
    UIView.animate(withDuration: 0.4,
                   delay: 0,
                   usingSpringWithDamping: 0.85,
                   initialSpringVelocity: 1,
                   options: [.curveLinear],
                   animations: {
                    
                    self.container.transform = CGAffineTransform.identity
                    self.alpha = 1.0
                    
    }, completion: nil)
  }
  
  fileprivate func dismiss(withCompletion completion: AlertAction?) {
    // Apply a fade-out animation
    UIView.animate(withDuration: 0.4,
                   delay: 0,
                   usingSpringWithDamping: 0.85,
                   initialSpringVelocity: 1,
                   options: [.curveLinear],
                   animations: {
                    
                    self.container.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    self.alpha = 0.0
    }, completion: { finished in
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(0) / Double(NSEC_PER_SEC), execute: {
        APP_DELEGATE.window?.viewWithTag(kAlertViewTag)?.removeFromSuperview()
        //                    completion?()
      })
      
      if finished {
        completion?()
      }
    })
  }
}
