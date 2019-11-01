//
//  GoogleWearAlertView.swift
//  GoogleWearAlertView
//
//  Created by Ashley Robinson on 27/06/2014.
//  Copyright (c) 2014 Ashley Robinson. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging

extension UIColor {
    class func successGreen() -> UIColor {
        return UIColor(red: 69.0/255.0, green: 181.0/255.0, blue: 38.0/255.0, alpha: 1)
    }
    class func errorRed() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 82.0/255.0, blue: 82.0/255.0, alpha: 1)
    }
    class func warningYellow() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 205.0/255.0, blue: 64.0/255.0, alpha: 1)
    }
    class func messageBlue() -> UIColor {
        return UIColor(red: 2.0/255.0, green: 169.0/255.0, blue: 244.0/255.0, alpha: 1)
    }
}

class GoogleWearAlertView: UIView, UIGestureRecognizerDelegate {
    
    //Constants
    var alertViewSize:CGFloat = 0.4 // 40% of presenting viewcontrollers width
    var imageViewSize:CGFloat = 0.4 //4 0% of AlertViews width
    var imageViewOffsetFromCentre:CGFloat = 0.25 // Offset of image along Y axis
    var titleLabelWidth:CGFloat = 0.7 // 70% of AlertViews width
    var titleLabelHeight:CGFloat = 40
    var navControllerHeight:CGFloat = 44
    
    /** The displayed title of this message */
    var title:NSString?
    
    /** The view controller this message is displayed in, only used to size the alert*/
    var viewController:UIViewController!
    
    /** The duration of the displayed message. If it is 0.0, it will automatically be calculated */
    var duration:Double?
    
    /** The position of the message (top or bottom) */
    var alertPosition:GoogleWearAlertPosition?
    
    /** Is the message currenlty fully displayed? Is set as soon as the message is really fully visible */
    var messageIsFullyDisplayed:Bool?
    
    /** If you'd like to customise the image shown with the alert */
    var iconImage:UIImage?
    
    /** Internal properties needed to resize the view on device rotation properly */
    lazy var titleLabel: UILabel = UILabel()
    lazy var iconImageView: UIImageView = UIImageView()
    
    /** Inits the notification view. Do not call this from outside this library.
     @param title The text of the notification view
     @param image A custom icon image (optional)
     @param notificationType The type (color) of the notification view
     @param duration The duration this notification should be displayed (optional)
     @param viewController the view controller this message should be displayed in
     @param position The position of the message on the screen
     @param dismissingEnabled Should this message be dismissed when the user taps it?
     */
    
    init(title:String, image:UIImage?, type:GoogleWearAlertType, duration:Double, viewController:UIViewController, position:GoogleWearAlertPosition, canbeDismissedByUser:Bool, iAction: Int, form:String) {
        super.init(frame: CGRect.zero)
        
        self.title = title as NSString
        self.iconImage = image
        self.duration = duration
        self.viewController = viewController
        self.alertPosition = position
        
        if iAction == 2{
            /*alertViewSize = 0.4 // 40% of presenting viewcontrollers width
             imageViewSize = 0.4 //4 0% of AlertViews width
             imageViewOffsetFromCentre = 0.25 // Offset of image along Y axis
             titleLabelWidth = 0.7 // 70% of AlertViews width
             titleLabelHeight = 30
             navControllerHeight = 44*/
            titleLabel.numberOfLines = 0
            titleLabel.adjustsFontSizeToFitWidth = true
        }
        
        // Setup background color and choose icon
        let imageProvided = image != nil
        switch type {
        case .error:
            backgroundColor = UIColor.errorRed()
            if !imageProvided { self.iconImage = UIImage(named: "errorIcon") }
            
        case .message:
            backgroundColor = UIColor.messageBlue()
            if !imageProvided { self.iconImage = UIImage(named: "messageIcon") }
            
        case .success:
            backgroundColor = UIColor.successGreen()
            if !imageProvided { self.iconImage = UIImage(named: "successIcon") }
            
        case .warning:
            backgroundColor = UIColor.warningYellow()
            if !imageProvided { self.iconImage = UIImage(named: "warningIcon") }
            
        }
        
        // Setup self
        //setTranslatesAutoresizingMaskIntoConstraints(false)
        frame.size = CGSize(width: viewController.view.bounds.size.width * alertViewSize, height: viewController.view.bounds.width * alertViewSize)
        layer.cornerRadius = self.frame.width/2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.8
        self.clipsToBounds = false
        var name: String = ""
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if Reachability.isConnectedToNetwork(){
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            switch form {
            case "Account Payment":
                Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                    AnalyticsParameterItemID: "id-Account Payment Successful",
                    AnalyticsParameterItemName: "Account Payment Successful",
                    AnalyticsParameterContentType: "Evento"
                    ])
                
                Analytics.setScreenName("Event Account Payment Successful", screenClass: appDelegate.gstrAppName)
                
                if appDelegate.ynIPad {
                    titleLabel.font = UIFont.systemFont(ofSize: 18)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }else{
                    titleLabel.font = UIFont.systemFont(ofSize: 10)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }
                
            case "Request Edit New":
                Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                    AnalyticsParameterItemID: "id-Request Added",
                    AnalyticsParameterItemName: "Request Added",
                    AnalyticsParameterContentType: "Evento"
                    ])
                
                Analytics.setScreenName("Event Request Added", screenClass: appDelegate.gstrAppName)
                
                if appDelegate.ynIPad {
                    titleLabel.font = UIFont.systemFont(ofSize: 18)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }else{
                    titleLabel.font = UIFont.systemFont(ofSize: 10)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }
                
            case "Stay Guest Add":
                Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                    AnalyticsParameterItemID: "id-Stay Guest Saved",
                    AnalyticsParameterItemName: "Stay Guest Saved",
                    AnalyticsParameterContentType: "Evento"
                    ])
                
                Analytics.setScreenName("Event Stay Guest Saved", screenClass: appDelegate.gstrAppName)
                
                if appDelegate.ynIPad {
                    titleLabel.font = UIFont.systemFont(ofSize: 16)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }else{
                    titleLabel.font = UIFont.systemFont(ofSize: 8)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }
                
            case "Email Request":
                Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                    AnalyticsParameterItemID: "id-Email Request Successful",
                    AnalyticsParameterItemName: "Email Request Successful",
                    AnalyticsParameterContentType: "Evento"
                    ])
                
                Analytics.setScreenName("Event Request Successful", screenClass: appDelegate.gstrAppName)
                
                if appDelegate.ynIPad {
                    titleLabel.font = UIFont.systemFont(ofSize: 16)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }else{
                    titleLabel.font = UIFont.systemFont(ofSize: 8)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }
                
            case "Check Out":
                Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                    AnalyticsParameterItemID: "id-Check Out Successful",
                    AnalyticsParameterItemName: "Check Out Successful",
                    AnalyticsParameterContentType: "Evento"
                    ])
                
                Analytics.setScreenName("Event Check Out Successful", screenClass: appDelegate.gstrAppName)
                
                if appDelegate.ynIPad {
                    titleLabel.font = UIFont.systemFont(ofSize: 13)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 70
                }else{
                    titleLabel.font = UIFont.systemFont(ofSize: 9)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }
                
            case "Login":
                Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                    AnalyticsParameterItemID: "id-Login Successful",
                    AnalyticsParameterItemName: "Login Successful",
                    AnalyticsParameterContentType: "Evento"
                    ])
                
                Analytics.setScreenName("Event Login Successful", screenClass: appDelegate.gstrAppName)
                
                if appDelegate.ynIPad {
                    titleLabel.font = UIFont.systemFont(ofSize: 18)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }else{
                    titleLabel.font = UIFont.systemFont(ofSize: 10)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }
                
            case "Restaurant Reservation":
                Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                    AnalyticsParameterItemID: "id-Restaurant Reservation Successful",
                    AnalyticsParameterItemName: "Restaurant Reservation Successful",
                    AnalyticsParameterContentType: "Evento"
                    ])
                
                Analytics.setScreenName("Event Restaurant Reservation Successful", screenClass: appDelegate.gstrAppName)
                
                if appDelegate.ynIPad {
                    titleLabel.font = UIFont.systemFont(ofSize: 18)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }else{
                    titleLabel.font = UIFont.systemFont(ofSize: 10)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }
                
            case "Restaurant Concierge":

                if appDelegate.ynIPad {
                    titleLabel.font = UIFont.systemFont(ofSize: 16)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }else{
                    titleLabel.font = UIFont.systemFont(ofSize: 9)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }
                
            case "InvalidDate":

                if appDelegate.ynIPad {
                    titleLabel.font = UIFont.systemFont(ofSize: 18)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }else{
                    titleLabel.font = UIFont.systemFont(ofSize: 12)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }
            case "Resort Credit Error":
                Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                    AnalyticsParameterItemID: "id-Resort Credit Error",
                    AnalyticsParameterItemName: "Resort Credit Error",
                    AnalyticsParameterContentType: "Evento"
                    ])
                
                Analytics.setScreenName("Event Resort Credit Error", screenClass: appDelegate.gstrAppName)
                
                if appDelegate.ynIPad {
                    titleLabel.font = UIFont.systemFont(ofSize: 16)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }else{
                    titleLabel.font = UIFont.systemFont(ofSize: 10)
                    titleLabel.numberOfLines = 0
                    titleLabelWidth = 0.8
                    titleLabelHeight = 60
                }
            default:
                name = ""
                
            }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
        // Setup Image View
        iconImageView.image = iconImage
        iconImageView.frame = CGRect(x: 0, y: 0, width: frame.size.width * imageViewSize, height: frame.size.width * imageViewSize)
        iconImageView.center = center
        iconImageView.center.y -= (iconImageView.frame.size.height * imageViewOffsetFromCentre) * 1.5
        self.addSubview(iconImageView)
        
        // Setup Text Label
        titleLabel.text = title
        titleLabel.frame = CGRect(x: self.center.x - (frame.size.width * titleLabelWidth) / 2, y: (iconImageView.frame.origin.y + iconImageView.frame.size.height - 5), width: frame.size.width * titleLabelWidth, height: titleLabelHeight * 1.2)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = NSTextAlignment.center
        
        self.addSubview(titleLabel)
        
        //Position the alert
        positionAlertForPosition(position)
        
        if canbeDismissedByUser {
            let tagGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(GoogleWearAlertView.dismissAlert))
            self.addGestureRecognizer(tagGestureRecognizer)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        NSException(name: NSExceptionName(rawValue: "init from storyboard error"), reason: "alert cannot be initalized from a storybaord", userInfo: nil).raise()
    }
    
    @objc func dismissAlert() {
        GoogleWearAlert.sharedInstance.removeCurrentAlert(self)
    }
    
    func insideNavController() -> Bool {
        
        if let vc = viewController {
            if vc.parent is UINavigationController {
                return true
            } else if vc is UINavigationController {
                return true
            }
        }
        return false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection!) {
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let position = alertPosition {
            positionAlertForPosition(position)
        }
    }
    
    func positionAlertForPosition(_ position:GoogleWearAlertPosition) {
        
        if UIApplication.shared.statusBarOrientation.isLandscape {
            
            let centerX = viewController.view.bounds.width/2
            let centerY = viewController.view.bounds.height/2
            center = CGPoint(x: centerX, y: centerY)
            
        } else {
            
            switch position {
            case .top:
                center = CGPoint(x: viewController.view.center.x, y: viewController.view.frame.size.height / 4)
                if insideNavController() { center.y += navControllerHeight }
                
            case .center:
                center = viewController.view.center
                
            case .bottom:
                center = CGPoint(x: viewController.view.center.x, y: viewController.view.frame.size.height * 0.75)
                
            }
        }
    }
    
}
