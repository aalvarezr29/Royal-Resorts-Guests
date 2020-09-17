//
//  vcRequestDetail.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 22/01/16.
//  Copyright © 2016 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging

class vcRequestDetail: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var width: CGFloat!
    var height: CGFloat!
    var btnBack = UIButton()
    var btnNext = UIButton()
    var tblFollowUp: [Dictionary<String, String>]!
    
    var StayInfoID: String = ""
    var PeopleID: String = ""
    var PeopleFDeskID: String = ""
    var formatter = NumberFormatter()
    var btnAddRequest = UIButton()
    var tblLogin: Dictionary<String, String>!
    var LastName: String = ""
    var ynShowHistory: Bool = false
    var swTypePay = UISwitch()
    var FollowUpId: String = ""
    var Reqshort: String = ""
    var AccCode: String = ""
    var FType: String = ""
    var Status: String = ""
    var lastIndex = IndexPath()
    var isSelected: Bool = false
    var rowHeight: CGFloat!
    var ynSelected: Bool = false
    var rowSelected: Bool = false
    var imgCell = UIImage()
    var imgvwCell = UIImageView()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var ViewItem: UINavigationItem!
    @IBOutlet weak var AccView: UIView!
    @IBOutlet weak var BodyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tabBarController?.navigationController?.navigationBar.isHidden = true;
        
        self.navigationController?.navigationBar.isHidden = false;
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString("lblRequestDetail",comment:"")
        
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        self.navigationController?.isToolbarHidden = false;
        
        //BodyView.frame = CGRectMake(0.0, 44, width, height);
        AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.14*height);
        AccView.backgroundColor = UIColor.white
        AccView.layer.borderColor = UIColor.black.cgColor
        AccView.layer.cornerRadius = 5

        let lblDesc = UILabel(frame: CGRect(x: 0.001*width, y: 0.01*height, width: 0.4*width, height: 0.03*height));
        lblDesc.backgroundColor = UIColor.clear;
        lblDesc.textAlignment = NSTextAlignment.right;
        lblDesc.textColor = UIColor.black
        lblDesc.numberOfLines = 1;
        lblDesc.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblDesc.text = NSLocalizedString("lblDesc",comment:"")
        AccView.addSubview(lblDesc)
        
        let lblDescRes = UILabel(frame: CGRect(x: 0.45*width, y: 0.01*height, width: 0.35*width, height: 0.03*height));
        lblDescRes.backgroundColor = UIColor.clear;
        lblDescRes.textAlignment = NSTextAlignment.left;
        lblDescRes.textColor = UIColor.black
        lblDescRes.numberOfLines = 0;
        lblDescRes.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        lblDescRes.text = Reqshort
        AccView.addSubview(lblDescRes)
        
        let lblStay = UILabel(frame: CGRect(x: 0.001*width, y: 0.04*height, width: 0.4*width, height: 0.03*height));
        lblStay.backgroundColor = UIColor.clear;
        lblStay.textAlignment = NSTextAlignment.right;
        lblStay.textColor = UIColor.black
        lblStay.numberOfLines = 1;
        lblStay.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblStay.text = NSLocalizedString("lblStay",comment:"")
        AccView.addSubview(lblStay)
        
        let lblStayRes = UILabel(frame: CGRect(x: 0.45*width, y: 0.04*height, width: 0.35*width, height: 0.03*height));
        lblStayRes.backgroundColor = UIColor.clear;
        lblStayRes.textAlignment = NSTextAlignment.left;
        lblStayRes.textColor = UIColor.black
        lblStayRes.numberOfLines = 0;
        lblStayRes.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        lblStayRes.text = AccCode
        AccView.addSubview(lblStayRes)
        
        let lblType = UILabel(frame: CGRect(x: 0.001*width, y: 0.07*height, width: 0.4*width, height: 0.03*height));
        lblType.backgroundColor = UIColor.clear;
        lblType.textAlignment = NSTextAlignment.right;
        lblType.textColor = UIColor.black
        lblType.numberOfLines = 1;
        lblType.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblType.text = NSLocalizedString("lblType",comment:"")
        AccView.addSubview(lblType)
        
        let lblTypeRes = UILabel(frame: CGRect(x: 0.45*width, y: 0.07*height, width: 0.35*width, height: 0.03*height));
        lblTypeRes.backgroundColor = UIColor.clear;
        lblTypeRes.textAlignment = NSTextAlignment.left;
        lblTypeRes.textColor = UIColor.black
        lblTypeRes.numberOfLines = 0;
        lblTypeRes.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        lblTypeRes.text = FType
        AccView.addSubview(lblTypeRes)
        
        let lblStatus = UILabel(frame: CGRect(x: 0.001*width, y: 0.1*height, width: 0.4*width, height: 0.03*height));
        lblStatus.backgroundColor = UIColor.clear;
        lblStatus.textAlignment = NSTextAlignment.right;
        lblStatus.textColor = UIColor.black
        lblStatus.numberOfLines = 1;
        lblStatus.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblStatus.text = NSLocalizedString("lblStatus",comment:"")
        AccView.addSubview(lblStatus)
        
        let lblStatusRes = UILabel(frame: CGRect(x: 0.45*width, y: 0.1*height, width: 0.4*width, height: 0.03*height));
        lblStatusRes.backgroundColor = UIColor.clear;
        lblStatusRes.textAlignment = NSTextAlignment.left;
        lblStatusRes.textColor = UIColor.black
        lblStatusRes.numberOfLines = 0;
        lblStatusRes.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        lblStatusRes.text = Status
        
        if Status != "Completed"
        {
            lblStatusRes.textColor = colorWithHexString("929292")
        }else{
            lblStatusRes.textColor = colorWithHexString("129C21")
        }

        AccView.addSubview(lblStatusRes)
        
        LastName = appDelegate.gtblLogin["LastName"]!
        
        CargaFollowUp()

        if appDelegate.ynIPad {
            switch appDelegate.Model {
            case "iPad 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
            case "iPad Air":
                tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
            case "iPad Air 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
            case "iPad Pro":
                tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
            case "iPad Retina":
                tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
            default:
                tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
            }
        }else{
            switch appDelegate.Model {
            case "iPhone":
                tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 4":
                tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 4s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 5":
                tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 5c":
                tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 5s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 6":
                tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 6 Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 6s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 6s Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
            default:
                tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
            }
        }
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            AccView.backgroundColor = UIColor.clear
            
            //AccView.backgroundColor = colorWithHexString ("DDF4FF")
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            //tableView.backgroundColor = colorWithHexString ("DDF4FF")
            
            AccView.backgroundColor = UIColor.white
            tableView.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"bg.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: -0.05*height, width: width, height: height+(0.05*height));
            imgvwBack.alpha = 0.3
            imgvwBack.contentMode = UIView.ContentMode.scaleAspectFill
            //self.view.addSubview(imgvwBack)
            
            var imgHdr = UIImage()
            var imgHdrVw = UIImageView()
            
            imgHdr = UIImage(named:"Titlehdr.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.0, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.6
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.03*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.58
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.06*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.56
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlefooter.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.09*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.54
            AccView.addSubview(imgHdrVw)
            
            var strFontTitle: String = "Futura-CondensedExtraBold"
            var Color: UIColor = colorWithHexString("ba8748")
            
            lblDesc.textColor = Color
            lblStay.textColor = Color
            lblType.textColor = Color
            lblStatus.textColor = Color
            lblDesc.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblStay.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblType.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblStatus.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            strFontTitle = "Futura-CondensedMedium"
            Color = colorWithHexString("ba8748")
            
            lblDescRes.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblStayRes.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblTypeRes.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblStatusRes.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblDescRes.textColor = Color
            lblStayRes.textColor = Color
            lblTypeRes.textColor = Color
            lblStatusRes.textColor = Color
            
            lblDesc.textAlignment = NSTextAlignment.left
            lblDesc.frame = CGRect(x: 0.02*width, y: 0.00001*height, width: 0.2*width, height: 0.03*height);
            lblStay.textAlignment = NSTextAlignment.left
            lblStay.frame = CGRect(x: 0.02*width, y: 0.029*height, width: 0.2*width, height: 0.03*height);
            lblType.textAlignment = NSTextAlignment.left
            lblType.frame = CGRect(x: 0.02*width, y: 0.058*height, width: 0.2*width, height: 0.03*height);
            lblStatus.textAlignment = NSTextAlignment.left
            lblStatus.frame = CGRect(x: 0.02*width, y: 0.087*height, width: 0.2*width, height: 0.03*height);
            
            lblDescRes.numberOfLines = 0
            lblDescRes.frame = CGRect(x: 0.24*width, y: 0.0001*height, width: 0.45*width, height: 0.03*height);
            lblStayRes.numberOfLines = 0
            lblStayRes.frame = CGRect(x: 0.24*width, y: 0.0297*height, width: 0.45*width, height: 0.03*height);
            lblTypeRes.numberOfLines = 0
            lblTypeRes.frame = CGRect(x: 0.24*width, y: 0.059*height, width: 0.45*width, height: 0.03*height);
            lblStatusRes.numberOfLines = 0
            lblStatusRes.frame = CGRect(x: 0.24*width, y: 0.0885*height, width: 0.6*width, height: 0.03*height);
            
            
            AccView.addSubview(lblDesc)
            AccView.addSubview(lblStay)
            AccView.addSubview(lblType)
            AccView.addSubview(lblStatus)
            
            AccView.addSubview(lblDescRes)
            AccView.addSubview(lblStayRes)
            AccView.addSubview(lblTypeRes)
            AccView.addSubview(lblStatusRes)
            
            self.view.addSubview(AccView)
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            
            if appDelegate.ynIPad {
                switch appDelegate.Model {
                case "iPad 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPad Air":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPad Air 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPad Pro":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPad Retina":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                }
            }else{
                switch appDelegate.Model {
                case "iPhone":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 4":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 4s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 5":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.4*height);
                case "iPhone 5c":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 5s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.24*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 6":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 6 Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 6s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 6s Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                }
            }
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            AccView.backgroundColor = UIColor.clear
            
            //AccView.backgroundColor = colorWithHexString ("DDF4FF")
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            //tableView.backgroundColor = colorWithHexString ("DDF4FF")
            
            AccView.backgroundColor = UIColor.white
            tableView.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"bg.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: -0.05*height, width: width, height: height+(0.05*height));
            imgvwBack.alpha = 0.3
            imgvwBack.contentMode = UIView.ContentMode.scaleAspectFill
            //self.view.addSubview(imgvwBack)
            
            var imgHdr = UIImage()
            var imgHdrVw = UIImageView()
            
            imgHdr = UIImage(named:"Titlehdr.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.0, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.6
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.03*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.58
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.06*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.56
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlefooter.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.09*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.54
            AccView.addSubview(imgHdrVw)
            
            var strFontTitle: String = "Futura-CondensedExtraBold"
            var Color: UIColor = colorWithHexString("5c9fcc")
            
            lblDesc.textColor = Color
            lblStay.textColor = Color
            lblType.textColor = Color
            lblStatus.textColor = Color
            lblDesc.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblStay.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblType.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblStatus.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            strFontTitle = "Futura-CondensedMedium"
            Color = colorWithHexString("5c9fcc")
            
            lblDescRes.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblStayRes.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblTypeRes.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblStatusRes.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblDescRes.textColor = Color
            lblStayRes.textColor = Color
            lblTypeRes.textColor = Color
            lblStatusRes.textColor = Color
            
            lblDesc.textAlignment = NSTextAlignment.left
            lblDesc.frame = CGRect(x: 0.02*width, y: 0.00001*height, width: 0.2*width, height: 0.03*height);
            lblStay.textAlignment = NSTextAlignment.left
            lblStay.frame = CGRect(x: 0.02*width, y: 0.029*height, width: 0.2*width, height: 0.03*height);
            lblType.textAlignment = NSTextAlignment.left
            lblType.frame = CGRect(x: 0.02*width, y: 0.058*height, width: 0.2*width, height: 0.03*height);
            lblStatus.textAlignment = NSTextAlignment.left
            lblStatus.frame = CGRect(x: 0.02*width, y: 0.087*height, width: 0.2*width, height: 0.03*height);
            
            lblDescRes.numberOfLines = 0
            lblDescRes.frame = CGRect(x: 0.24*width, y: 0.0001*height, width: 0.45*width, height: 0.03*height);
            lblStayRes.numberOfLines = 0
            lblStayRes.frame = CGRect(x: 0.24*width, y: 0.0297*height, width: 0.45*width, height: 0.03*height);
            lblTypeRes.numberOfLines = 0
            lblTypeRes.frame = CGRect(x: 0.24*width, y: 0.059*height, width: 0.45*width, height: 0.03*height);
            lblStatusRes.numberOfLines = 0
            lblStatusRes.frame = CGRect(x: 0.24*width, y: 0.0885*height, width: 0.6*width, height: 0.03*height);

            
            AccView.addSubview(lblDesc)
            AccView.addSubview(lblStay)
            AccView.addSubview(lblType)
            AccView.addSubview(lblStatus)
            
            AccView.addSubview(lblDescRes)
            AccView.addSubview(lblStayRes)
            AccView.addSubview(lblTypeRes)
            AccView.addSubview(lblStatusRes)
            
            self.view.addSubview(AccView)
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            
            if appDelegate.ynIPad {
                switch appDelegate.Model {
                case "iPad 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPad Air":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPad Air 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPad Pro":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPad Retina":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                }
            }else{
                switch appDelegate.Model {
                case "iPhone":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 4":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 4s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 5":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.4*height);
                case "iPhone 5c":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 5s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.24*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 6":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 6 Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 6s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 6s Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                }
            }
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            AccView.backgroundColor = UIColor.clear
            
            //AccView.backgroundColor = colorWithHexString ("DDF4FF")
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            //tableView.backgroundColor = colorWithHexString ("DDF4FF")
            
            AccView.backgroundColor = UIColor.white
            tableView.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"bg.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: -0.05*height, width: width, height: height+(0.05*height));
            imgvwBack.alpha = 0.3
            imgvwBack.contentMode = UIView.ContentMode.scaleAspectFill
            //self.view.addSubview(imgvwBack)
            
            var imgHdr = UIImage()
            var imgHdrVw = UIImageView()
            
            imgHdr = UIImage(named:"Titlehdr.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.0, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.6
            //AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.03*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.58
            //AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.06*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.56
            //AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlefooter.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.09*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.54
            //AccView.addSubview(imgHdrVw)
            
            var strFontTitle: String = "Futura-CondensedExtraBold"
            var Color: UIColor = colorWithHexString("004c50")
            
            lblDesc.textColor = Color
            lblStay.textColor = Color
            lblType.textColor = Color
            lblStatus.textColor = Color
            lblDesc.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblStay.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblType.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblStatus.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            strFontTitle = "Futura-CondensedMedium"
            Color = colorWithHexString("2e3634")
            
            lblDescRes.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblStayRes.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblTypeRes.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblStatusRes.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblDescRes.textColor = Color
            lblStayRes.textColor = Color
            lblTypeRes.textColor = Color
            lblStatusRes.textColor = Color
            
            lblDesc.textAlignment = NSTextAlignment.left
            lblDesc.frame = CGRect(x: 0.02*width, y: 0.00001*height, width: 0.2*width, height: 0.03*height);
            lblStay.textAlignment = NSTextAlignment.left
            lblStay.frame = CGRect(x: 0.02*width, y: 0.029*height, width: 0.2*width, height: 0.03*height);
            lblType.textAlignment = NSTextAlignment.left
            lblType.frame = CGRect(x: 0.02*width, y: 0.058*height, width: 0.2*width, height: 0.03*height);
            lblStatus.textAlignment = NSTextAlignment.left
            lblStatus.frame = CGRect(x: 0.02*width, y: 0.087*height, width: 0.2*width, height: 0.03*height);
            
            lblDescRes.numberOfLines = 0
            lblDescRes.frame = CGRect(x: 0.24*width, y: 0.0001*height, width: 0.45*width, height: 0.03*height);
            lblStayRes.numberOfLines = 0
            lblStayRes.frame = CGRect(x: 0.24*width, y: 0.0297*height, width: 0.45*width, height: 0.03*height);
            lblTypeRes.numberOfLines = 0
            lblTypeRes.frame = CGRect(x: 0.24*width, y: 0.059*height, width: 0.45*width, height: 0.03*height);
            lblStatusRes.numberOfLines = 0
            lblStatusRes.frame = CGRect(x: 0.24*width, y: 0.0885*height, width: 0.6*width, height: 0.03*height);
            
            
            AccView.addSubview(lblDesc)
            AccView.addSubview(lblStay)
            AccView.addSubview(lblType)
            AccView.addSubview(lblStatus)
            
            AccView.addSubview(lblDescRes)
            AccView.addSubview(lblStayRes)
            AccView.addSubview(lblTypeRes)
            AccView.addSubview(lblStatusRes)
            
            self.view.addSubview(AccView)
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            
            if appDelegate.ynIPad {
                switch appDelegate.Model {
                case "iPad 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPad Air":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPad Air 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPad Pro":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPad Retina":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                }
            }else{
                switch appDelegate.Model {
                case "iPhone":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 4":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 4s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 5":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.4*height);
                case "iPhone 5c":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 5s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.24*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 6":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 6 Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 6s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                case "iPhone 6s Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.5*height);
                }
            }
            
        }
        
        self.tableView.reloadData()
        
    }
    
    func switchIsChanged(_ mySwitch: UISwitch) {
        
        if mySwitch.isOn {
            ynShowHistory = true
        } else {
            ynShowHistory = false
        }
        
        CargaFollowUp()
        
        self.tableView.reloadData()
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tblFollowUp.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if lastIndex.count > 0 {
            if indexPath.row != lastIndex.row{
                return 0.07*height
            }else{
                if isSelected == true
                {
                    return (0.06 + (rowHeight/height))*height
                }else{
                    return 0.07*height
                }
            }
        }else{
            return 0.07*height
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CellFollowUpDetail") as! tvcFollowUpDetail
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            // Initialize a gradient view
            let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 0.9*width, height: 0.12*height))
            
            // Optionally set some locations
            gradientView.locations = [0.4, 1.0]
            
            // Optionally change the direction. The default is vertical.
            gradientView.direction = .vertical
            
            // Add some borders too if you want
            gradientView.topBorderColor = UIColor.lightGray
            
            gradientView.bottomBorderColor = colorWithHexString ("C7C7CD")
            
            /*if isSelected == false
             {
             isSelected = true
             }else{
             if lastIndex.length > 0 {
             if indexPath.row != lastIndex.row{
             isSelected = true
             }else{
             isSelected = false
             }
             }else{
             isSelected = true
             }
             }*/
            
            if lastIndex.count > 0 {
                if indexPath.row != lastIndex.row{
                    rowSelected = false
                }else{
                    rowSelected = true
                }
            }else{
                rowSelected = false
            }
            
            if lastIndex.count > 0 {
                if indexPath.row != lastIndex.row{
                    ynSelected = false
                }else{
                    if isSelected == rowSelected {
                        ynSelected = true
                    }else{
                        ynSelected = false
                    }
                }
            }else{
                ynSelected = false
            }
            
            if lastIndex.count > 0 {
                if indexPath.row != lastIndex.row{
                    
                    // Set the gradient colors 8DE3F5 5C9F00
                    gradientView.colors = [UIColor.white, colorWithHexString ("F2F2F2")]
                    
                }else{
                    if isSelected == true
                    {
                        // Set the gradient colors 8DE3F5 5C9F00
                        gradientView.colors = [UIColor.white, colorWithHexString ("F2F2F2")]
                    }else{
                        // Set the gradient colors 8DE3F5 5C9F00
                        gradientView.colors = [UIColor.white, colorWithHexString ("F2F2F2")]
                    }
                }
            }else{
                
                // Set the gradient colors 8DE3F5 5C9F00
                gradientView.colors = [UIColor.white, colorWithHexString ("F2F2F2")]
                
            }
            
            cell.backgroundView = gradientView
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            cell.backgroundColor = UIColor.clear
            
            
            if lastIndex.count > 0 {
                if indexPath.row != lastIndex.row{
                    rowSelected = false
                }else{
                    rowSelected = true
                }
            }else{
                rowSelected = false
            }
            
            if lastIndex.count > 0 {
                if indexPath.row != lastIndex.row{
                    ynSelected = false
                }else{
                    if isSelected == rowSelected {
                        ynSelected = true
                    }else{
                        ynSelected = false
                    }
                }
            }else{
                ynSelected = false
            }
            
            if indexPath.row == 0{
                imgCell = UIImage(named:"tblacchdr.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblacchdrSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }else if (tblFollowUp.count-1) == indexPath.row{
                imgCell = UIImage(named:"tblaccfooter.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblaccfooterSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            } else {
                
                imgCell = UIImage(named:"tblaccrow.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblaccrowSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }
            
            if (tblFollowUp.count) == 1
            {
                imgCell = UIImage(named:"tblaccrowsingle.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblaccrowsingleSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
                
            }
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            cell.backgroundColor = UIColor.clear
            
            
            if lastIndex.count > 0 {
                if indexPath.row != lastIndex.row{
                    rowSelected = false
                }else{
                    rowSelected = true
                }
            }else{
                rowSelected = false
            }
            
            if lastIndex.count > 0 {
                if indexPath.row != lastIndex.row{
                    ynSelected = false
                }else{
                    if isSelected == rowSelected {
                        ynSelected = true
                    }else{
                        ynSelected = false
                    }
                }
            }else{
                ynSelected = false
            }
            
            if indexPath.row == 0{
                imgCell = UIImage(named:"tblacchdr.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblacchdrSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }else if (tblFollowUp.count-1) == indexPath.row{
                imgCell = UIImage(named:"tblaccfooter.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblaccfooterSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            } else {
                
                imgCell = UIImage(named:"tblaccrow.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblaccrowSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }
            
            if (tblFollowUp.count) == 1
            {
                imgCell = UIImage(named:"tblaccrowsingle.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblaccrowsingleSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
                
            }
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
            
            cell.backgroundColor = UIColor.clear
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.layer.borderWidth = 1
            cell.layer.shadowOffset = CGSize(width: -1, height: 1)
            cell.layer.borderColor = UIColor.black.cgColor
            
            if lastIndex.count > 0 {
                if indexPath.row != lastIndex.row{
                    rowSelected = false
                }else{
                    rowSelected = true
                }
            }else{
                rowSelected = false
            }
            
            if lastIndex.count > 0 {
                if indexPath.row != lastIndex.row{
                    ynSelected = false
                }else{
                    if isSelected == rowSelected {
                        ynSelected = true
                    }else{
                        ynSelected = false
                    }
                }
            }else{
                ynSelected = false
            }
            
            /*if indexPath.row == 0{
                imgCell = UIImage(named:"tblacchdr.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblacchdrSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }else if (tblFollowUp.count-1) == indexPath.row{
                imgCell = UIImage(named:"tblaccfooter.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblaccfooterSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            } else {
                
                imgCell = UIImage(named:"tblaccrow.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblaccrowSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }
            
            if (tblFollowUp.count) == 1
            {
                imgCell = UIImage(named:"tblaccrowsingle.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblaccrowsingleSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
                
            }*/
        }
        
        if indexPath.row > 0 {
                rowHeight = cell.SetValues(String(tblFollowUp[indexPath.row]["ClosedBy"]!), Date: String(tblFollowUp[indexPath.row]["CrDt"]!), Desc: String(tblFollowUp[indexPath.row]["Solution"]!), width: width, height: height, select: ynSelected, blnRes: true)
        }else{
                rowHeight = cell.SetValues(String(tblFollowUp[indexPath.row]["Name"]!), Date: String(tblFollowUp[indexPath.row]["ExpectedDt"]!), Desc: String(tblFollowUp[indexPath.row]["Requiere"]!), width: width, height: height, select: ynSelected, blnRes: false)
        }
        
        cell.accessoryType = UITableViewCell.AccessoryType.none
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isSelected{
            if indexPath.row != lastIndex.row{
                isSelected = true
            }else{
                isSelected = false
            }
        }else{
            isSelected = true
        }
        
        lastIndex = tableView.indexPathForSelectedRow!

        self.tableView.reloadData()
        
    }

    func CargaFollowUp(){
        var iRes: String = ""
        var tblFollow: Dictionary<String, String>!
        
        tblFollowUp = []
        
        var tableItems = RRDataSet()
        let service=RRRestaurantService(url: appDelegate.URLService as String, host: appDelegate.Host as String, userNameMobile : appDelegate.UserName, passwordMobile: appDelegate.Password);
        tableItems = (service?.spGetMobileFollowUpVw("2", appCode: self.appDelegate.gstrAppName, peopleID: appDelegate.gstrLoginPeopleID, followUpId: FollowUpId, dataBase: self.appDelegate.strDataBaseByStay, sLanguage: self.appDelegate.strLenguaje))!
        
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
                table = tableItems.tables.object(at: 2) as! RRDataTable
                
                var r = RRDataRow()
                r = table.rows.object(at: 0) as! RRDataRow
                
                for r in table.rows{
                    
                    tblFollow = [:]
                    
                    tblFollow["ID"] = (r as AnyObject).getColumnByName("ID").content as? String
                    tblFollow["ExpectedDt"] = (r as AnyObject).getColumnByName("ExpectedDt").content as? String
                    tblFollow["FinishDt"] = (r as AnyObject).getColumnByName("FinishDt").content as? String
                    tblFollow["Reqshort"] = (r as AnyObject).getColumnByName("Reqshort").content as? String
                    tblFollow["Requiere"] = (r as AnyObject).getColumnByName("Requiere").content as? String
                    tblFollow["FType"] = (r as AnyObject).getColumnByName("FType").content as? String
                    tblFollow["ConfirmationCode"] = (r as AnyObject).getColumnByName("ConfirmationCode").content as? String
                    tblFollow["pkStayInfoID"] = (r as AnyObject).getColumnByName("pkStayInfoID").content as? String
                    tblFollow["Status"] = (r as AnyObject).getColumnByName("Status").content as? String
                    tblFollow["intv"] = (r as AnyObject).getColumnByName("intv").content as? String
                    tblFollow["IntvYear"] = (r as AnyObject).getColumnByName("IntvYear").content as? String
                    tblFollow["peopleID"] = (r as AnyObject).getColumnByName("peopleID").content as? String
                    tblFollow["Solution"] = (r as AnyObject).getColumnByName("Solution").content as? String
                    tblFollow["AccCode"] = (r as AnyObject).getColumnByName("AccCode").content as? String
                    tblFollow["CrDt"] = (r as AnyObject).getColumnByName("CrDt").content as? String
                    tblFollow["Name"] = (r as AnyObject).getColumnByName("Name").content as? String
                    tblFollow["ClosedBy"] = (r as AnyObject).getColumnByName("ClosedBy").content as? String
                    
                    tblFollowUp.append(tblFollow)
                    
                    if tblFollow["Solution"] != ""{
                        tblFollowUp.append(tblFollow)
                    }
                    
                }
                
                appDelegate.gtblFollowUp = tblFollowUp
                
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.toolbar.isHidden = true

        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Request Detail",
            AnalyticsParameterItemName: "Request Detail",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Request Detail", screenClass: appDelegate.gstrAppName)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (self.appDelegate.gblExitPreAuth == true){
            
            self.navigationController?.popViewController(animated: false)
        }
        
    }
    
    @IBAction func clickAccount(_ sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
