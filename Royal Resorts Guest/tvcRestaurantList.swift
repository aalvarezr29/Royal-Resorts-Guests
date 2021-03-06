//
//  tvcRestaurantList.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 9/03/17.
//  Copyright © 2017 Marco Cocom. All rights reserved.
//

import UIKit

open class tvcRestaurantList: UITableViewCell {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var lblRestaurantName: UILabel!

    open func SetValues(_ RestaurantName: String?, width: CGFloat?, height: CGFloat?, cellh: CGFloat?) {

        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            lblRestaurantName.frame = CGRect(x: width!/2.9, y: cellh!/2.6, width: 0.6*width!, height: 0.06*height!);
            lblRestaurantName.font = UIFont(name: "Cochin-BoldItalic", size: appDelegate.gblFont10 + appDelegate.gblDeviceFont3)
            lblRestaurantName.textColor = colorWithHexString("0D94FC")
            lblRestaurantName.textAlignment = NSTextAlignment.left
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            lblRestaurantName.frame = CGRect(x: width!/2.9, y: cellh!/2.6, width: 0.6*width!, height: 0.06*height!);
            lblRestaurantName.font = UIFont(name: "Cochin-BoldItalic", size: appDelegate.gblFont10 + appDelegate.gblDeviceFont3)
            lblRestaurantName.textColor = colorWithHexString("CB983E")
            lblRestaurantName.textAlignment = NSTextAlignment.left
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{

        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
            lblRestaurantName.frame = CGRect(x: 0, y: cellh!/2.6, width: width!, height: 0.06*height!);
            lblRestaurantName.font = UIFont(name: "HelveticaNeue-Bold", size: appDelegate.gblFont10 + appDelegate.gblDeviceFont3)
            lblRestaurantName.adjustsFontSizeToFitWidth = true
            lblRestaurantName.textColor = colorWithHexString("ffffff")
            lblRestaurantName.textAlignment = NSTextAlignment.center
        }

        //lblRestaurantName.textAlignment = NSTextAlignment.left
        //lblRestaurantName.adjustsFontSizeToFitWidth = true
        lblRestaurantName.text = RestaurantName
        
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

