//
//  tvcNotifications.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 24/04/18.
//  Copyright © 2018 Marco Cocom. All rights reserved.
//

import UIKit

open class tvcNotifications: UITableViewCell {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var img: UIImageView!
    open func SetValues(_ Title: String?, Message: String?, Hour: String?, Viewed: String?, width: CGFloat?, height: CGFloat?) {
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            if Viewed == "0"
            {
                lblMessage.textColor = UIColor.black
                lblHour.textColor = UIColor.black
                lblTitle.textColor = UIColor.black
                img.image = UIImage(named:"mail.png")!
                img.image = img.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                img.tintColor = UIColor.black
            }else{
                lblMessage.textColor = colorWithHexString("929292")
                lblHour.textColor = colorWithHexString("929292")
                lblTitle.textColor = colorWithHexString("929292")
                img.image = UIImage(named:"mail.png")!
                img.image = img.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                img.tintColor = colorWithHexString("929292")
            }
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{

            if Viewed == "0"
            {
                lblMessage.textColor = colorWithHexString("ba8748")
                lblHour.textColor = colorWithHexString("ba8748")
                lblTitle.textColor = colorWithHexString("ba8748")
                img.image = UIImage(named:"mail.png")!
                img.image = img.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                img.tintColor = colorWithHexString("e4c29c")
            }else{
                lblMessage.textColor = colorWithHexString("929292")
                lblHour.textColor = colorWithHexString("929292")
                lblTitle.textColor = colorWithHexString("929292")
                img.image = UIImage(named:"mail.png")!
                img.image = img.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                img.tintColor = colorWithHexString("929292")
            }
            
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            if Viewed == "0"
            {
                lblMessage.textColor = colorWithHexString("00467f")
                lblHour.textColor = colorWithHexString("00467f")
                lblTitle.textColor = colorWithHexString("00467f")
                img.image = UIImage(named:"mail.png")!
                img.image = img.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                img.tintColor = colorWithHexString("00467f")
            }else{
                lblMessage.textColor = colorWithHexString("929292")
                lblHour.textColor = colorWithHexString("929292")
                lblTitle.textColor = colorWithHexString("929292")
                img.image = UIImage(named:"mail.png")!
                img.image = img.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                img.tintColor = colorWithHexString("929292")
            }
            
        }
        
        lblTitle.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblMessage.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblHour.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)

        lblTitle.textAlignment = NSTextAlignment.left
        lblMessage.textAlignment = NSTextAlignment.left
        lblHour.textAlignment = NSTextAlignment.left
        
        lblTitle.adjustsFontSizeToFitWidth = true
        lblMessage.adjustsFontSizeToFitWidth = true

        lblTitle.text = Title
        
        lblMessage.text = Message
        lblHour.text = Hour

        lblTitle.frame = CGRect(x: 0.1*width!, y: 0, width: 0.4*width!, height: 0.025*height!);
        lblMessage.frame = CGRect(x: 0.04*width!, y: 0.04*height!, width: 0.7*width!, height: 0.025*height!);
        lblHour.frame = CGRect(x: 0.75*width!, y: 0, width: 0.1*width!, height: 0.025*height!);
        
        img.frame = CGRect(x: 0.04*width!, y: 0, width: img.bounds.width, height: img.bounds.height);
        
    }
    
    func colorWithHexString (_ hexString:String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
}
