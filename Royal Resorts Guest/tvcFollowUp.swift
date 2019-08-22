//
//  tvcFollowUp.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 21/01/16.
//  Copyright © 2016 Marco Cocom. All rights reserved.
//

import UIKit

open class tvcFollowUp: UITableViewCell {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var lblComent: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblAccCode: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var img: UIImageView!
    open func SetValues(_ Coment: String?, Status: String?, AccCode: String?, Date: String?, width: CGFloat?, height: CGFloat?) {
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            if Status != "Completed"
            {
                lblStatus.textColor = colorWithHexString("929292")
                img.image = UIImage(named:"ic_uncheck.png")!
            }else{
                lblStatus.textColor = colorWithHexString("129C21")
                img.image = UIImage(named:"ic_check.png")!
            }
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            lblComent.textColor = colorWithHexString("ba8748")
            lblAccCode.textColor = colorWithHexString("ba8748")
            lblDate.textColor = colorWithHexString("ba8748")
            
            if Status != "Completed"
            {
                lblStatus.textColor = colorWithHexString("929292")
                img.image = UIImage(named:"ic_uncheck.png")!
            }else{
                lblStatus.textColor = colorWithHexString("129C21")
                img.image = UIImage(named:"ic_check.png")!
            }
            
            img.image = img.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            img.tintColor = colorWithHexString("e4c29c")
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            lblComent.textColor = colorWithHexString("00467f")
            lblAccCode.textColor = colorWithHexString("00467f")
            lblDate.textColor = colorWithHexString("00467f")

            if Status != "Completed"
            {
                lblStatus.textColor = colorWithHexString("929292")
                img.image = UIImage(named:"ic_uncheck.png")!
            }else{
                lblStatus.textColor = colorWithHexString("129C21")
                img.image = UIImage(named:"ic_check.png")!
            }
            
            img.image = img.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            img.tintColor = colorWithHexString("00467f")
            
        }
        
        lblComent.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblStatus.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblAccCode.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblDate.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblComent.textAlignment = NSTextAlignment.left
        lblStatus.textAlignment = NSTextAlignment.left
        lblAccCode.textAlignment = NSTextAlignment.left
        lblComent.adjustsFontSizeToFitWidth = true
        lblStatus.adjustsFontSizeToFitWidth = true
        lblAccCode.adjustsFontSizeToFitWidth = true
        lblComent.text = Coment
        lblStatus.text = Status

        lblAccCode.text = AccCode
        lblDate.text = Date
        lblComent.frame = CGRect(x: 0.2*width!, y: 0.001*height!, width: 0.6*width!, height: 0.025*height!);
        lblStatus.frame = CGRect(x: 0.2*width!, y: 0.021*height!, width: 0.3*width!, height: 0.025*height!);
        lblAccCode.frame = CGRect(x: 0.6*width!, y: 0.021*height!, width: 0.3*width!, height: 0.025*height!);
        lblDate.frame = CGRect(x: 0.2*width!, y: 0.041*height!, width: 0.3*width!, height: 0.025*height!);

        img.frame = CGRect(x: 0.05*width!, y: 0.014*height!, width: img.image!.size.width, height: img.image!.size.height);
        
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
