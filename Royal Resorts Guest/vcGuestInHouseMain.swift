//
//  vcGuestInHouseMain.swift
//  Royal Resorts Guest
//
//  Created by Marco Cocom on 11/18/14.
//  Copyright (c) 2014 Marco Cocom. All rights reserved.
//

import UIKit
import Crashlytics
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging
import Photos

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


class vcGuestInHouseMain: UIViewController, UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate
{
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //var ynHome: Bool = false
    let app = UIApplication.shared
    var Email: String = ""
    var FullName: String = ""
    var PersonalID: String = ""
    var LastStayUpdate: String = ""
    var iHour: Int=0
    var ynRefresh: Bool=false
    var iCount: Int=0
    var iCountOut: Int=0
    var iCountInhouse: Int=0
    var iCountAssign: Int=0
    var tblStay: [Dictionary<String, String>]!
    var CountStay: Int32 = 0
    var StaysStatus: [[Dictionary<String, String>]]!
    var CountStatus: Int32 = 0
    var iseccion: Int = 0
    var ynReloadTable: Bool = false
    var tblLogin: Dictionary<String, String>!
    var tblStayInfo: Dictionary<String, String>!
    var Gender: String = ""
    var ynTraeDatos:Bool=false
    var ynConn:Bool=false
    var lblGuestType = UILabel()
    var PeopleType: String = ""
    var btnBack = UIButton()
    var width: CGFloat!
    var height: CGFloat!
    
    var ynReload: Bool = false
    var ynActualiza: Bool = false
    var strStayType: String = ""
    
    var imgBack = UIImage()
    var imgvwBack = UIImageView()
    var imgTakePic = UIImage()
    var imgvwTakePic = UIImageView()
    var imgOut = UIImage()
    var imgvwOut = UIImageView()
    var btnUploadImg:UIButton = UIButton()
    var imgCell = UIImage()
    var imgvwCell = UIImageView()
    var btnLogOut = UIButton()
    var LogOutView: UIView = UIView()
    var UploadView: UIView = UIView()
    var picker:UIImagePickerController?=UIImagePickerController()
    //var popover : UIPopoverController?
    var lastIndex = IndexPath()
    var ynCamera: Bool = false
    var btnBadge = UIButton()
    
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var UserView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnPoints: UIButton!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet var ViewItem: UINavigationItem!
    @IBOutlet weak var btnHome: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var imgArrow = "";
        
        width = appDelegate.width
        height = appDelegate.height

        bodyView.frame = CGRect(x: 0.0, y: 44, width: width, height: height);
        UserView.frame = CGRect(x: 0.05*width, y: 44 + 0.01*height, width: 0.9*width, height: 0.18*height);
        imgArrow = "left_Arrow.png"
        //ImageView.frame = CGRectMake(0.02*width, 0.01*height, 0.25*width, 0.15*height);
        lblName.frame = CGRect(x: 0.35*width, y: 0.01*height, width: 0.5*width, height: 0.04*height);
        lblGuestType.frame = CGRect(x: 0.35*width, y: 0.05*height, width: 0.5*width, height: 0.04*height);
        lblEmail.frame = CGRect(x: 0.35*width, y: 0.09*height, width: 0.5*width, height: 0.04*height);
        
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        
        lblName.font = UIFont(name:"Helvetica", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont5)
        lblEmail.font = UIFont(name:"Helvetica", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont5)
        lblGuestType.font = UIFont(name:"Helvetica", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont2)

        let lblFooter = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 0.1*height))
        lblFooter.backgroundColor = UIColor.clear;
        lblFooter.textAlignment = NSTextAlignment.left;
        lblFooter.textColor = UIColor.gray;
        lblFooter.font = UIFont(name:"HelveticaNeue-Light", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont4)
        lblFooter.numberOfLines = 0;
        lblFooter.text = NSLocalizedString("Msg2",comment:"")
        tableView.tableFooterView = lblFooter
        tableView.backgroundColor = UIColor.clear
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString("TitleGuest",comment:"");

        self.tabBarController?.navigationController?.navigationBar.isHidden = true;
        self.navigationController?.navigationBar.isHidden = false;
        
        tblLogin = appDelegate.gtblLogin
        
        Email = tblLogin["Email"]!
        self.appDelegate.strPeopleType = tblLogin["PeopleType"]!
        
        if Email == ""
        {
            Email = NSLocalizedString("sMsjEmail",comment:"")
        }
        
        FullName = tblLogin["FullName"]!
        PersonalID = tblLogin["PersonalID"]!
        LastStayUpdate = tblLogin["LastStayUpdate"]!
        Gender = tblLogin["Gender"]!
        PeopleType = tblLogin["PeopleType"]!

        lblName.text = FullName
        lblEmail.text = Email
        lblGuestType.text = PeopleType
        
        lblGuestType.textColor = UIColor.gray
        
        lblName.adjustsFontSizeToFitWidth = true;
        lblEmail.adjustsFontSizeToFitWidth = true;

        UserView.addSubview(lblGuestType)
        
        var image = UIImage()
        
        /*btnBadge.frame = CGRect(x: 0.2*width, y: 0.045*height, width: 0.2*width, height: 0.04*height);
        btnBadge.backgroundColor = UIColor.clear
        btnBadge.setTitleColor(colorWithHexString("007AFF"), for: UIControlState())
        btnBadge.setTitle(NSLocalizedString("Notify",comment:"Notify"), for:UIControlState())
        btnBadge.titleLabel?.font = UIFont(name: "Helvetica", size: appDelegate.gblFont9 + appDelegate.gblDeviceFont2)
        btnBadge.titleLabel?.textAlignment = NSTextAlignment.left
        btnBadge.titleLabel?.numberOfLines = 5
        btnBadge.layer.borderColor = UIColor.blue.cgColor
        btnBadge.layer.borderWidth = 1
        
        //btnBadge.addTarget(self, action: "imageTapped:", for: UIControlEvents.touchUpInside)
        btnBadge.addTarget(self, action: #selector(vcGuestInHouseMain.imageTapped), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(btnBadge)*/
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            var strFont: String = ""
            
            strFont = "HelveticaNeue"
            
            self.view.backgroundColor = UIColor.white//colorWithHexString ("DDF4FF")
            
            bodyView.isHidden = false
            UserView.isHidden = true
            //ImageView.hidden = true
            //lblName.hidden = true
            //lblGuestType.hidden = true
            //lblEmail.hidden = true
            //btnLogOut.hidden = true
            
            self.navigationController?.navigationBar.tintColor = colorWithHexString("0D94FC")
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            
            btnBack.frame = CGRect(x: 0.0, y: 0.12*height, width: 0.12*width, height: 0.06*height)
            btnBack.backgroundColor = UIColor.clear
            btnBack.setTitleColor(colorWithHexString("007AFF"), for: UIControl.State())
            btnBack.setTitle(NSLocalizedString("btnHome",comment:""), for:UIControl.State())
            btnBack.titleLabel?.font = UIFont(name: "Helvetica", size: appDelegate.gblFont9 + appDelegate.gblDeviceFont2)
            btnBack.titleLabel?.textAlignment = NSTextAlignment.left
            btnBack.titleLabel?.numberOfLines = 5
            btnBack.layer.borderColor = UIColor.clear.cgColor

            btnBack.addTarget(self, action: #selector(vcGuestInHouseMain.clickLogout(_:)), for: UIControl.Event.touchUpInside)
            
            btnHome.customView = btnBack
            btnHome.customView?.sizeToFit()
            
            var queueFM: FMDatabaseQueue?
            
            queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
            
            var correctPicture: Data? = nil
            
            queueFM?.inDatabase() {
                db in
                
                if let rs = db.executeQuery("SELECT UserImg FROM tblLogin WHERE PersonalID = ?", withArgumentsIn:[self.PersonalID]) {
                    while rs.next() {
                        correctPicture = rs.data(forColumn: "UserImg")
                    }
                } else {
                    print("select failure: \(db.lastErrorMessage())")
                }
            }

        
            if correctPicture != nil {
                
                btnUploadImg.setBackgroundImage(imgTakePic, for: UIControl.State())
                btnUploadImg.addTarget(self, action: #selector(vcGuestInHouseMain.buttonActionTakePicture(_:)), for: UIControl.Event.touchUpInside)
                
                if appDelegate.ynIPad == true {
                    btnUploadImg.frame = CGRect(x: 0.025*width, y: 0.08*height, width: 0.2*width, height: 0.12*height);
                }
                else{
                    btnUploadImg.frame = CGRect(x: 0.025*width, y: 0.08*height, width: 0.2*width, height: 0.12*height);
                }
                
                btnUploadImg.setTitleColor(colorWithHexString("5d5854"), for: UIControl.State())
                btnUploadImg.setTitle(NSLocalizedString("lblUpload",comment:""), for:UIControl.State())
                btnUploadImg.titleLabel?.font = UIFont(name: strFont, size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
                btnUploadImg.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
                btnUploadImg.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -45, right: 0)
                btnUploadImg.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
                self.view.addSubview(btnUploadImg)
                
                self.imgvwTakePic = UIImageView(image: UIImage(data: correctPicture!))
                if appDelegate.ynIPad == true {
                    self.imgvwTakePic.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: 0.2*self.width, height: 0.15*self.height);
                    self.imgvwTakePic.layer.cornerRadius = 44
                }
                else{
                    self.imgvwTakePic.frame = CGRect(x: 0.04*self.width, y: 0.08*self.height, width: 0.22*self.width, height: 0.13*self.height);
                    self.imgvwTakePic.layer.cornerRadius = 41
                }
                
                self.imgvwTakePic.clipsToBounds = true
                self.view.addSubview(self.imgvwTakePic)
            }else{
                imgTakePic = UIImage(named:"TomarFoto.png")!
                
                btnUploadImg.setBackgroundImage(imgTakePic, for: UIControl.State())
                btnUploadImg.addTarget(self, action: #selector(vcGuestInHouseMain.buttonActionTakePicture(_:)), for: UIControl.Event.touchUpInside)
                if appDelegate.ynIPad == true{
                    btnUploadImg.frame = CGRect(x: 0.003*width, y: 0.005*height, width: 0.2*width, height: 0.12*height);
                    btnUploadImg.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -80, right: 0)
                }else{
                    btnUploadImg.frame = CGRect(x: 0.015*width, y: 0.005*height, width: 0.2*width, height: 0.1*height);
                    btnUploadImg.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -45, right: 0)
                }
                
                //btnUploadImg.setTitleColor(colorWithHexString("00467f"), forState: UIControlState.Normal)
                btnUploadImg.setTitleColor(UIColor.black, for: UIControl.State())
                btnUploadImg.setTitle(NSLocalizedString("lblUpload",comment:""), for:UIControl.State())
                btnUploadImg.titleLabel?.font = UIFont(name: strFont, size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
                btnUploadImg.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
                btnUploadImg.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
                btnUploadImg.alpha = 0.5
                
                if appDelegate.ynIPad == true{
                    UploadView.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/4.35, height: self.height/7.5);
                }else{
                    UploadView.frame = CGRect(x: 0.036*self.width, y: 0.08*self.height, width: self.width/4.35, height: self.height/7.5);
                }

                UploadView.layer.cornerRadius = 44
                UploadView.clipsToBounds = true
                UploadView.layer.borderWidth = 4
                UploadView.layer.borderColor = colorWithHexString("616167").cgColor//colorWithHexString("94cce5").CGColor
                UploadView.backgroundColor = colorWithHexString("F2F2F2")//colorWithHexString("ddf4ff")
                appDelegate.gstrBorderColorImg = "616167"
                UploadView.addSubview(btnUploadImg)
                self.view.addSubview(UploadView)
            }
            
            imgOut = UIImage(named:"signout.png")!
            btnLogOut.setBackgroundImage(imgOut, for: UIControl.State())
            
            /*imgOut = UIImage(named:"signoutsel.png")!
             btnLogOut.setImage(imgOut, forState: UIControlState.Highlighted)*/
            
            btnLogOut.addTarget(self, action: #selector(vcGuestInHouseMain.LogOUT(_:)), for: UIControl.Event.touchUpInside)
            btnLogOut.addTarget(self, action: #selector(vcGuestInHouseMain.butonSignOutEfect(_:)), for: UIControl.Event.touchDown)
            if appDelegate.ynIPad == true{
                btnLogOut.frame = CGRect(x: 0.004*width, y: 0.001*height, width: 0.12*width, height: 0.07*height);
                btnLogOut.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -60, right: 0)
            }else{
                btnLogOut.frame = CGRect(x: 0.008*width, y: 0.001*height, width: 0.12*width, height: 0.06*height);
                btnLogOut.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -33, right: 0)
            }
            btnLogOut.setTitleColor(colorWithHexString("5d5854"), for: UIControl.State())
            btnLogOut.setTitle(NSLocalizedString("btnLogOut",comment:""), for:UIControl.State())
            btnLogOut.titleLabel?.font = UIFont(name: strFont, size: (appDelegate.gblFont1) + appDelegate.gblDeviceFont1)
            btnLogOut.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            btnLogOut.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            btnLogOut.alpha = 0.6
            //self.view.addSubview(btnLogOut)
            
            LogOutView.frame = CGRect(x: 0.81*width, y: 0.08*height, width: self.width/7.6, height: self.height/13);
            LogOutView.layer.cornerRadius = 25.5
            LogOutView.clipsToBounds = true
            //LogOutView.backgroundColor = UIColor.redColor()
            LogOutView.layer.borderWidth = 4
            LogOutView.layer.borderColor = colorWithHexString("616167").cgColor
            LogOutView.backgroundColor = colorWithHexString("F2F2F2")
            LogOutView.addSubview(btnLogOut)
            self.view.addSubview(LogOutView)
            
            lblName.frame = CGRect(x: 0.32*width, y: 0.09*height, width: 0.5*width, height: 0.12*height);
            lblGuestType.frame = CGRect(x: 0.32*width, y: 0.175*height, width: 0.6*width, height: 0.03*height);
            lblEmail.frame = CGRect(x: 0.32*width, y: 0.215*height, width: 0.6*width, height: 0.03*height);
            
            lblName.textColor = colorWithHexString("000000")
            lblGuestType.textColor = colorWithHexString("000000")
            lblEmail.textColor = colorWithHexString("000000")
            
            lblName.textAlignment = NSTextAlignment.left
            lblGuestType.textAlignment = NSTextAlignment.left
            lblEmail.textAlignment = NSTextAlignment.left
            
            lblName.font = UIFont(name:strFont, size:appDelegate.gblFont9 + appDelegate.gblDeviceFont5)
            lblEmail.font = UIFont(name:strFont, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont2)
            lblGuestType.font = UIFont(name:strFont, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont2)
            
            lblName.numberOfLines = 2
            lblName.sizeToFit()
            
            lblGuestType.numberOfLines = 1
            lblGuestType.sizeToFit()
            
            lblEmail.numberOfLines = 1
            lblEmail.sizeToFit()
            
            self.view.addSubview(lblName)
            self.view.addSubview(lblGuestType)
            self.view.addSubview(lblEmail)

            if appDelegate.ynIPad {
                switch appDelegate.Model {
                case "iPad 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                    UploadView.layer.cornerRadius = 75
                    UploadView.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    LogOutView.layer.cornerRadius = 46
                    LogOutView.frame = CGRect(x: 0.81*width, y: 0.08*height, width: self.width/8.1, height: self.height/11);
                    self.imgvwTakePic.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    self.imgvwTakePic.layer.cornerRadius = 75
                case "iPad Air":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                    UploadView.layer.cornerRadius = 75
                    UploadView.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    LogOutView.layer.cornerRadius = 46
                    LogOutView.frame = CGRect(x: 0.81*width, y: 0.08*height, width: self.width/8.1, height: self.height/11);
                    self.imgvwTakePic.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    self.imgvwTakePic.layer.cornerRadius = 75
                case "iPad Air 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                    UploadView.layer.cornerRadius = 75
                    UploadView.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    LogOutView.layer.cornerRadius = 46
                    LogOutView.frame = CGRect(x: 0.81*width, y: 0.08*height, width: self.width/8.1, height: self.height/11);
                    self.imgvwTakePic.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    self.imgvwTakePic.layer.cornerRadius = 75
                case "iPad Pro":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                    UploadView.layer.cornerRadius = 75
                    UploadView.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    LogOutView.layer.cornerRadius = 46
                    LogOutView.frame = CGRect(x: 0.81*width, y: 0.08*height, width: self.width/8.1, height: self.height/11);
                    self.imgvwTakePic.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    self.imgvwTakePic.layer.cornerRadius = 75
                case "iPad Retina":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                    UploadView.layer.cornerRadius = 75
                    UploadView.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    LogOutView.layer.cornerRadius = 46
                    LogOutView.frame = CGRect(x: 0.81*width, y: 0.08*height, width: self.width/8.1, height: self.height/11);
                    self.imgvwTakePic.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    self.imgvwTakePic.layer.cornerRadius = 75
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                    UploadView.layer.cornerRadius = 75
                    UploadView.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    LogOutView.layer.cornerRadius = 46
                    LogOutView.frame = CGRect(x: 0.81*width, y: 0.08*height, width: self.width/8.1, height: self.height/11);
                    self.imgvwTakePic.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    self.imgvwTakePic.layer.cornerRadius = 75
                }
            }else{
                switch appDelegate.Model {
                case "iPhone":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.55*height);
                    UploadView.layer.cornerRadius = 38
                    self.imgvwTakePic.layer.cornerRadius = 38
                case "iPhone 4":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.55*height);
                    UploadView.layer.cornerRadius = 38
                    self.imgvwTakePic.layer.cornerRadius = 38
                case "iPhone 4s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.55*height);
                    UploadView.layer.cornerRadius = 38
                    self.imgvwTakePic.layer.cornerRadius = 38
                case "iPhone 5":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.57*height);
                    UploadView.layer.cornerRadius = 38
                    self.imgvwTakePic.layer.cornerRadius = 38
                    LogOutView.layer.cornerRadius = 21.5
                    btnUploadImg.titleLabel?.font = UIFont(name: strFont, size: appDelegate.gblFont1 + appDelegate.gblDeviceFont3)
                case "iPhone 5c":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.57*height);
                    UploadView.layer.cornerRadius = 38
                    self.imgvwTakePic.layer.cornerRadius = 38
                    LogOutView.layer.cornerRadius = 21.5
                case "iPhone 5s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.57*height);
                    UploadView.layer.cornerRadius = 38
                    self.imgvwTakePic.layer.cornerRadius = 38
                    LogOutView.layer.cornerRadius = 21.5
                case "iPhone 6":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                    UploadView.layer.cornerRadius = 44
                    self.imgvwTakePic.layer.cornerRadius = 44
                    LogOutView.layer.cornerRadius = 21.5
                case "iPhone 6 Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                    UploadView.layer.cornerRadius = 47
                    self.imgvwTakePic.layer.cornerRadius = 47
                    LogOutView.layer.cornerRadius = 28
                case "iPhone 6s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                    UploadView.layer.cornerRadius = 44
                    self.imgvwTakePic.layer.cornerRadius = 44
                    LogOutView.layer.cornerRadius = 21.5
                case "iPhone 6s Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                    UploadView.layer.cornerRadius = 44
                    self.imgvwTakePic.layer.cornerRadius = 44
                    LogOutView.layer.cornerRadius = 21.5
                case "iPhone 7 Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                    UploadView.layer.cornerRadius = 48
                    self.imgvwTakePic.layer.cornerRadius = 44
                    LogOutView.layer.cornerRadius = 27.5
                //case "iPhone 8 Plus":
                    //UploadView.layer.cornerRadius = 48
                    //self.imgvwTakePic.layer.cornerRadius = 42
                    //LogOutView.layer.cornerRadius = 27.5
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.55*height);
                    //UploadView.layer.cornerRadius = 44
                    //self.imgvwTakePic.layer.cornerRadius = 44
                }
            }
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            
            //Boton Refresh
            ViewItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(vcGuestInHouseMain.clickHome(_:)))
            
            self.tabBarController?.tabBar.items?[0].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[0].title = NSLocalizedString("tabStay",comment:"")
            self.tabBarController?.tabBar.items?[1].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[1].title = NSLocalizedString("tabRequest",comment:"")
            self.tabBarController?.tabBar.items?[2].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[2].title = NSLocalizedString("tabActivity",comment:"")
            self.tabBarController?.tabBar.items?[3].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[3].title = NSLocalizedString("tabRestaurant",comment:"")
            self.tabBarController?.tabBar.items?[4].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[4].title = NSLocalizedString("tabNotification",comment:"")
            
            /*if (Gender=="FEMALE"){
                image = UIImage(named:"female_avatar.png")!
            }else{
                image = UIImage(named:"male_avatar.png")!
            }
            
            ImageView.image = image
            ImageView.layer.cornerRadius = 5
            
            ImageView.frame = CGRect(x: 0.05*self.width, y: 0.01*self.height, width: self.width/4.35, height: self.height/7.5);
            
            if appDelegate.ynIPad {
                switch appDelegate.Model {
                case "iPad 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                case "iPad Air":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                case "iPad Air 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                case "iPad Pro":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                case "iPad Retina":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                }
            }else{
                switch appDelegate.Model {
                case "iPhone":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.55*height);
                case "iPhone 4":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.55*height);
                case "iPhone 4s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.55*height);
                case "iPhone 5":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.57*height);
                case "iPhone 5c":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.57*height);
                case "iPhone 5s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.57*height);
                case "iPhone 6":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                case "iPhone 6 Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                case "iPhone 6s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                case "iPhone 6s Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.55*height);
                }
            }
            
            self.navigationController?.navigationBar.tintColor = colorWithHexString("0D94FC")
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            
            btnBack.frame = CGRect(x: 0.0, y: 0.12*height, width: 0.12*width, height: 0.06*height)
            btnBack.backgroundColor = UIColor.clear
            btnBack.setTitleColor(colorWithHexString("007AFF"), for: UIControl.State())
            btnBack.setTitle(NSLocalizedString("btnHome",comment:""), for:UIControl.State())
            btnBack.titleLabel?.font = UIFont(name: "Helvetica", size: appDelegate.gblFont9 + appDelegate.gblDeviceFont2)
            btnBack.titleLabel?.textAlignment = NSTextAlignment.left
            btnBack.titleLabel?.numberOfLines = 5
            btnBack.layer.borderColor = UIColor.clear.cgColor
            
            //var btnimage: UIImage!
            
            //btnimage = UIImage(named: imgArrow) as UIImage!
            
            //btnimage = UIImage(named:"ic_navigate_before.png")!
            
            //btnBack.setImage(btnimage, for: UIControlState())
            btnBack.addTarget(self, action: #selector(vcGuestInHouseMain.clickLogout(_:)), for: UIControl.Event.touchUpInside)
            
            btnHome.customView = btnBack
            btnHome.customView?.sizeToFit()

            btnLogOut.frame = CGRect(x: 0.35*width, y: 0.14*height, width: 0.3*width, height: 0.03*height);
            btnLogOut.backgroundColor = colorWithHexString("E01C0F")
            btnLogOut.layer.cornerRadius = 5
            let mas = NSMutableAttributedString(string: NSLocalizedString("btnLogOut",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:"Helvetica", size:appDelegate.gblFont6 + appDelegate.gblDeviceFont6)!,
                NSAttributedString.Key.foregroundColor: UIColor.white
                ])
            btnLogOut.setAttributedTitle(mas, for: UIControl.State())
            btnLogOut.addTarget(self, action: #selector(vcGuestInHouseMain.LogOUT(_:)), for: UIControl.Event.touchUpInside)
            UserView.addSubview(btnLogOut)
            
            //Boton Refresh
            ViewItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(vcGuestInHouseMain.clickHome(_:)))
            
            self.tabBarController?.tabBar.items?[0].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[0].title = NSLocalizedString("tabStay",comment:"")
            self.tabBarController?.tabBar.items?[1].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[1].title = NSLocalizedString("tabRequest",comment:"")
            self.tabBarController?.tabBar.items?[2].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[2].title = NSLocalizedString("tabActivity",comment:"")
            self.tabBarController?.tabBar.items?[3].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[3].title = NSLocalizedString("tabRestaurant",comment:"")
            self.tabBarController?.tabBar.items?[4].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[4].title = NSLocalizedString("tabNotification",comment:"")*/
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            var strFont: String = ""
            
            strFont = "HelveticaNeue"
            
            self.view.backgroundColor = UIColor.white//colorWithHexString ("DDF4FF")
            
            bodyView.isHidden = false
            UserView.isHidden = true
            //ImageView.hidden = true
            //lblName.hidden = true
            //lblGuestType.hidden = true
            //lblEmail.hidden = true
            //btnLogOut.hidden = true
            
            btnBack.frame = CGRect(x: 0.0, y: 0.12*height, width: 0.12*width, height: 0.06*height)
            btnBack.backgroundColor = UIColor.clear
            btnBack.setTitleColor(colorWithHexString("FFF8F0"), for: UIControl.State())
            btnBack.setTitle(NSLocalizedString("btnHome",comment:""), for:UIControl.State())
            btnBack.titleLabel?.font = UIFont(name: strFont, size: appDelegate.gblFont10 + appDelegate.gblDeviceFont2)
            btnBack.titleLabel?.textAlignment = NSTextAlignment.left
            btnBack.titleLabel?.numberOfLines = 5
            btnBack.layer.borderColor = UIColor.clear.cgColor
            
            btnBack.addTarget(self, action: #selector(vcGuestInHouseMain.clickLogout(_:)), for: UIControl.Event.touchUpInside)
            
            btnHome.customView = btnBack
            btnHome.customView?.sizeToFit()
            
            var img = UIImage(named:appDelegate.gstrNavImg)
            var resizable = img!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
            self.navigationController?.navigationBar.setBackgroundImage(resizable, for: .default)
            let navigationTitleFont = UIFont(name: strFont, size: appDelegate.gblFont10 + appDelegate.gblDeviceFont3)!
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationTitleFont]
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.alpha = 0.99
            self.navigationController?.navigationBar.tintColor = UIColor.white
            for parent in self.navigationController!.navigationBar.subviews {
                for childView in parent.subviews {
                    if(childView is UIImageView) {
                        childView.removeFromSuperview()
                    }
                }
            }
            
            imgBack = UIImage(named:"bg.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: -0.05*height, width: width, height: height+(0.05*height));
            imgvwBack.alpha = 0.3
            imgvwBack.contentMode = UIView.ContentMode.scaleAspectFill
            //self.view.addSubview(imgvwBack)
            
            var queueFM: FMDatabaseQueue?
            
            queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
            
            var correctPicture: Data? = nil
            
            queueFM?.inDatabase() {
                db in
                
                if let rs = db.executeQuery("SELECT UserImg FROM tblLogin WHERE PersonalID = ?", withArgumentsIn:[self.PersonalID]) {
                    while rs.next() {
                        correctPicture = rs.data(forColumn: "UserImg")
                    }
                } else {
                    print("select failure: \(db.lastErrorMessage())")
                }
            }
            
            if correctPicture != nil {
                
                btnUploadImg.setBackgroundImage(imgTakePic, for: UIControl.State())
                btnUploadImg.addTarget(self, action: #selector(vcGuestInHouseMain.buttonActionTakePicture(_:)), for: UIControl.Event.touchUpInside)
                btnUploadImg.frame = CGRect(x: 0.025*width, y: 0.1*height, width: 0.2*width, height: 0.1*height);
                btnUploadImg.setTitleColor(colorWithHexString("5d5854"), for: UIControl.State())
                btnUploadImg.setTitle(NSLocalizedString("lblUpload",comment:""), for:UIControl.State())
                btnUploadImg.titleLabel?.font = UIFont(name: strFont, size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
                btnUploadImg.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
                btnUploadImg.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -45, right: 0)
                btnUploadImg.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
                self.view.addSubview(btnUploadImg)
                
                self.imgvwTakePic = UIImageView(image: UIImage(data: correctPicture!))
                self.imgvwTakePic.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: 0.2*self.width, height: 0.15*self.height);
                self.imgvwTakePic.layer.cornerRadius = 41.4
                self.imgvwTakePic.clipsToBounds = true
                self.view.addSubview(self.imgvwTakePic)
            }else{
                imgTakePic = UIImage(named:"TomarFoto.png")!
                
                btnUploadImg.setBackgroundImage(imgTakePic, for: UIControl.State())
                btnUploadImg.addTarget(self, action: #selector(vcGuestInHouseMain.buttonActionTakePicture(_:)), for: UIControl.Event.touchUpInside)
                if appDelegate.ynIPad == true{
                    btnUploadImg.frame = CGRect(x: 0.003*width, y: 0.005*height, width: 0.2*width, height: 0.12*height);
                    btnUploadImg.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -80, right: 0)
                }else{
                    btnUploadImg.frame = CGRect(x: 0.015*width, y: 0.005*height, width: 0.2*width, height: 0.1*height);
                    btnUploadImg.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -45, right: 0)
                }
                
                //btnUploadImg.setTitleColor(colorWithHexString("00467f"), forState: UIControlState.Normal)
                btnUploadImg.setTitleColor(UIColor.black, for: UIControl.State())
                btnUploadImg.setTitle(NSLocalizedString("lblUpload",comment:""), for:UIControl.State())
                btnUploadImg.titleLabel?.font = UIFont(name: strFont, size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
                btnUploadImg.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
                btnUploadImg.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
                btnUploadImg.alpha = 0.5
                
                UploadView.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/4.35, height: self.height/7.5);
                UploadView.layer.cornerRadius = 44
                UploadView.clipsToBounds = true
                UploadView.layer.borderWidth = 4
                UploadView.layer.borderColor = colorWithHexString("7c6a56").cgColor//colorWithHexString("94cce5").CGColor
                UploadView.backgroundColor = colorWithHexString("eee7dd")//colorWithHexString("ddf4ff")
                appDelegate.gstrBorderColorImg = "675040"
                UploadView.addSubview(btnUploadImg)
                self.view.addSubview(UploadView)
            }
            
            imgOut = UIImage(named:"signout.png")!
            btnLogOut.setBackgroundImage(imgOut, for: UIControl.State())
            
            /*imgOut = UIImage(named:"signoutsel.png")!
             btnLogOut.setImage(imgOut, forState: UIControlState.Highlighted)*/
            
            btnLogOut.addTarget(self, action: #selector(vcGuestInHouseMain.LogOUT(_:)), for: UIControl.Event.touchUpInside)
            btnLogOut.addTarget(self, action: #selector(vcGuestInHouseMain.butonSignOutEfect(_:)), for: UIControl.Event.touchDown)
            if appDelegate.ynIPad == true{
                btnLogOut.frame = CGRect(x: 0.004*width, y: 0.001*height, width: 0.12*width, height: 0.07*height);
                btnLogOut.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -60, right: 0)
            }else{
                btnLogOut.frame = CGRect(x: 0.008*width, y: 0.001*height, width: 0.12*width, height: 0.06*height);
                btnLogOut.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -33, right: 0)
            }
            btnLogOut.setTitleColor(colorWithHexString("5d5854"), for: UIControl.State())
            btnLogOut.setTitle(NSLocalizedString("btnLogOut",comment:""), for:UIControl.State())
            btnLogOut.titleLabel?.font = UIFont(name: strFont, size: (appDelegate.gblFont1) + appDelegate.gblDeviceFont1)
            btnLogOut.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            btnLogOut.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            btnLogOut.alpha = 0.6
            //self.view.addSubview(btnLogOut)
            
            LogOutView.frame = CGRect(x: 0.81*width, y: 0.08*height, width: self.width/7.6, height: self.height/13);
            LogOutView.layer.cornerRadius = 25.5
            LogOutView.clipsToBounds = true
            //LogOutView.backgroundColor = UIColor.redColor()
            LogOutView.layer.borderWidth = 4
            LogOutView.layer.borderColor = colorWithHexString("7c6a56").cgColor
            LogOutView.backgroundColor = colorWithHexString("eee7dd")
            LogOutView.addSubview(btnLogOut)
            self.view.addSubview(LogOutView)
            
            lblName.frame = CGRect(x: 0.32*width, y: 0.09*height, width: 0.5*width, height: 0.12*height);
            lblGuestType.frame = CGRect(x: 0.32*width, y: 0.175*height, width: 0.6*width, height: 0.03*height);
            lblEmail.frame = CGRect(x: 0.32*width, y: 0.215*height, width: 0.6*width, height: 0.03*height);
            
            lblName.textColor = colorWithHexString("ba8748")
            lblGuestType.textColor = colorWithHexString("b28564")
            lblEmail.textColor = colorWithHexString("b28564")
            
            lblName.textAlignment = NSTextAlignment.left
            lblGuestType.textAlignment = NSTextAlignment.left
            lblEmail.textAlignment = NSTextAlignment.left
            
            lblName.font = UIFont(name:strFont, size:appDelegate.gblFont9 + appDelegate.gblDeviceFont5)
            lblEmail.font = UIFont(name:strFont, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont2)
            lblGuestType.font = UIFont(name:strFont, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont2)
            
            lblName.numberOfLines = 2
            lblName.sizeToFit()
            
            lblGuestType.numberOfLines = 1
            lblGuestType.sizeToFit()
            
            lblEmail.numberOfLines = 1
            lblEmail.sizeToFit()
            
            self.view.addSubview(lblName)
            self.view.addSubview(lblGuestType)
            self.view.addSubview(lblEmail)
            
            if appDelegate.ynIPad {
                switch appDelegate.Model {
                case "iPad 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                    UploadView.layer.cornerRadius = 75
                    UploadView.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    LogOutView.layer.cornerRadius = 46
                    LogOutView.frame = CGRect(x: 0.81*width, y: 0.08*height, width: self.width/8.1, height: self.height/11);
                    self.imgvwTakePic.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    self.imgvwTakePic.layer.cornerRadius = 75
                case "iPad Air":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                    UploadView.layer.cornerRadius = 75
                    UploadView.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    LogOutView.layer.cornerRadius = 46
                    LogOutView.frame = CGRect(x: 0.81*width, y: 0.08*height, width: self.width/8.1, height: self.height/11);
                    self.imgvwTakePic.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    self.imgvwTakePic.layer.cornerRadius = 75
                case "iPad Air 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                    UploadView.layer.cornerRadius = 75
                    UploadView.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    LogOutView.layer.cornerRadius = 46
                    LogOutView.frame = CGRect(x: 0.81*width, y: 0.08*height, width: self.width/8.1, height: self.height/11);
                    self.imgvwTakePic.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    self.imgvwTakePic.layer.cornerRadius = 75
                case "iPad Pro":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                    UploadView.layer.cornerRadius = 75
                    UploadView.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    LogOutView.layer.cornerRadius = 46
                    LogOutView.frame = CGRect(x: 0.81*width, y: 0.08*height, width: self.width/8.1, height: self.height/11);
                    self.imgvwTakePic.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    self.imgvwTakePic.layer.cornerRadius = 75
                case "iPad Retina":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                    UploadView.layer.cornerRadius = 75
                    UploadView.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    LogOutView.layer.cornerRadius = 46
                    LogOutView.frame = CGRect(x: 0.81*width, y: 0.08*height, width: self.width/8.1, height: self.height/11);
                    self.imgvwTakePic.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    self.imgvwTakePic.layer.cornerRadius = 75
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                    UploadView.layer.cornerRadius = 75
                    UploadView.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    LogOutView.layer.cornerRadius = 46
                    LogOutView.frame = CGRect(x: 0.81*width, y: 0.08*height, width: self.width/8.1, height: self.height/11);
                    self.imgvwTakePic.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: self.width/5, height: self.height/6.5);
                    self.imgvwTakePic.layer.cornerRadius = 75
                }
            }else{
                switch appDelegate.Model {
                case "iPhone":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.55*height);
                    UploadView.layer.cornerRadius = 38
                    self.imgvwTakePic.layer.cornerRadius = 38
                case "iPhone 4":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.55*height);
                    UploadView.layer.cornerRadius = 38
                    self.imgvwTakePic.layer.cornerRadius = 38
                case "iPhone 4s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.55*height);
                    UploadView.layer.cornerRadius = 38
                    self.imgvwTakePic.layer.cornerRadius = 38
                case "iPhone 5":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.57*height);
                    UploadView.layer.cornerRadius = 38
                    self.imgvwTakePic.layer.cornerRadius = 38
                    LogOutView.layer.cornerRadius = 21.5
                    btnUploadImg.titleLabel?.font = UIFont(name: strFont, size: appDelegate.gblFont1 + appDelegate.gblDeviceFont3)
                case "iPhone 5c":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.57*height);
                    UploadView.layer.cornerRadius = 38
                    self.imgvwTakePic.layer.cornerRadius = 38
                    LogOutView.layer.cornerRadius = 21.5
                case "iPhone 5s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.57*height);
                    UploadView.layer.cornerRadius = 38
                    self.imgvwTakePic.layer.cornerRadius = 38
                    LogOutView.layer.cornerRadius = 21.5
                case "iPhone 6":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                    UploadView.layer.cornerRadius = 44
                    self.imgvwTakePic.layer.cornerRadius = 44
                    LogOutView.layer.cornerRadius = 21.5
                case "iPhone 6 Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                    UploadView.layer.cornerRadius = 47
                    self.imgvwTakePic.layer.cornerRadius = 47
                    LogOutView.layer.cornerRadius = 28
                case "iPhone 6s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                    UploadView.layer.cornerRadius = 44
                    self.imgvwTakePic.layer.cornerRadius = 44
                    LogOutView.layer.cornerRadius = 21.5
                case "iPhone 6s Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                    UploadView.layer.cornerRadius = 44
                    self.imgvwTakePic.layer.cornerRadius = 44
                    LogOutView.layer.cornerRadius = 21.5
                case "iPhone 7 Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                    UploadView.layer.cornerRadius = 48
                    self.imgvwTakePic.layer.cornerRadius = 48
                    LogOutView.layer.cornerRadius = 27.5
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.55*height);
                    UploadView.layer.cornerRadius = 44
                    self.imgvwTakePic.layer.cornerRadius = 44
                }
            }
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            
            //Boton Refresh
            ViewItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(vcGuestInHouseMain.clickHome(_:)))
            
            let imgtabbar = UIImage(named:"TabBar.png")
            let resizable2 = imgtabbar!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
            self.tabBarController?.tabBar.backgroundImage = resizable2
            let TabTitleFont = UIFont(name: strFont, size: appDelegate.gblFont5 + appDelegate.gblDeviceFont)!
            self.tabBarController?.tabBar.tintColor = UIColor.white
            self.tabBarController?.tabBar.barTintColor = UIColor.white
            
            self.tabBarController!.tabBar.layer.borderWidth = 0.001
            self.tabBarController!.tabBar.layer.borderColor = UIColor.white.cgColor
            self.tabBarController?.tabBar.clipsToBounds = true
            
            self.tabBarController?.tabBar.items?[0].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[0].title = NSLocalizedString("tabStay",comment:"")
            self.tabBarController?.tabBar.items?[0].titlePositionAdjustment = UIOffset(horizontal: 0,vertical: -5)
            self.tabBarController?.tabBar.items?[0].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: colorWithHexString("ba8748")], for: UIControl.State())
            self.tabBarController?.tabBar.items?[0].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
            
            self.tabBarController?.tabBar.items?[1].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[1].title = NSLocalizedString("tabRequest",comment:"")
            self.tabBarController?.tabBar.items?[1].titlePositionAdjustment = UIOffset(horizontal: 0,vertical: -5)
            self.tabBarController?.tabBar.items?[1].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: colorWithHexString("ba8748")], for: UIControl.State())
            self.tabBarController?.tabBar.items?[1].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
            
            self.tabBarController?.tabBar.items?[2].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[2].title = NSLocalizedString("tabActivity",comment:"")
            self.tabBarController?.tabBar.items?[2].titlePositionAdjustment = UIOffset(horizontal: 0,vertical: -5)
            self.tabBarController?.tabBar.items?[2].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: colorWithHexString("ba8748")], for: UIControl.State())
            self.tabBarController?.tabBar.items?[2].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
            
            self.tabBarController?.tabBar.items?[3].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[3].title = NSLocalizedString("tabRestaurant",comment:"")
            self.tabBarController?.tabBar.items?[3].titlePositionAdjustment = UIOffset(horizontal: 0,vertical: -5)
            self.tabBarController?.tabBar.items?[3].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: colorWithHexString("ba8748")], for: UIControl.State())
            self.tabBarController?.tabBar.items?[3].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
            
            self.tabBarController?.tabBar.items?[4].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[4].title = NSLocalizedString("tabNotification",comment:"")
            self.tabBarController?.tabBar.items?[4].titlePositionAdjustment = UIOffset(horizontal: 0,vertical: -5)
            self.tabBarController?.tabBar.items?[4].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: colorWithHexString("ba8748")], for: UIControl.State())
            self.tabBarController?.tabBar.items?[4].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
            
            for item in (self.tabBarController?.tabBar.items)! as [UITabBarItem] {
                if let image = item.image {
                    item.image = image.imageWithColor(colorWithHexString("ba8748")).withRenderingMode(.alwaysOriginal)
                }
            }
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            var strFont: String = ""
            
            strFont = "HelveticaNeue"

            self.view.backgroundColor = UIColor.white//colorWithHexString ("DDF4FF")
            
            bodyView.isHidden = false
            UserView.isHidden = true
            ImageView.isHidden = true
            //lblName.hidden = true
            //lblGuestType.hidden = true
            //lblEmail.hidden = true
            //btnLogOut.hidden = true
            
            btnBack.frame = CGRect(x: 0.0, y: 0.12*height, width: 0.12*width, height: 0.06*height)
            btnBack.backgroundColor = UIColor.clear
            btnBack.setTitleColor(colorWithHexString("FFF8F0"), for: UIControl.State())
            btnBack.setTitle(NSLocalizedString("btnHome",comment:""), for:UIControl.State())
            btnBack.titleLabel?.font = UIFont(name: strFont, size: appDelegate.gblFont10 + appDelegate.gblDeviceFont2)
            btnBack.titleLabel?.textAlignment = NSTextAlignment.left
            btnBack.titleLabel?.numberOfLines = 5
            btnBack.layer.borderColor = UIColor.clear.cgColor

            btnBack.addTarget(self, action: #selector(vcGuestInHouseMain.clickLogout(_:)), for: UIControl.Event.touchUpInside)
            
            btnHome.customView = btnBack
            btnHome.customView?.sizeToFit()
            
            var img = UIImage(named:appDelegate.gstrNavImg)
            var resizable = img!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
            self.navigationController?.navigationBar.setBackgroundImage(resizable, for: .default)
            let navigationTitleFont = UIFont(name: strFont, size: appDelegate.gblFont10 + appDelegate.gblDeviceFont3)!
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationTitleFont]
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.alpha = 0.99
            self.navigationController?.navigationBar.tintColor = UIColor.white
            for parent in self.navigationController!.navigationBar.subviews {
                for childView in parent.subviews {
                    if(childView is UIImageView) {
                        childView.removeFromSuperview()
                    }
                }
            }
            
            imgBack = UIImage(named:"bg.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: -0.05*height, width: width, height: height+(0.05*height));
            imgvwBack.alpha = 0.3
            imgvwBack.contentMode = UIView.ContentMode.scaleAspectFill
            //self.view.addSubview(imgvwBack)
            
            var queueFM: FMDatabaseQueue?
            
            queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
            
            var correctPicture: Data? = nil
            
            queueFM?.inDatabase() {
                db in
                
                if let rs = db.executeQuery("SELECT UserImg FROM tblLogin WHERE PersonalID = ?", withArgumentsIn:[self.PersonalID]) {
                    while rs.next() {
                        correctPicture = rs.data(forColumn: "UserImg")
                    }
                } else {
                    print("select failure: \(db.lastErrorMessage())")
                }
            }
            
            if correctPicture != nil {
                
                btnUploadImg.setBackgroundImage(imgTakePic, for: UIControl.State())
                btnUploadImg.addTarget(self, action: #selector(vcGuestInHouseMain.buttonActionTakePicture(_:)), for: UIControl.Event.touchUpInside)
                btnUploadImg.frame = CGRect(x: 0.025*width, y: 0.1*height, width: 0.2*width, height: 0.1*height);
                btnUploadImg.setTitleColor(colorWithHexString("000000"), for: UIControl.State())
                btnUploadImg.setTitle(NSLocalizedString("lblUpload",comment:""), for:UIControl.State())
                btnUploadImg.titleLabel?.font = UIFont(name: strFont, size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
                btnUploadImg.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
                btnUploadImg.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -45, right: 0)
                btnUploadImg.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
                self.view.addSubview(btnUploadImg)
                
                self.imgvwTakePic = UIImageView(image: UIImage(data: correctPicture!))
                self.imgvwTakePic.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: 0.2*self.width, height: 0.15*self.height);
                self.imgvwTakePic.layer.cornerRadius = 41.4
                self.imgvwTakePic.clipsToBounds = true
                self.view.addSubview(self.imgvwTakePic)
            }else{
                imgTakePic = UIImage(named:"TomarFoto.png")!
                
                btnUploadImg.setBackgroundImage(imgTakePic, for: UIControl.State())
                btnUploadImg.addTarget(self, action: #selector(vcGuestInHouseMain.buttonActionTakePicture(_:)), for: UIControl.Event.touchUpInside)
                if appDelegate.ynIPad == true{
                    btnUploadImg.frame = CGRect(x: 0.025*width, y: 0.015*height, width: 0.2*width, height: 0.12*height);
                    btnUploadImg.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -80, right: 0)
                }else{
                    btnUploadImg.frame = CGRect(x: 0.025*width, y: 0.015*height, width: 0.2*width, height: 0.1*height);
                    btnUploadImg.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -45, right: 0)
                }

                //btnUploadImg.setTitleColor(colorWithHexString("00467f"), forState: UIControlState.Normal)
                btnUploadImg.setTitleColor(UIColor.black, for: UIControl.State())
                btnUploadImg.setTitle(NSLocalizedString("lblUpload",comment:""), for:UIControl.State())
                btnUploadImg.titleLabel?.font = UIFont(name: strFont, size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
                btnUploadImg.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
                btnUploadImg.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
                btnUploadImg.alpha = 0.5
                
                UploadView.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: 0.2*self.width, height: 0.15*self.height);
                UploadView.layer.cornerRadius = 41.4
                UploadView.clipsToBounds = true
                UploadView.layer.borderWidth = 4
                UploadView.layer.borderColor = colorWithHexString("a18015").cgColor//colorWithHexString("94cce5").CGColor
                UploadView.backgroundColor = colorWithHexString("c39b1a")//colorWithHexString("ddf4ff")
                appDelegate.gstrBorderColorImg = "f29301"
                UploadView.addSubview(btnUploadImg)
                self.view.addSubview(UploadView)
           }
            
            imgOut = UIImage(named:"signout.png")!
            btnLogOut.setBackgroundImage(imgOut, for: UIControl.State())
            
            /*imgOut = UIImage(named:"signoutsel.png")!
            btnLogOut.setImage(imgOut, forState: UIControlState.Highlighted)*/
            
            btnLogOut.addTarget(self, action: #selector(vcGuestInHouseMain.LogOUT(_:)), for: UIControl.Event.touchUpInside)
            btnLogOut.addTarget(self, action: #selector(vcGuestInHouseMain.butonSignOutEfect(_:)), for: UIControl.Event.touchDown)
            if appDelegate.ynIPad == true{
                btnLogOut.frame = CGRect(x: 0.02*width, y: 0.001*height, width: 0.12*width, height: 0.07*height);
                btnLogOut.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -60, right: 0)
            }else{
                btnLogOut.frame = CGRect(x: 0.02*width, y: 0.001*height, width: 0.12*width, height: 0.06*height);
                btnLogOut.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -33, right: 0)
            }
            btnLogOut.setTitleColor(UIColor.black, for: UIControl.State())
            btnLogOut.setTitle(NSLocalizedString("btnLogOut",comment:""), for:UIControl.State())
            btnLogOut.titleLabel?.font = UIFont(name: strFont, size: (appDelegate.gblFont0) + appDelegate.gblDeviceFont3)
            btnLogOut.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            btnLogOut.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            btnLogOut.alpha = 0.5
            //self.view.addSubview(btnLogOut)
            
            LogOutView.frame = CGRect(x: 0.81*width, y: 0.08*height, width: 0.1562*self.width, height: 0.0881*self.height);
            LogOutView.layer.cornerRadius = 25
            LogOutView.clipsToBounds = true
            //LogOutView.backgroundColor = UIColor.redColor()
            LogOutView.layer.borderWidth = 4
            LogOutView.layer.borderColor = colorWithHexString("a18015").cgColor
            LogOutView.backgroundColor = colorWithHexString("c39b1a")
            LogOutView.addSubview(btnLogOut)
            self.view.addSubview(LogOutView)
            
            lblName.frame = CGRect(x: 0.32*width, y: 0.09*height, width: 0.5*width, height: 0.12*height);
            lblGuestType.frame = CGRect(x: 0.32*width, y: 0.175*height, width: 0.6*width, height: 0.03*height);
            lblEmail.frame = CGRect(x: 0.32*width, y: 0.215*height, width: 0.6*width, height: 0.03*height);
            
            lblName.textColor = colorWithHexString("00467f")
            lblGuestType.textColor = colorWithHexString("00467f")
            lblEmail.textColor = colorWithHexString("00467f")
            
            lblName.textAlignment = NSTextAlignment.left
            lblGuestType.textAlignment = NSTextAlignment.left
            lblEmail.textAlignment = NSTextAlignment.left

            lblName.font = UIFont(name:strFont, size:appDelegate.gblFont9 + appDelegate.gblDeviceFont5)
            lblEmail.font = UIFont(name:strFont, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont2)
            lblGuestType.font = UIFont(name:strFont, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont2)
            
            lblName.numberOfLines = 2
            lblName.sizeToFit()
            
            lblGuestType.numberOfLines = 1
            lblGuestType.sizeToFit()
            
            lblEmail.numberOfLines = 1
            lblEmail.sizeToFit()
            
            self.view.addSubview(lblName)
            self.view.addSubview(lblGuestType)
            self.view.addSubview(lblEmail)
            
            if appDelegate.ynIPad {
                switch appDelegate.Model {
                case "iPad 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                case "iPad Air":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                case "iPad Air 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                case "iPad Pro":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                case "iPad Retina":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.63*height);
                }
            }else{
                switch appDelegate.Model {
                case "iPhone":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.55*height);
                case "iPhone 4":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.55*height);
                case "iPhone 4s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.55*height);
                case "iPhone 5":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.57*height);
                case "iPhone 5c":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.57*height);
                case "iPhone 5s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.57*height);
                case "iPhone 6":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                case "iPhone 6 Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                case "iPhone 6s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                case "iPhone 6s Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.6*height);
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.55*height);
                }
            }
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

            //Boton Refresh
            ViewItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(vcGuestInHouseMain.clickHome(_:)))
            
            let imgtabbar = UIImage(named:"tabbar.png")
            let resizable2 = imgtabbar!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
            self.tabBarController?.tabBar.backgroundImage = resizable2
            let TabTitleFont = UIFont(name: strFont, size: appDelegate.gblFont5 + appDelegate.gblDeviceFont)!
            self.tabBarController?.tabBar.tintColor = UIColor.white
            self.tabBarController?.tabBar.barTintColor = UIColor.white
            
            self.tabBarController!.tabBar.layer.borderWidth = 0.001
            self.tabBarController!.tabBar.layer.borderColor = UIColor.white.cgColor
            self.tabBarController?.tabBar.clipsToBounds = true
            
            self.tabBarController?.tabBar.items?[0].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[0].title = NSLocalizedString("tabStay",comment:"")
            self.tabBarController?.tabBar.items?[0].titlePositionAdjustment = UIOffset(horizontal: 0,vertical: -5)
            self.tabBarController?.tabBar.items?[0].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: colorWithHexString("5fa0ca")], for: UIControl.State())
            self.tabBarController?.tabBar.items?[0].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
            
            self.tabBarController?.tabBar.items?[1].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[1].title = NSLocalizedString("tabRequest",comment:"")
            self.tabBarController?.tabBar.items?[1].titlePositionAdjustment = UIOffset(horizontal: 0,vertical: -5)
            self.tabBarController?.tabBar.items?[1].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: colorWithHexString("5fa0ca")], for: UIControl.State())
            self.tabBarController?.tabBar.items?[1].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
            
            self.tabBarController?.tabBar.items?[2].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[2].title = NSLocalizedString("tabActivity",comment:"")
            self.tabBarController?.tabBar.items?[2].titlePositionAdjustment = UIOffset(horizontal: 0,vertical: -5)
            self.tabBarController?.tabBar.items?[2].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: colorWithHexString("5fa0ca")], for: UIControl.State())
            self.tabBarController?.tabBar.items?[2].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
            
            self.tabBarController?.tabBar.items?[3].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[3].title = NSLocalizedString("tabRestaurant",comment:"")
            self.tabBarController?.tabBar.items?[3].titlePositionAdjustment = UIOffset(horizontal: 0,vertical: -5)
            self.tabBarController?.tabBar.items?[3].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: colorWithHexString("5fa0ca")], for: UIControl.State())
            self.tabBarController?.tabBar.items?[3].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
            
            self.tabBarController?.tabBar.items?[4].isEnabled = appDelegate.ynTabsEnabled
            self.tabBarController?.tabBar.items?[4].title = NSLocalizedString("tabNotification",comment:"")
            self.tabBarController?.tabBar.items?[4].titlePositionAdjustment = UIOffset(horizontal: 0,vertical: -5)
            self.tabBarController?.tabBar.items?[4].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: colorWithHexString("5fa0ca")], for: UIControl.State())
            self.tabBarController?.tabBar.items?[4].setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
            
            for item in (self.tabBarController?.tabBar.items)! as [UITabBarItem] {
                if let image = item.image {
                    item.image = image.imageWithColor(colorWithHexString("5fa0ca")).withRenderingMode(.alwaysOriginal)
                }
            }
            
        }
        
        if (LastStayUpdate != "")
        {
            
            let todaysDate:Date = Date()
            let dtdateFormatter:DateFormatter = DateFormatter()
            dtdateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
            let DateInFormat:String = dtdateFormatter.string(from: todaysDate)
            
            let startDate = moment(LastStayUpdate)
            let endDate = moment(DateInFormat)
            
            let cal = Calendar.current
            
            let unit:NSCalendar.Unit = [.hour]
            
            let components = (cal as NSCalendar).components(unit, from: startDate!.date, to: endDate!.date, options: [])
            
            iHour = components.hour!

            if (iHour >= 2){
                ynActualiza = true
                recargarTablas()
            }else{
                ynActualiza = true
                recargarTablas()
            }
            
        }else{
            ynActualiza = true
            recargarTablas()
        }
        
        Analytics.setScreenName("Stay", screenClass: appDelegate.gstrAppName)
        
        print("***Token***")
        print(self.appDelegate.gstrToken)
    }
    
    func imageTapped()
    {
        
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcNotification") as! vcNotification
        appDelegate.gblNotification = true
        self.navigationController?.pushViewController(tercerViewController, animated: true)
    }
    
    @objc func butonSignOutEfect(_ sender: AnyObject)
    {
        
        self.LogOutView.layer.borderWidth = 4
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            self.LogOutView.layer.borderColor = self.colorWithHexString("87878e").cgColor
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            self.LogOutView.layer.borderColor = self.colorWithHexString("675040").cgColor
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{

            self.LogOutView.layer.borderColor = self.colorWithHexString("786010").cgColor
            
        }
    }
    
    @objc func buttonActionTakePicture(_ sender: AnyObject) {

        self.UploadView.layer.borderWidth = 4

        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            self.UploadView .layer.borderColor = self.colorWithHexString("87878e").cgColor
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            self.UploadView .layer.borderColor = self.colorWithHexString("675040").cgColor
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            self.UploadView .layer.borderColor = self.colorWithHexString("786010").cgColor
            
        }
        
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let cameraAction = UIAlertAction(title: NSLocalizedString("Camera",comment:""), style: UIAlertAction.Style.default)
        {
            
            UIAlertAction in
            self.openCamera()

        }
        let gallaryAction = UIAlertAction(title: NSLocalizedString("Gallery",comment:""), style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallary()

        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel",comment:""), style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
            
            self.UploadView.layer.borderWidth = 3
            
            if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                
                self.UploadView.layer.borderColor = self.colorWithHexString("87878e").cgColor
                
            }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                
                self.UploadView.layer.borderColor = self.colorWithHexString("7c6a56").cgColor
                
            }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                
                self.UploadView.layer.borderColor = self.colorWithHexString("a18015").cgColor
                
            }
            
        }
        
        alert.popoverPresentationController?.sourceView = view
        alert.popoverPresentationController?.sourceRect = view.frame
        
        // Add the actions
        picker?.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)

        // Present the controller
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let popover : UIPopoverController?
            popover=UIPopoverController(contentViewController: alert)
            popover!.present(from: btnUploadImg.frame, in: self.view, permittedArrowDirections: UIPopoverArrowDirection.any, animated: true)
        }
 
    }
    
    func openCamera()
    {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            ynCamera = true
            
            if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
                
                picker!.sourceType = UIImagePickerController.SourceType.camera
                self.present(picker!, animated: true, completion: nil)
            } else {
                AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                    if granted {
                        self.picker!.sourceType = UIImagePickerController.SourceType.camera
                        self.present(self.picker!, animated: true, completion: nil)
                    } else {
                        self.picker!.dismiss(animated: false, completion: nil)
                    }
                })
            }

        }
        else
        {
            openGallary()
        }
    }

    func openGallary()
    {
        ynCamera = false
        
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(picker!, animated: true, completion: nil)
        case .denied, .restricted:
            picker!.dismiss(animated: false, completion: nil)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                guard status == .authorized else {
                    self.picker!.dismiss(animated: false, completion: nil)
                    return
                }
                self.picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(self.picker!, animated: true, completion: nil)
            }
        }

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
        picker.dismiss(animated: false, completion: nil)
        
        var array = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!.pngData()
       
        if (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!.imageOrientation == UIImage.Orientation.up && ynCamera == false
        {
            
            array = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!.pngData()
            
        }else{

            array = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!.imageRotatedByDegrees(90, flip: false).pngData()
        
        }
        
        if ynCamera{
            array = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!.imageRotatedByDegrees(90, flip: false).pngData()
        }
        
        ynCamera = false
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        queueFM?.inTransaction() {
            db, rollback in
            
            if (db.executeUpdate("UPDATE tblLogin SET UserImg=? WHERE PersonalID=?", withArgumentsIn: [array!,self.PersonalID])) {
                
            }
            
        }
        
        var correctPicture: Data? = nil
        
        queueFM?.inDatabase() {
            db in
            
            if let rs = db.executeQuery("SELECT UserImg FROM tblLogin WHERE PersonalID = ?", withArgumentsIn:[self.PersonalID]) {
                while rs.next() {
                    correctPicture = rs.data(forColumn: "UserImg")
                }
            } else {
                print("select failure: \(db.lastErrorMessage())")
            }
        }
        
        if correctPicture != nil {
            self.imgvwTakePic = UIImageView(image: UIImage(data: correctPicture!))

            if appDelegate.ynIPad == true {
                self.imgvwTakePic.frame = CGRect(x: 0.05*self.width, y: 0.08*self.height, width: 0.21*self.width, height: 0.16*self.height);
                self.imgvwTakePic.layer.cornerRadius = 79
            }
            else{
                self.imgvwTakePic.frame = CGRect(x: 0.037*self.width, y: 0.08*self.height, width: 0.23*self.width, height: 0.13*self.height);
                self.imgvwTakePic.layer.cornerRadius = 41
            }

            //imgvwTakePic.removeFromSuperview()
            //UploadView.removeFromSuperview()
            
            self.imgvwTakePic.clipsToBounds = true
            self.view.addSubview(self.imgvwTakePic)
        }
        self.UploadView.layer.borderWidth = 3
        if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            self.UploadView .layer.borderColor = self.colorWithHexString("616167").cgColor
            
        }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            self.UploadView .layer.borderColor = self.colorWithHexString("7c6a56").cgColor
            
        }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            self.UploadView .layer.borderColor = self.colorWithHexString("a18015").cgColor
            
        }
    
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.UploadView.layer.borderWidth = 3
        if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            self.UploadView .layer.borderColor = self.colorWithHexString("616167").cgColor
            
        }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            self.UploadView .layer.borderColor = self.colorWithHexString("7c6a56").cgColor
            
        }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            self.UploadView .layer.borderColor = self.colorWithHexString("a18015").cgColor
            
        }
        print("picker cancel.")
        picker.dismiss(animated: true, completion: nil)

    }
    
    func recargarTablas(){
    
        ViewItem.rightBarButtonItem?.isEnabled = false
        self.tableView.isUserInteractionEnabled = false
        app.beginIgnoringInteractionEvents()
        
        var tableItems = RRDataSet()
        var iRes: String = ""
        
        var resultStayID: Int32 = 0
        var resultStatusID: Int32 = 0
        var Stays: [Dictionary<String, String>]
        var DataStays = [String:String]()
        var Index: Int = 0
        var Status: [String]
        var StaysStatus: [[Dictionary<String, String>]]
        var contStatus: Int = 0
        var CountStatusTot: Int32 = 0
        
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 100
        config.backgroundColor = UIColor(white: 1, alpha: 0.5)
        config.spinnerColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.titleTextColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.spinnerLineWidth = 2.0
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        SwiftLoader.show(title: NSLocalizedString("lblLoading",comment:""), animated: true)
        
        StaysStatus = []
        Status = [""]
        Stays = []
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        let queue = OperationQueue()
        
        if self.ynActualiza {
            
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("DELETE FROM tblAccount", withArgumentsIn: [])
                    
                } catch {
                    rollback.pointee = true
                }
            }
            
            //accion base de datos
            queue.addOperation() {//1
                //print("A1")
                if Reachability.isConnectedToNetwork(){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    
                    let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
                    tableItems = (service?.spGetGuestStay("1", personalID: self.PersonalID, appCode: self.appDelegate.gstrAppName, dataBase: self.appDelegate.strDataBaseByStay))!
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
                OperationQueue.main.addOperation() {
                    
                    
                    if Reachability.isConnectedToNetwork(){
                        
                        self.CountStay = 0
                        
                        /*queueFM?.inTransaction() {
                            db, rollback in
                            
                            if (db.executeUpdate("DELETE FROM tblStay", withArgumentsIn: [])) {
                                rollback.initialize(to: true)
                                return
                            }
                            
                        }*/
                        
                        queueFM?.inTransaction { db, rollback in
                            do {
  
                                try db.executeUpdate("DELETE FROM tblStay", withArgumentsIn: [])
                                
                            } catch {
                                rollback.pointee = true
                            }
                        }
                        
                        if (tableItems.getTotalTables() > 0 ){
                            
                            var tableResult = RRDataTable()
                            tableResult = tableItems.tables.object(at: 0) as! RRDataTable
                            
                            var rowResult = RRDataRow()
                            rowResult = tableResult.rows.object(at: 0) as! RRDataRow
                            
                            if rowResult.getColumnByName("iResult") != nil{
                                iRes = rowResult.getColumnByName("iResult").content as! String
                            }else{
                                iRes = "-1"
                            }
                            
                            if ( (iRes != "0") && (iRes != "-1")){
                                
                                var table = RRDataTable()
                                table = tableItems.tables.object(at: 1) as! RRDataTable
                                
                                var r = RRDataRow()
                                r = table.rows.object(at: 0) as! RRDataRow
                                
                                iRes = (r as AnyObject).getColumnByName("Result").content as! String
                                
                                if (Int(iRes) > 0){
                                    
                                    /*queueFM?.inTransaction() {
                                        db, rollback in
                                        
                                        
                                        for r in table.rows{

                                            if db.executeUpdate("INSERT INTO tblStay (StayInfoID, DatabaseName, PropertyCode, UnitCode, StatusCode, StatusDesc, ArrivalDate, DepartureDate, PropertyName, PrimaryPeopleID, OrderNo, Intv, IntvYear, fkAccID, fkTrxTypeID, AccCode, USDExchange, UnitID, FloorPlanDesc, UnitViewDesc, ynPostCheckout, LastAccountUpdate, PrimAgeCFG, fkPlaceID, DepartureDateCheckOut, ConfirmationCode, fkCurrencyID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [((r as AnyObject).getColumnByName("StayInfoID").content as? String)!, ((r as AnyObject).getColumnByName("DatabaseName").content as? String)!, ((r as AnyObject).getColumnByName("PropertyCode").content as? String)!, ((r as AnyObject).getColumnByName("UnitCode").content as? String)!, ((r as AnyObject).getColumnByName("StatusCode").content as? String)!, ((r as AnyObject).getColumnByName("StatusDesc").content as? String)!, ((r as AnyObject).getColumnByName("ArrivalDate").content as? String)!, ((r as AnyObject).getColumnByName("DepartureDate").content as? String)!, ((r as AnyObject).getColumnByName("PropertyName").content as? String)!, ((r as AnyObject).getColumnByName("PrimaryPeopleID").content as? String)!, ((r as AnyObject).getColumnByName("OrderNo").content as? String)!, ((r as AnyObject).getColumnByName("Intv").content as? String)!, ((r as AnyObject).getColumnByName("IntvYear").content as? String)!, ((r as AnyObject).getColumnByName("fkAccID").content as? String)!, ((r as AnyObject).getColumnByName("fkTrxTypeCCID").content as? String)!, ((r as AnyObject).getColumnByName("AccCode").content as? String)!, ((r as AnyObject).getColumnByName("USDExchange").content as? String)!, ((r as AnyObject).getColumnByName("UnitID").content as? String)!, ((r as AnyObject).getColumnByName("FloorPlanDesc").content as? String)!, ((r as AnyObject).getColumnByName("UnitViewDesc").content as? String)!, "0", "", ((r as AnyObject).getColumnByName("PrimAgeCFG").content as? String)!, ((r as AnyObject).getColumnByName("fkPlaceID").content as? String)!, ((r as AnyObject).getColumnByName("DepartureDateCheckOut").content as? String)!, ((r as AnyObject).getColumnByName("ConfirmationCode").content as? String)!, ((r as AnyObject).getColumnByName("fkCurrencyID").content as? String)!]) {
                                            
                                            }
                                            
                                        }
                                    }*/
                                    
                                    queueFM?.inTransaction { db, rollback in
                                        do {
                                            
                                            for r in table.rows{
                                                
                                                try db.executeUpdate("INSERT INTO tblStay (StayInfoID, DatabaseName, PropertyCode, UnitCode, StatusCode, StatusDesc, ArrivalDate, DepartureDate, PropertyName, PrimaryPeopleID, OrderNo, Intv, IntvYear, fkAccID, fkTrxTypeID, AccCode, USDExchange, UnitID, FloorPlanDesc, UnitViewDesc, ynPostCheckout, LastAccountUpdate, PrimAgeCFG, fkPlaceID, DepartureDateCheckOut, ConfirmationCode, fkCurrencyID, PlaceCode) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [((r as AnyObject).getColumnByName("StayInfoID").content as? String)!, ((r as AnyObject).getColumnByName("DatabaseName").content as? String)!, ((r as AnyObject).getColumnByName("PropertyCode").content as? String)!, ((r as AnyObject).getColumnByName("UnitCode").content as? String)!, ((r as AnyObject).getColumnByName("StatusCode").content as? String)!, ((r as AnyObject).getColumnByName("StatusDesc").content as? String)!, ((r as AnyObject).getColumnByName("ArrivalDate").content as? String)!, ((r as AnyObject).getColumnByName("DepartureDate").content as? String)!, ((r as AnyObject).getColumnByName("PropertyName").content as? String)!, ((r as AnyObject).getColumnByName("PrimaryPeopleID").content as? String)!, ((r as AnyObject).getColumnByName("OrderNo").content as? String)!, ((r as AnyObject).getColumnByName("Intv").content as? String)!, ((r as AnyObject).getColumnByName("IntvYear").content as? String)!, ((r as AnyObject).getColumnByName("fkAccID").content as? String)!, ((r as AnyObject).getColumnByName("fkTrxTypeCCID").content as? String)!, ((r as AnyObject).getColumnByName("AccCode").content as? String)!, ((r as AnyObject).getColumnByName("USDExchange").content as? String)!, ((r as AnyObject).getColumnByName("UnitID").content as? String)!, ((r as AnyObject).getColumnByName("FloorPlanDesc").content as? String)!, ((r as AnyObject).getColumnByName("UnitViewDesc").content as? String)!, "0", "", ((r as AnyObject).getColumnByName("PrimAgeCFG").content as? String)!, ((r as AnyObject).getColumnByName("fkPlaceID").content as? String)!, ((r as AnyObject).getColumnByName("DepartureDateCheckOut").content as? String)!, ((r as AnyObject).getColumnByName("ConfirmationCode").content as? String)!, ((r as AnyObject).getColumnByName("fkCurrencyID").content as? String)!,((r as AnyObject).getColumnByName("PlaceCode").content as? String)!])
                                                
                                            }
                                            
                                            
                                        } catch {
                                            rollback.pointee = true
                                            print(error)
                                        }
                                    }
                                    
                                    queueFM?.inTransaction { db, rollback in
                                        do {
                                            
                                            for r in table.rows{
                                                
                                                let todaysDate:Date = Date()
                                                let dateFormatter:DateFormatter = DateFormatter()
                                                dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
                                                let DateInFormat:String = dateFormatter.string(from: todaysDate)
                                                
                                                try db.executeUpdate("UPDATE tblLogin SET LastStayUpdate=? WHERE PersonalID=?", withArgumentsIn: [DateInFormat,self.PersonalID])
                                                
                                            }
                                            
                                            
                                        } catch {
                                            rollback.pointee = true
                                            print(error)
                                        }
                                    }
                                    
                                    /*queueFM?.inTransaction() {
                                        db, rollback in

                                            let todaysDate:Date = Date()
                                            let dateFormatter:DateFormatter = DateFormatter()
                                            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
                                            let DateInFormat:String = dateFormatter.string(from: todaysDate)
                                        
                                            if (db.executeUpdate("UPDATE tblLogin SET LastStayUpdate=? WHERE PersonalID=?", withArgumentsIn: [DateInFormat,self.PersonalID])) {
                                                
                                            }

                                    }*/

                                    self.tblStayInfo = [:]
                                    Stays = []
                                    
                                    queueFM?.inDatabase() {
                                        db in
                                        
                                        let resultCount = db.intForQuery("SELECT COUNT(*) FROM tblStay" as String,"" as AnyObject)
                                        
                                        if (resultCount == nil){
                                            resultStayID = 0
                                        }else{
                                            if (String(describing: resultCount) == ""){
                                                resultStayID = 0
                                            }else{
                                                resultStayID = Int32(resultCount!)
                                            }
                                            
                                        }

                                    }
                                    
                                    
                                    self.CountStay = resultStayID
                                    self.appDelegate.iCountStayF = Int(self.CountStay)
                                    
                                    if self.CountStay > 0{
                                        queueFM?.inDatabase() {
                                            db in
                                            
                                            for _ in 0...resultStayID-1 {
                                                Stays.append([:])
                                            }

                                            if let rs = db.executeQuery("SELECT * FROM tblStay ORDER BY ArrivalDate DESC", withArgumentsIn: []){
                                                while rs.next() {
                                                    DataStays["StayInfoID"] = String(describing: rs.string(forColumn: "StayInfoID")!)
                                                    DataStays["DatabaseName"] = String(describing: rs.string(forColumn: "DatabaseName")!)
                                                    DataStays["PropertyCode"] = String(describing: rs.string(forColumn: "PropertyCode")!)
                                                    DataStays["PropertyName"] = String(describing: rs.string(forColumn: "PropertyName")!)
                                                    DataStays["UnitCode"] = String(describing: rs.string(forColumn: "UnitCode")!)
                                                    DataStays["StatusCode"] = String(describing: rs.string(forColumn: "StatusCode")!)
                                                    DataStays["StatusDesc"] = String(describing: rs.string(forColumn: "StatusDesc")!)
                                                    DataStays["ArrivalDate"] = String(describing: rs.string(forColumn: "ArrivalDate")!)
                                                    DataStays["DepartureDate"] = String(describing: rs.string(forColumn: "DepartureDate")!)
                                                    DataStays["PrimaryPeopleID"] = String(describing: rs.string(forColumn: "PrimaryPeopleID")!)
                                                    DataStays["OrderNo"] = String(describing: rs.string(forColumn: "OrderNo")!)
                                                    DataStays["PrimAgeCFG"] = String(describing: rs.string(forColumn: "PrimAgeCFG")!)
                                                    DataStays["fkPlaceID"] = String(describing: rs.string(forColumn: "fkPlaceID")!)
                                                    DataStays["DepartureDateCheckOut"] = String(describing: rs.string(forColumn: "DepartureDateCheckOut")!)
                                                    DataStays["ConfirmationCode"] = String(describing: rs.string(forColumn: "ConfirmationCode")!)
                                                    DataStays["fkCurrencyID"] = String(describing: rs.string(forColumn: "fkCurrencyID")!)
                                                    DataStays["PlaceCode"] = String(describing: rs.string(forColumn: "PlaceCode")!)
                                                    Stays[Index] = DataStays
                                                    
                                                    Index = Index + 1
                                                }
                                            } else {
                                                print("select failure: \(db.lastErrorMessage())")
                                            }

                                        }
                                        
                                        self.appDelegate.gtblStay = Stays
                                        self.tblStay = Stays
                                        
                                        queueFM?.inDatabase() {
                                            db in
                                            
                                            let CountStatusTot = db.intForQuery("SELECT COUNT(*) FROM (SELECT OrderNo FROM tblStay GROUP BY OrderNo)" as String,"" as AnyObject)

                                            if (CountStatusTot == nil){
                                                resultStatusID = 0
                                            }else{
                                                if (String(describing: CountStatusTot) == ""){
                                                    resultStatusID = 0
                                                }else{
                                                    resultStatusID = Int32(CountStatusTot!)
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                        Index = 0

                                        queueFM?.inDatabase() {
                                            db in
                                            
                                            for _ in 0...resultStayID-1 {
                                                Stays.append([:])
                                            }
                                            
                                            if let rs = db.executeQuery("SELECT count(*) as CountStatus,OrderNo FROM tblStay GROUP BY OrderNo ORDER BY OrderNo DESC", withArgumentsIn: []){
                                                while rs.next() {
                                                    if (Index==0){
                                                        Status[0] = rs.string(forColumn: "OrderNo")!
                                                        contStatus = Int(rs.int(forColumn: "CountStatus"))
                                                        StaysStatus.append([])
                                                        for _ in 0...contStatus-1 {
                                                            StaysStatus[0].append([:])
                                                        }
                                                        
                                                    }else{
                                                        Status.append(rs.string(forColumn: "OrderNo")!)
                                                        contStatus = Int(rs.int(forColumn: "CountStatus"))
                                                        StaysStatus.append([])
                                                        for _ in 0...contStatus-1 {
                                                            StaysStatus[Index].append([:])
                                                        }
                                                        
                                                    }
                                                    Index = Index + 1
                                                }
                                            } else {
                                                print("select failure: \(db.lastErrorMessage())")
                                            }
                                            
                                        }
                                        
                                        let xCountStatus = Int(resultStatusID)
                                        let xCountStays = Int(resultStayID)
                                        var sCount: Int = 0
                                        
                                        for xIndex in 0...xCountStatus-1 {
                                            sCount = 0
                                            for yIndex in 0...xCountStays-1 {

                                                if (Status[xIndex]==self.tblStay[yIndex]["OrderNo"]){
                                                    StaysStatus[xIndex][sCount] = self.tblStay[yIndex]
                                                    sCount = sCount + 1
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                        self.appDelegate.gStaysStatus = StaysStatus
                                        self.StaysStatus = StaysStatus
                                        
                                        if self.appDelegate.iCountStayF == 1{
                                            self.appDelegate.strUnitStay = String(self.StaysStatus[0][0]["PropertyCode"]!) + "/" + String(self.StaysStatus[0][0]["UnitCode"]!)
                                            self.appDelegate.strUnitStayInfoID = String(self.StaysStatus[0][0]["StayInfoID"]!)
                                            self.appDelegate.strUnitCode = String(self.StaysStatus[0][0]["UnitCode"]!)
                                        }
                                        
                                        queueFM?.inDatabase() {
                                            db in
                                            
                                            if let rs = db.executeQuery("SELECT * FROM tblStay WHERE DepartureDate > strftime('%m/%d/%Y', date('now')) AND StatusCode = 'INHOUSE' LIMIT 1" as String,"" as AnyObject){
                                                while rs.next() {
                                                    
                                                    self.appDelegate.RestStayInfoID = Int(rs.string(forColumn: "StayInfoID")!)!
                                                    self.appDelegate.strRestUnit = rs.string(forColumn: "UnitCode")! + " - " + rs.string(forColumn: "FloorPlanDesc")!
                                                    self.appDelegate.strRestUnitReserv = rs.string(forColumn: "UnitCode")!
                                                    self.appDelegate.strRestAccCode = rs.string(forColumn: "AccCode")!
                                                }
                                            } else {
                                                self.appDelegate.RestStayInfoID = 0
                                            }
                                            
                                        }
                                        

                                    }


                                    }else{
                                        self.appDelegate.gtblStay = nil
                                        self.appDelegate.gStaysStatus = nil
                                    }
                                
                            }else{
                                self.appDelegate.gtblStay = nil
                                self.appDelegate.gStaysStatus = nil
                            }
                            
                            }
                        
                        }
                    
                    if (self.CountStay>0){
                        
                        self.iseccion = self.StaysStatus.count
                        
                        if !Reachability.isConnectedToNetwork(){
                            RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                        }
                        
                        let lblHeader = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: self.width, height: 0.00000001*self.height))
                        lblHeader.backgroundColor = UIColor.clear;
                        lblHeader.textAlignment = NSTextAlignment.left;
                        lblHeader.textColor = UIColor.gray;
                        lblHeader.font = UIFont(name:"HelveticaNeue-Light", size:self.appDelegate.gblFont8 + self.appDelegate.gblDeviceFont4)
                        lblHeader.numberOfLines = 0;
                        lblHeader.text = ""
                        self.tableView.tableHeaderView = lblHeader
                        self.tableView.backgroundColor = UIColor.clear
                        
                    }else{
                        
                        self.iseccion = 0
                        
                        let lblHeader = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: self.width, height: 0.1*self.height))
                        lblHeader.backgroundColor = UIColor.clear;
                        lblHeader.textAlignment = NSTextAlignment.left;
                        lblHeader.textColor = UIColor.gray;
                        lblHeader.font = UIFont(name:"HelveticaNeue-Light", size:self.appDelegate.gblFont8 + self.appDelegate.gblDeviceFont4)
                        lblHeader.numberOfLines = 0;
                        lblHeader.text = NSLocalizedString("msgNoReserv",comment:"")
                        self.tableView.tableHeaderView = lblHeader
                        self.tableView.backgroundColor = UIColor.clear
                        
                        if !Reachability.isConnectedToNetwork(){
                            RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                        }
                        
                    }
                    
                    self.tableView.reloadData()
                    
                    self.ViewItem.rightBarButtonItem?.isEnabled = true
                    self.tableView.isUserInteractionEnabled = true
                    self.app.endIgnoringInteractionEvents()
                    
                    SwiftLoader.hide()
                
                    }
                }

            }else{
            
            queueFM?.inDatabase() {
                db in
                
                let resultCount = db.intForQuery("SELECT COUNT(*) FROM tblStay" as String,"" as AnyObject)
                
                if (resultCount == nil){
                    resultStayID = 0
                }else{
                    if (String(describing: resultCount) == ""){
                        resultStayID = 0
                    }else{
                        resultStayID = Int32(resultCount!)
                    }
                    
                }
                
            }
            
            CountStay = resultStayID
            self.appDelegate.iCountStayF = Int(self.CountStay)
            
            if self.CountStay > 0{
                queueFM?.inDatabase() {
                    db in
                    
                    for _ in 0...resultStayID-1 {
                        Stays.append([:])
                    }
                    
                    if let rs = db.executeQuery("SELECT * FROM tblStay ORDER BY ArrivalDate DESC", withArgumentsIn: []){
                        while rs.next() {
                            DataStays["StayInfoID"] = String(describing: rs.string(forColumn: "StayInfoID")!)
                            DataStays["DatabaseName"] = String(describing: rs.string(forColumn: "DatabaseName")!)
                            DataStays["PropertyCode"] = String(describing: rs.string(forColumn: "PropertyCode")!)
                            DataStays["PropertyName"] = String(describing: rs.string(forColumn: "PropertyName")!)
                            DataStays["UnitCode"] = String(describing: rs.string(forColumn: "UnitCode")!)
                            DataStays["StatusCode"] = String(describing: rs.string(forColumn: "StatusCode")!)
                            DataStays["StatusDesc"] = String(describing: rs.string(forColumn: "StatusDesc")!)
                            DataStays["ArrivalDate"] = String(describing: rs.string(forColumn: "ArrivalDate")!)
                            DataStays["DepartureDate"] = String(describing: rs.string(forColumn: "DepartureDate")!)
                            DataStays["PrimaryPeopleID"] = String(describing: rs.string(forColumn: "PrimaryPeopleID")!)
                            DataStays["OrderNo"] = String(describing: rs.string(forColumn: "OrderNo")!)
                            DataStays["PrimAgeCFG"] = String(describing: rs.string(forColumn: "PrimAgeCFG")!)
                            DataStays["fkPlaceID"] = String(describing: rs.string(forColumn: "fkPlaceID")!)
                            DataStays["DepartureDateCheckOut"] = String(describing: rs.string(forColumn: "DepartureDateCheckOut")!)
                            DataStays["ConfirmationCode"] = String(describing: rs.string(forColumn: "ConfirmationCode")!)
                            DataStays["fkCurrencyID"] = String(describing: rs.string(forColumn: "fkCurrencyID")!)
                            DataStays["PlaceCode"] = String(describing: rs.string(forColumn: "PlaceCode")!)
                            Stays[Index] = DataStays
                            
                            Index = Index + 1
                        }
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                    
                }
                
                self.appDelegate.gtblStay = Stays
                self.tblStay = Stays
                
                queueFM?.inDatabase() {
                    db in
                    
                    let CountStatusTot = db.intForQuery("SELECT COUNT(*) FROM (SELECT OrderNo FROM tblStay GROUP BY OrderNo)" as String,"" as AnyObject)
                    
                    if (CountStatusTot == nil){
                        resultStatusID = 0
                    }else{
                        if (String(describing: CountStatusTot) == ""){
                            resultStatusID = 0
                        }else{
                            resultStatusID = Int32(CountStatusTot!)
                        }
                        
                    }
                    
                }
                
                Index = 0
                
                queueFM?.inDatabase() {
                    db in
                    
                    for _ in 0...resultStayID-1 {
                        Stays.append([:])
                    }
                    
                    if let rs = db.executeQuery("SELECT count(*) as CountStatus,OrderNo FROM tblStay GROUP BY OrderNo ORDER BY OrderNo DESC", withArgumentsIn: []){
                        while rs.next() {
                            if (Index==0){
                                Status[0] = rs.string(forColumn: "OrderNo")!
                                contStatus = Int(rs.int(forColumn: "CountStatus"))
                                StaysStatus.append([])
                                for _ in 0...contStatus-1 {
                                    StaysStatus[0].append([:])
                                }
                                
                            }else{
                                Status.append(rs.string(forColumn: "OrderNo")!)
                                contStatus = Int(rs.int(forColumn: "CountStatus"))
                                StaysStatus.append([])
                                for _ in 0...contStatus-1 {
                                    StaysStatus[Index].append([:])
                                }
                                
                            }
                            Index = Index + 1
                        }
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                    
                }
                
                let xCountStatus = Int(resultStatusID)
                let xCountStays = Int(resultStayID)
                var sCount: Int = 0
                
                for xIndex in 0...xCountStatus-1 {
                    sCount = 0
                    for yIndex in 0...xCountStays-1 {
                        if (Status[xIndex]==self.tblStay[yIndex]["OrderNo"]){
                            StaysStatus[xIndex][sCount] = self.tblStay[yIndex]
                            sCount = sCount + 1
                        }
                        
                    }
                    
                }
                
                self.appDelegate.gStaysStatus = StaysStatus
                self.StaysStatus = StaysStatus
                
                if self.appDelegate.iCountStayF == 1{
                    self.appDelegate.strUnitStay = String(self.StaysStatus[0][0]["PropertyCode"]!) + "/" + String(self.StaysStatus[0][0]["UnitCode"]!)
                    self.appDelegate.strUnitStayInfoID = String(self.StaysStatus[0][0]["StayInfoID"]!)
                    self.appDelegate.strUnitCode = String(self.StaysStatus[0][0]["UnitCode"]!)
                }
                
            }
            
            if (CountStay > 0){
                
                self.iseccion = self.StaysStatus.count
                
                if !Reachability.isConnectedToNetwork(){
                    RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                }
                
                let lblHeader = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: self.width, height: 0.00000001*self.height))
                lblHeader.backgroundColor = UIColor.clear;
                lblHeader.textAlignment = NSTextAlignment.left;
                lblHeader.textColor = UIColor.gray;
                lblHeader.font = UIFont(name:"HelveticaNeue-Light", size:self.appDelegate.gblFont8 + self.appDelegate.gblDeviceFont4)
                lblHeader.numberOfLines = 0;
                lblHeader.text = ""
                self.tableView.tableHeaderView = lblHeader
                self.tableView.backgroundColor = UIColor.clear
                
                queueFM?.inDatabase() {
                    db in
                    
                    if let rs = db.executeQuery("SELECT * FROM tblStay WHERE DepartureDate > strftime('%m/%d/%Y', date('now')) AND StatusCode = 'INHOUSE' LIMIT 1" as String,"" as AnyObject){
                        while rs.next() {
                            
                            self.appDelegate.RestStayInfoID = Int(rs.string(forColumn: "StayInfoID")!)!
                            self.appDelegate.strRestUnit = rs.string(forColumn: "UnitCode")! //+ " - " + rs.stringForColumn("FloorPlanDesc")
                            self.appDelegate.strRestUnitReserv = rs.string(forColumn: "UnitCode")!
                            self.appDelegate.strRestAccCode = rs.string(forColumn: "AccCode")!
                        }
                    } else {
                        self.appDelegate.RestStayInfoID = 0
                    }
                    
                }

                
            }else{
                
                self.iseccion = 0
                
                let lblHeader = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: self.width, height: 0.1*self.height))
                lblHeader.backgroundColor = UIColor.clear;
                lblHeader.textAlignment = NSTextAlignment.left;
                lblHeader.textColor = UIColor.gray;
                lblHeader.font = UIFont(name:"HelveticaNeue-Light", size:self.appDelegate.gblFont8 + self.appDelegate.gblDeviceFont4)
                lblHeader.numberOfLines = 0;
                lblHeader.text = NSLocalizedString("msgNoReserv",comment:"")
                self.tableView.tableHeaderView = lblHeader
                self.tableView.backgroundColor = UIColor.clear
                
                if !Reachability.isConnectedToNetwork(){
                    RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                }
                
            }
            
            self.tableView.reloadData()
            
            self.ViewItem.rightBarButtonItem?.isEnabled = true
            self.tableView.isUserInteractionEnabled = true
            self.app.endIgnoringInteractionEvents()
            
            SwiftLoader.hide()
            
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
    
    @objc func LogOUT(_ sender: UIButton!){
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        /*queueFM?.inTransaction() {
            db, rollback in
            
            if !(db.executeUpdate("DELETE FROM tblLogin", withArgumentsIn: [])) {
                rollback.initialize(to: true)
                return
            }
            
        }*/
        
        queueFM?.inTransaction { db, rollback in
            do {
                
                try db.executeUpdate("DELETE FROM tblLogin", withArgumentsIn: [])
                
            } catch {
                rollback.pointee = true
            }
        }
        
        /*queueFM?.inTransaction() {
            db, rollback in
            
            if (db.executeUpdate("DELETE FROM tblStay", withArgumentsIn: [])) {
                rollback.initialize(to: true)
                return
            }
            
        }*/
        
        queueFM?.inTransaction { db, rollback in
            do {
                
                try db.executeUpdate("DELETE FROM tblStay", withArgumentsIn: [])
                
            } catch {
                rollback.pointee = true
            }
        }
        
        /*queueFM?.inTransaction() {
            db, rollback in
            
            if (db.executeUpdate("DELETE FROM tblAccount", withArgumentsIn: [])) {
                rollback.initialize(to: true)
                return
            }
            
        }*/
        
        queueFM?.inTransaction { db, rollback in
            do {
                
                try db.executeUpdate("DELETE FROM tblAccount", withArgumentsIn: [])
                
            } catch {
                rollback.pointee = true
            }
        }
        
        /*queueFM?.inTransaction() {
            db, rollback in
            
            if (db.executeUpdate("DELETE FROM tblPerson", withArgumentsIn: [])) {
                rollback.initialize(to: true)
                return
            }
            
        }*/
        
        queueFM?.inTransaction { db, rollback in
            do {
                
                try db.executeUpdate("DELETE FROM tblPerson", withArgumentsIn: [])
                
            } catch {
                rollback.pointee = true
            }
            
            
        }
        
        queueFM?.inTransaction { db, rollback in
            do {
                
                try db.executeUpdate("DELETE FROM tblPersonAI", withArgumentsIn: [])
                
            } catch {
                rollback.pointee = true
            }
            
            
        }
        
        queueFM?.inTransaction { db, rollback in
            do {
                
                try db.executeUpdate("DELETE FROM tblPushMessage", withArgumentsIn: [])
                
            } catch {
                rollback.pointee = true
            }
        }
        
        /*queueFM?.inTransaction() {
            db, rollback in
            
            if (db.executeUpdate("UPDATE tblLogin SET PIN='-1', LastStayUpdate = '' WHERE PersonalID=?", withArgumentsIn: [self.PersonalID])) {
                rollback.initialize(to: true)
                return
            }
            
        }*/
        
        queueFM?.inTransaction { db, rollback in
            do {
                
                try db.executeUpdate("UPDATE tblLogin SET PIN='-1', LastStayUpdate = '' WHERE PersonalID=?", withArgumentsIn: [self.PersonalID])
                
            } catch {
                rollback.pointee = true
                return
            }
        }
        
        var tblLogin: Dictionary<String, String>
        var strQuery: String = ""
        
        if (PersonalID==""){
            strQuery = "SELECT * FROM tblLogin WHERE PIN > 0"
        }else{
            strQuery = "SELECT * FROM tblLogin WHERE PersonalID = ?"
        }
        
        tblLogin = [:]

        queueFM?.inDatabase() {
            db in
            
            if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.PersonalID]){
                while rs.next() {
                    tblLogin["Email"] = rs.string(forColumn: "Email")!
                    tblLogin["PIN"] = rs.string(forColumn: "PIN")!
                    tblLogin["PersonalID"] = rs.string(forColumn: "PersonalID")!
                    tblLogin["Gender"] = rs.string(forColumn: "Gender")!
                    tblLogin["Lenguage"] = rs.string(forColumn: "Lenguage")!
                    tblLogin["FullName"] = rs.string(forColumn: "FullName")!
                    tblLogin["FirstName"] = rs.string(forColumn: "FirstName")!
                    tblLogin["LastName"] = rs.string(forColumn: "LastName")!
                    tblLogin["Field1"] = rs.string(forColumn: "Field1")!
                    tblLogin["Field2"] = rs.string(forColumn: "Field2")!
                    tblLogin["Field3"] = rs.string(forColumn: "Field3")!
                    tblLogin["Field4"] = rs.string(forColumn: "Field4")!
                    tblLogin["Field5"] = rs.string(forColumn: "Field5")!
                    tblLogin["LastStayUpdate"] = rs.string(forColumn: "LastStayUpdate")!
                    tblLogin["PeopleType"] = rs.string(forColumn: "PeopleType")!
                }
            } else {
                print("select failure: \(db.lastErrorMessage())")
            }
            
        }
        
        appDelegate.gtblLogin = tblLogin

        appDelegate.gtblStay = nil
        appDelegate.gStaysStatus = nil
        appDelegate.gblGoOut = true
        appDelegate.gblGoHome = true
        appDelegate.RestStayInfoID = 0
        appDelegate.strRestStayInfoID = ""

        var tableItemsPush = RRDataSet()
        
        let queuenew = OperationQueue()
        
        queuenew.addOperation() {
            //accion webservice
            if Reachability.isConnectedToNetwork(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
                var prepareOrderResult:NSString="";
                let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
                
                tableItemsPush = (service?.spSetAppPeoplePushToken("2", peopleID: self.appDelegate.gstrLoginPeopleID, token: self.appDelegate.gstrToken, osCode: "IOS", appCode: self.appDelegate.gstrAppName, dataBase: "CDRPRD"))!
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            OperationQueue.main.addOperation() {
                
                self.appDelegate.gstrLoginPeopleID = ""
                
                self.tabBarController?.navigationController?.navigationBar.isHidden = false;
                
                self.tabBarController?.navigationController?.popViewController(animated: false)
                
                queueFM?.inTransaction { db, rollback in
                    do {
                        
                        try db.executeUpdate("DELETE FROM tblChannelCfg WHERE AppCode = ?", withArgumentsIn: [self.appDelegate.gstrAppName])
                        
                    } catch {
                        rollback.pointee = true
                    }
                }
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Stay",
            AnalyticsParameterItemName: "Stay",
            AnalyticsParameterContentType: "Pantalla"
            ])

        Analytics.setScreenName("Stay", screenClass: appDelegate.gstrAppName)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return iseccion;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StaysStatus[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch StaysStatus[section][0]["OrderNo"]!{
        case "3":
            return NSLocalizedString("OUT",comment:"")
        case "2":
            return NSLocalizedString("INHOUSE",comment:"")
        case "1":
            return NSLocalizedString("ASSIGNED",comment:"")
        default:
            return ""
        }
    }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0.08*height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.03*height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.03*height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title: UILabel = UILabel()
        title.backgroundColor = UIColor.clear;
        title.textAlignment = NSTextAlignment.left;
        title.textColor = UIColor.gray;
        title.font = UIFont(name:"HelveticaNeue-Light", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont4)
        title.numberOfLines = 0;
        
        switch StaysStatus[section][0]["OrderNo"]!{
        case "3":
            title.text = NSLocalizedString("OUT",comment:"");
        case "2":
            title.text = NSLocalizedString("INHOUSE",comment:"");
        case "1":
            title.text = NSLocalizedString("ASSIGNED",comment:"");
        default:
            title.text = NSLocalizedString("ASSIGNED",comment:"");
        }

        return title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var strArrivalDate: String = ""
        var strDepartureDate: String = ""

        let ArrivalDate = moment(StaysStatus[indexPath.section][indexPath.row]["ArrivalDate"]!)
        let DepartureDate = moment(StaysStatus[indexPath.section][indexPath.row]["DepartureDate"]!)
        
        let strdateFormatter = DateFormatter()
        strdateFormatter.dateFormat = "yyyy-MM-dd";
        strArrivalDate = strdateFormatter.string(from: ArrivalDate!.date)
        strDepartureDate = strdateFormatter.string(from: DepartureDate!.date)
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "CellCustomStays")!
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            // Initialize a gradient view
            let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 0.9*width, height: 0.12*height))
             
             // Set the gradient colors 8DE3F5 5C9F00
             gradientView.colors = [UIColor.white, colorWithHexString ("F2F2F2")]
             
             // Optionally set some locations
             gradientView.locations = [0.4, 1.0]
             
             // Optionally change the direction. The default is vertical.
             gradientView.direction = .vertical
             
             // Add some borders too if you want
             gradientView.topBorderColor = UIColor.lightGray
             
             gradientView.bottomBorderColor = colorWithHexString ("C7C7CD")
             
             cell.backgroundView = gradientView
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            cell.backgroundColor = UIColor.clear
            cell.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("e4c29c"))
            
            if indexPath.row == 0{
                imgCell = UIImage(named:"tblhdr.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblhdrSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }else if (StaysStatus[indexPath.section].count-1) == indexPath.row{
                imgCell = UIImage(named:"tblfooter.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblfooterSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            } else {
                imgCell = UIImage(named:"tblrow.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblrowSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }
            
            if (StaysStatus[indexPath.section].count) == 1
            {
                imgCell = UIImage(named:"tblrowsingle.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblrowsingleSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
                
            }
            
            lastIndex = IndexPath.init()
            cell.textLabel?.textColor = colorWithHexString("ba8748")
            cell.detailTextLabel?.textColor = colorWithHexString("ba8748")
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            cell.backgroundColor = UIColor.clear
            cell.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("94cce5"))
            
            if indexPath.row == 0{
                imgCell = UIImage(named:"tblhdr.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell

                imgCell = UIImage(named:"tblhdrSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }else if (StaysStatus[indexPath.section].count-1) == indexPath.row{
                imgCell = UIImage(named:"tblfooter.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblfooterSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            } else {
                imgCell = UIImage(named:"tblrow.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblrowSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }
            
            if (StaysStatus[indexPath.section].count) == 1
            {
                imgCell = UIImage(named:"tblrowsingle.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblrowsingleSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
                
            }
            
            lastIndex = IndexPath.init()
            cell.textLabel?.textColor = colorWithHexString("00467f")
            cell.detailTextLabel?.textColor = colorWithHexString("00467f")
        }

        if (String(StaysStatus[indexPath.section][indexPath.row]["OrderNo"]!) == "1"){
            cell.textLabel?.text = String(StaysStatus[indexPath.section][indexPath.row]["PropertyName"]!) + " - " + String(StaysStatus[indexPath.section][indexPath.row]["ConfirmationCode"]!)
        }else{
            cell.textLabel?.text = String(StaysStatus[indexPath.section][indexPath.row]["PropertyName"]!) + " - " + String(StaysStatus[indexPath.section][indexPath.row]["UnitCode"]!)
        }
        
        cell.textLabel?.font = UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont2)
        cell.textLabel?.adjustsFontSizeToFitWidth = true;
        
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.detailTextLabel?.text = strArrivalDate + " - " + strDepartureDate
        cell.detailTextLabel?.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont2)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{

        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            if lastIndex != indexPath && lastIndex.count > 0{
                tableView.cellForRow(at: lastIndex)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("e4c29c"))
            }
            
            tableView.cellForRow(at: indexPath)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("ba8748"))
            
            lastIndex = indexPath
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            if lastIndex != indexPath && lastIndex.count > 0{
                tableView.cellForRow(at: lastIndex)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("94cce5"))
            }
            
            tableView.cellForRow(at: indexPath)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("00467f"))
            
            lastIndex = indexPath
            
        }

        tableView.cellForRow(at: indexPath)?.isUserInteractionEnabled = false
        
        let len: Int = String(StaysStatus[indexPath.section][indexPath.row]["ConfirmationCode"]!).characters.count - 2
        
        let strpre: String = String(StaysStatus[indexPath.section][indexPath.row]["ConfirmationCode"]!)
        
        let start = strpre.index(strpre.startIndex, offsetBy: 0)
        let end = strpre.index(strpre.endIndex, offsetBy: -len)
        let range = start..<end
        
        let mySubstring = strpre[range]
        
        strStayType = String(mySubstring)
        
        if (String(StaysStatus[indexPath.section][0]["OrderNo"]!) == "1") {

                appDelegate.glbPreCheck = false
                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcGuestPreCheckin") as! vcGuestPreCheckin
                tercerViewController.StayInfoID = StaysStatus[indexPath.section][indexPath.row]["StayInfoID"]!
                tercerViewController.PrimAgeCFG = Int(StaysStatus[indexPath.section][indexPath.row]["PrimAgeCFG"]!)!
                tercerViewController.strStayType = strStayType
                self.appDelegate.gstrPrimaryPeopleID = StaysStatus[indexPath.section][indexPath.row]["PrimaryPeopleID"]!
                tercerViewController.strPeopleType = self.PeopleType
                self.navigationController?.pushViewController(tercerViewController, animated: true)
                
        }
        else{
                
                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcGuestAccount") as! vcGuestAccount
                tercerViewController.StayInfoID = StaysStatus[indexPath.section][indexPath.row]["StayInfoID"]!
                self.appDelegate.gstrPrimaryPeopleID = StaysStatus[indexPath.section][indexPath.row]["PrimaryPeopleID"]!
                self.navigationController?.pushViewController(tercerViewController, animated: true)
                
        }
        
        tableView.cellForRow(at: indexPath)?.isUserInteractionEnabled = true

    }
    
    @IBAction func clickLogout(_ sender: AnyObject) {

        var tblLogin: Dictionary<String, String>
        var strQuery: String = ""
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        if (PersonalID==""){
            strQuery = "SELECT * FROM tblLogin WHERE PIN > 0"
        }else{
            strQuery = "SELECT * FROM tblLogin WHERE PersonalID = ?"
        }
        
        tblLogin = [:]
        
        queueFM?.inDatabase() {
            db in
            
            if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.PersonalID]){
                while rs.next() {
                    tblLogin["Email"] = rs.string(forColumn: "Email")!
                    tblLogin["PIN"] = rs.string(forColumn: "PIN")!
                    tblLogin["PersonalID"] = rs.string(forColumn: "PersonalID")!
                    tblLogin["Gender"] = rs.string(forColumn: "Gender")!
                    tblLogin["Lenguage"] = rs.string(forColumn: "Lenguage")!
                    tblLogin["FullName"] = rs.string(forColumn: "FullName")!
                    tblLogin["FirstName"] = rs.string(forColumn: "FirstName")!
                    tblLogin["LastName"] = rs.string(forColumn: "LastName")!
                    tblLogin["Field1"] = rs.string(forColumn: "Field1")!
                    tblLogin["Field2"] = rs.string(forColumn: "Field2")!
                    tblLogin["Field3"] = rs.string(forColumn: "Field3")!
                    tblLogin["Field4"] = rs.string(forColumn: "Field4")!
                    tblLogin["Field5"] = rs.string(forColumn: "Field5")!
                    tblLogin["LastStayUpdate"] = rs.string(forColumn: "LastStayUpdate")!
                    tblLogin["PeopleType"] = rs.string(forColumn: "PeopleType")!
                }
            } else {
                print("select failure: \(db.lastErrorMessage())")
            }
            
        }
        
        appDelegate.gtblLogin = tblLogin
        self.tabBarController?.navigationController?.navigationBar.isHidden = false;

        appDelegate.gblGoHome = true
        appDelegate.gblGoOut = false
        self.tabBarController?.navigationController?.popViewController(animated: false)

    }
    
    @IBAction func clickHome(_ sender: AnyObject) {

        ynActualiza = true
        recargarTablas()

    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
            if (self.appDelegate.gblCheckOUT == true){
                ynActualiza = true
                recargarTablas()
                self.appDelegate.gblCheckOUT = false
            }else if self.appDelegate.gblGoNotification == true{
                
                self.appDelegate.gblGoNotification = false
                self.appDelegate.gblGoMessage = true
                
                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcNotification") as! vcNotification
                appDelegate.gblNotification = true
                self.navigationController?.pushViewController(tercerViewController, animated: true)
                
            }

    }
    
}

extension UIImage {
    public func imageRotatedByDegrees(_ degrees: CGFloat, flip: Bool) -> UIImage {
        let radiansToDegrees: (CGFloat) -> CGFloat = {
            return $0 * (180.0 / CGFloat(M_PI))
        }
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(M_PI)
        }
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap!.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0);
        
        //   // Rotate the image context
        bitmap!.rotate(by: degreesToRadians(degrees));
        
        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat
        
        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }
        
        bitmap!.scaleBy(x: yFlip, y: -1.0)
        bitmap!.draw(cgImage!, in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}


public extension UIImage {
    func imageWithColor(_ tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

