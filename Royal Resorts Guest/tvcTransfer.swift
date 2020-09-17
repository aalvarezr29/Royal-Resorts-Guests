//
//  tvcTransfer.swift
//  Royal Resorts Guest
//
//  Created by Soluciones on 10/25/19.
//  Copyright © 2019 Marco Cocom. All rights reserved.
//

import UIKit

open class tvcTransfer: UITableViewCell {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    public var lblConfirmationCode = UILabel()
    public var lblArrivalDate = UILabel()
    public var img = UIImageView()
    public var lblStatus = UILabel()
    
    public func SetValues(_ ConfirmationCode: String?, ArrivalDate: String?, width: CGFloat?, height: CGFloat?) {
        
        //lblStatus.textColor = colorWithHexString("929292")
        //img.image = UIImage(named:"ic_uncheck.png")!
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            lblStatus.textColor = colorWithHexString("929292")
            img.image = UIImage(named:"ic_uncheck.png")!
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            lblConfirmationCode.textColor = colorWithHexString("ba8748")
            lblArrivalDate.textColor = colorWithHexString("ba8748")
            lblStatus.textColor = colorWithHexString("ba8748")
            
            img.image = UIImage(named:"ic_uncheck.png")!
            
            img.image = img.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            img.tintColor = colorWithHexString("e4c29c")
            
        }
        
        lblConfirmationCode.font = UIFont(name: "Helvetica", size: appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        lblArrivalDate.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblConfirmationCode.textAlignment = NSTextAlignment.left
        lblArrivalDate.textAlignment = NSTextAlignment.left
        lblConfirmationCode.adjustsFontSizeToFitWidth = true
        lblArrivalDate.adjustsFontSizeToFitWidth = true
        lblConfirmationCode.text = ConfirmationCode
        lblArrivalDate.text = ArrivalDate

        lblConfirmationCode.frame = CGRect(x: 0.2*width!, y: 0.001*height!, width: 0.6*width!, height: 0.025*height!);
        lblArrivalDate.frame = CGRect(x: 0.2*width!, y: 0.03*height!, width: 0.3*width!, height: 0.025*height!);
        
        img.frame = CGRect(x: 0.05*width!, y: 0.014*height!, width: img.image!.size.width, height: img.image!.size.height);
        
        self.addSubview(lblConfirmationCode)
        self.addSubview(lblArrivalDate)
        self.addSubview(img)
        
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

