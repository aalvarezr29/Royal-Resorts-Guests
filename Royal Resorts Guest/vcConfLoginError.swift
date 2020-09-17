//
//  vcConfLoginError.swift
//  Royal Resorts Guest
//
//  Created by Soluciones on 7/8/20.
//  Copyright © 2020 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging

class vcConfLoginError: UIViewController {
    
    @IBOutlet var ViewItem: UINavigationItem!
    
    var lblErrorConf = UILabel()
    var lblErrorConf1 = UILabel()
    var lblErrorConf2 = UILabel()
    var lblErrorConf3 = UILabel()
    var lblErrorConf4 = UILabel()
    var lblErrorConf5 = UILabel()
    var lblErrorConf6 = UILabel()
    var lblErrorConf7 = UILabel()
    var lblErrorConf8 = UILabel()
    var lblErrorConf9 = UILabel()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        ViewItem.title = NSLocalizedString("lblInvalidLogIn",comment:"");
        
        lblErrorConf = UILabel(frame: CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.08*height));
        lblErrorConf1 = UILabel(frame: CGRect(x: 0.05*width, y: 0.18*height, width: 0.9*width, height: 0.07*height));
        lblErrorConf2 = UILabel(frame: CGRect(x: 0.05*width, y: 0.25*height, width: 0.9*width, height: 0.05*height));
        lblErrorConf3 = UILabel(frame: CGRect(x: 0.1*width, y: 0.3*height, width: 0.8*width, height: 0.07*height));
        lblErrorConf4 = UILabel(frame: CGRect(x: 0.1*width, y: 0.355*height, width: 0.8*width, height: 0.07*height));
        lblErrorConf5 = UILabel(frame: CGRect(x: 0.1*width, y: 0.42*height, width: 0.8*width, height: 0.12*height));
        lblErrorConf6 = UILabel(frame: CGRect(x: 0.1*width, y: 0.54*height, width: 0.8*width, height: 0.12*height));
        lblErrorConf7 = UILabel(frame: CGRect(x: 0.05*width, y: 0.66*height, width: 0.9*width, height: 0.07*height));
        lblErrorConf8 = UILabel(frame: CGRect(x: 0.1*width, y: 0.7*height, width: 0.8*width, height: 0.1*height));
        lblErrorConf9 = UILabel(frame: CGRect(x: 0.1*width, y: 0.78*height, width: 0.8*width, height: 0.12*height));
        
        lblErrorConf.backgroundColor = UIColor.clear
        lblErrorConf.textAlignment = NSTextAlignment.left;
        lblErrorConf.textColor = colorWithHexString("004c50")
        lblErrorConf.numberOfLines = 0;
        lblErrorConf.font = UIFont(name: "Verdana", size: appDelegate.gblFont10 + appDelegate.gblDeviceFont3)
        lblErrorConf.text = NSLocalizedString("lblErrorConf",comment:"");
        
        lblErrorConf1.backgroundColor = UIColor.clear
        lblErrorConf1.textAlignment = NSTextAlignment.left;
        lblErrorConf1.textColor = colorWithHexString("004c50")
        lblErrorConf1.numberOfLines = 0;
        lblErrorConf1.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
        lblErrorConf1.text = NSLocalizedString("lblErrorConf1",comment:"");
        
        lblErrorConf2.backgroundColor = UIColor.clear
        lblErrorConf2.textAlignment = NSTextAlignment.left;
        lblErrorConf2.textColor = colorWithHexString("004c50")
        lblErrorConf2.numberOfLines = 0;
        lblErrorConf2.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
        lblErrorConf2.text = NSLocalizedString("lblErrorConf2",comment:"");
        
        lblErrorConf3.backgroundColor = UIColor.clear
        lblErrorConf3.textAlignment = NSTextAlignment.left;
        lblErrorConf3.textColor = colorWithHexString("004c50")
        lblErrorConf3.numberOfLines = 0;
        lblErrorConf3.font = UIFont(name: "Verdana", size: appDelegate.gblFont7 + appDelegate.gblDeviceFont3)
        lblErrorConf3.text = "*" + NSLocalizedString("lblErrorConf3",comment:"");
        
        lblErrorConf4.backgroundColor = UIColor.clear
        lblErrorConf4.textAlignment = NSTextAlignment.left;
        lblErrorConf4.textColor = colorWithHexString("004c50")
        lblErrorConf4.numberOfLines = 0;
        lblErrorConf4.font = UIFont(name: "Verdana", size: appDelegate.gblFont7 + appDelegate.gblDeviceFont3)
        lblErrorConf4.text = "*" + NSLocalizedString("lblErrorConf4",comment:"");
        
        lblErrorConf5.backgroundColor = UIColor.clear
        lblErrorConf5.textAlignment = NSTextAlignment.left;
        lblErrorConf5.textColor = colorWithHexString("004c50")
        lblErrorConf5.numberOfLines = 0;
        lblErrorConf5.font = UIFont(name: "Verdana", size: appDelegate.gblFont7 + appDelegate.gblDeviceFont3)
        lblErrorConf5.text = "*" + NSLocalizedString("lblErrorConf5",comment:"");
        
        lblErrorConf6.backgroundColor = UIColor.clear
        lblErrorConf6.textAlignment = NSTextAlignment.left;
        lblErrorConf6.textColor = colorWithHexString("004c50")
        lblErrorConf6.numberOfLines = 0;
        lblErrorConf6.font = UIFont(name: "Verdana", size: appDelegate.gblFont7 + appDelegate.gblDeviceFont3)
        lblErrorConf6.text = "*" + NSLocalizedString("lblErrorConf6",comment:"");
        
        lblErrorConf7.backgroundColor = UIColor.clear
        lblErrorConf7.textAlignment = NSTextAlignment.left;
        lblErrorConf7.textColor = colorWithHexString("004c50")
        lblErrorConf7.numberOfLines = 0;
        lblErrorConf7.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
        lblErrorConf7.text = NSLocalizedString("lblErrorConf7",comment:"");
        
        lblErrorConf8.backgroundColor = UIColor.clear
        lblErrorConf8.textAlignment = NSTextAlignment.left;
        lblErrorConf8.textColor = colorWithHexString("004c50")
        lblErrorConf8.numberOfLines = 0;
        lblErrorConf8.font = UIFont(name: "Verdana", size: appDelegate.gblFont7 + appDelegate.gblDeviceFont3)
        lblErrorConf8.text = "*" + NSLocalizedString("lblErrorConf8",comment:"");
        
        lblErrorConf9.backgroundColor = UIColor.clear
        lblErrorConf9.textAlignment = NSTextAlignment.left;
        lblErrorConf9.textColor = colorWithHexString("004c50")
        lblErrorConf9.numberOfLines = 0;
        lblErrorConf9.font = UIFont(name: "Verdana", size: appDelegate.gblFont7 + appDelegate.gblDeviceFont3)
        lblErrorConf9.text = "*" + NSLocalizedString("lblErrorConf9",comment:"");
        
        self.view.addSubview(lblErrorConf)
        self.view.addSubview(lblErrorConf1)
        self.view.addSubview(lblErrorConf2)
        self.view.addSubview(lblErrorConf3)
        self.view.addSubview(lblErrorConf4)
        self.view.addSubview(lblErrorConf5)
        self.view.addSubview(lblErrorConf6)
        self.view.addSubview(lblErrorConf7)
        self.view.addSubview(lblErrorConf8)
        self.view.addSubview(lblErrorConf9)

        
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
