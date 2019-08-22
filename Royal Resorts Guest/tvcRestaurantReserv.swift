//
//  tvcRestaurantReserv.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 23/03/17.
//  Copyright © 2017 Marco Cocom. All rights reserved.
//

import UIKit

open class tvcRestaurantReserv: UITableViewCell {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var lblConfirmacionNumber: UILabel!
    @IBOutlet weak var lblDescReserv: UILabel!
    
    open func SetValues(_ RestaurantName: String?, ConfirmacionNumber: String?, DescReserv: String?, width: CGFloat?, height: CGFloat?) {
        
        var Color = UIColor()
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            Color = colorWithHexString("000000")
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            Color = colorWithHexString("ba8748")
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            Color = colorWithHexString("ba8748")
        }
        
        lblRestaurantName.font = UIFont(name: "Helvetica", size: appDelegate.gblFont3 + appDelegate.gblDeviceFont3)
        lblRestaurantName.textAlignment = NSTextAlignment.left
        lblRestaurantName.adjustsFontSizeToFitWidth = true
        lblRestaurantName.text = RestaurantName
        lblRestaurantName.frame = CGRect(x: 0.05*width!, y: 0.0001*height!, width: 0.4*width!, height: 0.03*height!);
        lblRestaurantName.textColor = Color
        
        lblConfirmacionNumber.font = UIFont(name: "Helvetica-Bold", size: appDelegate.gblFont3 + appDelegate.gblDeviceFont3)
        lblConfirmacionNumber.textAlignment = NSTextAlignment.right
        lblConfirmacionNumber.adjustsFontSizeToFitWidth = true
        lblConfirmacionNumber.text = NSLocalizedString("lblRestConfirmationNumber",comment:"") + " " + ConfirmacionNumber!
        lblConfirmacionNumber.frame = CGRect(x: 0.5*width!, y: 0.0001*height!, width: 0.3*width!, height: 0.03*height!);
        lblConfirmacionNumber.textColor = Color
        
        lblDescReserv.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblDescReserv.textAlignment = NSTextAlignment.left
        lblDescReserv.adjustsFontSizeToFitWidth = true
        lblDescReserv.text = DescReserv!
        lblDescReserv.frame = CGRect(x: 0.05*width!, y: 0.015*height!, width: 0.7*width!, height: 0.06*height!);
        lblDescReserv.textColor = Color
        lblDescReserv.numberOfLines = 0
        
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
