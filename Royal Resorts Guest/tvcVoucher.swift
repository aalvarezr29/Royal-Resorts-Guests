//
//  tvcVoucher.swift
//  Royal Resorts Guest
//
//  Created by Alan Alvarez on 17/02/15.
//  Copyright (c) 2015 Marco Cocom. All rights reserved.
//

import UIKit

open class tvcVoucher: UITableViewCell {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var lblVoucher: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    open func SetValues(Voucher: String?, Place: String?, Amount: String?, width: CGFloat?, height: CGFloat?) {
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{

            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            lblVoucher.textColor = colorWithHexString("ba8748")
            lblPlace.textColor = colorWithHexString("ba8748")
            lblAmount.textColor = colorWithHexString("ba8748")
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            lblVoucher.textColor = colorWithHexString("00467f")
            lblPlace.textColor = colorWithHexString("00467f")
            lblAmount.textColor = colorWithHexString("00467f")
            
        }
        
        lblVoucher.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblPlace.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblAmount.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblVoucher.textAlignment = NSTextAlignment.left
        lblVoucher.adjustsFontSizeToFitWidth = true
        lblPlace.adjustsFontSizeToFitWidth = true
        lblAmount.adjustsFontSizeToFitWidth = true
        lblAmount.textAlignment = NSTextAlignment.right
        lblVoucher.text = Voucher
        lblPlace.text = Place
        lblAmount.text = Amount
        lblVoucher.frame = CGRect(x: 0.05*width!, y: 0, width: 0.2*width!, height: 0.036*height!);
        lblPlace.frame = CGRect(x: 0.25*width!, y: 0, width: 0.36*width!, height: 0.036*height!);
        lblAmount.frame = CGRect(x: 0.62*width!, y: 0, width: 0.2*width!, height: 0.036*height!);
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

