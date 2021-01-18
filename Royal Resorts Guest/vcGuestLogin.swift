//
//  vcGuestLogin.swift
//  Royal Resorts Guest
//
//  Created by Marco Cocom on 11/18/14.
//  Copyright (c) 2014 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class vcGuestLogin: UIViewController, UITextFieldDelegate {
    
    var sMsj = ""
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let app = UIApplication.shared
    var strEmailReq: String = ""
    var tblLogin: Dictionary<String, String>!
    var fSizeFont: CGFloat = 0
    var mas: NSMutableAttributedString = NSMutableAttributedString()
    var fSizeBarFont: CGFloat = 0
    var RowResult = RRDataRow()
    var ynLogin: Bool = false
    var ynCargaParse: Bool = false
    var ParseAppKey: String = ""
    var ParseClientKey: String = ""
    var ParseRestKey: String = ""
    var ParseMasterKey: String = ""
    var nameArray : NSArray = []
    var config : SwiftLoader.Config = SwiftLoader.Config()
    var strFont: String = ""
    
    //Estilos
    var img = UIImage()
    var imgvw = UIImageView()
    var imgMail = UIImage()
    var imgvwMail = UIImageView()
    var linevw1: UIView = UIView()
    var imgPass = UIImage()
    var imgvwPass = UIImageView()
    var linevw2: UIView = UIView()
    var linevw3: UIView = UIView()
    var linevw4: UIView = UIView()
    var imgBack = UIImage()
    var imgvwBack = UIImageView()
    var lblmsjor: UILabel = UILabel()
    var lblmsjnotreg: UILabel = UILabel()
    var btnConfCode: UIButton = UIButton()
    
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPin: UITextField!
    @IBOutlet weak var lblMsj: UILabel!
    @IBOutlet weak var btnAply: UIButton!
    @IBOutlet weak var lblMsjPin: UILabel!
    @IBOutlet weak var btnRequest: UIButton!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet var ViewItem: UINavigationItem!
    @IBOutlet var btnBack: UIBarButtonItem!
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = appDelegate.width
        let height = appDelegate.height
        
        config.size = 100
        config.backgroundColor = UIColor(white: 1, alpha: 0.5)
        config.spinnerColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.titleTextColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.spinnerLineWidth = 2.0
        
        lblHeader.frame = CGRect(x: 0.1*width, y: 0.12*height, width: 0.8*width, height: 0.1*height);
        bodyView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.27*height);
        txtEmail.frame = CGRect(x: 0.1*width, y: 0.03*height, width: 0.7*width, height: 0.05*height);
        txtPin.frame = CGRect(x: 0.1*width, y: 0.11*height, width: 0.7*width, height: 0.05*height);
        btnAply.frame = CGRect(x: 0.3*width, y: 0.19*height, width: 0.3*width, height: 0.05*height);
        btnAply.layer.cornerRadius = 5
        lblMsj.frame = CGRect(x: 0.05*width, y: 0.6*height, width: 0.9*width, height: 0.1*height);
        lblMsjPin.frame = CGRect(x: 0.1*width, y: 0.82*height, width: 0.8*width, height: 0.1*height);
        btnRequest.frame = CGRect(x: 0.1*width, y: 0.92*height, width: 0.8*width, height: 0.05*height);
        txtEmail.delegate = self
        txtPin.delegate = self
        
        txtEmail.font = UIFont(name:"Helvetica", size:appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
        txtPin.font = UIFont(name:"Helvetica", size:appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
        txtEmail.placeholder = NSLocalizedString("txtEmail",comment:"");
        txtPin.placeholder = NSLocalizedString("txtPIN",comment:"");
        lblHeader.numberOfLines = 0
        lblHeader.font = UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont5)
        lblHeader.text = NSLocalizedString("lblHeader",comment:"")
        lblMsjPin.font = UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont5)
        lblMsjPin.text = NSLocalizedString("lblMsjPin",comment:"")

        mas = NSMutableAttributedString(string: NSLocalizedString("btnRequest",comment:""), attributes: [
            NSAttributedString.Key.font: UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont5)!,
            NSAttributedString.Key.foregroundColor: colorWithHexString ("5C9FCC")
            ])
        btnRequest.setAttributedTitle(mas, for: UIControl.State())
        
        mas = NSMutableAttributedString(string: NSLocalizedString("btnAply",comment:""), attributes: [
            NSAttributedString.Key.font: UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont4)!,
            NSAttributedString.Key.foregroundColor: colorWithHexString ("007AFF")
            ])
        btnAply.setAttributedTitle(mas, for: UIControl.State())
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString("Iniciar",comment:"");
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            self.view.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"BackAqua.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height);
            imgvwBack.alpha = 0.2
            //self.view.addSubview(imgvwBack)
            
            bodyView.isHidden = true
            lblMsj.isHidden = true
            
            img = UIImage(named:"Logo.png")!
            imgvw = UIImageView(image: img)
            if appDelegate.ynIPad == true{
                imgvw.frame = CGRect(x: 0.33*width, y: 0.12*height, width: 0.34*width, height: 0.22*height);
            }else{
                imgvw.frame = CGRect(x: 0.3*width, y: 0.15*height, width: 0.4*width, height: 0.2*height);
            }
            //imgvw.alpha = 0.4
            self.view.addSubview(imgvw)
            
            lblHeader.frame = CGRect(x: 0.05*width, y: 0.345*height, width: 0.9*width, height: 0.1*height);
            lblHeader.textColor = colorWithHexString ("ba8748")
            lblHeader.numberOfLines = 0
            lblHeader.font = UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont5)
            lblHeader.text = NSLocalizedString("lblHeader",comment:"")
            lblHeader.textAlignment = NSTextAlignment.center
            lblHeader.alpha = 0.9
            //self.view.addSubview(lblTitleHdr)
            
            imgMail = UIImage(named:"mail.png")!
            imgvwMail = UIImageView(image: imgMail)
            if appDelegate.ynIPad == true{
                imgvwMail.frame = CGRect(x: 0.05*width, y: 0.454*height, width: 0.08*width, height: 0.06*height);
            }else{
                imgvwMail.frame = CGRect(x: 0.05*width, y: 0.454*height, width: 0.09*width, height: 0.06*height);
            }
            imgvwMail.tintColor = UIColor.white
            imgvwMail.alpha = 0.5
            self.view.addSubview(imgvwMail)
            
            txtEmail.frame = CGRect(x: 0.15*width, y: 0.471*height, width: 0.7*width, height: 0.04*height);
            txtEmail.font = UIFont(name:"Helvetica", size:appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
            txtEmail.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("txtEmail",comment:""),
                                                                attributes:[NSAttributedString.Key.foregroundColor: colorWithHexString ("e4c29c")])
            txtEmail.tintColor = colorWithHexString ("ba8748")
            txtEmail.textColor = colorWithHexString ("ba8748")
            txtEmail.backgroundColor = UIColor.clear
            txtEmail.layer.borderColor = UIColor.clear.cgColor
            txtEmail.layer.borderWidth = 0
            txtEmail.borderStyle = UITextField.BorderStyle.none
            txtEmail.delegate = self
            self.view.addSubview(txtEmail)
            
            linevw1.frame = CGRect(x: 0.05*width, y: 0.51*height, width: 0.9*width, height: 1);
            linevw1.backgroundColor = colorWithHexString ("e4c29c")
            linevw1.alpha = 0.9
            self.view.addSubview(linevw1)
            
            imgPass = UIImage(named:"lock.png")!
            imgvwPass = UIImageView(image: imgPass)
            if appDelegate.ynIPad == true{
                imgvwPass.frame = CGRect(x: 0.03*width, y: 0.515*height, width: 0.11*width, height: 0.06*height);
            }else{
                imgvwPass.frame = CGRect(x: 0.03*width, y: 0.515*height, width: 0.12*width, height: 0.06*height);
            }
            imgvwPass.tintColor = UIColor.white
            imgvwPass.alpha = 0.5
            self.view.addSubview(imgvwPass)
            
            txtPin.frame = CGRect(x: 0.15*width, y: 0.534*height, width: 0.7*width, height: 0.04*height);
            txtPin.font = UIFont(name:"Helvetica", size:appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
            txtPin.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("txtPIN",comment:""),
                                                              attributes:[NSAttributedString.Key.foregroundColor: colorWithHexString ("e4c29c")])
            txtPin.tintColor = colorWithHexString ("ba8748")
            txtPin.textColor = colorWithHexString ("ba8748")
            txtPin.backgroundColor = UIColor.clear
            txtPin.layer.borderColor = UIColor.clear.cgColor
            txtPin.layer.borderWidth = 0
            txtPin.borderStyle = UITextField.BorderStyle.none
            txtPin.delegate = self
            self.view.addSubview(txtPin)
            
            linevw2.frame = CGRect(x: 0.05*width, y: 0.573*height, width: 0.9*width, height: 1);
            linevw2.backgroundColor = colorWithHexString ("e4c29c")
            linevw2.alpha = 0.9
            self.view.addSubview(linevw2)
            
            btnAply.frame = CGRect(x: 0.05*width, y: 0.587*height, width: 0.9*width, height: 0.04*height);
            mas = NSMutableAttributedString(string: NSLocalizedString("btnAply",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont4)!,
                NSAttributedString.Key.foregroundColor: colorWithHexString ("ba8748")
                ])
            btnAply.setAttributedTitle(mas, for: UIControl.State())
            btnAply.layer.borderColor = colorWithHexString ("e4c29c").cgColor
            btnAply.layer.borderWidth = 1
            btnAply.alpha = 0.9
            btnAply.addTarget(self, action: #selector(vcGuestLogin.clickSignIn(_:)), for: UIControl.Event.touchUpInside)
            btnAply.backgroundColor = UIColor.clear
            btnAply.layer.cornerRadius = 0
            self.view.addSubview(btnAply)
            
            lblMsjPin.frame = CGRect(x: 0.05*width, y: 0.83*height, width: 0.9*width, height: 0.1*height);
            lblMsjPin.textColor = colorWithHexString ("ba8748")
            lblMsjPin.numberOfLines = 0
            lblMsjPin.font = UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont5)
            lblMsjPin.text = NSLocalizedString("lblMsjPin",comment:"")
            lblMsjPin.textAlignment = NSTextAlignment.center
            lblMsjPin.alpha = 0.9
            //self.view.addSubview(lblMsjPin)
            
            linevw3.frame = CGRect(x: 0.38*width, y: 0.95*height, width: 0.24*width, height: 1);
            linevw3.backgroundColor = colorWithHexString ("e4c29c")
            linevw3.alpha = 0.9
            self.view.addSubview(linevw3)
            
            btnRequest.frame = CGRect(x: 0.05*width, y: 0.92*height, width: 0.9*width, height: 0.04*height);
            mas = NSMutableAttributedString(string: NSLocalizedString("btnRequest",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont5)!,
                NSAttributedString.Key.foregroundColor: colorWithHexString ("ba8748")
                ])
            btnRequest.setAttributedTitle(mas, for: UIControl.State())
            btnRequest.alpha = 0.9
            btnRequest.addTarget(self, action: #selector(vcGuestLogin.clickRequest(_:)), for: UIControl.Event.touchUpInside)
            //self.view.addSubview(btnRequest)
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            self.view.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"BackAqua.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height);
            imgvwBack.alpha = 0.2
            //self.view.addSubview(imgvwBack)
            
            bodyView.isHidden = true
            lblMsj.isHidden = true
            
            img = UIImage(named:"Logo.png")!
            imgvw = UIImageView(image: img)
            if appDelegate.ynIPad == true{
                imgvw.frame = CGRect(x: 0.3*width, y: 0.2*height, width: 0.4*width, height: 0.12*height);
            }else{
                imgvw.frame = CGRect(x: 0.3*width, y: 0.2*height, width: 0.4*width, height: 0.1*height);
            }
            //imgvw.alpha = 0.4
            self.view.addSubview(imgvw)
            
            lblHeader.frame = CGRect(x: 0.05*width, y: 0.345*height, width: 0.9*width, height: 0.1*height);
            lblHeader.textColor = colorWithHexString ("00467f")
            lblHeader.numberOfLines = 0
            lblHeader.font = UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont5)
            lblHeader.text = NSLocalizedString("lblHeader",comment:"")
            lblHeader.textAlignment = NSTextAlignment.center
            lblHeader.alpha = 0.6
            //self.view.addSubview(lblTitleHdr)
            
            imgMail = UIImage(named:"mail.png")!
            imgvwMail = UIImageView(image: imgMail)
            if appDelegate.ynIPad == true{
                imgvwMail.frame = CGRect(x: 0.05*width, y: 0.454*height, width: 0.08*width, height: 0.06*height);
            }else{
                imgvwMail.frame = CGRect(x: 0.05*width, y: 0.454*height, width: 0.09*width, height: 0.06*height);
            }
            imgvwMail.tintColor = UIColor.white
            imgvwMail.alpha = 0.3
            self.view.addSubview(imgvwMail)
            
            txtEmail.frame = CGRect(x: 0.15*width, y: 0.471*height, width: 0.7*width, height: 0.04*height);
            txtEmail.font = UIFont(name:"Helvetica", size:appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
            txtEmail.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("txtEmail",comment:""),
                                                                attributes:[NSAttributedString.Key.foregroundColor: colorWithHexString ("9abfd8")])
            txtEmail.tintColor = colorWithHexString ("00467f")
            txtEmail.textColor = colorWithHexString ("00467f")
            txtEmail.backgroundColor = UIColor.clear
            txtEmail.layer.borderColor = UIColor.clear.cgColor
            txtEmail.layer.borderWidth = 0
            txtEmail.borderStyle = UITextField.BorderStyle.none
            txtEmail.delegate = self
            self.view.addSubview(txtEmail)
            
            linevw1.frame = CGRect(x: 0.05*width, y: 0.51*height, width: 0.9*width, height: 1);
            linevw1.backgroundColor = colorWithHexString ("00467f")
            linevw1.alpha = 0.6
            self.view.addSubview(linevw1)
            
            imgPass = UIImage(named:"lock.png")!
            imgvwPass = UIImageView(image: imgPass)
            if appDelegate.ynIPad == true{
                imgvwPass.frame = CGRect(x: 0.03*width, y: 0.515*height, width: 0.11*width, height: 0.06*height);
            }else{
                imgvwPass.frame = CGRect(x: 0.03*width, y: 0.515*height, width: 0.12*width, height: 0.06*height);
            }
            imgvwPass.tintColor = UIColor.white
            imgvwPass.alpha = 0.3
            self.view.addSubview(imgvwPass)
            
            txtPin.frame = CGRect(x: 0.15*width, y: 0.534*height, width: 0.7*width, height: 0.04*height);
            txtPin.font = UIFont(name:"Helvetica", size:appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
            txtPin.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("txtPIN",comment:""),
                                                              attributes:[NSAttributedString.Key.foregroundColor: colorWithHexString ("9abfd8")])
            txtPin.tintColor = colorWithHexString ("00467f")
            txtPin.textColor = colorWithHexString ("00467f")
            txtPin.backgroundColor = UIColor.clear
            txtPin.layer.borderColor = UIColor.clear.cgColor
            txtPin.layer.borderWidth = 0
            txtPin.borderStyle = UITextField.BorderStyle.none
            txtPin.delegate = self
            self.view.addSubview(txtPin)
            
            linevw2.frame = CGRect(x: 0.05*width, y: 0.573*height, width: 0.9*width, height: 1);
            linevw2.backgroundColor = colorWithHexString ("00467f")
            linevw2.alpha = 0.6
            self.view.addSubview(linevw2)
            
            btnAply.frame = CGRect(x: 0.05*width, y: 0.587*height, width: 0.9*width, height: 0.04*height);
            mas = NSMutableAttributedString(string: NSLocalizedString("btnAply",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont4)!,
                NSAttributedString.Key.foregroundColor: colorWithHexString ("00467f")
                ])
            btnAply.setAttributedTitle(mas, for: UIControl.State())
            btnAply.layer.borderColor = colorWithHexString ("00467f").cgColor
            btnAply.layer.borderWidth = 1
            btnAply.alpha = 0.5
            btnAply.addTarget(self, action: #selector(vcGuestLogin.clickSignIn(_:)), for: UIControl.Event.touchUpInside)
            btnAply.backgroundColor = UIColor.clear
            btnAply.layer.cornerRadius = 0
            self.view.addSubview(btnAply)
            
            lblMsjPin.frame = CGRect(x: 0.05*width, y: 0.83*height, width: 0.9*width, height: 0.1*height);
            lblMsjPin.textColor = colorWithHexString ("00467f")
            lblMsjPin.numberOfLines = 0
            lblMsjPin.font = UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont5)
            lblMsjPin.text = NSLocalizedString("lblMsjPin",comment:"")
            lblMsjPin.textAlignment = NSTextAlignment.center
            lblMsjPin.alpha = 0.6
            //self.view.addSubview(lblMsjPin)
            
            linevw3.frame = CGRect(x: 0.38*width, y: 0.95*height, width: 0.24*width, height: 1);
            linevw3.backgroundColor = colorWithHexString ("00467f")
            linevw3.alpha = 0.6
            self.view.addSubview(linevw3)
            
            btnRequest.frame = CGRect(x: 0.05*width, y: 0.92*height, width: 0.9*width, height: 0.04*height);
            mas = NSMutableAttributedString(string: NSLocalizedString("btnRequest",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont5)!,
                NSAttributedString.Key.foregroundColor: colorWithHexString ("00467f")
                ])
            btnRequest.setAttributedTitle(mas, for: UIControl.State())
            btnRequest.alpha = 0.5
            btnRequest.addTarget(self, action: #selector(vcGuestLogin.clickRequest(_:)), for: UIControl.Event.touchUpInside)
            //self.view.addSubview(btnRequest)
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            self.view.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"BackAqua.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height);
            imgvwBack.alpha = 0.2
            //self.view.addSubview(imgvwBack)
            
            bodyView.isHidden = true
            lblMsj.isHidden = true
            
            img = UIImage(named:"Logo.png")!
            imgvw = UIImageView(image: img)
            if appDelegate.ynIPad == true{
                imgvw.frame = CGRect(x: 0.3*width, y: 0.2*height, width: 0.4*width, height: 0.12*height);
            }else{
                imgvw.frame = CGRect(x: 0.3*width, y: 0.2*height, width: 0.4*width, height: 0.1*height);
            }
            //imgvw.alpha = 0.4
            self.view.addSubview(imgvw)
            
            lblHeader.frame = CGRect(x: 0.05*width, y: 0.345*height, width: 0.9*width, height: 0.1*height);
            lblHeader.textColor = colorWithHexString ("2e3634")
            lblHeader.numberOfLines = 0
            lblHeader.font = UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont5)
            lblHeader.text = NSLocalizedString("lblHeader",comment:"")
            lblHeader.textAlignment = NSTextAlignment.center
            lblHeader.alpha = 0.6
            //self.view.addSubview(lblTitleHdr)
            
            imgMail = UIImage(named:"mail.png")!
            imgvwMail = UIImageView(image: imgMail)
            if appDelegate.ynIPad == true{
                imgvwMail.frame = CGRect(x: 0.05*width, y: 0.454*height, width: 0.08*width, height: 0.06*height);
            }else{
                imgvwMail.frame = CGRect(x: 0.05*width, y: 0.454*height, width: 0.09*width, height: 0.06*height);
            }
            imgvwMail.tintColor = colorWithHexString ("2e3634")
            imgvwMail.alpha = 0.6
            self.view.addSubview(imgvwMail)
            
            txtEmail.frame = CGRect(x: 0.15*width, y: 0.471*height, width: 0.7*width, height: 0.04*height);
            txtEmail.font = UIFont(name:"Helvetica", size:appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
            txtEmail.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("txtEmail",comment:""),
                                                                attributes:[NSAttributedString.Key.foregroundColor: colorWithHexString ("2e3634")])
            txtEmail.tintColor = colorWithHexString ("2e3634")
            txtEmail.textColor = colorWithHexString ("2e3634")
            txtEmail.backgroundColor = UIColor.clear
            txtEmail.layer.borderColor = UIColor.clear.cgColor
            txtEmail.layer.borderWidth = 0
            txtEmail.borderStyle = UITextField.BorderStyle.none
            txtEmail.delegate = self
            self.view.addSubview(txtEmail)
            
            linevw1.frame = CGRect(x: 0.05*width, y: 0.51*height, width: 0.9*width, height: 1);
            linevw1.backgroundColor = colorWithHexString ("2e3634")
            linevw1.alpha = 0.6
            self.view.addSubview(linevw1)
            
            imgPass = UIImage(named:"lock.png")!
            imgvwPass = UIImageView(image: imgPass)
            if appDelegate.ynIPad == true{
                imgvwPass.frame = CGRect(x: 0.03*width, y: 0.515*height, width: 0.11*width, height: 0.06*height);
            }else{
                imgvwPass.frame = CGRect(x: 0.03*width, y: 0.515*height, width: 0.12*width, height: 0.06*height);
            }
            imgvwPass.tintColor = colorWithHexString ("2e3634")
            imgvwPass.alpha = 0.6
            self.view.addSubview(imgvwPass)
            
            txtPin.frame = CGRect(x: 0.15*width, y: 0.534*height, width: 0.7*width, height: 0.04*height);
            txtPin.font = UIFont(name:"Helvetica", size:appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
            txtPin.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("txtPIN",comment:""),
                                                              attributes:[NSAttributedString.Key.foregroundColor: colorWithHexString ("2e3634")])
            txtPin.tintColor = colorWithHexString ("2e3634")
            txtPin.textColor = colorWithHexString ("2e3634")
            txtPin.backgroundColor = UIColor.clear
            txtPin.layer.borderColor = UIColor.clear.cgColor
            txtPin.layer.borderWidth = 0
            txtPin.borderStyle = UITextField.BorderStyle.none
            txtPin.delegate = self
            self.view.addSubview(txtPin)
            
            linevw2.frame = CGRect(x: 0.05*width, y: 0.573*height, width: 0.9*width, height: 1);
            linevw2.backgroundColor = colorWithHexString ("2e3634")
            linevw2.alpha = 0.6
            self.view.addSubview(linevw2)
            
            btnAply.frame = CGRect(x: 0.05*width, y: 0.587*height, width: 0.9*width, height: 0.04*height);
            mas = NSMutableAttributedString(string: NSLocalizedString("btnAply",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont4)!,
                NSAttributedString.Key.foregroundColor: colorWithHexString ("2e3634")
                ])
            btnAply.setAttributedTitle(mas, for: UIControl.State())
            //btnAply.layer.borderColor = colorWithHexString ("2e3634").cgColor
            //btnAply.layer.borderWidth = 1
            //btnAply.alpha = 0.5
            btnAply.addTarget(self, action: #selector(vcGuestLogin.clickSignIn(_:)), for: UIControl.Event.touchUpInside)
            btnAply.backgroundColor = colorWithHexString ("f7941e")
            btnAply.layer.cornerRadius = 0
            self.view.addSubview(btnAply)
            
            lblMsjPin.frame = CGRect(x: 0.05*width, y: 0.64*height, width: 0.9*width, height: 0.1*height);
            lblMsjPin.textColor = colorWithHexString ("2e3634")
            lblMsjPin.numberOfLines = 1
            lblMsjPin.font = UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont5)
            lblMsjPin.text = NSLocalizedString("lblMsjPin",comment:"")
            lblMsjPin.textAlignment = NSTextAlignment.center
            lblMsjPin.alpha = 0.6
            lblMsjPin.adjustsFontSizeToFitWidth = true
            
            linevw3.frame = CGRect(x: 0.38*width, y: 0.73*height, width: 0.24*width, height: 1);
            linevw3.backgroundColor = colorWithHexString ("2e3634")
            linevw3.alpha = 0.6
            //self.view.addSubview(linevw3)
            
            btnRequest.frame = CGRect(x: 0.05*width, y: 0.7*height, width: 0.9*width, height: 0.04*height);
            mas = NSMutableAttributedString(string: NSLocalizedString("btnRequest",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont5)!,
                NSAttributedString.Key.foregroundColor: colorWithHexString ("2e3634"),
                NSAttributedString.Key.underlineStyle : 1
                ])
            btnRequest.setAttributedTitle(mas, for: UIControl.State())
            btnRequest.alpha = 0.5
            btnRequest.addTarget(self, action: #selector(vcGuestLogin.clickRequest(_:)), for: UIControl.Event.touchUpInside)
            
            lblmsjor.frame = CGRect(x: 0.05*width, y: 0.75*height, width: 0.9*width, height: 0.04*height);
            lblmsjor.textColor = colorWithHexString ("2e3634")
            lblmsjor.numberOfLines = 0
            lblmsjor.font = UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont5)
            lblmsjor.text = NSLocalizedString("lblOr",comment:"")
            lblmsjor.textAlignment = NSTextAlignment.center
            lblmsjor.alpha = 0.6
            self.view.addSubview(lblmsjor)
            
            lblmsjnotreg.frame = CGRect(x: 0.05*width, y: 0.8*height, width: 0.9*width, height: 0.04*height);
            lblmsjnotreg.textColor = colorWithHexString ("2e3634")
            lblmsjnotreg.numberOfLines = 0
            lblmsjnotreg.font = UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont5)
            lblmsjnotreg.text = NSLocalizedString("lblmsjnotreg",comment:"")
            lblmsjnotreg.textAlignment = NSTextAlignment.center
            lblmsjnotreg.alpha = 0.6
            self.view.addSubview(lblmsjnotreg)
            
            btnConfCode.frame = CGRect(x: 0.05*width, y: 0.83*height, width: 0.9*width, height: 0.04*height);
            mas = NSMutableAttributedString(string: NSLocalizedString("btnConfCode",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont5)!,
                NSAttributedString.Key.foregroundColor: colorWithHexString ("2e3634"),
                NSAttributedString.Key.underlineStyle : 1
                ])
            btnConfCode.setAttributedTitle(mas, for: UIControl.State())
            btnConfCode.alpha = 0.5
            btnConfCode.addTarget(self, action: #selector(vcGuestLogin.clickLogInConf(_:)), for: UIControl.Event.touchUpInside)
            self.view.addSubview(btnConfCode)

            linevw4.frame = CGRect(x: 0.38*width, y: 0.85*height, width: 0.3*width, height: 1);
            linevw4.backgroundColor = colorWithHexString ("2e3634")
            linevw4.alpha = 0.6
            //self.view.addSubview(linevw4)
            
        }
        
        Analytics.setScreenName("Login", screenClass: appDelegate.gstrAppName)
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickSignIn(_ sender: AnyObject){

        var tableItems = RRDataSet()
        var iRes: String = ""
        var sRes: String = ""
        var isInserted: Bool = false
        var strPeople: String = ""
    
        self.btnAply.isEnabled = false
        self.btnRequest.isEnabled = false
        app.beginIgnoringInteractionEvents()
        
        /*print("***Token***")
        print(self.appDelegate.gstrToken)*/
        
        if (ValidaEmail() && ValidaPin()) || self.appDelegate.ynLogInConf{
            
            SwiftLoader.setConfig(config)
            SwiftLoader.show(animated: true)
            SwiftLoader.show(title: NSLocalizedString("lblLoading",comment:""), animated: true)
            
            let queue = OperationQueue()
            
            queue.addOperation() {
                //accion webservice
                if Reachability.isConnectedToNetwork(){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    
                    if self.appDelegate.ynLogInConf{
                        
                        self.appDelegate.ynLogInConf = false
                        
                        let service=RRRestaurantService(url: self.appDelegate.URLServiceLogin as String, host: self.appDelegate.HostLogin as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
                        tableItems = (service?.spGetPeople("1", peopleID: self.appDelegate.gstrLoginPeopleID))!;
                        
                    }else{
                        
                        let service=RRRestaurantService(url: self.appDelegate.URLServiceLogin as String, host: self.appDelegate.HostLogin as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
                        //tableItems = (service?.spGetLogin(by: "1", param1: self.appDelegate.gstrAppName, param2: self.txtEmail.text, param3: self.txtPin.text, sNotificationToken: self.appDelegate.gstrToken))!;
                        tableItems = (service?.spGetLogin(by: "1", param1: self.appDelegate.gstrAppName, param2: self.txtEmail.text, param3: self.txtPin.text))!;
                        
                    }
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
                OperationQueue.main.addOperation() {
                    var queueFM: FMDatabaseQueue?
                    
                    queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
                    

                        //accion base de datos
                        if (tableItems.getTotalTables() > 0 ){
                            
                            var tableResult = RRDataTable()
                            tableResult = tableItems.tables.object(at: 0) as! RRDataTable
                            
                            var rowResult = RRDataRow()
                            rowResult = tableResult.rows.object(at: 0) as! RRDataRow
                            
                            if rowResult.getColumnByName("iResult") != nil{
                                iRes = rowResult.getColumnByName("iResult").content as! String
                                sRes = rowResult.getColumnByName("sResult").content as! String
                            }else{
                                iRes = "-1"
                                sRes = NSLocalizedString("MsgError6",comment:"")
                            }
                            
                            if ( (iRes != "0") && (iRes != "-1")){
                                
                                var table = RRDataTable()
                                table = tableItems.tables.object(at: 1) as! RRDataTable
                                
                                var r = RRDataRow()
                                r = table.rows.object(at: 0) as! RRDataRow
                                
                                iRes = (r as AnyObject).getColumnByName("Result").content as! String
                                sRes = (r as AnyObject).getColumnByName("ResultDesc").content as! String
                                
                                if (Int(iRes) > 0){
                                    
                                    queueFM?.inTransaction { db, rollback in
                                        do {
                                            
                                            for r in table.rows{
                                                strPeople = ((r as AnyObject).getColumnByName("PersonaID").content as? String)!
                                                
                                                try db.executeUpdate("INSERT INTO tblLogin (Email, PIN, PersonalID, Gender, Lenguage, FullName, FirstName, LastName, Field1, Field2, Field3, Field4, Field5, LastStayUpdate, PeopleType, Address, City, ZipCode, State, Country, ISOCode, Phone, URLcxPay, TokenCLBRPay) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [((r as AnyObject).getColumnByName("Email").content as? String)!, "0", ((r as AnyObject).getColumnByName("PersonaID").content as? String)!, ((r as AnyObject).getColumnByName("Gender").content as? String)!, ((r as AnyObject).getColumnByName("DefaultLaguage").content as? String)!, ((r as AnyObject).getColumnByName("FullName").content as? String)!, ((r as AnyObject).getColumnByName("FirstName").content as? String)!, ((r as AnyObject).getColumnByName("LastName").content as? String)!, ((r as AnyObject).getColumnByName("Field1").content as? String)!, ((r as AnyObject).getColumnByName("Field2").content as? String)!, ((r as AnyObject).getColumnByName("Field3").content as? String)!, ((r as AnyObject).getColumnByName("Field4").content as? String)!, ((r as AnyObject).getColumnByName("Field5").content as? String)!, "", ((r as AnyObject).getColumnByName("PeopleType").content as? String)!, ((r as AnyObject).getColumnByName("Address").content as? String)!, ((r as AnyObject).getColumnByName("City").content as? String)!, ((r as AnyObject).getColumnByName("ZipCode").content as? String)!, ((r as AnyObject).getColumnByName("State").content as? String)!, ((r as AnyObject).getColumnByName("Country").content as? String)!, ((r as AnyObject).getColumnByName("ISOCode").content as? String)!, ((r as AnyObject).getColumnByName("Phone").content as? String)!, ((r as AnyObject).getColumnByName("WebPageURLCLBRPay").content as? String)!, ((r as AnyObject).getColumnByName("TokenCLBRPay").content as? String)!])
                                                
                                                    isInserted = true
                                                
                                            }


                                        } catch {
                                            rollback.pointee = true
                                            print(error)
                                        }
                                    }

                                    if isInserted{
                                        self.tblLogin = [:]
                                        
                                        queueFM?.inDatabase() {
                                            db in
                                            
                                            if let rs = db.executeQuery("SELECT * FROM tblLogin WHERE PersonalID = ?", withArgumentsIn:[strPeople]) {
                                                while rs.next() {
                                                    self.tblLogin["Email"] = rs.string(forColumn: "Email")!
                                                    self.tblLogin["PIN"] = rs.string(forColumn: "PIN")!
                                                    self.tblLogin["PersonalID"] = rs.string(forColumn: "PersonalID")!
                                                    self.tblLogin["Gender"] = rs.string(forColumn: "Gender")!
                                                    self.tblLogin["Lenguage"] = rs.string(forColumn: "Lenguage")!
                                                    self.tblLogin["FullName"] = rs.string(forColumn: "FullName")!
                                                    self.tblLogin["FirstName"] = rs.string(forColumn: "FirstName")!
                                                    self.tblLogin["LastName"] = rs.string(forColumn: "LastName")!
                                                    self.tblLogin["Field1"] = rs.string(forColumn: "Field1")!
                                                    self.tblLogin["Field2"] = rs.string(forColumn: "Field2")!
                                                    self.tblLogin["Field3"] = rs.string(forColumn: "Field3")!
                                                    self.tblLogin["Field4"] = rs.string(forColumn: "Field4")!
                                                    self.tblLogin["Field5"] = rs.string(forColumn: "Field5")!
                                                    self.tblLogin["LastStayUpdate"] = rs.string(forColumn: "LastStayUpdate")!
                                                    self.tblLogin["PeopleType"] = rs.string(forColumn: "PeopleType")!
                                                    self.tblLogin["Address"] = rs.string(forColumn: "Address")!
                                                    self.tblLogin["City"] = rs.string(forColumn: "City")!
                                                    self.tblLogin["ZipCode"] = rs.string(forColumn: "ZipCode")!
                                                    self.tblLogin["State"] = rs.string(forColumn: "State")!
                                                    self.tblLogin["Country"] = rs.string(forColumn: "Country")!
                                                    self.tblLogin["ISOCode"] = rs.string(forColumn: "ISOCode")!
                                                    self.tblLogin["Phone"] = rs.string(forColumn: "Phone")!
                                                    self.tblLogin["URLcxPay"] = rs.string(forColumn: "URLcxPay")!
                                                    self.tblLogin["TokenCLBRPay"] = rs.string(forColumn: "TokenCLBRPay")!
                                                }
                                            } else {
                                                print("select failure: \(db.lastErrorMessage())")
                                            }
                                        }
                                        
                                        self.appDelegate.strLoginMail = self.tblLogin["Email"]!
                                        self.appDelegate.gstrLoginPeopleID = self.tblLogin["PersonalID"]!
                                        self.appDelegate.gtblStay = nil
                                        self.appDelegate.gStaysStatus = nil
                                        self.appDelegate.ynHome = false
                                        self.appDelegate.gtblLogin = self.tblLogin
                                    }

                                }
                                
                                
                            }
                            
                        }
                    
                    var tableItemsPush = RRDataSet()
                    
                    if isInserted{
                        self.btnAply.isEnabled = true
                        self.btnRequest.isEnabled = true
                        self.app.endIgnoringInteractionEvents()
                        
                        let queuenew = OperationQueue()
                        
                        queuenew.addOperation() {
                            //accion webservice
                            if Reachability.isConnectedToNetwork(){
                                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                                
                                var prepareOrderResult:NSString="";
                                let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
                                
                                tableItemsPush = (service?.spSetAppPeoplePushToken("1", peopleID: self.appDelegate.gstrLoginPeopleID, token: self.appDelegate.gstrToken, osCode: "IOS", appCode: self.appDelegate.gstrAppName, dataBase: "CDRPRD"))!
                                
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            }
                            
                            OperationQueue.main.addOperation() {
                                
                                SwiftLoader.hide()
                                
                                let NextViewController = self.storyboard?.instantiateViewController(withIdentifier: "tcGuestServicesMain") as! UITabBarController
                                self.navigationController?.pushViewController(NextViewController, animated: true)
                                GoogleWearAlert.showAlert(title: NSLocalizedString("msgLogin",comment:""), type: .success, duration: 3, iAction: 1, form:"Login")
                                
                            }
                            
                        }
                        


                        /*queueFM?.inTransaction { db, rollback in
                            do {
                                
                                try db.executeUpdate("UPDATE tblChannelCfg SET pkPeopleID = ? WHERE AppCode=?", withArgumentsIn: [self.appDelegate.gstrLoginPeopleID,self.appDelegate.gstrAppName])
                                
                            } catch {
                                rollback.pointee = true
                                return
                                    print(error)
                            }
                        }*/
                        
                    }else{
                        //GoogleWearAlert.showAlert(title: "Login Error", type: .Error, iAction: 1, form:"LoginE")
                        
                        if sRes == ""{
                            RKDropdownAlert.title(NSLocalizedString("MsgError5",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                        }else{
                            RKDropdownAlert.title(sRes, backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                        }

                        RKDropdownAlert.title(sRes, backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                        self.txtPin.resignFirstResponder()
                        self.txtEmail.resignFirstResponder()
                        self.appDelegate.gtblStay = nil
                        self.appDelegate.gStaysStatus = nil
                        self.btnAply.isEnabled = true
                        self.btnRequest.isEnabled = true
                        self.app.endIgnoringInteractionEvents()
                        SwiftLoader.hide()
                    }

                }
            }
        
        }else{
            RKDropdownAlert.title(sMsj, backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
            self.txtPin.resignFirstResponder()
            self.txtEmail.resignFirstResponder()
            self.appDelegate.gtblStay = nil
            self.appDelegate.gStaysStatus = nil
            self.btnAply.isEnabled = true
            self.btnRequest.isEnabled = true
            self.app.endIgnoringInteractionEvents()
        }

        
    }

    @IBAction func clickHome(_ sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func clickRequest(_ sender: AnyObject) {
        
        let NextViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcLoginEmailRequest") as! vcLoginEmailRequest
        appDelegate.ynHome = false
        self.navigationController?.pushViewController(NextViewController, animated: true)
        
    }
    
    @IBAction func clickLogInConf(_ sender: AnyObject) {
        
        let NextViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcConfLogin") as! vcConfLogin
        self.navigationController?.pushViewController(NextViewController, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.appDelegate.ynLogInConf{
            clickSignIn(btnAply)
        }else{
            
            if self.appDelegate.gstrLoginPeopleID != ""{
                self.navigationController?.popViewController(animated: false)
            }
            
            if (appDelegate.gblGoHome == true){
                self.navigationController?.popViewController(animated: false)
            }else{
                if (appDelegate.gstrRequestEmail != ""){
                    txtEmail.text = appDelegate.gstrRequestEmail
                }
            }
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Login",
            AnalyticsParameterItemName: "Login",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Login", screenClass: appDelegate.gstrAppName)
        
    }
    
    func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func ValidaEmail()-> Bool{
        
        var validEmail = false
        
        if txtEmail.text == ""{
            sMsj = NSLocalizedString("MsgError1",comment:"")
            return false;
        }else{
            for character in (txtEmail.text?.characters)! {
                if character == "@"{
                    validEmail = true
                }
                
            }
            
            if validEmail == true{
                if isValidEmail(txtEmail.text!) == false{
                    sMsj = NSLocalizedString("MsgError2",comment:"")
                    return false;
                }else{
                    return true;
                }
                
            }else{
                let a:Int? = Int(txtEmail.text!)
                if a == nil {
                    sMsj = NSLocalizedString("MsgError3",comment:"")
                    return false;
                } else {
                    return true;
                }
            }
        }
        
    }
    
    func ValidaPin()-> Bool{
        if txtPin.text == ""{
            sMsj = NSLocalizedString("MsgError7",comment:"")
            return false;
        }else{
            return true;
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
