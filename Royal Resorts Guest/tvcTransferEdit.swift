//
//  tvcTransferEdit.swift
//  Royal Resorts Guest
//
//  Created by Soluciones on 12/5/19.
//  Copyright © 2019 Marco Cocom. All rights reserved.
//

import Foundation

open class tvcTransferEdit: UITableViewCell {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var lblLabel = UILabel()
    var txtTextField = UITextField()

    public func SetValues(_ Index: String?, btnSave: UIButton, btnCancel: UIButton, txtpax: UITextField, width: CGFloat?, height: CGFloat?) {
        
        var strArrivalDate: String = ""
        var strDeparturedate: String = ""
        let strdateFormatter = DateFormatter()
        strdateFormatter.dateFormat = "MM/dd/yyyy";

        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
 
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
        }
        
        if Index == "0"{
            
            lblLabel.frame = CGRect(x: 0.01*width!, y: 0.02*height!, width: 0.3*width!, height: 0.025*height!);
            lblLabel.backgroundColor = UIColor.clear
            lblLabel.textAlignment = NSTextAlignment.left
            lblLabel.textColor = colorWithHexString("000000")
            lblLabel.numberOfLines = 0;
            lblLabel.adjustsFontSizeToFitWidth = true
            lblLabel.font = UIFont(name: "Helvetica", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblLabel.text = NSLocalizedString("lblReservation",comment:"");
            
            txtTextField.frame = CGRect(x: 0.32*width!, y: 0.02*height!, width: 0.4*width!, height: 0.04*height!);
            txtTextField.backgroundColor = UIColor.clear;
            txtTextField.textAlignment = NSTextAlignment.right;
            txtTextField.textColor = colorWithHexString("000000")
            txtTextField.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtTextField.layer.borderColor = UIColor.black.cgColor
            txtTextField.borderStyle = UITextField.BorderStyle.roundedRect
            txtTextField.keyboardType = UIKeyboardType.numberPad
            txtTextField.text = self.appDelegate.gstrConfirmationCodeTransferAux;
            txtTextField.isEnabled = false
            
            self.addSubview(lblLabel)
            self.addSubview(txtTextField)
            
        } else if Index == "1"{
            
            lblLabel.frame = CGRect(x: 0.01*width!, y: 0.02*height!, width: 0.3*width!, height: 0.025*height!);
            lblLabel.backgroundColor = UIColor.clear
            lblLabel.textAlignment = NSTextAlignment.left
            lblLabel.textColor = colorWithHexString("000000")
            lblLabel.numberOfLines = 0;
            lblLabel.adjustsFontSizeToFitWidth = true
            lblLabel.font = UIFont(name: "Helvetica", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblLabel.text = NSLocalizedString("lblArrivalHotel",comment:"")
            
            txtTextField.frame = CGRect(x: 0.32*width!, y: 0.02*height!, width: 0.4*width!, height: 0.04*height!);
            txtTextField.backgroundColor = UIColor.clear;
            txtTextField.textAlignment = NSTextAlignment.right;
            txtTextField.textColor = colorWithHexString("000000")
            txtTextField.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtTextField.layer.borderColor = UIColor.black.cgColor
            txtTextField.borderStyle = UITextField.BorderStyle.roundedRect
            txtTextField.keyboardType = UIKeyboardType.numberPad
            txtTextField.text = self.appDelegate.gstrHotelNameAux;
            txtTextField.isEnabled = false
            
            self.addSubview(lblLabel)
            self.addSubview(txtTextField)
            
        } else if Index == "2"{
            
            lblLabel.frame = CGRect(x: 0.01*width!, y: 0.02*height!, width: 0.3*width!, height: 0.025*height!);
            lblLabel.backgroundColor = UIColor.clear
            lblLabel.textAlignment = NSTextAlignment.left
            lblLabel.textColor = colorWithHexString("000000")
            lblLabel.numberOfLines = 0;
            lblLabel.adjustsFontSizeToFitWidth = true
            lblLabel.font = UIFont(name: "Helvetica", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblLabel.text = NSLocalizedString("lblArrivalDate",comment:"");
            
            let ArrivalDate = moment(self.appDelegate.gstrArrivalTransferAux)
            strArrivalDate = strdateFormatter.string(from: ArrivalDate!.date)
            
            txtTextField.frame = CGRect(x: 0.32*width!, y: 0.02*height!, width: 0.4*width!, height: 0.04*height!);
            txtTextField.backgroundColor = UIColor.clear;
            txtTextField.textAlignment = NSTextAlignment.right;
            txtTextField.textColor = colorWithHexString("000000")
            txtTextField.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtTextField.layer.borderColor = UIColor.black.cgColor
            txtTextField.borderStyle = UITextField.BorderStyle.roundedRect
            txtTextField.keyboardType = UIKeyboardType.numberPad
            txtTextField.text = strArrivalDate;
            txtTextField.isEnabled = false
            
            self.addSubview(lblLabel)
            self.addSubview(txtTextField)
            
        } else if Index == "3"{
            
            lblLabel.frame = CGRect(x: 0.01*width!, y: 0.02*height!, width: 0.3*width!, height: 0.025*height!);
            lblLabel.backgroundColor = UIColor.clear
            lblLabel.textAlignment = NSTextAlignment.left
            lblLabel.textColor = colorWithHexString("000000")
            lblLabel.numberOfLines = 0;
            lblLabel.adjustsFontSizeToFitWidth = true
            lblLabel.font = UIFont(name: "Helvetica", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblLabel.text = NSLocalizedString("lblDepartureHotel",comment:"");

            txtTextField.frame = CGRect(x: 0.32*width!, y: 0.02*height!, width: 0.4*width!, height: 0.04*height!);
            txtTextField.backgroundColor = UIColor.clear;
            txtTextField.textAlignment = NSTextAlignment.right;
            txtTextField.textColor = colorWithHexString("000000")
            txtTextField.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtTextField.layer.borderColor = UIColor.black.cgColor
            txtTextField.borderStyle = UITextField.BorderStyle.roundedRect
            txtTextField.keyboardType = UIKeyboardType.numberPad
            txtTextField.text = self.appDelegate.gstrDepHotelNameAux;
            txtTextField.isEnabled = false
            
            self.addSubview(lblLabel)
            self.addSubview(txtTextField)
            
        } else if Index == "4"{
            
            lblLabel.frame = CGRect(x: 0.01*width!, y: 0.02*height!, width: 0.3*width!, height: 0.025*height!);
            lblLabel.backgroundColor = UIColor.clear
            lblLabel.textAlignment = NSTextAlignment.left
            lblLabel.textColor = colorWithHexString("000000")
            lblLabel.numberOfLines = 0;
            lblLabel.adjustsFontSizeToFitWidth = true
            lblLabel.font = UIFont(name: "Helvetica", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblLabel.text = NSLocalizedString("lblDepartureDate",comment:"");
            
            let Departuredate = moment(self.appDelegate.gstrDepartureTransferAux)
            strDeparturedate = strdateFormatter.string(from: Departuredate!.date)
            
            txtTextField.frame = CGRect(x: 0.32*width!, y: 0.02*height!, width: 0.4*width!, height: 0.04*height!);
            txtTextField.backgroundColor = UIColor.clear;
            txtTextField.textAlignment = NSTextAlignment.right;
            txtTextField.textColor = colorWithHexString("000000")
            txtTextField.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtTextField.layer.borderColor = UIColor.black.cgColor
            txtTextField.borderStyle = UITextField.BorderStyle.roundedRect
            txtTextField.keyboardType = UIKeyboardType.numberPad
            txtTextField.text = strDeparturedate;
            txtTextField.isEnabled = false
            
            self.addSubview(lblLabel)
            self.addSubview(txtTextField)
            
        } else if Index == "5"{
            
            lblLabel.frame = CGRect(x: 0.01*width!, y: 0.02*height!, width: 0.3*width!, height: 0.025*height!);
            lblLabel.backgroundColor = UIColor.clear
            lblLabel.textAlignment = NSTextAlignment.left
            lblLabel.textColor = colorWithHexString("000000")
            lblLabel.numberOfLines = 0;
            lblLabel.adjustsFontSizeToFitWidth = true
            lblLabel.font = UIFont(name: "Helvetica", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblLabel.text = NSLocalizedString("lblPax",comment:"");
            
            txtpax.frame = CGRect(x: 0.32*width!, y: 0.02*height!, width: 0.4*width!, height: 0.04*height!);
            txtpax.backgroundColor = UIColor.clear;
            txtpax.textAlignment = NSTextAlignment.right;
            txtpax.textColor = colorWithHexString("000000")
            txtpax.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtpax.layer.borderColor = UIColor.black.cgColor
            txtpax.borderStyle = UITextField.BorderStyle.roundedRect
            txtpax.keyboardType = UIKeyboardType.numberPad
            //txtpax.text = self.appDelegate.giPeopleNumTransferAux.description;
            
            self.addSubview(lblLabel)
            self.addSubview(txtpax)
            
        } else if Index == "6"{
            
            btnSave.frame = CGRect(x: 0.3*width!, y: 0.02*height!, width: 0.3*width!, height: 0.04*height!);
            btnSave.setTitle(NSLocalizedString("btnSave",comment:""), for: UIControl.State())
            btnSave.titleLabel?.font = UIFont(name: "Helvetica", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont4)
            btnSave.backgroundColor = colorWithHexString("5C9FCC")
            btnSave.layer.borderWidth = 0.8
            btnSave.setTitleColor(UIColor.white, for: UIControl.State())
            btnSave.titleLabel?.textAlignment = NSTextAlignment.center

            self.addSubview(btnSave)
            
        } else if Index == "7"{
            
            btnCancel.frame = CGRect(x: 0.3*width!, y: 0.02*height!, width: 0.3*width!, height: 0.04*height!);
            btnCancel.setTitle(NSLocalizedString("btnCancel",comment:""), for: UIControl.State())
            btnCancel.titleLabel?.font = UIFont(name: "Helvetica", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont4)
            btnCancel.backgroundColor = colorWithHexString("5C9FCC")
            btnCancel.layer.borderWidth = 0.8
            btnCancel.setTitleColor(UIColor.white, for: UIControl.State())
            btnCancel.titleLabel?.textAlignment = NSTextAlignment.center

            self.addSubview(btnCancel)
            
        }
        
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

