//
//  tvcFollowUpDetail.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 22/01/16.
//  Copyright © 2016 Marco Cocom. All rights reserved.
//

import UIKit

open class tvcFollowUpDetail: UITableViewCell {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    var rowHeight: CGFloat!
    
    open func SetValues(_ Name: String?, Date: String?, Desc: String?, width: CGFloat?, height: CGFloat?, select: Bool?, blnRes: Bool?) -> CGFloat {
        
        lblDesc.frame = CGRect(x: 0.05*width!, y: 0.025*height!, width: 0.8*width!, height: 0.025*height!);
        
        lblName.textAlignment = NSTextAlignment.left
        lblName.adjustsFontSizeToFitWidth = true
        lblDate.adjustsFontSizeToFitWidth = true
        lblDesc.textAlignment = NSTextAlignment.left
        lblDate.textAlignment = NSTextAlignment.right
        lblDesc.text = Desc
        
        if select == true{
            lblDesc.numberOfLines = 0
            lblDesc.sizeToFit()
        }else{
            lblDesc.numberOfLines = 1
        }
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            lblName.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
            lblDate.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
            lblDesc.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
            
            if (blnRes == true) {
                lblName.text = Date
                lblName.textColor = UIColor.lightGray
                lblDate.text = Name
                lblDate.textColor = UIColor.black
                lblName.frame = CGRect(x: 0.05*width!, y: 0.001*height!, width: 0.4*width!, height: 0.025*height!);
                lblDate.frame = CGRect(x: 0.2*width!, y: 0.001*height!, width: 0.6*width!, height: 0.025*height!);
                lblDate.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont2 + appDelegate.gblDeviceFont3);
            }else{
                lblName.text = Name
                lblName.textColor = UIColor.black
                lblDate.text = Date
                lblDate.textColor = UIColor.lightGray
                lblName.frame = CGRect(x: 0.05*width!, y: 0.001*height!, width: 0.6*width!, height: 0.025*height!);
                lblDate.frame = CGRect(x: 0.4*width!, y: 0.001*height!, width: 0.4*width!, height: 0.025*height!);
                lblName.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont2 + appDelegate.gblDeviceFont3);
            }
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            lblName.textColor = colorWithHexString("ba8748")
            lblDate.textColor = colorWithHexString("ba8748")
            lblDesc.textColor = colorWithHexString("ba8748")
            
            
            lblName.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
            lblDate.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
            lblDesc.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
            
            if (blnRes == true) {
                lblName.text = Date
                lblName.textColor = colorWithHexString("ba8748")
                lblDate.text = Name
                lblDate.textColor = colorWithHexString("ba8748")
                lblName.frame = CGRect(x: 0.05*width!, y: 0.001*height!, width: 0.4*width!, height: 0.025*height!);
                lblDate.frame = CGRect(x: 0.2*width!, y: 0.001*height!, width: 0.6*width!, height: 0.025*height!);
                lblDate.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont2 + appDelegate.gblDeviceFont3);
            }else{
                lblName.text = Name
                lblName.textColor = colorWithHexString("ba8748")
                lblDate.text = Date
                lblDate.textColor = colorWithHexString("ba8748")
                lblName.frame = CGRect(x: 0.05*width!, y: 0.001*height!, width: 0.6*width!, height: 0.025*height!);
                lblDate.frame = CGRect(x: 0.4*width!, y: 0.001*height!, width: 0.4*width!, height: 0.025*height!);
                lblName.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont2 + appDelegate.gblDeviceFont3);
            }
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            lblName.textColor = colorWithHexString("00467f")
            lblDate.textColor = colorWithHexString("00467f")
            lblDesc.textColor = colorWithHexString("00467f")
            

            lblName.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
            lblDate.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
            lblDesc.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
            
            if (blnRes == true) {
                lblName.text = Date
                lblName.textColor = colorWithHexString("00467f")
                lblDate.text = Name
                lblDate.textColor = colorWithHexString("00467f")
                lblName.frame = CGRect(x: 0.05*width!, y: 0.001*height!, width: 0.4*width!, height: 0.025*height!);
                lblDate.frame = CGRect(x: 0.2*width!, y: 0.001*height!, width: 0.6*width!, height: 0.025*height!);
                lblDate.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont2 + appDelegate.gblDeviceFont3);
            }else{
                lblName.text = Name
                lblName.textColor = colorWithHexString("00467f")
                lblDate.text = Date
                lblDate.textColor = colorWithHexString("00467f")
                lblName.frame = CGRect(x: 0.05*width!, y: 0.001*height!, width: 0.6*width!, height: 0.025*height!);
                lblDate.frame = CGRect(x: 0.4*width!, y: 0.001*height!, width: 0.4*width!, height: 0.025*height!);
                lblName.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont2 + appDelegate.gblDeviceFont3);
            }
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
            
            lblName.textColor = colorWithHexString("2e3634")
            lblDate.textColor = colorWithHexString("2e3634")
            lblDesc.textColor = colorWithHexString("2e3634")
            

            lblName.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
            lblDate.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
            lblDesc.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
            
            if (blnRes == true) {
                lblName.text = Date
                lblName.textColor = colorWithHexString("2e3634")
                lblDate.text = Name
                lblDate.textColor = colorWithHexString("2e3634")
                lblName.frame = CGRect(x: 0.05*width!, y: 0.001*height!, width: 0.4*width!, height: 0.025*height!);
                lblDate.frame = CGRect(x: 0.2*width!, y: 0.001*height!, width: 0.6*width!, height: 0.025*height!);
                lblDate.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont2 + appDelegate.gblDeviceFont3);
            }else{
                lblName.text = Name
                lblName.textColor = colorWithHexString("2e3634")
                lblDate.text = Date
                lblDate.textColor = colorWithHexString("2e3634")
                lblName.frame = CGRect(x: 0.05*width!, y: 0.001*height!, width: 0.6*width!, height: 0.025*height!);
                lblDate.frame = CGRect(x: 0.4*width!, y: 0.001*height!, width: 0.4*width!, height: 0.025*height!);
                lblName.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont2 + appDelegate.gblDeviceFont3);
            }
            
        }

        return lblDesc.frame.size.height

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
