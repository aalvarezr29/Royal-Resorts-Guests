//
//  tvcVoucherDetail.swift
//  Royal Resorts Guest
//
//  Created by Alan Alvarez on 24/02/15.
//  Copyright (c) 2015 Marco Cocom. All rights reserved.
//


import UIKit

open class tvcVoucherDetail: UITableViewCell {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var lblItemCode: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    open func SetValues(ItemCode: String?, Quantity: String?, Desc: String?, Total: String? , width: CGFloat?, height: CGFloat?) {
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            lblItemCode.frame = CGRect(x: 0.01*width!, y: 0, width: 0.15*width!, height: 0.036*height!);
            lblQuantity.frame = CGRect(x: 0.18*width!, y: 0, width: 0.1*width!, height: 0.036*height!);
            lblDesc.frame = CGRect(x: 0.3*width!, y: 0, width: 0.45*width!, height: 0.036*height!);
            lblTotal.frame = CGRect(x: 0.75*width!, y: 0, width: 0.1*width!, height: 0.036*height!);
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            lblItemCode.frame = CGRect(x: 0.03*width!, y: 0, width: 0.15*width!, height: 0.036*height!);
            lblQuantity.frame = CGRect(x: 0.2*width!, y: 0, width: 0.1*width!, height: 0.036*height!);
            lblDesc.frame = CGRect(x: 0.32*width!, y: 0, width: 0.45*width!, height: 0.036*height!);
            lblTotal.frame = CGRect(x: 0.77*width!, y: 0, width: 0.1*width!, height: 0.036*height!);
            lblItemCode.textColor = colorWithHexString("ba8748")
            lblQuantity.textColor = colorWithHexString("ba8748")
            lblDesc.textColor = colorWithHexString("ba8748")
            lblTotal.textColor = colorWithHexString("ba8748")
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            lblItemCode.frame = CGRect(x: 0.03*width!, y: 0, width: 0.15*width!, height: 0.036*height!);
            lblQuantity.frame = CGRect(x: 0.2*width!, y: 0, width: 0.1*width!, height: 0.036*height!);
            lblDesc.frame = CGRect(x: 0.32*width!, y: 0, width: 0.45*width!, height: 0.036*height!);
            lblTotal.frame = CGRect(x: 0.77*width!, y: 0, width: 0.1*width!, height: 0.036*height!);
            
        }
        
        lblItemCode.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblQuantity.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblDesc.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblTotal.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblItemCode.textAlignment = NSTextAlignment.left
        lblItemCode.adjustsFontSizeToFitWidth = true
        lblQuantity.adjustsFontSizeToFitWidth = true
        lblDesc.adjustsFontSizeToFitWidth = true
        lblTotal.adjustsFontSizeToFitWidth = true
        lblTotal.textAlignment = NSTextAlignment.right
        lblItemCode.text = ItemCode
        lblQuantity.text = Quantity
        lblDesc.text = Desc
        lblTotal.text = Total
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

