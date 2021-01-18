//
//  vcReservRest.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 9/03/17.
//  Copyright © 2017 Marco Cocom. All rights reserved.
//

import UIKit

class vcReservRestAvail: UIViewController, UITextFieldDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var ViewItem: UINavigationItem!
    
    var width: CGFloat!
    var height: CGFloat!
    var AccView: UIView = UIView()
    var RestaurantName: String = ""
    var Opentime: String = ""
    var tblRestAvail: [[[Dictionary<String, String>]]]!
    var iseccion: Int = 0
    var panel: UIView = UIView()
    var tblRestAvailAll: [Dictionary<String, String>]!
    
    var lblUnitR: UILabel = UILabel()
    var lblNameR: UITextField = UITextField()
    var lblLastNameR: UITextField = UITextField()
    var lblPeopleR: UITextField = UITextField()
    var lblChildR: UITextField = UITextField()
    var lblDateR: UIDatePicker = UIDatePicker()
    var lblStartTimeR: UITextField = UITextField()
    var RestaurantCode: String = ""
    var PropertyCode: String = ""
    var strOpentime: String = ""
    var scrollView: UIScrollView!
    var Color = UIColor()
    var ColorR = UIColor()
    var Colorbtn1 = UIColor()
    var Colorbtn2 = UIColor()
    var Colorbtn3 = UIColor()
    var strDayName: String = ""
    
    @IBOutlet weak var btnApply: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var mas: NSMutableAttributedString = NSMutableAttributedString()
        
        width = appDelegate.width
        height = appDelegate.height
        
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        //self.navigationController?.navigationBar.hidden = true;
        
        self.tabBarController?.navigationController?.navigationBar.isHidden = true;
        
        self.navigationController?.navigationBar.isHidden = false;
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString("lblReservRestAvail",comment:"");
        
        AccView.backgroundColor = UIColor.clear
        AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.24*height);
        
        self.view.backgroundColor = UIColor.white
        
        var strFontTitleExtra: String = "Futura-CondensedExtraBold"
        var strFontTitleMedium: String = "Futura-CondensedMedium"
        
        let lblUnit: UILabel = UILabel()
        let lblName: UILabel = UILabel()
        let lblLastName: UILabel = UILabel()
        let lblPeople: UILabel = UILabel()
        let lblChild: UILabel = UILabel()
        let lblDate: UILabel = UILabel()
        let lblStartTime: UILabel = UILabel()
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            Color = colorWithHexString("000000")
            ColorR = colorWithHexString("000000")
            
            Colorbtn1 = colorWithHexString("5d5854")
            Colorbtn2 = colorWithHexString("616167")
            Colorbtn3 = colorWithHexString("F2F2F2")
            
            strFontTitleExtra = "HelveticaNeue-Bold"
            strFontTitleMedium = "Helvetica"

            btnApply.titleLabel?.font = UIFont(name: strFontTitleMedium, size: self.appDelegate.gblFont6 + self.appDelegate.gblDeviceFont4)
            btnApply.setTitle(NSLocalizedString("btnApplyReserv",comment:""), for: UIControl.State())
            btnApply.backgroundColor = colorWithHexString("00467f")
            btnApply.layer.borderColor = colorWithHexString("00467f").cgColor
            btnApply.setTitleColor(UIColor.white, for: UIControl.State())
            btnApply.addTarget(self, action: #selector(vcReservRestAvail.Search(_:)), for: UIControl.Event.touchUpInside)
            
            lblUnit.textAlignment = NSTextAlignment.right
            lblName.textAlignment = NSTextAlignment.right
            lblLastName.textAlignment = NSTextAlignment.right
            lblPeople.textAlignment = NSTextAlignment.right
            lblChild.textAlignment = NSTextAlignment.right
            lblDate.textAlignment = NSTextAlignment.right
            lblStartTime.textAlignment = NSTextAlignment.right
            
            lblUnit.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblName.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblLastName.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblPeople.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblChild.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblDate.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblStartTime.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            
            lblUnitR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblNameR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblLastNameR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblPeopleR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblChildR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblStartTimeR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            lblStartTimeR.backgroundColor = UIColor.white
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
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
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.09*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.54
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.12*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.52
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.15*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.52
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.18*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.52
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.21*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.52
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlefooter.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.24*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.5
            AccView.addSubview(imgHdrVw)
            
            Color = colorWithHexString("ba8748")
            ColorR = colorWithHexString("ba8748")
            
            Colorbtn1 = colorWithHexString("ba8748")
            Colorbtn2 = colorWithHexString("7c6a56")
            Colorbtn3 = colorWithHexString("eee7dd")
            
            strFontTitleExtra = "Futura-CondensedExtraBold"
            strFontTitleMedium = "Futura-CondensedMedium"
            
            mas = NSMutableAttributedString(string: NSLocalizedString("btnApplyReserv",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:strFontTitleMedium, size:appDelegate.gblFont7 + appDelegate.gblDeviceFont3)!
                ])
            btnApply.setAttributedTitle(mas, for: UIControl.State())
            btnApply.titleLabel?.textAlignment = NSTextAlignment.center
            btnApply.titleLabel?.adjustsFontSizeToFitWidth = true
            btnApply.setTitleColor(Colorbtn1, for: UIControl.State())
            btnApply.layer.borderWidth = 4
            btnApply.layer.borderColor = Colorbtn2.cgColor
            btnApply.backgroundColor = Colorbtn3
            btnApply.tintColor = Colorbtn1
            btnApply.addTarget(self, action: #selector(vcReservRestAvail.Search(_:)), for: UIControl.Event.touchUpInside)
            
            lblUnit.textAlignment = NSTextAlignment.left
            lblName.textAlignment = NSTextAlignment.left
            lblLastName.textAlignment = NSTextAlignment.left
            lblPeople.textAlignment = NSTextAlignment.left
            lblChild.textAlignment = NSTextAlignment.left
            lblDate.textAlignment = NSTextAlignment.left
            lblStartTime.textAlignment = NSTextAlignment.left
            
            lblUnit.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblName.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblLastName.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblPeople.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblChild.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblDate.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblStartTime.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            
            lblUnitR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblNameR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont3 + appDelegate.gblDeviceFont3)
            lblLastNameR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont3 + appDelegate.gblDeviceFont3)
            lblPeopleR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblChildR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblStartTimeR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            
            lblStartTimeR.backgroundColor = UIColor.lightGray
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            Color = colorWithHexString("ba8748")
            ColorR = colorWithHexString("ba8748")
            
            Colorbtn1 = colorWithHexString("ba8748")
            Colorbtn2 = colorWithHexString("7c6a56")
            Colorbtn3 = colorWithHexString("eee7dd")
            
            strFontTitleExtra = "Futura-CondensedExtraBold"
            strFontTitleMedium = "Futura-CondensedMedium"
            
            mas = NSMutableAttributedString(string: NSLocalizedString("btnApplyReserv",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:strFontTitleMedium, size:appDelegate.gblFont7 + appDelegate.gblDeviceFont3)!
                ])
            btnApply.setAttributedTitle(mas, for: UIControl.State())
            btnApply.titleLabel?.textAlignment = NSTextAlignment.center
            btnApply.titleLabel?.adjustsFontSizeToFitWidth = true
            btnApply.setTitleColor(Colorbtn1, for: UIControl.State())
            btnApply.layer.borderWidth = 4
            btnApply.layer.borderColor = Colorbtn2.cgColor
            btnApply.backgroundColor = Colorbtn3
            btnApply.tintColor = Colorbtn1
            btnApply.addTarget(self, action: #selector(vcReservRestAvail.Search(_:)), for: UIControl.Event.touchUpInside)
            
            lblUnit.textAlignment = NSTextAlignment.left
            lblName.textAlignment = NSTextAlignment.left
            lblLastName.textAlignment = NSTextAlignment.left
            lblPeople.textAlignment = NSTextAlignment.left
            lblChild.textAlignment = NSTextAlignment.left
            lblDate.textAlignment = NSTextAlignment.left
            lblStartTime.textAlignment = NSTextAlignment.left
            
            lblUnit.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblName.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblLastName.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblPeople.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblChild.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblDate.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblStartTime.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            
            lblUnitR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblNameR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont3 + appDelegate.gblDeviceFont3)
            lblLastNameR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont3 + appDelegate.gblDeviceFont3)
            lblPeopleR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblChildR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblStartTimeR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            
            lblStartTimeR.backgroundColor = UIColor.lightGray
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
            
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
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.09*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.54
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.12*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.52
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.15*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.52
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.18*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.52
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.21*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.52
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlefooter.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.24*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.5
            AccView.addSubview(imgHdrVw)
            
            Color = colorWithHexString("2e3634")
            ColorR = colorWithHexString("2e3634")
            
            Colorbtn1 = colorWithHexString("ba8748")
            Colorbtn2 = colorWithHexString("7c6a56")
            Colorbtn3 = colorWithHexString("eee7dd")
            
            strFontTitleExtra = "Futura-CondensedExtraBold"
            strFontTitleMedium = "Futura-CondensedMedium"
            
            mas = NSMutableAttributedString(string: NSLocalizedString("btnApplyReserv",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:strFontTitleMedium, size:appDelegate.gblFont7 + appDelegate.gblDeviceFont3)!
                ])
            btnApply.setAttributedTitle(mas, for: UIControl.State())
            btnApply.titleLabel?.textAlignment = NSTextAlignment.center
            btnApply.titleLabel?.adjustsFontSizeToFitWidth = true
            btnApply.setTitleColor(Colorbtn1, for: UIControl.State())
            btnApply.layer.borderWidth = 4
            btnApply.layer.borderColor = Colorbtn2.cgColor
            btnApply.backgroundColor = Colorbtn3
            btnApply.tintColor = Colorbtn1
            btnApply.addTarget(self, action: #selector(vcReservRestAvail.Search(_:)), for: UIControl.Event.touchUpInside)
            
            lblUnit.textAlignment = NSTextAlignment.left
            lblName.textAlignment = NSTextAlignment.left
            lblLastName.textAlignment = NSTextAlignment.left
            lblPeople.textAlignment = NSTextAlignment.left
            lblChild.textAlignment = NSTextAlignment.left
            lblDate.textAlignment = NSTextAlignment.left
            lblStartTime.textAlignment = NSTextAlignment.left
            
            lblUnit.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblName.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblLastName.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblPeople.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblChild.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblDate.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblStartTime.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            
            lblUnitR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblNameR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont3 + appDelegate.gblDeviceFont3)
            lblLastNameR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont3 + appDelegate.gblDeviceFont3)
            lblPeopleR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblChildR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblStartTimeR.font = UIFont(name:strFontTitleMedium, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            
            lblStartTimeR.backgroundColor = UIColor.lightGray
            
        }

        lblUnit.text = NSLocalizedString("lblRestUnit",comment:"")
        lblName.text = NSLocalizedString("lblRestName",comment:"")
        //lblLastName.text = NSLocalizedString("lblRestLastName",comment:"")
        lblPeople.text = NSLocalizedString("lblRestAdultChild",comment:"")
        //lblChild.text = NSLocalizedString("lblRestChildren",comment:"")
        lblDate.text = NSLocalizedString("lblRestDate",comment:"")
        lblStartTime.text = NSLocalizedString("lblRestOpentime",comment:"")
        
        lblUnit.textColor = Color
        lblName.textColor = Color
        lblLastName.textColor = Color
        lblPeople.textColor = Color
        lblChild.textColor = Color
        lblDate.textColor = Color
        lblStartTime.textColor = Color

        lblNameR.layer.borderColor = UIColor.black.cgColor
        lblNameR.borderStyle = UITextField.BorderStyle.roundedRect
        lblNameR.keyboardType = UIKeyboardType.alphabet
        
        lblLastNameR.layer.borderColor = UIColor.black.cgColor
        lblLastNameR.borderStyle = UITextField.BorderStyle.roundedRect
        lblLastNameR.keyboardType = UIKeyboardType.alphabet
        
        lblPeopleR.layer.borderColor = UIColor.black.cgColor
        lblPeopleR.borderStyle = UITextField.BorderStyle.roundedRect
        lblPeopleR.keyboardType = UIKeyboardType.numberPad
        
        lblChildR.layer.borderColor = UIColor.black.cgColor
        lblChildR.borderStyle = UITextField.BorderStyle.roundedRect
        lblChildR.keyboardType = UIKeyboardType.numberPad
        
        lblStartTimeR.layer.borderColor = UIColor.black.cgColor
        lblStartTimeR.borderStyle = UITextField.BorderStyle.roundedRect
        lblStartTimeR.keyboardType = UIKeyboardType.numberPad
        
        lblUnitR.textColor = ColorR
        lblNameR.textColor = ColorR
        lblLastNameR.textColor = ColorR
        lblPeopleR.textColor = ColorR
        lblChildR.textColor = ColorR
        lblStartTimeR.textColor = ColorR
        
        //lblUnit.textAlignment = NSTextAlignment.left
        lblUnit.frame = CGRect(x: 0.02*width, y: 0.00001*height, width: 0.2*width, height: 0.03*height);
        //lblName.textAlignment = NSTextAlignment.left
        lblName.frame = CGRect(x: 0.02*width, y: 0.034*height, width: 0.2*width, height: 0.03*height);
        //lblLastName.textAlignment = NSTextAlignment.left
        lblLastName.frame = CGRect(x: 0.49*width, y: 0.034*height, width: 0.2*width, height: 0.03*height);
        //lblPeople.textAlignment = NSTextAlignment.left
        lblPeople.frame = CGRect(x: 0.02*width, y: 0.066*height, width: 0.2*width, height: 0.03*height);
        //lblChild.textAlignment = NSTextAlignment.left
        lblChild.frame = CGRect(x: 0.49*width, y: 0.066*height, width: 0.2*width, height: 0.03*height);
        //lblDate.textAlignment = NSTextAlignment.left
        lblDate.frame = CGRect(x: 0.02*width, y: 0.13*height, width: 0.2*width, height: 0.03*height);
        //lblStartTime.textAlignment = NSTextAlignment.left
        lblStartTime.frame = CGRect(x: 0.02*width, y: 0.1*height, width: 0.2*width, height: 0.03*height);
        
        lblUnitR.numberOfLines = 0
        lblUnitR.frame = CGRect(x: 0.24*width, y: 0.0001*height, width: 0.45*width, height: 0.03*height);
        lblNameR.frame = CGRect(x: 0.24*width, y: 0.034*height, width: 0.3*width, height: 0.03*height);
        lblLastNameR.frame = CGRect(x: 0.55*width, y: 0.034*height, width: 0.3*width, height: 0.03*height);
        lblPeopleR.frame = CGRect(x: 0.24*width, y: 0.066*height, width: 0.3*width, height: 0.03*height);
        lblChildR.frame = CGRect(x: 0.55*width, y: 0.066*height, width: 0.3*width, height: 0.03*height);
        lblDateR.frame = CGRect(x: -16, y: 0.14*height, width: width, height: 0.14*height);
        lblStartTimeR.frame = CGRect(x: 0.24*width, y: 0.1*height, width: 0.61*width, height: 0.03*height);
        
        lblNameR.placeholder = NSLocalizedString("lblRestFirstName",comment:"")
        lblLastNameR.placeholder = NSLocalizedString("lblRestLastName",comment:"")
        lblPeopleR.placeholder = NSLocalizedString("lblRestAdults",comment:"")
        lblChildR.placeholder = NSLocalizedString("lblRestChildren",comment:"")
        
        lblUnitR.text = appDelegate.strRestUnit
        lblNameR.text = appDelegate.strPeopleName
        lblLastNameR.text = appDelegate.strPeopleLastName
        lblPeopleR.text = appDelegate.RestCountPeople.description

        let pretime: AnyObject = Opentime as AnyObject
        let lentime: Int = pretime.description.characters.count - 5
        
        let strpre:  String = pretime.description
        
        let start = strpre.index(strpre.startIndex, offsetBy: 0)
        let end = strpre.index(strpre.endIndex, offsetBy: -lentime)
        let range = start..<end
        
        let mySubstring = strpre[range]
        
        strOpentime = String(mySubstring)
        
        lblStartTimeR.text = strOpentime
        lblChildR.text = "0"
        
        lblDateR.minimumDate = Date()
        lblDateR.datePickerMode = UIDatePicker.Mode.date
        lblDateR.locale = Locale(identifier: "en_GB")
        lblDateR.addTarget(self, action: #selector(vcReservRestAvail.ChangeDate(_:)), for: UIControl.Event.valueChanged)
        
        let todaysDate:Date = Date()
        let dtdateFormatter:DateFormatter = DateFormatter()
        dtdateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        let DateInFormat:String = dtdateFormatter.string(from: todaysDate)
        
        let dtdateFormatterAux:DateFormatter = DateFormatter()
        dtdateFormatterAux.dateFormat = "yyyy-MM-dd hh:mm a"
        let DateInFormatAux:Date = dtdateFormatterAux.date(from: DateInFormat)!
    
        lblDateR.setDate(DateInFormatAux, animated: true)
        
        btnApply.frame = CGRect(x: 0.1*width, y: 0.38*height, width: 0.8*width, height: 0.06*height);
        
        lblStartTimeR.isEnabled = false

        
        AccView.addSubview(lblUnit)
        AccView.addSubview(lblName)
        AccView.addSubview(lblLastName)
        AccView.addSubview(lblDate)
        AccView.addSubview(lblPeople)
        AccView.addSubview(lblChild)
        AccView.addSubview(lblChildR)
        AccView.addSubview(lblDate)
        AccView.addSubview(lblStartTime)
        AccView.addSubview(lblUnitR)
        AccView.addSubview(lblNameR)
        AccView.addSubview(lblLastNameR)
        AccView.addSubview(lblPeopleR)
        AccView.addSubview(lblDateR)
        AccView.addSubview(lblStartTimeR)
        
        lblNameR.delegate = self
        lblLastNameR.delegate = self
        lblChildR.delegate = self
        lblPeopleR.delegate = self

        self.view.addSubview(btnApply)
        
        self.view.addSubview(AccView)
        
        if appDelegate.ynIPad {
            switch appDelegate.Model {
            case "iPad 2":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.24*height);
                scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.45*self.height, width: self.width, height: 0.47*self.height))
            case "iPad Air":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.24*height);
                scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.45*self.height, width: self.width, height: 0.47*self.height))
            case "iPad Air 2":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.24*height);
                scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.45*self.height, width: self.width, height: 0.47*self.height))
            case "iPad Pro":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.24*height);
                scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.45*self.height, width: self.width, height: 0.47*self.height))
            case "iPad Retina":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.24*height);
                scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.45*self.height, width: self.width, height: 0.47*self.height))
            default:
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.24*height);
                scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.45*self.height, width: self.width, height: 0.47*self.height))
            }
        }else{
            switch appDelegate.Model {
            case "iPhone":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.24*height);
                scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.435*self.height, width: self.width, height: 0.43*self.height))
            case "iPhone 4":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.24*height);
                scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.435*self.height, width: self.width, height: 0.43*self.height))
            case "iPhone 4s":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.24*height);
                scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.435*self.height, width: self.width, height: 0.43*self.height))
            case "iPhone 5":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.24*height);
                scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.435*self.height, width: self.width, height: 0.43*self.height))
            case "iPhone 5c":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.24*height);
                scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.435*self.height, width: self.width, height: 0.43*self.height))
            case "iPhone 5s":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.24*height);
                scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.435*self.height, width: self.width, height: 0.43*self.height))
            case "iPhone 6":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.24*height);
                scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.435*self.height, width: self.width, height: 0.43*self.height))
            case "iPhone 6 Plus":
                AccView.frame = CGRect(x: 0.05*width, y: 0.08*height, width: 0.9*width, height: 0.24*height);
                scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.435*self.height, width: self.width, height: 0.47*self.height))
            case "iPhone 6s":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.24*height);
                scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.435*self.height, width: self.width, height: 0.43*self.height))
            case "iPhone 6s Plus":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.24*height);
                scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.435*self.height, width: self.width, height: 0.43*self.height))
            default:
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.24*height);
                scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.435*self.height, width: self.width, height: 0.43*self.height))
            }
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
    
    @objc func Search(_ sender: AnyObject) {
        
        let cal = Calendar.current
        
        let unit:NSCalendar.Unit = [.weekday]
        
        let components = (cal as NSCalendar).component(unit, from: lblDateR.date)
        
        var iResFin: Int = 0
        var sResFin: String = ""
        
        /*var strNameDate: String = ""
        
        if components == 1{
            strNameDate = "SUNDAY"
        }else if components == 2{
            strNameDate = "MONDAY"
        }else if components == 3{
            strNameDate = "TUESDAY"
        }else if components == 4{
            strNameDate = "WEDNESDAY"
        }else if components == 5{
            strNameDate = "THURSDAY"
        }else if components == 6{
            strNameDate = "FRIDAY"
        }else if components == 7{
            strNameDate = "SATURDAY"
        }*/
        
        if Int(strDayName) == components{
            
            GoogleWearAlert.showAlert(title: NSLocalizedString("InvalidDate",comment:""), type: .warning, duration: 3, iAction: 1, form:"InvalidDate")
            
            let todaysDate:Date = Date()
            let dtdateFormatter:DateFormatter = DateFormatter()
            dtdateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
            let DateInFormat:String = dtdateFormatter.string(from: todaysDate)
            
            let dtdateFormatterAux:DateFormatter = DateFormatter()
            dtdateFormatterAux.dateFormat = "yyyy-MM-dd hh:mm a"
            let DateInFormatAux:Date = dtdateFormatterAux.date(from: DateInFormat)!
            
            lblDateR.setDate(DateInFormatAux, animated: true)
            
        }else{
            
            var tableItems = RRDataSet()
            var iRes: String = ""
            var tblRestAvailTemp: Dictionary<String, String>!
            var iSection: Int = 0
            var iSectionTheme: Int = 0
            var iSectionArea: Int = 0
            var ThemeDescriptionEng: String = ""
            var ZoneDescription: String = ""
            var tblRestAvail: [[[Dictionary<String, String>]]]
            var tblRestAvailAll: [Dictionary<String, String>]!
            var strChild: String = ""
            var strAdult: String = ""
            var indexThem: Int = 0
            var strInitHour: String = ""
            var sRes: String = ""
            
            self.btnApply.isUserInteractionEnabled = false
            self.btnApply.isEnabled = false
            
            if self.lblPeopleR.text == ""
            {
                strAdult = "0"
            }else{
                strAdult = self.lblPeopleR.text!
            }
            
            if self.lblChildR.text == ""
            {
                strChild = "0"
            }else{
                strChild = self.lblChildR.text!
            }
            
            let dateFormatterWST: DateFormatter = DateFormatter()
            dateFormatterWST.dateFormat = "yyyy-MM-dd"
            let dateStrWST = dateFormatterWST.string(from: lblDateR.date)
            
            tblRestAvail = []
            tblRestAvailAll = []
            
            var config : SwiftLoader.Config = SwiftLoader.Config()
            config.size = 100
            config.backgroundColor = UIColor(white: 1, alpha: 0.5)
            config.spinnerColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
            config.titleTextColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
            config.spinnerLineWidth = 2.0
            SwiftLoader.setConfig(config)
            SwiftLoader.show(animated: true)
            SwiftLoader.show(title: NSLocalizedString("lblLoading",comment:""), animated: true)
            
            
            let calendar = Calendar.current
            let comp = (calendar as NSCalendar).components([.hour, .minute], from: Date())
            let hour = comp.hour
            let minute = comp.minute
            
            strInitHour = (hour?.description)! + ":" + (minute?.description)!
            
            let dateFormatter2: DateFormatter = DateFormatter()
            dateFormatter2.dateFormat = "yyyy-MM-dd"
            let date2 = dateFormatter2.date(from: dateStrWST)
            
            let todaysDate:Date = Date()
            let dateFormatter:DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let DateInFormat:String = dateFormatter.string(from: todaysDate)
            
            let dateFormatter3:DateFormatter = DateFormatter()
            dateFormatter3.dateFormat = "yyyy-MM-dd"
            let DateInFormat3:Date = dateFormatter3.date(from: DateInFormat)!
            
            if date2!.equalToDate(DateInFormat3){
                strInitHour = (hour?.description)! + ":" + (minute?.description)!
            }else if date2!.isGreaterThanDate(DateInFormat3){
                
                strInitHour = lblStartTimeR.text!
                
            }
            
            let queue = OperationQueue()
            
            queue.addOperation() {//1
                //accion base de datos
                //print("A1")
                if Reachability.isConnectedToNetwork(){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    
                    let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                    tableItems = (service?.spGetRestaurantAvailability("1", restaurantCode: self.RestaurantCode, dateTimeStart: dateStrWST + " " + strInitHour, peopleNo: strAdult, children: strChild, dataBase: self.appDelegate.strDataBaseByStay))!
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
                OperationQueue.main.addOperation() {
                    queue.addOperation() {//2
                        //accion base de datos
                        //print("A2")
                        
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
                                
                                if table.rows != nil{
                                    var r = RRDataRow()
                                    r = table.rows.object(at: 0) as! RRDataRow
                                    
                                    if r.getColumnByName("iResult") != nil{
                                        iRes = r.getColumnByName("iResult").content as! String
                                        sRes = r.getColumnByName("sResult").content as! String
                                    }else{
                                        iRes = "1"
                                    }
                                    
                                    let iResAux = (iRes as NSString).integerValue
                                    
                                    iResFin = iResAux
                                    sResFin = sRes
                                    
                                    if iResAux > 0 {
                                    
                                            for r in table.rows{
                                                
                                                if indexThem == 0{
                                                    iSection = 0
                                                    iSectionArea = 0
                                                    iSectionTheme = 0
                                                    tblRestAvail.append([[[:]]])
                                                }else if ThemeDescriptionEng != ((r as AnyObject).getColumnByName("ThemeDescriptionEng").content as? String)!{
                                                    iSection = 0
                                                    iSectionArea = 0
                                                    iSectionTheme = iSectionTheme + 1
                                                    tblRestAvail.append([[[:]]])
                                                }else{
                                                    if ZoneDescription != ((r as AnyObject).getColumnByName("ZoneDescriptionEng").content as? String)!{
                                                        iSection = 0
                                                        iSectionArea = iSectionArea + 1
                                                        tblRestAvail[iSectionTheme].append([[:]])
                                                    }else{
                                                        iSection = iSection + 1
                                                        tblRestAvail[iSectionTheme][iSectionArea].append([:])
                                                    }
                                                }
                                                
                                                tblRestAvailTemp = [:]
                                                
                                                ThemeDescriptionEng = ((r as AnyObject).getColumnByName("ThemeDescriptionEng").content as? String)!
                                                ZoneDescription = ((r as AnyObject).getColumnByName("ZoneDescriptionEng").content as? String)!
                                                
                                                tblRestAvailTemp["ID"] = (r as AnyObject).getColumnByName("ID").content as? String
                                                tblRestAvailTemp["EventDescription"] = (r as AnyObject).getColumnByName("EventDescription").content as? String
                                                tblRestAvailTemp["ThemeDescriptionEng"] = (r as AnyObject).getColumnByName("ThemeDescriptionEng").content as? String
                                                tblRestAvailTemp["ThemeDescriptionSpa"] = (r as AnyObject).getColumnByName("ThemeDescriptionSpa").content as? String
                                                tblRestAvailTemp["ZoneDescriptionEng"] = (r as AnyObject).getColumnByName("ZoneDescriptionEng").content as? String
                                                tblRestAvailTemp["ZoneDescriptionEsp"] = (r as AnyObject).getColumnByName("ZoneDescriptionEsp").content as? String
                                                tblRestAvailTemp["IntervalTime"] = (r as AnyObject).getColumnByName("IntervalTime").content as? String
                                                tblRestAvailTemp["SearAvailable"] = (r as AnyObject).getColumnByName("SearAvailable").content as? String
                                                tblRestAvailTemp["AvailableLevel"] = (r as AnyObject).getColumnByName("AvailableLevel").content as? String
                                                tblRestAvailTemp["RestCode"] = (r as AnyObject).getColumnByName("RestCode").content as? String
                                                tblRestAvailTemp["pkZoneID"] = (r as AnyObject).getColumnByName("pkZoneID").content as? String
                                                tblRestAvailTemp["pkEventID"] = (r as AnyObject).getColumnByName("pkEventID").content as? String
                                                tblRestAvailTemp["pkRestaurantEventID"] = (r as AnyObject).getColumnByName("pkRestaurantEventID").content as? String
                                                tblRestAvailTemp["ZoneCode"] = (r as AnyObject).getColumnByName("ZoneCode").content as? String
                                                tblRestAvailAll.append(tblRestAvailTemp)
                                                tblRestAvail[iSectionTheme][iSectionArea][iSection] = tblRestAvailTemp
                                                
                                                indexThem = indexThem + 1
                                                
                                            }
                                            
                                            self.tblRestAvailAll = tblRestAvailAll
                                            self.tblRestAvail = tblRestAvail
                                            self.iseccion = self.tblRestAvail.count
                                        
                                    } else {

                                           
                                           DispatchQueue.main.async {
                                             
                                               RKDropdownAlert.title(sResFin.description, backgroundColor: UIColor.red, textColor: UIColor.black)
                                             
                                           }

                                    }
                                    
                                }
                                
                            }
                            
                        }
                        

                        OperationQueue.main.addOperation() {
                            //accion
                            if !Reachability.isConnectedToNetwork(){
                                RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                            }
                            
                            var indexTheme: Int = 0
                            var indexArea: Int = 0
                            var iSeccion: Int = 0
                            var hArea: CGFloat = 0.0
                            var halt: CGFloat = 0.0
                            var wArea: CGFloat = 0.0
                            var hAreabtn: CGFloat = 0.0
                            var strIntvTime: String = ""
                            var iSeccionAux: Int = -1
                            var haltFin: CGFloat = 0.0
                            var ynExt: Bool = false
                            var hAreaCont: CGFloat = 0.0
                            
                            halt = 0.02*self.height
                            haltFin = 0.01*self.height
                            
                            for view in self.panel.subviews {
                                view.removeFromSuperview()
                            }
                            
                            if tblRestAvail.count > 0
                            {
                                
                                for _ in 0...(tblRestAvail.count)-1 {
                                    
                                    indexArea = 0
                                    
                                    for _ in 0...(tblRestAvail[indexTheme].count)-1 {
                                        var themeView: UIView = UIView()
                                        var lblTheme: UILabel = UILabel()
                                        var themeArea: UIView = UIView()
                                        iSeccion = 0
                                        iSeccionAux = -1
                                        for _ in 0...(tblRestAvail[indexTheme][indexArea].count)-1 {
                                            
                                            var lblArea: UILabel = UILabel()
                                            
                                            var btnIntvTime: UIButton = UIButton()
                                            
                                            if self.appDelegate.strLenguaje == "ENG"{
                                                lblTheme.text = tblRestAvail[indexTheme][0][0]["ThemeDescriptionEng"]
                                                lblArea.text = tblRestAvail[indexTheme][indexArea][0]["ZoneDescriptionEng"]
                                            }else{
                                                lblTheme.text = tblRestAvail[indexTheme][0][0]["ThemeDescriptionSpa"]
                                                lblArea.text = tblRestAvail[indexTheme][indexArea][0]["ZoneDescriptionEsp"]
                                            }
                                            
                                            
                                            /*lblTheme.font = UIFont(name: "Cochin-BoldItalic", size: self.appDelegate.gblFont10 + self.appDelegate.gblDeviceFont3)
                                             lblTheme.textAlignment = NSTextAlignment.Left
                                             lblTheme.textColor = UIColor.blackColor()*/
                                            
                                            lblTheme.backgroundColor = UIColor.clear;
                                            lblTheme.textAlignment = NSTextAlignment.left;
                                            lblTheme.textColor = UIColor.gray;
                                            lblTheme.font = UIFont(name:"HelveticaNeue", size: self.appDelegate.gblFont10 + self.appDelegate.gblDeviceFont3)
                                            lblTheme.numberOfLines = 0;
                                            lblTheme.adjustsFontSizeToFitWidth = true
                                            
                                            lblArea.font = UIFont(name: "HelveticaNeue", size: self.appDelegate.gblFont8 + self.appDelegate.gblDeviceFont3)
                                            lblArea.textAlignment = NSTextAlignment.center
                                            lblArea.adjustsFontSizeToFitWidth = true
                                            lblArea.backgroundColor = self.Colorbtn3 //self.colorWithHexString("EEE7DD")
                                            lblArea.textColor = self.Color //self.colorWithHexString("ba8748")
                                            
                                            let pre: AnyObject = tblRestAvail[indexTheme][indexArea][iSeccion]["IntervalTime"]! as AnyObject
                                            let len: Int = pre.description.characters.count - 5
                                            
                                            let strpre: String = pre.description
                                            
                                            let start = strpre.index(strpre.startIndex, offsetBy: 0)
                                            let end = strpre.index(strpre.endIndex, offsetBy: -len)
                                            let range = start..<end
                                            
                                            let mySubstring = strpre[range]
                                            
                                            strIntvTime = mySubstring.description
                                            
                                            if (iSeccion == 0)
                                            {
                                                themeView.frame = CGRect(x: 0.05*self.width, y: haltFin, width: 0.9*self.width, height: 0.15*self.height);
                                                
                                                if indexArea == 0
                                                {
                                                    lblTheme.frame = CGRect(x: 0.0, y: 0.005*self.height, width: 0.9*self.width, height: 0.03*self.height);
                                                    themeView.addSubview(lblTheme)
                                                }
                                                
                                                //halt = halt + ((0.15)*self.height)
                                                hArea = 0.01*self.height
                                                wArea = 0.05*self.width
                                                hAreabtn = 0.1*self.height
                                                
                                            }
                                            
                                            if (iSeccion == 0) && (indexArea > 0)
                                            {
                                                hArea = hArea - (0.01*self.height)
                                                
                                            }else{
                                                hArea = ((0.04)*self.height)
                                            }
                                            
                                            if (wArea > 0.8*self.width) && (iSeccion > iSeccionAux)
                                            {
                                                hAreabtn = hAreabtn + ((0.05)*self.height)
                                                wArea = 0.05*self.width
                                                iSeccionAux = iSeccion
                                                haltFin = hAreabtn + ((0.04)*self.height)
                                                ynExt = true
                                            }
                                            
                                            if (iSeccion == 0){
                                                lblArea.frame = CGRect(x: 0.0, y: hArea, width: 0.9*self.width, height: 0.03*self.height);
                                                themeView.addSubview(lblArea)
                                                themeArea.frame = CGRect(x: 0.0, y: hArea + (0.035*self.height), width: 0.9*self.width, height: hAreabtn - (0.01*self.height));
                                                themeArea.backgroundColor = self.Colorbtn2//self.colorWithHexString("E6E7E9")
                                                themeView.addSubview(themeArea)
                                            }
                                            
                                            if (iSeccion == 0) && (indexArea > 0)
                                            {
                                                
                                                lblArea.frame = CGRect(x: 0.0, y: hArea, width: 0.9*self.width, height: 0.03*self.height);
                                                themeArea.frame = CGRect(x: 0.0, y: hArea + (0.035*self.height), width: 0.9*self.width, height: hAreabtn - (0.01*self.height));
                                                if indexTheme > 0{
                                                    lblArea.frame = CGRect(x: 0.0, y: hArea, width: 0.9*self.width, height: 0.03*self.height);
                                                    themeArea.frame = CGRect(x: 0.0, y: hArea + (0.035*self.height), width: 0.9*self.width, height: hAreabtn - (0.01*self.height))
                                                    
                                                }
                                            }else{
                                                
                                                if (iSeccion == 0){
                                                    lblArea.frame = CGRect(x: 0.0, y: hArea, width: 0.9*self.width, height: 0.03*self.height);
                                                    themeArea.frame = CGRect(x: 0.0, y: hArea + (0.035*self.height), width: 0.9*self.width, height: hAreabtn - (0.01*self.height));
                                                }else{
                                                    if ynExt{
                                                        
                                                        themeArea.frame = CGRect(x: 0.0, y: themeArea.bounds.origin.y + (0.035*self.height), width: 0.9*self.width, height: hAreabtn + (0.03*self.height));
                                                        ynExt = false
                                                        
                                                    }
                                                    
                                                }
                                                
                                                /*if ynExt{
                                                 
                                                 themeArea.frame = CGRectMake(0.0, themeArea.bounds.origin.y + (0.04*self.height), 0.9*self.width, hAreabtn - (0.01*self.height));
                                                 themeArea.backgroundColor = self.colorWithHexString("E6E7E9")
                                                 
                                                 ynExt = false
                                                 }*/
                                                
                                            }
                                            
                                            if (iSeccion == 0) && (indexArea > 0)
                                            {
                                                hAreabtn = 0.06*self.height
                                                /*if indexTheme > 0{
                                                 hAreabtn = hAreabtn + ((0.02)*self.height)
                                                 }*/
                                            }
                                            
                                            
                                            btnIntvTime.frame = CGRect(x: wArea, y: hAreabtn, width: 0.15*self.width, height: 0.04*self.height);
                                            
                                            
                                            btnIntvTime.titleLabel?.textAlignment = NSTextAlignment.center
                                            btnIntvTime.titleLabel?.adjustsFontSizeToFitWidth = true
                                            
                                            btnIntvTime.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: self.appDelegate.gblFont5 + self.appDelegate.gblDeviceFont4)
                                            //btnIntvTime.layer.borderWidth = 1
                                            btnIntvTime.setTitleColor(UIColor.white, for: UIControl.State())
                                            btnIntvTime.layer.cornerRadius = 5
                                            
                                            if Int(tblRestAvail[indexTheme][indexArea][iSeccion]["AvailableLevel"]!) == 0{
                                                btnIntvTime.isEnabled = false
                                                btnIntvTime.backgroundColor = UIColor.gray
                                            }else if Int(tblRestAvail[indexTheme][indexArea][iSeccion]["AvailableLevel"]!) == 1{
                                                //btnIntvTime.layer.borderColor = self.colorWithHexString("D93944").CGColor
                                                btnIntvTime.isEnabled = true
                                                btnIntvTime.backgroundColor = self.colorWithHexString("E05C66")
                                            }else if Int(tblRestAvail[indexTheme][indexArea][iSeccion]["AvailableLevel"]!) == 2{
                                                //btnIntvTime.layer.borderColor = self.colorWithHexString("CD9641").CGColor
                                                btnIntvTime.isEnabled = true
                                                btnIntvTime.backgroundColor = self.colorWithHexString("FEBE45")
                                            }else if Int(tblRestAvail[indexTheme][indexArea][iSeccion]["AvailableLevel"]!) == 3{
                                                //btnIntvTime.layer.borderColor = self.colorWithHexString("136E43").CGColor
                                                btnIntvTime.isEnabled = true
                                                btnIntvTime.backgroundColor = self.colorWithHexString("139D58")
                                            }
                                            
                                            btnIntvTime.setTitle(strIntvTime, for: UIControl.State())
                                            btnIntvTime.tag = Int(tblRestAvail[indexTheme][indexArea][iSeccion]["ID"]!)!
                                            btnIntvTime.addTarget(self, action: #selector(vcReservRestAvail.RestReserv(_:)), for: UIControl.Event.touchUpInside)
                                            
                                            wArea = wArea + 0.2*self.width
                                            
                                            themeView.addSubview(btnIntvTime)
                                            
                                            
                                            if iSeccion == (tblRestAvail[indexTheme][indexArea].count - 1)
                                            {
                                                
                                                if indexTheme == 0{
                                                    themeView.frame = CGRect(x: 0.05*self.width, y: halt, width: 0.9*self.width, height: hAreabtn + ((0.09)*self.height));
                                                    halt = halt + themeView.bounds.height
                                                }else{
                                                    themeView.frame = CGRect(x: 0.05*self.width, y: halt, width: 0.9*self.width, height: hAreabtn + ((0.06)*self.height));
                                                    halt = halt + themeView.bounds.height + (0.03*self.height)
                                                }
                                                
                                                self.panel.addSubview(themeView)
                                            }
                                            
                                            iSeccion = iSeccion + 1
                                        }
                                        
                                        indexArea = indexArea + 1
                                    }
                                    
                                    indexTheme = indexTheme + 1
                                }
                                
                                self.panel.frame = CGRect(x: 0.0, y: 0.0, width: 0.9*self.width, height: self.height + ((0.06)*self.height));
                                self.scrollView.contentSize = self.panel.bounds.size
                                /*self.scrollView.autoresizingMask = [UIViewAutoresizing.FlexibleBottomMargin, UIViewAutoresizing.FlexibleHeight]*/
                                self.scrollView.addSubview(self.panel)
                                self.view.addSubview(self.scrollView)
                                
                            }
                            self.btnApply.isUserInteractionEnabled = true
                            self.btnApply.isEnabled = true
                            SwiftLoader.hide()
                            
                            
                            
                        }

                    }//2
 
                }//1

            }

        }

    }
    
    @objc func RestReserv(_ sender: UIButton) {
        
        var ZoneCode: String = ""
        var zonaDesc: String = ""
        var btnTag: Int = 0
        var iIndex: Int = 0
        var strHour: String = ""
        
        btnTag = sender.tag
        
        for _ in 0...(self.tblRestAvailAll.count)-1 {
            
            if self.tblRestAvailAll[iIndex]["ID"] == btnTag.description
                {
                    ZoneCode = self.tblRestAvailAll[iIndex]["ZoneCode"]!
                    if self.appDelegate.strLenguaje == "ENG"{
                        zonaDesc = self.tblRestAvailAll[iIndex]["ZoneDescriptionEng"]!
                    }else{
                        zonaDesc = self.tblRestAvailAll[iIndex]["ZoneDescriptionEsp"]!
                    }
                    
                    let pre: AnyObject = self.tblRestAvailAll[iIndex]["IntervalTime"]! as AnyObject
                    let len: Int = pre.description.characters.count - 5
                    
                    let strpre: String = pre.description
                    
                    let start = strpre.index(strpre.startIndex, offsetBy: 0)
                    let end = strpre.index(strpre.endIndex, offsetBy: -len)
                    let range = start..<end
                    
                    let mySubstring = strpre[range]
                    
                    strHour = String(mySubstring)
                }
            
            iIndex = iIndex + 1
        }
        
        //"Mesa (Terraza) para 2 Adultos, 2 Niños el 23 de Marzo 2017"
        
        let dateFormatterWST: DateFormatter = DateFormatter()
        dateFormatterWST.dateFormat = "yyyy-MM-dd"
        dateFormatterWST.timeZone = TimeZone(identifier: "UTC")
        dateFormatterWST.locale = Locale(identifier: "en_US")
        dateFormatterWST.timeZone = TimeZone(secondsFromGMT: 0)
        let dateStrWST = dateFormatterWST.string(from: lblDateR.date)

        var strReservdesc: String = ""

        strReservdesc = NSLocalizedString("lblTableIn",comment:"") + " " + zonaDesc + " " + NSLocalizedString("lblZoneFor",comment:"") + " " + self.lblPeopleR.text! + " " + NSLocalizedString("lblAdultsAnd",comment:"") + " " + lblChildR.text! + " " + NSLocalizedString("lblChildrenOn",comment:"") + " " + dateStrWST + " " + NSLocalizedString("lblAt",comment:"") + " " + strHour
        
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcReservRest") as! vcReservRest
        tercerViewController.RestaurantName = self.RestaurantName
        tercerViewController.PeopleName = self.lblNameR.text! + " " + self.lblLastNameR.text!
        tercerViewController.Unit = self.appDelegate.strRestAccCode
        tercerViewController.ReservDesc = strReservdesc
        tercerViewController.date = dateStrWST
        tercerViewController.time = strHour
        tercerViewController.restaurantCode = self.RestaurantCode
        tercerViewController.numAdult = self.lblPeopleR.text!
        tercerViewController.numChildren = lblChildR.text!
        tercerViewController.restaurantCode = self.RestaurantCode
        tercerViewController.propertyCode = PropertyCode
        tercerViewController.hotelName = RestaurantName
        tercerViewController.roomNum = self.appDelegate.strRestUnitReserv
        tercerViewController.ZoneCode = ZoneCode
        tercerViewController.ZoneDescripcion = zonaDesc
        tercerViewController.firstName = self.lblNameR.text!
        tercerViewController.lastName = self.lblLastNameR.text!
        tercerViewController.ynReadOnly = false
        tercerViewController.ConfirmationNumber = ""
        self.navigationController?.pushViewController(tercerViewController, animated: true)
        
    
    }
    
    @objc func ChangeDate(_ sender: UIDatePicker) {
        for view in self.panel.subviews {
            view.removeFromSuperview()
        }
        
        let cal = Calendar.current
        
        let unit:NSCalendar.Unit = [.weekday]
        
        let components = (cal as NSCalendar).component(unit, from: sender.date)
        
        /*var strNameDate: String = ""
        
        if components == 1{
            strNameDate = "SUNDAY"
        }else if components == 2{
            strNameDate = "MONDAY"
        }else if components == 3{
            strNameDate = "TUESDAY"
        }else if components == 4{
            strNameDate = "WEDNESDAY"
        }else if components == 5{
            strNameDate = "THURSDAY"
        }else if components == 6{
            strNameDate = "FRIDAY"
        }else if components == 7{
            strNameDate = "SATURDAY"
        }*/
        
        if Int(strDayName) == components{
            
            GoogleWearAlert.showAlert(title: NSLocalizedString("InvalidDate",comment:""), type: .warning, duration: 3, iAction: 1, form:"InvalidDate")
            
            let todaysDate:Date = Date()
            let dtdateFormatter:DateFormatter = DateFormatter()
            dtdateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
            let DateInFormat:String = dtdateFormatter.string(from: todaysDate)
            
            let dtdateFormatterAux:DateFormatter = DateFormatter()
            dtdateFormatterAux.dateFormat = "yyyy-MM-dd hh:mm a"
            let DateInFormatAux:Date = dtdateFormatterAux.date(from: DateInFormat)!
            
            lblDateR.setDate(DateInFormatAux, animated: true)
            
        }

    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        textField.selectAll(nil)

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var result = true
        
        for view in self.panel.subviews {
            view.removeFromSuperview()
        }
        
        if textField == lblPeopleR {

            let disallowedCharacterSet = CharacterSet(charactersIn: "0123456789").inverted
            let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
            
            result = replacementStringIsLegal
        }
        
        if textField == lblChildR {
            
            let disallowedCharacterSet = CharacterSet(charactersIn: "0123456789").inverted
            let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
            
            result = replacementStringIsLegal
        }
        
        return result // Bool
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension Date {
    func isGreaterThanDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func addDays(_ daysToAdd: Int) -> Date {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func addHours(_ hoursToAdd: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
}
