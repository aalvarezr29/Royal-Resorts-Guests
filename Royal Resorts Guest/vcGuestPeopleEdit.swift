//
//  vcGuestPeopleEdit.swift
//  Royal Resorts Guest
//
//  Created by Marco Cocom on 11/23/14.
//  Copyright (c) 2014 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging
import DGRunkeeperSwitch

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


class vcGuestPeopleEdit: UIViewController, UITextFieldDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let app = UIApplication.shared
    
    //Parametros de entrada
    var PeopleFromCRDID: String = ""
    var PersonID: String = "0"
    var StayInfoID: String = ""
    var FirstName: String = ""
    var MiddleName: String = ""
    var LastName: String = ""
    var SecondLName: String = ""
    var YearBirthDay: String = ""
    var EmailAddress: String = ""
    var ynPrimary: String = ""
    var ynPreRegisterAvailable: String = ""
    var mas: NSMutableAttributedString = NSMutableAttributedString()
    var Age: String = ""
    var PrimAgeCFG: Int=0
    var ynConn:Bool=false
    var config : SwiftLoader.Config = SwiftLoader.Config()
    var sMsj = ""
    var ynPrimaryAux : String = ""
    var strPeoplePrimary: String = ""
    var strStayType: String = ""
    var strPeopleType: String = ""
    var fkPeopleFromCDRID: String = ""
    var tblStayInfo: Dictionary<String, String>!
    var Stays: Dictionary<String, String>!
    var CountStay: Int32 = 0
    var PhoneNo: String = ""
    var PeopleAI: Dictionary<String, String>!
    var dtExpectedArrival: String = ""
    var dtExpectedArrivalDate: Date = Date()
    var strExpectedArrival: String = ""
    var strDateTime: String = ""
    var dtStayArrivalDate: Date = Date()
    var dtStayDepartureDate: Date = Date()
    var tblPersonAI: [Dictionary<String, String>]!
    var tblPersonRange: [Dictionary<String, String>]!
    var strRangeCode: String = ""
    var ynChangeDate: Bool = false
    var cAdult: Int = 0
    var strAges: String = ""
    var strAgeMsj: String = ""
    
    @IBOutlet weak var lblPrimaryPeople: UILabel!

    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var edtFName: UITextField!
    @IBOutlet weak var edtMName: UITextField!
    @IBOutlet weak var edtLName: UITextField!
    @IBOutlet weak var edtSLName: UITextField!
    @IBOutlet weak var edtAge: UITextField!
    @IBOutlet weak var edtEmail: UITextField!
    @IBOutlet weak var edtPrimary: UISwitch!
    @IBOutlet weak var edtPhoneNo: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewBody: UIView!
    @IBOutlet var ViewItem: UINavigationItem!
    @IBOutlet weak var dtExpectPicker: UIDatePicker!
    
    var btnBack = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = appDelegate.width
        let height = appDelegate.height

        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        viewBody.frame = CGRect(x: 0.0, y: 0.05*height, width: width, height: height);
        scrollView.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.8*height);
        
        ContentView.backgroundColor = UIColor.white
        ContentView.layer.cornerRadius = 5;
        
        let lblexpected = UILabel(frame: CGRect(x: 0.05*width, y: 0.36*height, width: 0.8*width, height: 0.04*height));
        lblexpected.backgroundColor = UIColor.clear;
        lblexpected.textAlignment = NSTextAlignment.left;
        lblexpected.textColor = colorWithHexString("000000")
        lblexpected.numberOfLines = 1;
        lblexpected.font = UIFont(name: "Verdana-Bold", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
        lblexpected.text = NSLocalizedString("lblexpected",comment:"")
        lblexpected.adjustsFontSizeToFitWidth = true

        //textField
        edtFName.frame = CGRect(x: 0.05*width, y: 0.01*height, width: 0.8*width, height: 0.04*height);
        edtMName.frame = CGRect(x: 0.05*width, y: 0.06*height, width: 0.8*width, height: 0.04*height);
        edtLName.frame = CGRect(x: 0.05*width, y: 0.11*height, width: 0.8*width, height: 0.04*height);
        edtSLName.frame = CGRect(x: 0.05*width, y: 0.16*height, width: 0.8*width, height: 0.04*height);
        edtAge.frame = CGRect(x: 0.05*width, y: 0.21*height, width: 0.8*width, height: 0.04*height);
        edtEmail.frame = CGRect(x: 0.05*width, y: 0.26*height, width: 0.8*width, height: 0.04*height);
        edtPhoneNo.frame = CGRect(x: 0.05*width, y: 0.31*height, width: 0.8*width, height: 0.04*height);
        
        lblPrimaryPeople.frame = CGRect(x: 0.05*width, y: 0.31*height, width: 0.3*width, height: 0.04*height);
        lblPrimaryPeople.textAlignment = NSTextAlignment.left
        edtPrimary.frame = CGRect(x: 0.35*width, y: 0.31*height, width: 0.1*width, height: 0.04*height);
        dtExpectPicker.frame = CGRect(x: 0.05*width, y: 0.38*height, width: 0.33*width, height: 0.1*height);
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString("lblGuestInfo",comment:"")
        
        lblPrimaryPeople.font = UIFont(name:"Helvetica", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
        
        edtFName.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        edtMName.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        edtLName.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        edtSLName.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        edtAge.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        edtEmail.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblPrimaryPeople.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        edtPhoneNo.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        
        edtFName.placeholder = NSLocalizedString("lblFirstName",comment:"");
        edtMName.placeholder = NSLocalizedString("lblMiddleName",comment:"");
        edtLName.placeholder = NSLocalizedString("lblLastName",comment:"");
        edtSLName.placeholder = NSLocalizedString("lblSLastName",comment:"");
        edtAge.placeholder = NSLocalizedString("lblAge",comment:"");
        edtEmail.placeholder = NSLocalizedString("lblEmail",comment:"");
        lblPrimaryPeople.text = NSLocalizedString("lblPrimaryPeople",comment:"");
        edtPhoneNo.placeholder = NSLocalizedString("lblPhoneNo",comment:"");
        
        edtAge.keyboardType = .numberPad
        edtPhoneNo.keyboardType = .numberPad
        
        let dateFormatterdp: DateFormatter = DateFormatter()
        dateFormatterdp.dateFormat = "MM/dd/yyyy h:mm:ss a"
        dateFormatterdp.timeZone = TimeZone(identifier: "UTC")
        dateFormatterdp.locale = Locale(identifier: "en_US")
        dateFormatterdp.timeZone = TimeZone(secondsFromGMT: 0)
        dtExpectedArrivalDate = dateFormatterdp.date(from: dtExpectedArrival)!
        
        let strFormatter: DateFormatter = DateFormatter()
        strFormatter.dateFormat = "yyyy-MM-dd h:mm a"
        strFormatter.timeZone = TimeZone(identifier: "UTC")
        strFormatter.locale = Locale(identifier: "en_US")
        strFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        strExpectedArrival = strFormatter.string(from: dtExpectedArrivalDate)
        
        let dateFormatterck: DateFormatter = DateFormatter()
        dateFormatterck.dateFormat = "yyyy-MM-dd hh:mm a"
        dateFormatterck.timeZone = TimeZone(identifier: "UTC")
        dateFormatterck.locale = Locale(identifier: "en_US")
        dateFormatterck.timeZone = TimeZone(secondsFromGMT: 0)
        dtExpectedArrivalDate = dateFormatterck.date(from: strExpectedArrival)!

        dtExpectPicker.minimumDate = dtStayArrivalDate
        dtExpectPicker.maximumDate = dtStayDepartureDate
        
        dtExpectPicker.locale = Locale(identifier: "en_US")
        dtExpectPicker.timeZone = TimeZone(secondsFromGMT: 0)
        dtExpectPicker.setDate(dtExpectedArrivalDate, animated: false)
        
        edtPrimary.isHidden = true
        lblPrimaryPeople.isHidden = true
        
        let runkeeperSwitchPrim = DGRunkeeperSwitch(titles: [NSLocalizedString("lblPrimPeople",comment:""), NSLocalizedString("lblPrimaryPeople",comment:"")])
        runkeeperSwitchPrim.backgroundColor = colorWithHexString ("5C9FCC")
        runkeeperSwitchPrim.selectedBackgroundColor = .white
        runkeeperSwitchPrim.titleColor = .white
        runkeeperSwitchPrim.selectedTitleColor = colorWithHexString ("5C9FCC")
        runkeeperSwitchPrim.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
        runkeeperSwitchPrim.frame = CGRect(x: 0.05*width, y: 0.5*height, width: 0.8*width, height: 0.04*height)
        runkeeperSwitchPrim.addTarget(self, action: #selector(vcGuestPeopleEdit.switchValueDidChangePrim(_:)), for: .valueChanged)
        ContentView.addSubview(runkeeperSwitchPrim)
        
        if appDelegate.ynIPad {
            switch appDelegate.Model {
            case "iPad 2":
                ContentView.frame = CGRect(x: 0.05*width, y: 0.025*height, width: 0.9*width, height: 0.47*height);
            case "iPad Air":
                ContentView.frame = CGRect(x: 0.05*width, y: 0.025*height, width: 0.9*width, height: 0.47*height);
            case "iPad Air 2":
                ContentView.frame = CGRect(x: 0.05*width, y: 0.025*height, width: 0.9*width, height: 0.47*height);
            case "iPad Pro":
                ContentView.frame = CGRect(x: 0.05*width, y: 0.025*height, width: 0.9*width, height: 0.47*height);
            case "iPad Retina":
                ContentView.frame = CGRect(x: 0.05*width, y: 0.025*height, width: 0.9*width, height: 0.47*height);
            default:
                ContentView.frame = CGRect(x: 0.05*width, y: 0.025*height, width: 0.9*width, height: 0.47*height);
                dtExpectPicker.frame = CGRect(x: 0.05*width, y: 0.39*height, width: 0.8*width, height: 0.08*height);
            }
        }else{
            switch appDelegate.Model {
            case "iPhone":
                ContentView.frame = CGRect(x: 0.05*width, y: 0.023*height, width: 0.9*width, height: 0.47*height);
            case "iPhone 4":
                ContentView.frame = CGRect(x: 0.05*width, y: 0.023*height, width: 0.9*width, height: 0.47*height);
            case "iPhone 4s":
                ContentView.frame = CGRect(x: 0.05*width, y: 0.023*height, width: 0.9*width, height: 0.47*height);
            case "iPhone 5":
                ContentView.frame = CGRect(x: 0.05*width, y: 0.025*height, width: 0.9*width, height: 0.47*height);
            case "iPhone 5c":
                ContentView.frame = CGRect(x: 0.05*width, y: 0.025*height, width: 0.9*width, height: 0.47*height);
            case "iPhone 5s":
                ContentView.frame = CGRect(x: 0.05*width, y: 0.025*height, width: 0.9*width, height: 0.47*height);
            case "iPhone 6":
                ContentView.frame = CGRect(x: 0.05*width, y: 0.025*height, width: 0.9*width, height: 0.47*height);
            case "iPhone 6 Plus":
                ContentView.frame = CGRect(x: 0.05*width, y: 0.025*height, width: 0.9*width, height: 0.47*height);
            case "iPhone 6s":
                ContentView.frame = CGRect(x: 0.05*width, y: 0.025*height, width: 0.9*width, height: 0.47*height);
            case "iPhone 6s Plus":
                ContentView.frame = CGRect(x: 0.05*width, y: 0.025*height, width: 0.9*width, height: 0.47*height);
            default:
                ContentView.frame = CGRect(x: 0.05*width, y: 0.025*height, width: 0.9*width, height: 0.47*height);
                dtExpectPicker.frame = CGRect(x: 0.05*width, y: 0.38*height, width: 0.8*width, height: 0.1*height);
            }
        }

        edtFName.delegate = self
        edtMName.delegate = self
        edtLName.delegate = self
        edtSLName.delegate = self
        edtAge.delegate = self
        edtEmail.delegate = self
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(vcGuestPeopleEdit.hideKeyboard))
        
        // prevents the scroll view from swallowing up the touch event of child buttons
        tapGesture.cancelsTouchesInView = false
        
        scrollView.addSubview(ContentView)
        
        scrollView.addGestureRecognizer(tapGesture)
        
        self.scrollView.setContentOffset(CGPoint.zero, animated: true)
        
        ViewItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(vcGuestPeopleEdit.clickSave(_:)))

        if ynPrimary == "True"{
            dtExpectPicker.isEnabled = true
        } else {
            dtExpectPicker.isEnabled = false
        }
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            //Si FirstName no es vacio se esta editando
            if (FirstName != ""){
                edtFName.text = FirstName
                edtMName.text = MiddleName
                edtLName.text = LastName
                edtSLName.text = SecondLName
                edtAge.text = Age
                edtEmail.text = EmailAddress
                edtPhoneNo.text = PhoneNo
                
                if ynPrimary == "True"{
                    //edtPrimary.setOn(true, animated: true)
                    //Si es Primary people, se desabilitara para q no se pueda cambiar
                    //edtPrimary.enabled = false
                    runkeeperSwitchPrim.isEnabled = false
                    runkeeperSwitchPrim.setSelectedIndex(1, animated: false)
                    runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("C7C7CD")
                    runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("C7C7CD")
                }
                else{
                    
                    runkeeperSwitchPrim.isEnabled = true
                    runkeeperSwitchPrim.setSelectedIndex(0, animated: false)
                    runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("5C9FCC")
                    runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("5C9FCC")
                }
                
                if fkPeopleFromCDRID != "0"{
                    
                    edtFName.isEnabled = false
                    edtMName.isEnabled = false
                    edtLName.isEnabled = false
                    edtSLName.isEnabled = false
                    
                    
                }
                
            }else{
                //Cuando se esta agregando apagamos el switch
                //edtPrimary.setOn(false, animated: false)
                runkeeperSwitchPrim.isEnabled = true
                runkeeperSwitchPrim.setSelectedIndex(0, animated: false)
                runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("5C9FCC")
                runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("5C9FCC")
            }
            
            if self.strStayType == "OW"{
                if self.appDelegate.gstrLoginPeopleID != self.appDelegate.gstrPrimaryPeopleID{
                    runkeeperSwitchPrim.isEnabled = false
                    runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("C7C7CD")
                    runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("C7C7CD")
                }else{
                    if strPeopleType == "NON-MEMBER"{
                        runkeeperSwitchPrim.isEnabled = false
                        runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("C7C7CD")
                        runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("C7C7CD")
                    }
                }
            }else{
                if self.appDelegate.gstrLoginPeopleID != self.appDelegate.gstrPrimaryPeopleID{
                    runkeeperSwitchPrim.isEnabled = false
                    runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("C7C7CD")
                    runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("C7C7CD")
                }
            }
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            scrollView.backgroundColor = UIColor.clear
            scrollView.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.8*height);

            self.view.backgroundColor = UIColor.white
            ContentView.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"bg.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: -0.05*height, width: width, height: height+(0.05*height));
            imgvwBack.alpha = 0.3
            imgvwBack.contentMode = UIView.ContentMode.scaleAspectFill
            //self.view.addSubview(imgvwBack)
            
            //Si FirstName no es vacio se esta editando
            if (FirstName != ""){
                edtFName.text = FirstName
                edtMName.text = MiddleName
                edtLName.text = LastName
                edtSLName.text = SecondLName
                edtAge.text = Age
                edtEmail.text = EmailAddress
                edtPhoneNo.text = PhoneNo
                
                if ynPrimary == "True"{
                    runkeeperSwitchPrim.isEnabled = false
                    runkeeperSwitchPrim.setSelectedIndex(1, animated: false)
                    runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("C7C7CD")
                    runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("C7C7CD")
                }
                else{
                    runkeeperSwitchPrim.isEnabled = true
                    runkeeperSwitchPrim.setSelectedIndex(0, animated: false)
                    runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("ba8748")
                    runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("ba8748")
                }
                
                if fkPeopleFromCDRID != "0"{
                    
                    edtFName.isEnabled = false
                    edtMName.isEnabled = false
                    edtLName.isEnabled = false
                    edtSLName.isEnabled = false
                    
                    
                }
                
            }else{
                //Cuando se esta agregando apagamos el switch
                //edtPrimary.setOn(false, animated: false)
                runkeeperSwitchPrim.isEnabled = true
                runkeeperSwitchPrim.setSelectedIndex(0, animated: false)
                runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("ba8748")
                runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("ba8748")
            }
            
            if self.strStayType == "OW"{
                if self.appDelegate.gstrLoginPeopleID != self.appDelegate.gstrPrimaryPeopleID{
                    runkeeperSwitchPrim.isEnabled = false
                    runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("C7C7CD")
                    runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("C7C7CD")
                }else{
                    if strPeopleType == "NON-MEMBER"{
                        runkeeperSwitchPrim.isEnabled = false
                        runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("C7C7CD")
                        runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("C7C7CD")
                    }
                }
            }else{
                if self.appDelegate.gstrLoginPeopleID != self.appDelegate.gstrPrimaryPeopleID{
                    runkeeperSwitchPrim.isEnabled = false
                    runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("C7C7CD")
                    runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("C7C7CD")
                }
            }
            
            edtFName.canBecomeFirstResponder
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            scrollView.backgroundColor = UIColor.clear
            scrollView.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.8*height);
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            //ContentView.backgroundColor = colorWithHexString ("DDF4FF")
            self.view.backgroundColor = UIColor.white
            ContentView.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"bg.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: -0.05*height, width: width, height: height+(0.05*height));
            imgvwBack.alpha = 0.3
            imgvwBack.contentMode = UIView.ContentMode.scaleAspectFill
            //self.view.addSubview(imgvwBack)
            
            //Si FirstName no es vacio se esta editando
            if (FirstName != ""){
                edtFName.text = FirstName
                edtMName.text = MiddleName
                edtLName.text = LastName
                edtSLName.text = SecondLName
                edtAge.text = Age
                edtEmail.text = EmailAddress
                edtPhoneNo.text = PhoneNo
                
                if ynPrimary == "True"{
                    //edtPrimary.setOn(true, animated: true)
                    //Si es Primary people, se desabilitara para q no se pueda cambiar
                    //edtPrimary.enabled = false
                    runkeeperSwitchPrim.isEnabled = false
                    runkeeperSwitchPrim.setSelectedIndex(1, animated: false)
                    runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("C7C7CD")
                    runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("C7C7CD")
                }
                else{
                    runkeeperSwitchPrim.isEnabled = true
                    runkeeperSwitchPrim.setSelectedIndex(0, animated: false)
                    runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("a18015")
                    runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("a18015")
                }
                
                if fkPeopleFromCDRID != "0"{
                    
                    edtFName.isEnabled = false
                    edtMName.isEnabled = false
                    edtLName.isEnabled = false
                    edtSLName.isEnabled = false
                    
                    
                }
                
            }else{
                //Cuando se esta agregando apagamos el switch
                //edtPrimary.setOn(false, animated: false)
                runkeeperSwitchPrim.isEnabled = true
                runkeeperSwitchPrim.setSelectedIndex(0, animated: false)
                runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("a18015")
                runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("a18015")
            }
            
            if self.strStayType == "OW"{
                if self.appDelegate.gstrLoginPeopleID != self.appDelegate.gstrPrimaryPeopleID{
                    runkeeperSwitchPrim.isEnabled = false
                    runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("C7C7CD")
                    runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("C7C7CD")
                }else{
                    if strPeopleType == "NON-MEMBER"{
                        runkeeperSwitchPrim.isEnabled = false
                        runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("C7C7CD")
                        runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("C7C7CD")
                    }
                }
            }else{
                if self.appDelegate.gstrLoginPeopleID != self.appDelegate.gstrPrimaryPeopleID{
                    runkeeperSwitchPrim.isEnabled = false
                    runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("C7C7CD")
                    runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("C7C7CD")
                }
            }
            
            edtFName.canBecomeFirstResponder

        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            scrollView.backgroundColor = UIColor.clear
            scrollView.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.8*height);
            
            self.view.backgroundColor = UIColor.white
            ContentView.backgroundColor = UIColor.white
            edtFName.textColor = colorWithHexString("2e3634")
            edtMName.textColor = colorWithHexString("2e3634")
            edtLName.textColor = colorWithHexString("2e3634")
            edtSLName.textColor = colorWithHexString("2e3634")
            edtAge.textColor = colorWithHexString("2e3634")
            edtEmail.textColor = colorWithHexString("2e3634")
            lblPrimaryPeople.textColor = colorWithHexString("2e3634")
            edtPhoneNo.textColor = colorWithHexString("2e3634")
            lblexpected.textColor = colorWithHexString("2e3634")
            
            //Si FirstName no es vacio se esta editando
            if (FirstName != ""){
                edtFName.text = FirstName
                edtMName.text = MiddleName
                edtLName.text = LastName
                edtSLName.text = SecondLName
                edtAge.text = Age
                edtEmail.text = EmailAddress
                edtPhoneNo.text = PhoneNo
                
                if ynPrimary == "True"{
                    runkeeperSwitchPrim.isEnabled = false
                    runkeeperSwitchPrim.setSelectedIndex(1, animated: false)
                    runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("888888")
                    runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("888888")
                }
                else{
                    runkeeperSwitchPrim.isEnabled = true
                    runkeeperSwitchPrim.setSelectedIndex(0, animated: false)
                    runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("004c50")
                    runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("004c50")
                }
                
                if fkPeopleFromCDRID != "0"{
                    
                    edtFName.isEnabled = false
                    edtMName.isEnabled = false
                    edtLName.isEnabled = false
                    edtSLName.isEnabled = false
                    
                    
                }
                
            }else{
                //Cuando se esta agregando apagamos el switch
                //edtPrimary.setOn(false, animated: false)
                runkeeperSwitchPrim.isEnabled = true
                runkeeperSwitchPrim.setSelectedIndex(0, animated: false)
                runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("004c50")
                runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("004c50")
            }
            
            if self.strStayType == "OW"{
                if self.appDelegate.gstrLoginPeopleID != self.appDelegate.gstrPrimaryPeopleID{
                    runkeeperSwitchPrim.isEnabled = false
                    runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("888888")
                    runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("888888")
                }else{
                    if strPeopleType == "NON-MEMBER"{
                        runkeeperSwitchPrim.isEnabled = false
                        runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("888888")
                        runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("888888")
                    }
                }
            }else{
                if self.appDelegate.gstrLoginPeopleID != self.appDelegate.gstrPrimaryPeopleID{
                    runkeeperSwitchPrim.isEnabled = false
                    runkeeperSwitchPrim.backgroundColor = self.colorWithHexString ("888888")
                    runkeeperSwitchPrim.selectedTitleColor = self.colorWithHexString ("888888")
                }
            }
            
            edtFName.canBecomeFirstResponder
            
        }
        
        ContentView.addSubview(edtFName)
        ContentView.addSubview(edtMName)
        ContentView.addSubview(edtLName)
        ContentView.addSubview(edtSLName)
        ContentView.addSubview(edtAge)
        ContentView.addSubview(edtEmail)
        ContentView.addSubview(edtPhoneNo)
        ContentView.addSubview(lblexpected)
        ContentView.addSubview(dtExpectPicker)

    }
    @objc func switchValueDidChangePrim(_ sender: DGRunkeeperSwitch!) {
        
        if sender.selectedIndex == 1 {
            ynPrimaryAux = "1"
        } else {
            ynPrimaryAux = "0"
        }
  
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Stay Guest Add",
            AnalyticsParameterItemName: "Stay Guest Add",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Stay Guest Add", screenClass: appDelegate.gstrAppName)
        
    }

    func registerForKeyboardNotifications() -> Void {
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
    }
    
    func keyboardWasShown(_ notification: Notification) {
        
        //var scrollPoint: CGPoint = CGPointMake(0.0, 30)
        //self.scrollView.setContentOffset(scrollPoint, animated: true)
        
    }
    
    @IBAction func DateAction(_ sender: UIDatePicker) {
        
        let targetedDatePicker = sender
        
        let dateFormatterWST: DateFormatter = DateFormatter()
        dateFormatterWST.dateFormat = "yyyy-MM-dd"
        dateFormatterWST.timeZone = TimeZone(identifier: "UTC")
        dateFormatterWST.locale = Locale(identifier: "en_US")
        dateFormatterWST.timeZone = TimeZone(secondsFromGMT: 0)
        let dateStrWST = dateFormatterWST.string(from: targetedDatePicker.date)
        
        let timeFormatterWS1: DateFormatter = DateFormatter()
        timeFormatterWS1.dateFormat = "hh:mm a"
        timeFormatterWS1.timeZone = TimeZone(identifier: "UTC")
        timeFormatterWS1.locale = Locale(identifier: "en_US")
        timeFormatterWS1.timeZone = TimeZone(secondsFromGMT: 0)
        let timeStrWS1 = timeFormatterWS1.string(from: targetedDatePicker.date)
        
        strDateTime = dateStrWST + " " + timeStrWS1
        
        ynChangeDate = true
        
    }
    
    
    @objc func hideKeyboard() {
        /*edtFName.resignFirstResponder()   //FirstResponder's must be resigned for hiding keyboard.
        edtMName.resignFirstResponder()
        edtLName.resignFirstResponder()
        edtSLName.resignFirstResponder()
        edtAge.resignFirstResponder()
        edtEmail.resignFirstResponder()
        self.scrollView.setContentOffset(CGPointZero, animated: true)*/
    }
    
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var result = true
        var ireturn: Int = 100
    
        if textField == edtFName {
        
            ireturn = 132
            let newLength = textField.text!.utf16.count + string.utf16.count - range.length
            result = (newLength <= ireturn)
        
        } else if textField == edtMName {
        
            ireturn = 60
            let newLength = textField.text!.utf16.count + string.utf16.count - range.length
            result = (newLength <= ireturn)
        
        } else if textField == edtLName {
            
            ireturn = 60
            let newLength = textField.text!.utf16.count + string.utf16.count - range.length
            result = (newLength <= ireturn)
            
        } else if textField == edtSLName {
            
            ireturn = 60
            let newLength = textField.text!.utf16.count + string.utf16.count - range.length
            result = (newLength <= ireturn)
            
        } else if textField == edtAge {
        
            ireturn = 3
            let newLength = textField.text!.utf16.count + string.utf16.count - range.length
            result = (newLength <= ireturn)
            
            if string.characters.count > 0 && (result == true) {
                let disallowedCharacterSet = CharacterSet(charactersIn: "0123456789").inverted
                let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }

        } else if textField == edtEmail {
            
            ireturn = 100
            let newLength = textField.text!.utf16.count + string.utf16.count - range.length
            result = (newLength <= ireturn)
        
        }
        
    return result

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickPrimary(_ sender: AnyObject) {
        
    }
    
    func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func ValidaEmail(_ strEmailAux:String)-> Bool{
        
        var validEmail = false
        
        if strEmailAux == ""{
            return false;
        }else{
            for character in strEmailAux.characters {
                if character == "@"{
                    validEmail = true
                }
                
            }
            
            if validEmail == true{
                if isValidEmail(strEmailAux) == false{
                    return false;
                }else{
                    return true;
                }
                
            }else{
                let a:Int? = Int(strEmailAux)
                if a == nil {
                    return false;
                } else {
                    return true;
                }
            }
        }
        
    }
    

    
    func recargarTablaStay(){
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        ViewItem.rightBarButtonItem?.isEnabled = false
        ViewItem.leftBarButtonItem?.isEnabled = false
        app.beginIgnoringInteractionEvents()
        
        var tableItems = RRDataSet()
        var iRes: String = ""
        
        var iResult = Int()
        var sResult: String = ""
        var iType : String = ""
        var ynValidate: Bool = true
        var iResAux: String = ""
        var Stays: [Dictionary<String, String>]
        var resultStayID: Int32 = 0
        var DataStays = [String:String]()
        var Index: Int = 0
        var Stay: Dictionary<String, String>
        var ynAddStay: Bool = false
        var resultCountAI: Int32! = 0
        var resultAI: Int32! = 0
        var ynOverBookAI: Bool = false
        var resultRangeCode: String = ""
        var resultRangeCodeAux: String = ""
        
        Stay = [:]
        Stays = []
        
        let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
        
        //Si FirstName es vacio se esta agregando
        if (self.FirstName == ""){
            //Nuevo
            iType = "1"
            self.PersonID = "0"
        }
        else
        {
            //Edicion
            iType = "2"
        }
        
        
        /*if self.edtPrimary.on{
         ynPrimaryAux = "1"
         }else
         {
         ynPrimaryAux = "0"
         }*/

        if self.edtFName.text == ""{
            sMsj = NSLocalizedString("msgPropName",comment:"")
            ynValidate = false
        }
        
        if self.edtLName.text == ""{
            sMsj = NSLocalizedString("msgPropApellido",comment:"")
            ynValidate = false
        }
        
        let x: Int? = (edtAge.text! as NSString).integerValue
        
        if x == nil
        {
            self.sMsj = NSLocalizedString("msgEdadE",comment:"")
            ynValidate = false
        }
        
        if (ynPrimaryAux == "1"){
            if (PrimAgeCFG > x){
                self.sMsj = NSLocalizedString("msgDebeS",comment:"") + PrimAgeCFG.description + NSLocalizedString("msgAgePrim",comment:"")
                ynValidate = false
            }
        }
        
        if (x! >= 18)
        {
            if self.edtEmail.text! == "" && edtPhoneNo.text == "" {
                sMsj = NSLocalizedString("msgPhoneEmail",comment:"")
                ynValidate = false
            }else{
                
                if edtPhoneNo.text == ""{
                    //if (ynPrimary=="True") && (ynPrimaryAux=="1")
                    //{
                    if ValidaEmail(self.edtEmail.text!) == false {
                        sMsj = NSLocalizedString("msgDirEmail",comment:"")
                        ynValidate = false
                    }
                    //}
                }
                
            }
        }
        
        if self.appDelegate.gblPromoAI {
            
            if edtAge.text == ""{
                self.sMsj = NSLocalizedString("msgEdadE",comment:"")
                ynValidate = false
            }
            
        }
        
        if ynValidate  {

            var config : SwiftLoader.Config = SwiftLoader.Config()
            config.size = 100
            config.backgroundColor = UIColor(white: 1, alpha: 0.5)
            config.spinnerColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
            config.titleTextColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
            config.spinnerLineWidth = 2.0
            SwiftLoader.setConfig(config)
            SwiftLoader.show(animated: true)
            SwiftLoader.show(title: NSLocalizedString("lblLoading",comment:""), animated: true)
            
            let queue = OperationQueue()
            
            queue.addOperation() {//1
                //accion base de datos
                print("A1")
                if Reachability.isConnectedToNetwork(){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    
                    tableItems = (service?.spGetGuestStay("1", personalID: self.appDelegate.gstrLoginPeopleID, appCode: self.appDelegate.gstrAppName, dataBase: self.appDelegate.strDataBaseByStay))!
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
                OperationQueue.main.addOperation() {
                    queue.addOperation() {//2
                        //accion webservice-db
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
                                    
                                    for r in table.rows{
                                        
                                        self.tblStayInfo = [:]
                                        self.tblStayInfo["StayInfoID"] = (r as AnyObject).getColumnByName("StayInfoID").content as? String
                                        self.tblStayInfo["DatabaseName"] = (r as AnyObject).getColumnByName("DatabaseName").content as? String
                                        self.tblStayInfo["PropertyCode"] = (r as AnyObject).getColumnByName("PropertyCode").content as? String
                                        self.tblStayInfo["PropertyName"] = (r as AnyObject).getColumnByName("PropertyName").content as? String
                                        self.tblStayInfo["UnitCode"] = (r as AnyObject).getColumnByName("UnitCode").content as? String
                                        self.tblStayInfo["StatusCode"] = (r as AnyObject).getColumnByName("StatusCode").content as? String
                                        self.tblStayInfo["StatusDesc"] = (r as AnyObject).getColumnByName("StatusDesc").content as? String
                                        self.tblStayInfo["ArrivalDate"] = (r as AnyObject).getColumnByName("ArrivalDate").content as? String
                                        self.tblStayInfo["DepartureDate"] = (r as AnyObject).getColumnByName("DepartureDate").content as? String
                                        self.tblStayInfo["PrimaryPeopleID"] = (r as AnyObject).getColumnByName("PrimaryPeopleID").content as? String
                                        self.tblStayInfo["OrderNo"] = (r as AnyObject).getColumnByName("OrderNo").content as? String
                                        self.tblStayInfo["Intv"] = (r as AnyObject).getColumnByName("Intv").content as? String
                                        self.tblStayInfo["IntvYear"] = (r as AnyObject).getColumnByName("IntvYear").content as? String
                                        self.tblStayInfo["fkAccID"] = (r as AnyObject).getColumnByName("fkAccID").content as? String
                                        self.tblStayInfo["fkTrxTypeCCID"] = (r as AnyObject).getColumnByName("fkTrxTypeCCID").content as? String
                                        self.tblStayInfo["AccCode"] = (r as AnyObject).getColumnByName("AccCode").content as? String
                                        self.tblStayInfo["USDExchange"] = (r as AnyObject).getColumnByName("USDExchange").content as? String
                                        self.tblStayInfo["UnitID"] = (r as AnyObject).getColumnByName("UnitID").content as? String
                                        self.tblStayInfo["FloorPlanDesc"] = (r as AnyObject).getColumnByName("FloorPlanDesc").content as? String
                                        self.tblStayInfo["UnitViewDesc"] = (r as AnyObject).getColumnByName("UnitViewDesc").content as? String
                                        
                                        self.appDelegate.gstrPrimaryPeopleID = ((r as AnyObject).getColumnByName("PrimaryPeopleID").content as? String)!
                                        
                                        queueFM?.inDatabase() {
                                            db in
                                            
                                            if let rs = db.executeQuery("SELECT StayInfoID FROM tblStay s WHERE StayInfoID = ? and DataBaseName = ? and PrimaryPeopleID = ?", withArgumentsIn: [(r as AnyObject).getColumnByName("StayInfoID").content as! String, ((r as AnyObject).getColumnByName("DatabaseName").content as? String)!, self.appDelegate.gstrPrimaryPeopleID]){
                                                while rs.next() {
                                                    ynAddStay = false
                                                }
                                            } else {
                                                print("select failure: \(db.lastErrorMessage())")
                                            }
                                            
                                        }
                                        
                                        if ynAddStay{
                                            queueFM?.inTransaction() {
                                                db, rollback in
                                                
                                                if db.executeUpdate("INSERT INTO tblStay (StayInfoID, DatabaseName, PropertyCode, UnitCode, StatusCode, StatusDesc, ArrivalDate, DepartureDate, PropertyName, PrimaryPeopleID, OrderNo, Intv, IntvYear, fkAccID, fkTrxTypeID, AccCode, USDExchange, UnitID, FloorPlanDesc, UnitViewDesc, ynPostCheckout, LastAccountUpdate, PrimAgeCFG, fkPlaceID, DepartureDateCheckOut, ConfirmationCode, fkCurrencyID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [((r as AnyObject).getColumnByName("StayInfoID").content as? String)!, ((r as AnyObject).getColumnByName("DatabaseName").content as? String)!, ((r as AnyObject).getColumnByName("PropertyCode").content as? String)!, ((r as AnyObject).getColumnByName("UnitCode").content as? String)!, ((r as AnyObject).getColumnByName("StatusCode").content as? String)!, ((r as AnyObject).getColumnByName("StatusDesc").content as? String)!, ((r as AnyObject).getColumnByName("ArrivalDate").content as? String)!, ((r as AnyObject).getColumnByName("DepartureDate").content as? String)!, ((r as AnyObject).getColumnByName("PropertyName").content as? String)!, ((r as AnyObject).getColumnByName("PrimaryPeopleID").content as? String)!, ((r as AnyObject).getColumnByName("OrderNo").content as? String)!, ((r as AnyObject).getColumnByName("Intv").content as? String)!, ((r as AnyObject).getColumnByName("IntvYear").content as? String)!, ((r as AnyObject).getColumnByName("fkAccID").content as? String)!, ((r as AnyObject).getColumnByName("fkTrxTypeCCID").content as? String)!, ((r as AnyObject).getColumnByName("AccCode").content as? String)!, ((r as AnyObject).getColumnByName("USDExchange").content as? String)!, ((r as AnyObject).getColumnByName("UnitID").content as? String)!, ((r as AnyObject).getColumnByName("FloorPlanDesc").content as? String)!, ((r as AnyObject).getColumnByName("UnitViewDesc").content as? String)!, "0", "", ((r as AnyObject).getColumnByName("PrimAgeCFG").content as? String)!, ((r as AnyObject).getColumnByName("fkPlaceID").content as? String)!, ((r as AnyObject).getColumnByName("DepartureDateCheckOut").content as? String)!, ((r as AnyObject).getColumnByName("ConfirmationCode").content as? String)!, ((r as AnyObject).getColumnByName("fkCurrencyID").content as? String)!]) {
                                                    
                                                }
                                                
                                            }
                                        }else{
                                            queueFM?.inTransaction() {
                                                db, rollback in
                                                
                                                if db.executeUpdate("UPDATE tblStay SET StayInfoID = ?, DatabaseName = ?, PropertyCode = ?, UnitCode = ?, StatusCode = ?, StatusDesc = ?, ArrivalDate = ?, DepartureDate = ?, PropertyName = ?, PrimaryPeopleID = ?, OrderNo = ?, Intv= ?, IntvYear = ?, fkAccID = ?, fkTrxTypeID = ?, AccCode = ?, USDExchange = ?, UnitID = ?, FloorPlanDesc = ?, UnitViewDesc = ? WHERE StayInfoID=?", withArgumentsIn: [((r as AnyObject).getColumnByName("StayInfoID").content as? String)!, ((r as AnyObject).getColumnByName("DatabaseName").content as? String)!, ((r as AnyObject).getColumnByName("PropertyCode").content as? String)!, ((r as AnyObject).getColumnByName("UnitCode").content as? String)!, ((r as AnyObject).getColumnByName("StatusCode").content as? String)!, ((r as AnyObject).getColumnByName("StatusDesc").content as? String)!, ((r as AnyObject).getColumnByName("ArrivalDate").content as? String)!, ((r as AnyObject).getColumnByName("DepartureDate").content as? String)!, ((r as AnyObject).getColumnByName("PropertyName").content as? String)!, ((r as AnyObject).getColumnByName("PrimaryPeopleID").content as? String)!, ((r as AnyObject).getColumnByName("OrderNo").content as? String)!, ((r as AnyObject).getColumnByName("Intv").content as? String)!, ((r as AnyObject).getColumnByName("IntvYear").content as? String)!, ((r as AnyObject).getColumnByName("fkAccID").content as? String)!, ((r as AnyObject).getColumnByName("fkTrxTypeCCID").content as? String)!, ((r as AnyObject).getColumnByName("AccCode").content as? String)!, ((r as AnyObject).getColumnByName("USDExchange").content as? String)!, ((r as AnyObject).getColumnByName("UnitID").content as? String)!, ((r as AnyObject).getColumnByName("FloorPlanDesc").content as? String)!, ((r as AnyObject).getColumnByName("UnitViewDesc").content as? String)!, ((r as AnyObject).getColumnByName("StayInfoID").content as? String)!]) {
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                    
                                }else
                                {
                                    self.appDelegate.gtblStay = nil
                                    self.appDelegate.gStaysStatus = nil
                                }
                            }
                        }
                        OperationQueue.main.addOperation() {
                            queue.addOperation() {//3
                                //accion webservice-db,
                                if (tableItems.getTotalTables() > 0 ){
                                    queueFM?.inTransaction() {
                                        db, rollback in
                                        
                                        let todaysDate:Date = Date()
                                        let dateFormatter:DateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
                                        let DateInFormat:String = dateFormatter.string(from: todaysDate)
                                        
                                        if (db.executeUpdate("UPDATE tblLogin SET LastStayUpdate=? WHERE PersonalID=?", withArgumentsIn: [DateInFormat,self.appDelegate.gstrPrimaryPeopleID])) {
                                            
                                        }
                                        
                                    }
                                }
                                
                                OperationQueue.main.addOperation() {
                                    queue.addOperation() {//4
                                        //accion webservice-db
                                        if (tableItems.getTotalTables() > 0 ){
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
                                        }else{
                                            self.CountStay = 0
                                        }
                                        
                                        OperationQueue.main.addOperation() {
                                            queue.addOperation() {//5
                                                //accion webservice-db
                                                if (self.CountStay > 0){
                                                    
                                                    queueFM?.inDatabase() {
                                                        db in
                                                        
                                                        for _ in 0...resultStayID-1 {
                                                            Stays.append([:])
                                                        }
                                                        
                                                        if let rs = db.executeQuery("SELECT * FROM tblStay", withArgumentsIn: []){
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
                                                                DataStays["PrimaryPeopleID"] = String(describing:rs.string(forColumn: "PrimaryPeopleID")!)
                                                                DataStays["OrderNo"] = String(describing: rs.string(forColumn: "OrderNo")!)
                                                                DataStays["PrimAgeCFG"] = String(describing: rs.string(forColumn: "PrimAgeCFG")!)
                                                                DataStays["fkPlaceID"] = String(describing: rs.string(forColumn: "fkPlaceID")!)
                                                                DataStays["DepartureDateCheckOut"] = String(describing: rs.string(forColumn: "DepartureDateCheckOut")!)
                                                                DataStays["ConfirmationCode"] = String(describing: rs.string(forColumn: "ConfirmationCode")!)
                                                                DataStays["fkCurrencyID"] = String(describing: rs.string(forColumn: "fkCurrencyID")!)
                                                                Stays[Index] = DataStays
                                                                
                                                                Index = Index + 1
                                                            }
                                                        } else {
                                                            print("select failure: \(db.lastErrorMessage())")
                                                        }
                                                        
                                                    }
                                                    
                                                    self.appDelegate.gtblStay = Stays
                                                    
                                                }else{
                                                    
                                                    self.appDelegate.gtblStay = nil
                                                }
                                                
                                                OperationQueue.main.addOperation() {
                                                    queue.addOperation() {//6
                                                        //accion webservice-db
                                                        if self.appDelegate.gtblStay != nil{
                                                            
                                                            queueFM?.inDatabase() {
                                                                db in
                                                                
                                                                if let rs = db.executeQuery("SELECT * FROM tblStay WHERE StayInfoID = ?", withArgumentsIn: [self.StayInfoID]){
                                                                    while rs.next() {
                                                                        Stay["StayInfoID"] = rs.string(forColumn: "StayInfoID")!
                                                                        Stay["DatabaseName"] = rs.string(forColumn: "DatabaseName")!
                                                                        Stay["PropertyCode"] = rs.string(forColumn: "PropertyCode")!
                                                                        Stay["PropertyName"] = rs.string(forColumn: "PropertyName")!
                                                                        Stay["UnitCode"] = rs.string(forColumn: "UnitCode")!
                                                                        Stay["StatusCode"] = rs.string(forColumn: "StatusCode")!
                                                                        Stay["StatusDesc"] = rs.string(forColumn: "StatusDesc")!
                                                                        Stay["ArrivalDate"] = rs.string(forColumn: "ArrivalDate")!
                                                                        Stay["DepartureDate"] = rs.string(forColumn: "DepartureDate")!
                                                                        Stay["PrimaryPeopleID"] = rs.string(forColumn: "PrimaryPeopleID")!
                                                                        Stay["OrderNo"] = rs.string(forColumn: "OrderNo")!
                                                                        Stay["Intv"] = rs.string(forColumn: "Intv")!
                                                                        Stay["IntvYear"] = rs.string(forColumn: "IntvYear")!
                                                                        Stay["fkAccID"] = rs.string(forColumn: "fkAccID")!
                                                                        Stay["fkTrxTypeID"] = rs.string(forColumn: "fkTrxTypeID")!
                                                                        Stay["AccCode"] = rs.string(forColumn: "AccCode")!
                                                                        Stay["USDExchange"] = rs.string(forColumn: "USDExchange")!
                                                                        Stay["UnitID"] = rs.string(forColumn: "UnitID")!
                                                                        Stay["FloorPlanDesc"] = rs.string(forColumn: "FloorPlanDesc")!
                                                                        Stay["UnitViewDesc"] = rs.string(forColumn: "UnitViewDesc")!
                                                                        Stay["ynPostCheckout"] = rs.string(forColumn: "ynPostCheckout")!
                                                                        Stay["LastAccountUpdate"] = rs.string(forColumn: "LastAccountUpdate")!
                                                                        Stay["PrimAgeCFG"] = rs.string(forColumn: "PrimAgeCFG")!
                                                                        Stay["fkPlaceID"] = rs.string(forColumn: "fkPlaceID")!
                                                                        Stay["DepartureDateCheckOut"] = rs.string(forColumn: "DepartureDateCheckOut")!
                                                                        Stay["ConfirmationCode"] = rs.string(forColumn: "ConfirmationCode")!
                                                                        Stay["fkCurrencyID"] = String(describing: rs.string(forColumn: "fkCurrencyID")!)
                                                                    }
                                                                } else {
                                                                    print("select failure: \(db.lastErrorMessage())")
                                                                }
                                                                
                                                            }
                                                            
                                                            self.Stays = Stay
                                                        }else{
                                                            self.Stays = nil
                                                        }

                                                        queue.addOperation() {//
                                                                //accion base de datos

                                                                if Reachability.isConnectedToNetwork(){
                                                                    if (self.CountStay > 0){
                                                                        if self.Stays["StatusCode"] == "RESERVED" || self.Stays["StatusCode"] == "ASSIGNED"{
                                                                            
                                                                            if Reachability.isConnectedToNetwork(){
                                                                                
                                                                                if self.ynPrimary == "False"{
                                                                                    self.strDateTime = ""
                                                                                }
                                                                                
                                                                                resultAI = 1
                                                                                
                                                                                if self.appDelegate.gblPromoAI == true && self.tblPersonAI.count > 0{
                                                                                    
                                                                                    resultAI = 0
                                                                                    Index = 0
                                                                                    self.cAdult = 0
                                                                                    self.strAges = ""
                                                                                    self.strAgeMsj = ""
                                                                                    
                                                                                    for _ in 0...(self.tblPersonAI.count)-1 {

                                                                                        if self.tblPersonAI[Index]["AdultChildTeen"]!.description == "A"{
                                                                                            self.cAdult = self.cAdult + 1
                                                                                        }
                                                                                        
                                                                                        if self.tblPersonAI[Index]["AdultChildTeen"]!.description == "T"{
                                                                                            self.strAges = self.strAges + ", 1 T-" + self.tblPersonAI[Index]["Age"]!.description
                                                                                        }
                                                                                        
                                                                                        if self.tblPersonAI[Index]["AdultChildTeen"]!.description == "C"{
                                                                                            self.strAges = self.strAges + ", 1 C-" + self.tblPersonAI[Index]["Age"]!.description
                                                                                        }
                                                                                        
                                                                                        if self.tblPersonAI[Index]["AdultChildTeen"]!.description == "I"{
                                                                                            self.strAges = self.strAges + ", 1 I-" + self.tblPersonAI[Index]["Age"]!.description
                                                                                        }
                                                                                        
                                                                                        Index = Index + 1
                                                                                    }
                                                                                    
                                                                                    self.strAgeMsj = self.cAdult.description + " Adult" + self.strAges

                                                                                    Index = 0
                                                                                    
                                                                                    for _ in 0...(self.tblPersonRange.count)-1 {

                                                                                        let iMin = Int(self.tblPersonRange[Index]["RangeMin"]!.description) ?? 0
                                                                                        let iMax = Int(self.tblPersonRange[Index]["RangeMax"]!.description) ?? 0
                                                                                        
                                                                                        if iMin...iMax ~= x! {

                                                                                            self.strRangeCode = self.tblPersonRange[Index]["RangeCode"]!.description
                                                                                            
                                                                                        }

                                                                                        Index = Index + 1
                                                                                    }
                                                                                    
                                                                                    if Int(self.PersonID.description) > 0 {
                                                                                        
                                                                                        queueFM?.inDatabase() {
                                                                                            db in
                                                                                            
                                                                                            resultCountAI = db.intForQuery("SELECT pkGuestAgeID FROM tblPersonAI WHERE fkPeopleID = " + self.PersonID + " AND StayInfoID = " + self.StayInfoID + " LIMIT 1" as String,"" as AnyObject)
                                                                                            
                                                                                            if (resultCountAI == nil){
                                                                                                resultAI = 0
                                                                                                ynOverBookAI = true
                                                                                            }else{
                                                                                                if (String(describing: resultCountAI) == ""){
                                                                                                    resultAI = 0
                                                                                                    ynOverBookAI = true
                                                                                                }else{
                                                                                                    resultAI = Int32(resultCountAI)
                                                                                                }
                                                                                                
                                                                                            }
                                                                                            
                                                                                        
                                                                                    }

                                                                                    }
                                                                                    
                                                                                    if resultAI == 0{
                                                                                        
                                                                                        queueFM?.inDatabase() {
                                                                                            db in
                                                                                            
                                                                                            resultCountAI = db.intForQuery("SELECT pkGuestAgeID FROM tblPersonAI WHERE AdultChildTeen = '" + self.strRangeCode + "' AND fkPeopleID = 0 " + " AND StayInfoID = " + self.StayInfoID + " LIMIT 1" as String,"" as AnyObject)
                                                                                            
                                                                                            if (resultCountAI == nil){
                                                                                                resultAI = 0
                                                                                                ynOverBookAI = true
                                                                                            }else{
                                                                                                if (String(describing: resultCountAI) == ""){
                                                                                                    resultAI = 0
                                                                                                    ynOverBookAI = true
                                                                                                }else{
                                                                                                    resultAI = Int32(resultCountAI)
                                                                                                }
                                                                                                
                                                                                            }
                                                                                            
                                                                                        }
                                                                                        
                                                                                    }else{
                                                                                        
                                                                                        queueFM?.inDatabase() {
                                                                                            db in
                                                                                            
                                                                                            resultRangeCodeAux = db.stringForQuery("SELECT AdultChildTeen FROM tblPersonAI WHERE pkGuestAgeID = " + resultAI.description + " AND StayInfoID = " + self.StayInfoID + "  LIMIT 1" as String,"" as AnyObject)
                                                                                            
                                                                                            if (resultRangeCodeAux == nil){
                                                                                                resultAI = 0
                                                                                                ynOverBookAI = true
                                                                                            }else{
                                                                                                if (String(describing: resultRangeCodeAux) == ""){
                                                                                                    resultAI = 0
                                                                                                    ynOverBookAI = true
                                                                                                }else{
                                                                                                    
                                                                                                    resultRangeCode = String(resultRangeCodeAux.description)
                                                                                                    
                                                                                                    if resultRangeCode != self.strRangeCode{
                                                                                                        resultAI = 0
                                                                                                        ynOverBookAI = true
                                                                                                    }
                                                                                                    
                                                                                                }
                                                                                                
                                                                                            }
                                                                                            
                                                                                        }
                                                                                        
                                                                                    }

                                                                                }
                                                                                
                                                                                tableItems = RRDataSet()
                                                                                
                                                                                if resultAI > 0{
                                                                                    
                                                                                    if self.ynChangeDate{
                                                                                        
                                                                                        self.appDelegate.glbPreCheck = true
                                                                                        self.appDelegate.glbPreCheckSave = true
                                                                                        self.ynChangeDate = false
                                                                                    }
                                                                                    
                                                                                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                                                                                    tableItems = (service?.spSetAppStayPeople(iType,  appCode: self.appDelegate.gstrAppName, userPersonalID: self.PeopleFromCRDID, stayInfoID:self.StayInfoID, id:self.PersonID, firstName:self.edtFName.text, middleName:self.edtMName.text, lastName1:self.edtLName.text, lastName2:self.edtSLName.text, emailAddress:self.edtEmail.text, yearBirthday:self.edtAge.text, ynPrimary:self.ynPrimaryAux, phoneNo: self.edtPhoneNo.text, dtExpectedArrival: self.strDateTime, pkGuestAgeID: resultAI.description, dataBase: self.appDelegate.strDataBaseByStay))!
                                                                                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                                                                }

                                                                            }
                                                                            
                                                                        }
                                                                    }
                                                                    
                                                                }
                                                                
                                                                OperationQueue.main.addOperation() {
                                                                    //Verificamos si existen tablas
                                                                    if (tableItems.getTotalTables() > 0 ){
                                                                        
                                                                        var tableResult = RRDataTable()
                                                                        tableResult = tableItems.tables.object(at: 0) as! RRDataTable
                                                                        
                                                                        var rowResult = RRDataRow()
                                                                        rowResult = tableResult.rows.object(at: 0) as! RRDataRow
                                                                        
                                                                        if rowResult.getColumnByName("iResult") != nil{
                                                                            iResAux = rowResult.getColumnByName("iResult").content as! String
                                                                            iResult = Int(iResAux)!
                                                                        }else{
                                                                            iResAux = "-1"
                                                                        }
                                                                        
                                                                        //Validamos si se encontraron datos
                                                                        if ( iResult > 0 ){
                                                                            
                                                                            var table = RRDataTable()
                                                                            table = tableItems.tables.object(at: 1) as! RRDataTable
                                                                            
                                                                            var r = RRDataRow()
                                                                            r = table.rows.object(at: 0) as! RRDataRow
                                                                            
                                                                            let iResAux = (r as AnyObject).getColumnByName("Result").content as! String
                                                                            iResult = Int(iResAux)!
                                                                            
                                                                            //Si no hubo error regresamos a la forma anterior vcGuestPreCheckin
                                                                            if (iResult > 0 ){
                                                                                
                                                                                if self.appDelegate.gblPromoAI == true && resultCountAI > 0{
                                                                                    
                                                                                    queueFM?.inTransaction() {
                                                                                        db, rollback in
                                                                                        
                                                                                        if (db.executeUpdate("UPDATE tblPersonAI SET fkPeopleID=? WHERE StayInfoID=? AND pkPeopleID=?" , withArgumentsIn: [0,self.StayInfoID,iResult])) {
                                                                                            
                                                                                        }
                                                                                        
                                                                                    }
                                                                                    
                                                                                    queueFM?.inTransaction() {
                                                                                        db, rollback in
                                                                                        
                                                                                        if (db.executeUpdate("UPDATE tblPersonAI SET fkPeopleID=? WHERE StayInfoID=? AND pkGuestAgeID=?" , withArgumentsIn: [iResult,self.StayInfoID,resultCountAI])) {
                                                                                            
                                                                                        }
                                                                                        
                                                                                    }
                                                                                }
                                                                                
                                                                                GoogleWearAlert.showAlert(title: NSLocalizedString("msgAddGuest",comment:""), type: .success, duration: 3, iAction: 2, form:"Stay Guest Add")
                                                                                self.appDelegate.glbPreCheck = true
                                                                                self.appDelegate.glbPreCheckSave = true
                                                                                self.appDelegate.gstrPrimaryPeopleID = self.PersonID
                                                                                self.navigationController?.popViewController(animated: true)
                                                                            }
                                                                            else{
                                                                                sResult = (r as AnyObject).getColumnByName("ResultDesc").content as! String
                                                                                RKDropdownAlert.title(sResult, backgroundColor: UIColor.red, textColor: UIColor.black)
                                                                            }
                                                                            
                                                                            
                                                                        }
                                                                    }
                                                                    
                                                                    if Reachability.isConnectedToNetwork(){
                                                                        
                                                                        if (self.CountStay > 0){
                                                                            if !(self.Stays["StatusCode"] == "RESERVED" || self.Stays["StatusCode"] == "ASSIGNED"){
                                                                                
                                                                                RKDropdownAlert.title(NSLocalizedString("msgResInH",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                                                                                
                                                                            }else if ynOverBookAI == true{
                                                                                RKDropdownAlert.title(NSLocalizedString("msgOcupAI",comment:"") + self.strAgeMsj, backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                                                                            }
                                                                        }
                                                                        
                                                                    }else{
                                                                        RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                                                                    }

                                                                    self.ViewItem.rightBarButtonItem?.isEnabled = true
                                                                    self.ViewItem.leftBarButtonItem?.isEnabled = true
                                                                    self.app.endIgnoringInteractionEvents()
                                                                    SwiftLoader.hide()
                                                                }
                                                            }
                                                    }//6
                                                    
                                                }
                                            }//5
                                            
                                        }
                                    }//4
                                    
                                }
                            }//3
                        }
                    }//2
                }
                
            }//1
            
        }else{
            if resultAI == 0 && self.appDelegate.gblPromoAI == true && x! > 0 && sMsj == "" {
                
                self.ViewItem.rightBarButtonItem?.isEnabled = true
                self.ViewItem.leftBarButtonItem?.isEnabled = true
                self.app.endIgnoringInteractionEvents()
                RKDropdownAlert.title(NSLocalizedString("msgOcup",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                
            }else{
                
                self.ViewItem.rightBarButtonItem?.isEnabled = true
                self.ViewItem.leftBarButtonItem?.isEnabled = true
                self.app.endIgnoringInteractionEvents()
                RKDropdownAlert.title(sMsj, backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                
            }
        }
        
    }
    
    @IBAction func clickSave(_ sender: AnyObject) {
        
        recargarTablaStay()
        
    }
    
    
    /////////
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
    
    func clickGuests(_ sender: AnyObject) {
        
        appDelegate.glbPreCheck = true
        appDelegate.glbPreCheckSave = false
        
        //Regresamos a la vista anterior
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
