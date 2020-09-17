//
//  vcGuestAccountPayment.swift
//  Royal Resorts Guest
//
//  Created by Marco Cocom on 11/20/14.
//  Copyright (c) 2014 Marco Cocom. All rights reserved.
//

import UIKit
import AKMaskField
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


class vcGuestAccountPayment: UIViewController, UITextFieldDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let app = UIApplication.shared
    var width: CGFloat!
    var height: CGFloat!
    var StayInfoID: String!
    var PeopleID: String!
    var formatter = NumberFormatter()
    var Stays: Dictionary<String, String>!
    var fDollar: Double = 0.0
    var fkAccID: String=""
    var fkTrxTypeID: String=""
    var AccCode: String=""
    var DataBase: String=""
    var fAmount: Double = 0
    var AuxPeopleID: String = ""
    var str: String = ""
    var strValidError: String = ""
    //var swTypePay = UISwitch()
    //var lblPayment = UILabel()
    var fTotalAmount: Double = 0
    //var fSizeFont: CGFloat = 0
    var PeopleFDeskID: String = ""
    var ynConn:Bool=false
    var strPeopleName: String = ""
    var btnBack = UIButton()
    var People: Dictionary<String, String>!
    var StaysStatus: [[Dictionary<String, String>]]!
    var tblStayInfo: Dictionary<String, String>!
    var CountStay: Int32 = 0
    var ynPreAuth: Bool = false
    var AccTrxID: String!
    var CcNumber: String!
    var ExpDate: String!
    var PreAmount: String!
    var fPreAmount: Double = 0
    var ynPreAuthCreditCard: Bool = false
    var fkPlaceID: String!
    var ynFocusCVV: Bool = false
    var PersonalInfovw = UIView()
    
    private var cardProgrammatically: AKMaskField!
    
    //var txtccNumber: AKMaskField! = AKMaskField()
    var txtExpMonth = AKMaskField()
    var txtExpYear = AKMaskField()
    var strForceMexicanCc: String!
    var strPeoplePay: String!
    let labelUSD = UILabel()
    var fkCurrencyID: String!
    var runkeeperSwitchForce = DGRunkeeperSwitch()
    var runkeeperSwitch = DGRunkeeperSwitch()
    var aRes: [String] = []
    var strAccountPlace: String = ""
    var label = UILabel()
    var ynRecargaCC: Bool = false
    var ynUSD: Bool = false
    var strDocumentCode: String = ""
    var strFirstName: String = ""
    var strLastName: String = ""
    var labelAmount = UILabel()
    var txtFirstName = UITextField()
    var txtLastName = UITextField()
    var txtAddress = UITextField()
    var txtCity = UITextField()
    var btnCountry: UIButton = UIButton()
    var txtTel = UITextField()
    var txtEmail = UITextField()
    var txtState = UITextField()
    var txtZipCode = UITextField()
    var mas: NSMutableAttributedString = NSMutableAttributedString()
    
    var ynCC: Bool = false
    var ynExpM: Bool = false
    var ynExpY: Bool = false
    var ynCvv: Bool = false
    var ynAmount: Bool = false
    var ynFirstName: Bool = false
    var ynLastName: Bool = false
    var ynAddress: Bool = false
    var ynCity: Bool = false
    var ynCountry: Bool = false
    var ynTel: Bool = false
    var ynEmail: Bool = false
    var ynState: Bool = false
    var ynZipCode: Bool = false
    var strTokenCLBRPay: String = ""
    
    private var card: AKMaskField {
        return cardProgrammatically ?? cardStoryboard
    }
    
    //@IBOutlet weak var tv: UITextField!
    @IBOutlet weak var viewData: UIView!
    
    @IBOutlet weak var viewBody: UIView!
    @IBOutlet weak var viewAccount: UIView!
    @IBOutlet weak var viewCredit: UIView!
    @IBOutlet weak var lblMsgPay: UILabel!
    @IBOutlet weak var lblRules: UILabel!
    @IBOutlet weak var lblKeys: UILabel!
    @IBOutlet weak var lblNames: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblamount: UILabel!
    @IBOutlet weak var lblExchange: UILabel!
    @IBOutlet weak var txtAmountToPay: UITextField!
    //@IBOutlet weak var txtccNumber: UITextField!
    //@IBOutlet weak var txtExpMonth: UITextField!
    //@IBOutlet weak var txtExpYear: UITextField!
    @IBOutlet weak var txtCVV: UITextField!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var barNavigate: UINavigationBar!
    @IBOutlet weak var btnAccount: UIBarButtonItem!
    @IBOutlet var ViewItem: UINavigationItem!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var cardStoryboard: AKMaskField!
    
    @IBOutlet var indicators: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //txtAmountToPay.maskDelegate = self
        //self.tblLogin["FirstName"] = rs.string(forColumn: "FirstName")!
        //self.tblLogin["LastName"] = rs.string(forColumn: "LastName")!
        width = appDelegate.width
        height = appDelegate.height

        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        label.frame = CGRect(x: 0.2*width, y: 0.0, width: 0.6*width, height: 44)
        label.backgroundColor = UIColor.clear;
        label.textAlignment = NSTextAlignment.center;
        label.textColor = UIColor.black;
        label.numberOfLines = 0;
        label.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont9 + appDelegate.gblDeviceFont);
        
        self.tabBarController?.navigationController?.navigationBar.isHidden = true;

        self.navigationController?.navigationBar.isHidden = false;
        
        strFirstName = appDelegate.gtblLogin["FirstName"]!
        strLastName = appDelegate.gtblLogin["LastName"]!
        strTokenCLBRPay = appDelegate.gtblLogin["TokenCLBRPay"]!
        
        print(strTokenCLBRPay)
                
        //Titulo de la vista
        ViewItem.titleView = label
        
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        self.navigationController?.isToolbarHidden = false;
        
        viewBody.frame = CGRect(x: 0.0, y: 0.0*height, width: width, height: height);
        scrollView.frame = CGRect(x: 0.0, y: 0.0, width: width, height: 0.8*height);
        
        if appDelegate.ynIPad {
            switch appDelegate.Model {
            case "iPad 2":
                viewAccount.frame = CGRect(x: 0.05*width, y: 0.055*height, width: 0.9*width, height: 0.234*height);
                viewCredit.frame = CGRect(x: 0.05*width, y: 0.34*height, width: 0.9*width, height: 0.4*height);
            case "iPad Air":
                viewAccount.frame = CGRect(x: 0.05*width, y: 0.055*height, width: 0.9*width, height: 0.234*height);
                viewCredit.frame = CGRect(x: 0.05*width, y: 0.34*height, width: 0.9*width, height: 0.4*height);
            case "iPad Air 2":
                viewAccount.frame = CGRect(x: 0.05*width, y: 0.055*height, width: 0.9*width, height: 0.234*height);
                viewCredit.frame = CGRect(x: 0.05*width, y: 0.34*height, width: 0.9*width, height: 0.4*height);
            case "iPad Pro":
                viewAccount.frame = CGRect(x: 0.05*width, y: 0.055*height, width: 0.9*width, height: 0.234*height);
                viewCredit.frame = CGRect(x: 0.05*width, y: 0.34*height, width: 0.9*width, height: 0.4*height);
            case "iPad Retina":
                viewAccount.frame = CGRect(x: 0.05*width, y: 0.055*height, width: 0.9*width, height: 0.234*height);
                viewCredit.frame = CGRect(x: 0.05*width, y: 0.34*height, width: 0.9*width, height: 0.4*height);
            default:
                viewAccount.frame = CGRect(x: 0.05*width, y: 0.055*height, width: 0.9*width, height: 0.234*height);
                viewCredit.frame = CGRect(x: 0.05*width, y: 0.34*height, width: 0.9*width, height: 0.4*height);
            }
        }else{
            switch appDelegate.Model {
            case "iPhone":
                viewAccount.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.234*height);
                viewCredit.frame = CGRect(x: 0.05*width, y: 0.33*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 4":
                viewAccount.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.234*height);
                viewCredit.frame = CGRect(x: 0.05*width, y: 0.35*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 4s":
                viewAccount.frame = CGRect(x: 0.05*width, y: 0.103*height, width: 0.9*width, height: 0.234*height);
                viewCredit.frame = CGRect(x: 0.05*width, y: 0.35*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 5":
                viewAccount.frame = CGRect(x: 0.05*width, y: 0.076*height, width: 0.9*width, height: 0.234*height);
                viewCredit.frame = CGRect(x: 0.05*width, y: 0.33*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 5c":
                viewAccount.frame = CGRect(x: 0.05*width, y: 0.076*height, width: 0.9*width, height: 0.234*height);
                viewCredit.frame = CGRect(x: 0.05*width, y: 0.33*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 5s":
                viewAccount.frame = CGRect(x: 0.05*width, y: 0.088*height, width: 0.9*width, height: 0.234*height);
                viewCredit.frame = CGRect(x: 0.05*width, y: 0.34*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 6":
                viewAccount.frame = CGRect(x: 0.05*width, y: 0.076*height, width: 0.9*width, height: 0.234*height);
                viewCredit.frame = CGRect(x: 0.05*width, y: 0.33*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 6 Plus":
                viewAccount.frame = CGRect(x: 0.05*width, y: 0.076*height, width: 0.9*width, height: 0.234*height);
                viewCredit.frame = CGRect(x: 0.05*width, y: 0.33*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 6s":
                viewAccount.frame = CGRect(x: 0.05*width, y: 0.076*height, width: 0.9*width, height: 0.234*height);
                viewCredit.frame = CGRect(x: 0.05*width, y: 0.325*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 6s Plus":
                viewAccount.frame = CGRect(x: 0.05*width, y: 0.076*height, width: 0.9*width, height: 0.234*height);
                viewCredit.frame = CGRect(x: 0.05*width, y: 0.325*height, width: 0.9*width, height: 0.4*height);
            default:
                viewAccount.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.234*height);
                viewCredit.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.4*height);
            }
        }

        lblKeys.textAlignment = NSTextAlignment.right
        lblKeys.frame = CGRect(x: 0.02*width, y: 0.01*height, width: 0.2*width, height: 0.03*height);
        
        lblNames.frame = CGRect(x: 0.24*width, y: 0.017*height, width: 0.6*width, height: 0.08*height);
        lblNames.numberOfLines = 0
        lblNames.font = UIFont(name:"Helvetica", size:appDelegate.gblFont3 + appDelegate.gblDeviceFont3)
        //lblNames.sizeToFit()
        
        lblBalance.textAlignment = NSTextAlignment.right
        lblBalance.frame = CGRect(x: 0.02*width, y: 0.1*height, width: 0.2*width, height: 0.03*height);
        lblamount.frame = CGRect(x: 0.24*width, y: 0.101*height, width: 0.25*width, height: 0.03*height);
        lblamount.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        
        labelUSD.frame = CGRect(x: 0.55*width, y: 0.101*height, width: 0.25*width, height: 0.03*height)
        labelUSD.backgroundColor = UIColor.clear;
        labelUSD.textAlignment = NSTextAlignment.left;
        labelUSD.textColor = UIColor.black;
        labelUSD.numberOfLines = 1;
        labelUSD.font = UIFont(name:"Helvetica", size:appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
        viewAccount.addSubview(labelUSD)
        
        lblExchange.frame = CGRect(x: 0.24*width, y: 0.131*height, width: 0.6*width, height: 0.03*height);
        lblExchange.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblExchange.textAlignment = NSTextAlignment.left;
        
        AuxPeopleID = PeopleID
        
        viewAccount.backgroundColor = UIColor.white
        viewAccount.layer.borderColor = UIColor.black.cgColor
        viewAccount.layer.cornerRadius = 5
        lblMsgPay.frame = CGRect(x: 0.05*width, y: 0.24*height, width: 0.9*width, height: 0.06*height);
        viewCredit.backgroundColor = UIColor.white
        viewCredit.layer.borderColor = UIColor.black.cgColor
        viewCredit.layer.cornerRadius = 5

        labelAmount = UILabel(frame: CGRect(x: 0.04*width, y: 0.25*height, width: 0.37*width, height: 0.05*height));
        labelAmount.backgroundColor = UIColor.clear;
        labelAmount.textAlignment = NSTextAlignment.left;
        labelAmount.textColor = UIColor.black;
        labelAmount.numberOfLines = 0;
        labelAmount.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont5 + appDelegate.gblDeviceFont3);
        labelAmount.text = NSLocalizedString("lblAmount",comment:"");
        labelAmount.adjustsFontSizeToFitWidth = true;
        viewCredit.addSubview(labelAmount)
        
        txtAmountToPay.frame = CGRect(x: 0.04*width, y: 0.3*height, width: 0.8*width, height: 0.05*height);
        
        runkeeperSwitchForce = DGRunkeeperSwitch(titles: [NSLocalizedString("lblMXN",comment:""),NSLocalizedString("lblUSD",comment:"")])
        runkeeperSwitchForce.backgroundColor = colorWithHexString ("5C9FCC")
        runkeeperSwitchForce.selectedBackgroundColor = .white
        runkeeperSwitchForce.titleColor = .white
        runkeeperSwitchForce.selectedTitleColor = colorWithHexString ("5C9FCC")
        runkeeperSwitchForce.titleFont = UIFont(name: "HelveticaNeue-Medium", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        runkeeperSwitchForce.frame = CGRect(x: 0.14*width, y: 0.215*height, width: 0.6*width, height: 0.04*height)
        runkeeperSwitchForce.addTarget(self, action: #selector(vcGuestAccountPayment.switchForceMXN(_:)), for: .valueChanged)
        //viewCredit.addSubview(runkeeperSwitchForce)
        
        txtCVV.frame = CGRect(x: 0.69*width, y: 0.15*height, width: 0.15*width, height: 0.05*height);
        btnApply.frame = CGRect(x: 0.3*width, y: 0.37*height, width: 0.3*width, height: 0.05*height);
        lblRules.frame = CGRect(x: 0.05*width, y: 0.8*height, width: 0.6*width, height: 0.03*height);
        
        btnApply.layer.cornerRadius = 5

        txtAmountToPay.delegate = self
        txtCVV.delegate = self
        
        //txtCVV.addTarget(self, action: #selector(txtClick), for: .touchUpInside)
        //txtCVV.addTarget(self, action: #selector(vcGuestAccountPayment.txtClick(_:)), for: .allTouchEvents)
        //txtCVV.addTarget(self, action: #selector(vcGuestAccountPayment.txtClick(_:)), for: .allEditingEvents)
        //txtCVV.addTarget(self, action: #selector(vcGuestAccountPayment.txtClick(_:)), for: .allEvents)
        
        lblKeys.text = NSLocalizedString("lblKeys",comment:"")
        lblKeys.textColor = UIColor.black
        lblKeys.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblBalance.text = NSLocalizedString("lblBalance",comment:"")
        lblBalance.textColor = UIColor.black
        lblBalance.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblMsgPay.text = NSLocalizedString("lblMsgPay",comment:"")
        lblMsgPay.textColor = UIColor.gray;
        lblMsgPay.font = UIFont(name:"HelveticaNeue-Light", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblMsgPay.numberOfLines = 0
        lblMsgPay.textAlignment = NSTextAlignment.left
        txtAmountToPay.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        txtCVV.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)

        btnApply.setTitle(NSLocalizedString("btnPay",comment:""), for: UIControl.State())
        self.btnApply.isHidden = true
        
        let labelccNumber = UILabel(frame: CGRect(x: 0.04*width, y: 0.0*height, width: 0.8*width, height: 0.05*height));
        labelccNumber.backgroundColor = UIColor.clear;
        labelccNumber.textAlignment = NSTextAlignment.left;
        labelccNumber.textColor = UIColor.black;
        labelccNumber.numberOfLines = 0;
        labelccNumber.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont5 + appDelegate.gblDeviceFont3);
        labelccNumber.text = NSLocalizedString("txtccNumber",comment:"")
        labelccNumber.adjustsFontSizeToFitWidth = true;
        viewCredit.addSubview(labelccNumber)

        card.maskExpression = "{dddd} {dddd} {dddd} {dddd}"
        card.maskTemplate = ""
        card.maskDelegate = self
        card.layer.borderColor = UIColor.black.cgColor
        card.borderStyle = UITextField.BorderStyle.roundedRect
        card.frame = CGRect(x: 0.04*width, y: 0.05*height, width: 0.8*width, height: 0.05*height);
        card.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        card.keyboardType = UIKeyboardType.numberPad
        viewCredit.addSubview(card)

        let labelExpdate = UILabel(frame: CGRect(x: 0.04*width, y: 0.1*height, width: 0.8*width, height: 0.05*height));
        labelExpdate.backgroundColor = UIColor.clear;
        labelExpdate.textAlignment = NSTextAlignment.left;
        labelExpdate.textColor = UIColor.black;
        labelExpdate.numberOfLines = 0;
        labelExpdate.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont5 + appDelegate.gblDeviceFont3);
        labelExpdate.text = NSLocalizedString("lblExpirationDate",comment:"")
        labelExpdate.adjustsFontSizeToFitWidth = true;
        viewCredit.addSubview(labelExpdate)

        let labelExpMonth = UILabel(frame: CGRect(x: 0.04*width, y: 0.15*height, width: 0.15*width, height: 0.05*height));
        labelExpMonth.backgroundColor = UIColor.clear;
        labelExpMonth.textAlignment = NSTextAlignment.left;
        labelExpMonth.textColor = UIColor.black;
        labelExpMonth.numberOfLines = 0;
        labelExpMonth.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont5 + appDelegate.gblDeviceFont3);
        labelExpMonth.text = NSLocalizedString("txtExpMonth",comment:"")
        labelExpMonth.adjustsFontSizeToFitWidth = true;
        viewCredit.addSubview(labelExpMonth)
        
        txtExpMonth.maskExpression = "{qr}"
        txtExpMonth.maskTemplate = ""
        txtExpMonth.maskDelegate = self
        txtExpMonth.layer.borderColor = UIColor.black.cgColor
        txtExpMonth.borderStyle = UITextField.BorderStyle.roundedRect
        txtExpMonth.frame = CGRect(x: 0.18*width, y: 0.15*height, width: 0.12*width, height: 0.05*height);
        txtExpMonth.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        txtExpMonth.keyboardType = UIKeyboardType.numberPad
        viewCredit.addSubview(txtExpMonth)
        
        let labelExpYear = UILabel(frame: CGRect(x: 0.33*width, y: 0.15*height, width: 0.1*width, height: 0.05*height));
        labelExpYear.backgroundColor = UIColor.clear;
        labelExpYear.textAlignment = NSTextAlignment.left;
        labelExpYear.textColor = UIColor.black;
        labelExpYear.numberOfLines = 0;
        labelExpYear.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont5 + appDelegate.gblDeviceFont3);
        labelExpYear.text = NSLocalizedString("txtExpYear",comment:"")
        labelExpYear.adjustsFontSizeToFitWidth = true;
        viewCredit.addSubview(labelExpYear)
        
        txtExpYear.maskExpression = "{dd}"
        txtExpYear.maskTemplate = ""
        txtExpYear.maskDelegate = self
        txtExpYear.layer.borderColor = UIColor.black.cgColor
        txtExpYear.borderStyle = UITextField.BorderStyle.roundedRect
        txtExpYear.frame = CGRect(x: 0.43*width, y: 0.15*height, width: 0.12*width, height: 0.05*height);
        txtExpYear.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        txtExpYear.keyboardType = UIKeyboardType.numberPad
        viewCredit.addSubview(txtExpYear)
        
        let labelcvv = UILabel(frame: CGRect(x: 0.58*width, y: 0.15*height, width: 0.1*width, height: 0.05*height));
        labelcvv.backgroundColor = UIColor.clear;
        labelcvv.textAlignment = NSTextAlignment.left;
        labelcvv.textColor = UIColor.black;
        labelcvv.numberOfLines = 0;
        labelcvv.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont5 + appDelegate.gblDeviceFont3);
        labelcvv.text = "CVV";
        labelcvv.adjustsFontSizeToFitWidth = true;
        viewCredit.addSubview(labelcvv)
        
        let ImageVisa = UIImageView()
        let ImageMaster = UIImageView()
        let ImageDiscovery = UIImageView()
        let ImageAmex = UIImageView()
        
        var imageVisa = UIImage()
        var imageMaster = UIImage()
        var imageDiscovery = UIImage()
        var imageAmex = UIImage()
        
        fPreAmount = Double(PreAmount as String)!

        for indicator in indicators {
            indicator.layer.cornerRadius = 10
            indicator.frame  = CGRect(x: 0.7*width, y: 0.34*height, width: 0.05*width, height: 0.05*height);
        }
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(vcGuestAccountPayment.hideKeyboard))
        
        // prevents the scroll view from swallowing up the touch event of child buttons
        tapGesture.cancelsTouchesInView = false
        
        lblMsgPay.isHidden = true
        
        scrollView.addSubview(viewAccount)
        scrollView.addSubview(viewCredit)
        
        scrollView.addGestureRecognizer(tapGesture)

        self.scrollView.setContentOffset(CGPoint.zero, animated: true)
        
        self.ynUSD = false
        self.strForceMexicanCc = "0"
        self.runkeeperSwitchForce.isHidden = false
        self.runkeeperSwitchForce.isEnabled = false
        runkeeperSwitchForce.setSelectedIndex(0, animated: false)
        runkeeperSwitchForce.backgroundColor = colorWithHexString ("C7C7CD")
        runkeeperSwitchForce.selectedTitleColor = colorWithHexString ("C7C7CD")
        
        runkeeperSwitch = DGRunkeeperSwitch(titles: [NSLocalizedString("Parcial",comment:""),NSLocalizedString("Full",comment:"")])
        runkeeperSwitch.backgroundColor = colorWithHexString ("5C9FCC")
        runkeeperSwitch.selectedBackgroundColor = .white
        runkeeperSwitch.titleColor = .white
        runkeeperSwitch.selectedTitleColor = colorWithHexString ("5C9FCC")
        runkeeperSwitch.titleFont = UIFont(name: "HelveticaNeue-Medium", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        runkeeperSwitch.frame = CGRect(x: 0.14*width, y: 0.171*height, width: 0.6*width, height: 0.04*height)
        runkeeperSwitch.addTarget(self, action: #selector(vcGuestAccountPayment.switchValueDidChange(_:)), for: .valueChanged)

        if ynPreAuth == true
        {
            
            var strpre: String = CcNumber
            var start = strpre.index(strpre.startIndex, offsetBy: 12)
            var end = strpre.index(strpre.endIndex, offsetBy: 0)
            var range = start..<end
            var mySubstring = strpre[range]
            
            card.maskTemplate = "xxxx xxxx xxxx " + String(mySubstring)
            
            strpre = ExpDate
            start = strpre.index(strpre.startIndex, offsetBy: 0)
            end = strpre.index(strpre.startIndex, offsetBy: 2)
            range = start..<end
            mySubstring = strpre[range] 
            
            txtExpMonth.text = String(mySubstring)
            
            strpre = ExpDate
            start = strpre.index(strpre.startIndex, offsetBy: 2)
            end = strpre.index(strpre.endIndex, offsetBy: 0)
            range = start..<end
            mySubstring = strpre[range]
            
            txtExpYear.text = String(mySubstring)
            
            txtCVV.text = "xxxx"
            card.isEnabled = false
            txtExpMonth.isEnabled = false
            txtExpYear.isEnabled = false
            txtCVV.isEnabled = false
            if fAmount > fPreAmount{
                
                txtAmountToPay.text = fPreAmount.description
                
            }
            
        }
        
        //Boton pay
        ViewItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("btnPay",comment:""), style: .plain, target: self, action: #selector(vcGuestAccountPayment.clickPayment(_:)))
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            ImageVisa.frame = CGRect(x: 0.64*width, y: 0.008*height, width: 30, height: 20);
            ImageMaster.frame = CGRect(x: 0.74*width, y: 0.008*height, width: 30, height: 20);
            
            imageVisa = UIImage(named:"brand-visa.png")!
            imageMaster = UIImage(named:"brand-mastercard.png")!
            
            ImageVisa.image = imageVisa
            ImageMaster.image = imageMaster
            
            viewCredit.addSubview(ImageVisa)
            viewCredit.addSubview(ImageMaster)
            
            viewCredit.addSubview(runkeeperSwitchForce)
            viewAccount.addSubview(runkeeperSwitch)
            
            strDocumentCode = "APP_PAYTICKET"
            
            if(PeopleFDeskID=="0"){
                runkeeperSwitch.setSelectedIndex(1, animated: false)
                txtAmountToPay.isEnabled = false
                strPeoplePay = appDelegate.gstrLoginFDESKPeopleID
            }else{
                runkeeperSwitch.setSelectedIndex(0, animated: false)
                txtAmountToPay.isEnabled = true
                strPeoplePay = PeopleFDeskID
                runkeeperSwitch.isEnabled = false
                runkeeperSwitch.backgroundColor = colorWithHexString ("C7C7CD")
                runkeeperSwitch.selectedTitleColor = colorWithHexString ("C7C7CD")
            }
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            ImageVisa.frame = CGRect(x: 0.64*width, y: 0.008*height, width: 30, height: 20);
            ImageMaster.frame = CGRect(x: 0.74*width, y: 0.008*height, width: 30, height: 20);
            
            imageVisa = UIImage(named:"brand-visa.png")!
            imageMaster = UIImage(named:"brand-mastercard.png")!
            
            ImageVisa.image = imageVisa
            ImageMaster.image = imageMaster
            
            viewCredit.addSubview(ImageVisa)
            viewCredit.addSubview(ImageMaster)
            
            runkeeperSwitch.frame = CGRect(x: 0.14*width, y: 0.2*height, width: 0.6*width, height: 0.04*height)
            
            runkeeperSwitch.backgroundColor = colorWithHexString ("ba8748")
            runkeeperSwitch.selectedTitleColor = colorWithHexString ("ba8748")
            
            viewAccount.addSubview(runkeeperSwitch)
            viewCredit.addSubview(runkeeperSwitchForce)
            
            strDocumentCode = "APP_PAYTICKET_GRM"
            
            if(PeopleFDeskID=="0"){
                runkeeperSwitch.setSelectedIndex(1, animated: false)
                txtAmountToPay.isEnabled = false
                strPeoplePay = appDelegate.gstrLoginFDESKPeopleID
            }else{
                runkeeperSwitch.setSelectedIndex(0, animated: false)
                txtAmountToPay.isEnabled = true
                strPeoplePay = PeopleFDeskID
                runkeeperSwitch.isEnabled = false
                runkeeperSwitch.backgroundColor = UIColor.clear
                runkeeperSwitch.selectedTitleColor = UIColor.clear
                runkeeperSwitch.backgroundColor = colorWithHexString ("C7C7CD")
                runkeeperSwitch.selectedTitleColor = colorWithHexString ("C7C7CD")
            }

            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            viewAccount.backgroundColor = UIColor.clear
            //viewAccount.frame = CGRectMake(0.05*width, 0.1*height, 0.9*width, 0.17*height);
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
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
            viewAccount.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.03*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.58
            viewAccount.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.06*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.56
            viewAccount.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.09*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.54
            viewAccount.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.12*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.52
            viewAccount.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlefooter.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.15*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.5
            viewAccount.addSubview(imgHdrVw)
            
            var strFontTitle: String = "Futura-CondensedExtraBold"
            var Color: UIColor = colorWithHexString("ba8748")
            
            lblKeys.textColor = Color
            lblBalance.textColor = Color
            lblKeys.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblBalance.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            strFontTitle = "Futura-CondensedMedium"
            Color = colorWithHexString("ba8748")
            
            lblNames.textColor = Color
            lblamount.textColor = Color
            labelUSD.textColor = Color
            lblExchange.textColor = Color
            lblNames.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblamount.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            labelUSD.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblExchange.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            
            lblKeys.textAlignment = NSTextAlignment.left
            lblKeys.frame = CGRect(x: 0.02*width, y: 0.00001*height, width: 0.2*width, height: 0.03*height);
            lblBalance.textAlignment = NSTextAlignment.left
            lblBalance.frame = CGRect(x: 0.02*width, y: 0.1*height, width: 0.2*width, height: 0.03*height);
            
            lblNames.numberOfLines = 0
            lblNames.frame = CGRect(x: 0.24*width, y: 0.0001*height, width: 0.45*width, height: 0.03*height);
            lblNames.textAlignment = NSTextAlignment.left;
            lblNames.numberOfLines = 0
            lblamount.numberOfLines = 0
            lblamount.frame = CGRect(x: 0.24*width, y: 0.101*height, width: 0.25*width, height: 0.03*height);
            labelUSD.numberOfLines = 0
            labelUSD.frame = CGRect(x: 0.55*width, y: 0.101*height, width: 0.25*width, height: 0.03*height);
            labelUSD.textAlignment = NSTextAlignment.left;
            labelUSD.numberOfLines = 1;
            lblExchange.numberOfLines = 0
            lblExchange.frame = CGRect(x: 0.24*width, y: 0.131*height, width: 0.6*width, height: 0.03*height);
            lblExchange.textAlignment = NSTextAlignment.left;
            
            lblNames.text = ""
            lblamount.text = ""
            
            viewAccount.addSubview(lblKeys)
            viewAccount.addSubview(lblBalance)
            viewAccount.addSubview(lblNames)
            viewAccount.addSubview(lblamount)
            viewAccount.addSubview(labelUSD)
            viewAccount.addSubview(lblExchange)
            
            self.view.addSubview(viewAccount)
            
            //runkeeperSwitch.frame = CGRectMake(0.14*width, 0.19*height, 0.6*width, 0.04*height)
            
            strFontTitle = "Futura-CondensedExtraBold"
            Color = colorWithHexString("ba8748")
            
            labelccNumber.backgroundColor = UIColor.clear;
            labelccNumber.textColor = Color
            labelccNumber.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            card.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            labelExpdate.backgroundColor = UIColor.clear;
            labelExpdate.textColor = Color
            labelExpdate.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            labelExpMonth.backgroundColor = UIColor.clear;
            labelExpMonth.textColor = Color
            labelExpMonth.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            txtExpMonth.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            labelExpYear.backgroundColor = UIColor.clear;
            labelExpYear.textColor = Color
            labelExpYear.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            txtExpYear.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            labelcvv.backgroundColor = UIColor.clear;
            labelcvv.textColor = Color
            labelcvv.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            labelAmount.backgroundColor = UIColor.clear;
            labelAmount.textColor = Color
            labelAmount.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            txtAmountToPay.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            strFontTitle = "HelveticaNeue"
            
            label.textColor = UIColor.white
            label.font = UIFont(name:strFontTitle, size:appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            
            scrollView.addSubview(viewAccount)
            scrollView.addSubview(viewCredit)
            
            scrollView.addGestureRecognizer(tapGesture)
            
            self.scrollView.setContentOffset(CGPoint.zero, animated: true)
            
            viewCredit.backgroundColor = colorWithHexString ("eee7dd")

            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            ImageVisa.frame = CGRect(x: 0.64*width, y: 0.008*height, width: 30, height: 20);
            ImageMaster.frame = CGRect(x: 0.74*width, y: 0.008*height, width: 30, height: 20);

            imageVisa = UIImage(named:"brand-visa.png")!
            imageMaster = UIImage(named:"brand-mastercard.png")!
            
            ImageVisa.image = imageVisa
            ImageMaster.image = imageMaster
            
            viewCredit.addSubview(ImageVisa)
            viewCredit.addSubview(ImageMaster)
            
            strDocumentCode = "APP_PAYTICKET_SBR"
            
            if(PeopleFDeskID=="0"){
                txtAmountToPay.isEnabled = false
                strPeoplePay = appDelegate.gstrLoginFDESKPeopleID
            }else{
                txtAmountToPay.isEnabled = true
                strPeoplePay = PeopleFDeskID
            }
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            viewAccount.backgroundColor = UIColor.clear
            viewAccount.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.17*height);
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
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
            viewAccount.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.03*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.58
            viewAccount.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.06*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.56
            viewAccount.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.09*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.54
            viewAccount.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.12*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.52
            viewAccount.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlefooter.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.15*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.5
            viewAccount.addSubview(imgHdrVw)
            
            var strFontTitle: String = "Futura-CondensedExtraBold"
            var Color: UIColor = colorWithHexString("5c9fcc")

            lblKeys.textColor = Color
            lblBalance.textColor = Color
            lblKeys.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblBalance.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            strFontTitle = "Futura-CondensedMedium"
            Color = colorWithHexString("5c9fcc")
            
            lblNames.textColor = Color
            lblamount.textColor = Color
            labelUSD.textColor = Color
            lblExchange.textColor = Color
            lblNames.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblamount.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            labelUSD.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblExchange.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)

            lblKeys.textAlignment = NSTextAlignment.left
            lblKeys.frame = CGRect(x: 0.02*width, y: 0.00001*height, width: 0.2*width, height: 0.03*height);
            lblBalance.textAlignment = NSTextAlignment.left
            lblBalance.frame = CGRect(x: 0.02*width, y: 0.1*height, width: 0.2*width, height: 0.03*height);

            lblNames.numberOfLines = 0
            lblNames.frame = CGRect(x: 0.24*width, y: 0.0001*height, width: 0.45*width, height: 0.03*height);
            lblNames.textAlignment = NSTextAlignment.left;
            lblNames.numberOfLines = 0
            lblamount.numberOfLines = 0
            lblamount.frame = CGRect(x: 0.24*width, y: 0.101*height, width: 0.25*width, height: 0.03*height);
            labelUSD.numberOfLines = 0
            labelUSD.frame = CGRect(x: 0.55*width, y: 0.101*height, width: 0.25*width, height: 0.03*height);
            labelUSD.textAlignment = NSTextAlignment.left;
            labelUSD.numberOfLines = 1;
            lblExchange.numberOfLines = 0
            lblExchange.frame = CGRect(x: 0.24*width, y: 0.131*height, width: 0.6*width, height: 0.03*height);
            lblExchange.textAlignment = NSTextAlignment.left;
            
            lblNames.text = ""
            lblamount.text = ""
            
            viewAccount.addSubview(lblKeys)
            viewAccount.addSubview(lblBalance)
            viewAccount.addSubview(lblNames)
            viewAccount.addSubview(lblamount)
            viewAccount.addSubview(labelUSD)
            viewAccount.addSubview(lblExchange)
            
            self.view.addSubview(viewAccount)
            
            runkeeperSwitch.frame = CGRect(x: 0.14*width, y: 0.19*height, width: 0.6*width, height: 0.04*height)
            
            strFontTitle = "Futura-CondensedExtraBold"
            Color = colorWithHexString("5c9fcc")

            labelccNumber.backgroundColor = UIColor.clear;
            labelccNumber.textColor = Color
            labelccNumber.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            card.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            labelExpdate.backgroundColor = UIColor.clear;
            labelExpdate.textColor = Color
            labelExpdate.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)

            labelExpMonth.backgroundColor = UIColor.clear;
            labelExpMonth.textColor = Color
            labelExpMonth.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            txtExpMonth.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            labelExpYear.backgroundColor = UIColor.clear;
            labelExpYear.textColor = Color
            labelExpYear.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            txtExpYear.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            labelcvv.backgroundColor = UIColor.clear;
            labelcvv.textColor = Color
            labelcvv.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            labelAmount.backgroundColor = UIColor.clear;
            labelAmount.textColor = Color
            labelAmount.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            txtAmountToPay.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            strFontTitle = "HelveticaNeue"
            
            label.textColor = UIColor.white
            label.font = UIFont(name:strFontTitle, size:appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            
            scrollView.addSubview(viewAccount)
            scrollView.addSubview(viewCredit)
            
            scrollView.addGestureRecognizer(tapGesture)
            
            self.scrollView.setContentOffset(CGPoint.zero, animated: true)
            
            viewCredit.backgroundColor = colorWithHexString ("DDF4FF")
            
            labelUSD.isHidden = true
            lblExchange.isHidden = true
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{

            ImageDiscovery.frame = CGRect(x: 0.44*width, y: 0.008*height, width: 30, height: 20);
            ImageAmex.frame = CGRect(x: 0.54*width, y: 0.008*height, width: 30, height: 20);
            ImageMaster.frame = CGRect(x: 0.64*width, y: 0.008*height, width: 30, height: 20);
            ImageVisa.frame = CGRect(x: 0.74*width, y: 0.008*height, width: 30, height: 20);
            
            imageVisa = UIImage(named:"brand-visa.png")!
            imageMaster = UIImage(named:"brand-mastercard.png")!
            imageDiscovery = UIImage(named:"brand-discover.png")!
            imageAmex = UIImage(named:"brand-amex.png")!
            
            ImageVisa.image = imageVisa
            ImageMaster.image = imageMaster
            ImageDiscovery.image = imageDiscovery
            ImageAmex.image = imageAmex
            
            viewCredit.addSubview(ImageVisa)
            viewCredit.addSubview(ImageMaster)
            viewCredit.addSubview(ImageDiscovery)
            viewCredit.addSubview(ImageAmex)
            
            runkeeperSwitch.frame = CGRect(x: 0.14*width, y: 0.2*height, width: 0.6*width, height: 0.04*height)
            
            runkeeperSwitch.backgroundColor = colorWithHexString ("004c50")
            runkeeperSwitch.selectedTitleColor = colorWithHexString ("004c50")
            
            viewAccount.addSubview(runkeeperSwitch)
            viewCredit.addSubview(runkeeperSwitchForce)
            
            strDocumentCode = "APP_PAYTICKET_CL"
            
            if(PeopleFDeskID=="0"){
                runkeeperSwitch.setSelectedIndex(1, animated: false)
                txtAmountToPay.isEnabled = false
                strPeoplePay = appDelegate.gstrLoginFDESKPeopleID
            }else{
                runkeeperSwitch.setSelectedIndex(0, animated: false)
                txtAmountToPay.isEnabled = true
                strPeoplePay = PeopleFDeskID
                runkeeperSwitch.isEnabled = false
                runkeeperSwitch.backgroundColor = UIColor.clear
                runkeeperSwitch.selectedTitleColor = UIColor.clear
                runkeeperSwitch.backgroundColor = colorWithHexString ("C7C7CD")
                runkeeperSwitch.selectedTitleColor = colorWithHexString ("C7C7CD")
            }

            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            viewAccount.backgroundColor = UIColor.clear
            //viewAccount.frame = CGRectMake(0.05*width, 0.1*height, 0.9*width, 0.17*height);
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
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
            //viewAccount.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.03*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.58
            //viewAccount.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.06*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.56
            //viewAccount.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.09*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.54
            //viewAccount.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.12*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.52
            //viewAccount.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlefooter.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.15*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.5
            //viewAccount.addSubview(imgHdrVw)
            
            var strFontTitle: String = "Futura-CondensedExtraBold"
            var Color: UIColor = colorWithHexString("004c50")
            
            lblKeys.textColor = Color
            lblBalance.textColor = Color
            lblKeys.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblBalance.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            strFontTitle = "Futura-CondensedMedium"
            Color = colorWithHexString("2e3634")
            
            lblNames.textColor = Color
            lblamount.textColor = Color
            labelUSD.textColor = Color
            lblExchange.textColor = Color
            lblNames.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblamount.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            labelUSD.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblExchange.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            
            lblKeys.textAlignment = NSTextAlignment.left
            lblKeys.frame = CGRect(x: 0.02*width, y: 0.00001*height, width: 0.2*width, height: 0.03*height);
            lblBalance.textAlignment = NSTextAlignment.left
            lblBalance.frame = CGRect(x: 0.02*width, y: 0.1*height, width: 0.2*width, height: 0.03*height);
            
            lblNames.numberOfLines = 0
            lblNames.frame = CGRect(x: 0.24*width, y: 0.0001*height, width: 0.45*width, height: 0.03*height);
            lblNames.textAlignment = NSTextAlignment.left;
            lblNames.numberOfLines = 0
            lblamount.numberOfLines = 0
            lblamount.frame = CGRect(x: 0.24*width, y: 0.101*height, width: 0.25*width, height: 0.03*height);
            labelUSD.numberOfLines = 0
            labelUSD.frame = CGRect(x: 0.55*width, y: 0.101*height, width: 0.25*width, height: 0.03*height);
            labelUSD.textAlignment = NSTextAlignment.left;
            labelUSD.numberOfLines = 1;
            lblExchange.numberOfLines = 0
            lblExchange.frame = CGRect(x: 0.24*width, y: 0.131*height, width: 0.6*width, height: 0.03*height);
            lblExchange.textAlignment = NSTextAlignment.left;
            
            lblNames.text = ""
            lblamount.text = ""
            
            viewAccount.addSubview(lblKeys)
            viewAccount.addSubview(lblBalance)
            viewAccount.addSubview(lblNames)
            viewAccount.addSubview(lblamount)
            //viewAccount.addSubview(labelUSD)
            //viewAccount.addSubview(lblExchange)
            lblExchange.isHidden = true
            
            labelUSD.isHidden = true
            lblExchange.isHidden = true
            runkeeperSwitchForce.isHidden = true
            
            //self.view.addSubview(viewAccount)
            
            //runkeeperSwitch.frame = CGRectMake(0.14*width, 0.19*height, 0.6*width, 0.04*height)
            
            strFontTitle = "Futura-CondensedExtraBold"
            Color = colorWithHexString("004c50")
            
            labelccNumber.backgroundColor = UIColor.clear;
            labelccNumber.textColor = Color
            labelccNumber.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            card.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            labelExpdate.backgroundColor = UIColor.clear;
            labelExpdate.textColor = Color
            labelExpdate.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            labelExpMonth.backgroundColor = UIColor.clear;
            labelExpMonth.textColor = Color
            labelExpMonth.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            txtExpMonth.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            labelExpYear.backgroundColor = UIColor.clear;
            labelExpYear.textColor = Color
            labelExpYear.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            txtExpYear.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            labelcvv.backgroundColor = UIColor.clear;
            labelcvv.textColor = Color
            labelcvv.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            labelAmount.backgroundColor = UIColor.clear;
            labelAmount.textColor = Color
            labelAmount.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            txtAmountToPay.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            strFontTitle = "HelveticaNeue"
            
            label.textColor = UIColor.white
            label.font = UIFont(name:strFontTitle, size:appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            
            scrollView.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height);
            scrollView.contentSize = CGSize(width: width, height: height)
            
            labelAmount.frame = CGRect(x: 0.04*width, y: 0.2*height, width: 0.37*width, height: 0.05*height)
            txtAmountToPay.frame = CGRect(x: 0.04*width, y: 0.25*height, width: 0.8*width, height: 0.05*height);
            
            txtFirstName.frame = CGRect(x: 0.0, y: 0.01*height, width: 0.4*width, height: 0.05*height);
            txtLastName.frame = CGRect(x: 0.45*width, y: 0.01*height, width: 0.4*width, height: 0.05*height);
            txtAddress.frame = CGRect(x: 0.0, y: 0.07*height, width: 0.85*width, height: 0.05*height);
            txtCity.frame = CGRect(x: 0.0, y: 0.13*height, width: 0.4*width, height: 0.05*height);
            btnCountry.frame = CGRect(x: 0.45*width, y: 0.13*height, width: 0.4*width, height: 0.05*height);
            txtState.frame = CGRect(x: 0.0, y: 0.19*height, width: 0.4*width, height: 0.05*height);
            txtZipCode.frame = CGRect(x: 0.45*width, y: 0.19*height, width: 0.4*width, height: 0.05*height);
            txtTel.frame = CGRect(x: 0.0, y: 0.25*height, width: 0.4*width, height: 0.05*height);
            txtEmail.frame = CGRect(x: 0.45*width, y: 0.25*height, width: 0.4*width, height: 0.05*height);
            
            /*if appDelegate.ynIPad {
                PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.64*height, width: 0.9*width, height: 0.4*height)
            }else{
                PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.71*height, width: 0.9*width, height: 0.4*height)
            }*/
            
            //PersonalInfovw.backgroundColor = UIColor.red

            txtFirstName.backgroundColor = UIColor.clear;
            txtFirstName.textAlignment = NSTextAlignment.left;
            txtFirstName.font = UIFont(name: "Futura-CondensedMedium", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
            txtFirstName.layer.borderColor = UIColor.black.cgColor
            txtFirstName.borderStyle = UITextField.BorderStyle.roundedRect
            txtFirstName.keyboardType = UIKeyboardType.alphabet
            txtFirstName.placeholder = NSLocalizedString("lblFirstName",comment:"")
            txtFirstName.delegate = self
            
            txtFirstName.text = strFirstName
            
            txtLastName.backgroundColor = UIColor.clear;
            txtLastName.textAlignment = NSTextAlignment.left;
            txtLastName.font = UIFont(name: "Futura-CondensedMedium", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
            txtLastName.layer.borderColor = UIColor.black.cgColor
            txtLastName.borderStyle = UITextField.BorderStyle.roundedRect
            txtLastName.keyboardType = UIKeyboardType.alphabet
            txtLastName.placeholder = NSLocalizedString("lblLastName",comment:"")
            txtLastName.delegate = self
            
            txtLastName.text = strLastName
            
            txtAddress.backgroundColor = UIColor.clear;
            txtAddress.textAlignment = NSTextAlignment.left;
            txtAddress.font = UIFont(name: "Futura-CondensedMedium", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
            txtAddress.layer.borderColor = UIColor.black.cgColor
            txtAddress.borderStyle = UITextField.BorderStyle.roundedRect
            txtAddress.keyboardType = UIKeyboardType.alphabet
            txtAddress.placeholder = NSLocalizedString("lblAddress",comment:"")
            txtAddress.delegate = self
            
            txtAddress.text = appDelegate.gtblLogin["Address"]!
            
            txtCity.backgroundColor = UIColor.clear;
            txtCity.textAlignment = NSTextAlignment.left;
            txtCity.font = UIFont(name: "Futura-CondensedMedium", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
            txtCity.layer.borderColor = UIColor.black.cgColor
            txtCity.borderStyle = UITextField.BorderStyle.roundedRect
            txtCity.keyboardType = UIKeyboardType.alphabet
            txtCity.placeholder = NSLocalizedString("lblCity",comment:"")
            txtCity.delegate = self

            txtCity.text = appDelegate.gtblLogin["City"]!
            
            appDelegate.gstrCountry = appDelegate.gtblLogin["Country"]!
            
            if appDelegate.gstrCountry == ""{
                mas = NSMutableAttributedString(string: NSLocalizedString("lblCountry",comment:""), attributes: [
                    NSAttributedString.Key.font: UIFont(name:"Futura-CondensedMedium", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont7)!,
                    NSAttributedString.Key.foregroundColor: colorWithHexString ("000000")
                    ])
            }else{
                mas = NSMutableAttributedString(string: appDelegate.gstrCountry, attributes: [
                    NSAttributedString.Key.font: UIFont(name:"Futura-CondensedMedium", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont7)!,
                    NSAttributedString.Key.foregroundColor: colorWithHexString ("000000")
                    ])
            }
            

            btnCountry.setAttributedTitle(mas, for: UIControl.State())
            btnCountry.layer.borderColor = colorWithHexString ("e1e1e1").cgColor
            btnCountry.layer.borderWidth = 1
            btnCountry.addTarget(self, action: #selector(vcGuestAccountPayment.clickCountry(_:)), for: UIControl.Event.touchUpInside)
            btnCountry.backgroundColor = colorWithHexString ("ffffff")
            btnCountry.layer.cornerRadius = 5
            btnCountry.contentHorizontalAlignment = .left
            btnCountry.contentEdgeInsets = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 0)
            btnCountry.titleLabel!.numberOfLines = 1
            btnCountry.titleLabel!.adjustsFontSizeToFitWidth = true
            btnCountry.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            txtState.backgroundColor = UIColor.clear;
            txtState.textAlignment = NSTextAlignment.left;
            txtState.font = UIFont(name: "Futura-CondensedMedium", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
            txtState.layer.borderColor = UIColor.black.cgColor
            txtState.borderStyle = UITextField.BorderStyle.roundedRect
            txtState.keyboardType = UIKeyboardType.alphabet
            txtState.placeholder = NSLocalizedString("lblState",comment:"")
            txtState.delegate = self
            
            txtState.text = appDelegate.gtblLogin["State"]!
            
            txtZipCode.backgroundColor = UIColor.clear;
            txtZipCode.textAlignment = NSTextAlignment.left;
            txtZipCode.font = UIFont(name: "Futura-CondensedMedium", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
            txtZipCode.layer.borderColor = UIColor.black.cgColor
            txtZipCode.borderStyle = UITextField.BorderStyle.roundedRect
            txtZipCode.keyboardType = UIKeyboardType.alphabet
            txtZipCode.placeholder = NSLocalizedString("lblZipCode",comment:"")
            txtZipCode.delegate = self
            
            txtZipCode.text = appDelegate.gtblLogin["ZipCode"]!
            
            txtTel.backgroundColor = UIColor.clear;
            txtTel.textAlignment = NSTextAlignment.left;
            txtTel.font = UIFont(name: "Futura-CondensedMedium", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
            txtTel.layer.borderColor = UIColor.black.cgColor
            txtTel.borderStyle = UITextField.BorderStyle.roundedRect
            txtTel.keyboardType = UIKeyboardType.alphabet
            txtTel.placeholder = NSLocalizedString("lblTelephone",comment:"")
            txtTel.delegate = self
            
            txtTel.text = appDelegate.gtblLogin["Phone"]!
            
            txtEmail.backgroundColor = UIColor.clear;
            txtEmail.textAlignment = NSTextAlignment.left;
            txtEmail.font = UIFont(name: "Futura-CondensedMedium", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
            txtEmail.layer.borderColor = UIColor.black.cgColor
            txtEmail.borderStyle = UITextField.BorderStyle.roundedRect
            txtEmail.keyboardType = UIKeyboardType.alphabet
            txtEmail.placeholder = NSLocalizedString("lblEmail",comment:"")
            txtEmail.delegate = self
            
            txtEmail.text = appDelegate.gtblLogin["Email"]!
            
            PersonalInfovw.addSubview(txtFirstName)
            PersonalInfovw.addSubview(txtLastName)
            PersonalInfovw.addSubview(txtAddress)
            PersonalInfovw.addSubview(txtCity)
            PersonalInfovw.addSubview(btnCountry)
            PersonalInfovw.addSubview(txtTel)
            PersonalInfovw.addSubview(txtEmail)
            PersonalInfovw.addSubview(txtState)
            PersonalInfovw.addSubview(txtZipCode)
            
            scrollView.addSubview(viewAccount)
            scrollView.addSubview(viewCredit)
            scrollView.addSubview(PersonalInfovw)
            
            scrollView.addGestureRecognizer(tapGesture)
            
            if appDelegate.ynIPad {
                switch appDelegate.Model {
                case "iPad 2":
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 40), animated: true)
                    PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.64*height, width: 0.9*width, height: 0.4*height)
                case "iPad Air":
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 40), animated: true)
                    PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.64*height, width: 0.9*width, height: 0.4*height)
                case "iPad Air 2":
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 40), animated: true)
                    PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.64*height, width: 0.9*width, height: 0.4*height)
                case "iPad Pro":
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 60), animated: true)
                    PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.64*height, width: 0.9*width, height: 0.4*height)
                case "iPad Retina":
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 60), animated: true)
                    PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.64*height, width: 0.9*width, height: 0.4*height)
                default:
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 60), animated: true)
                    PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.64*height, width: 0.9*width, height: 0.4*height)
                }
            }else{
                switch appDelegate.Model {
                case "iPhone":
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 40), animated: true)
                    PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.64*height, width: 0.9*width, height: 0.4*height)
                case "iPhone 4":
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 40), animated: true)
                    PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.64*height, width: 0.9*width, height: 0.4*height)
                case "iPhone 4s":
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 40), animated: true)
                    PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.64*height, width: 0.9*width, height: 0.4*height)
                case "iPhone 5":
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 40), animated: true)
                    PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.64*height, width: 0.9*width, height: 0.4*height)
                case "iPhone 5c":
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 40), animated: true)
                    PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.64*height, width: 0.9*width, height: 0.4*height)
                case "iPhone 5s":
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 40), animated: true)
                    PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.64*height, width: 0.9*width, height: 0.4*height)
                case "iPhone 6":
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 40), animated: true)
                    PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.64*height, width: 0.9*width, height: 0.4*height)
                case "iPhone 6 Plus":
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 40), animated: true)
                    PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.64*height, width: 0.9*width, height: 0.4*height)
                case "iPhone 6s":
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 40), animated: true)
                    PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.64*height, width: 0.9*width, height: 0.4*height)
                case "iPhone 6s Plus":
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 40), animated: true)
                    PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.65*height, width: 0.9*width, height: 0.4*height)
                default:
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 60), animated: true)
                    PersonalInfovw.frame = CGRect(x: 0.05*width, y: 0.71*height, width: 0.9*width, height: 0.4*height)
                }
            }
            
            viewCredit.backgroundColor = colorWithHexString ("ffffff")
            
            spGetCmbCountryForApp()
            
            self.appDelegate.gstrISOCountryCode = appDelegate.gtblLogin["ISOCode"]!
            
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(vcGuestAccountPayment.txtClickCCNumber))
        tap.numberOfTapsRequired = 1
        card.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(vcGuestAccountPayment.txtClickExpMonth))
        tap2.numberOfTapsRequired = 1
        txtExpMonth.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(vcGuestAccountPayment.txtClickExpYear))
        tap3.numberOfTapsRequired = 1
        txtExpYear.addGestureRecognizer(tap3)
        
        recargarTablaStay()

    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        /*if txtCountry == textField{
            return false
        }*/
        return true
    }
    
    @objc func spGetCmbCountryForApp() {
        //[dbo].[spGetCmbCountryForApp]
        
        var iRes: String = ""

        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        var tableItems = RRDataSet()
        let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
        tableItems = (service?.spGetCmbCountry(self.appDelegate.strDataBaseByStay))!
        
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
                
                if (table.getTotalRows() > 0){
                    
                    var gtblCountryAux: Dictionary<String, String>!
                    
                    gtblCountryAux = [:]
                    self.appDelegate.gtblCountry = []
                    
                    queueFM?.inTransaction { db, rollback in
                        do {
                            
                            for r in table.rows{

                                try db.executeUpdate("INSERT INTO tblCountry(ISOCode, Description, SeqNo) VALUES (?, ?, ?)", withArgumentsIn: [((r as AnyObject).getColumnByName("ISOCode").content as? String)!, ((r as AnyObject).getColumnByName("Description").content as? String)!, ((r as AnyObject).getColumnByName("SeqNo").content as? String)!])
                                
                            }


                        } catch {
                            rollback.pointee = true
                            print(error)
                        }
                    }
                    
                    queueFM?.inDatabase() {
                        db in
                        
                        if let rs = db.executeQuery("SELECT * FROM tblCountry", withArgumentsIn:[]) {
                            while rs.next() {
                                
                                gtblCountryAux["ISOCode"] = rs.string(forColumn: "ISOCode")!
                                gtblCountryAux["Description"] = rs.string(forColumn: "Description")!
                                gtblCountryAux["SeqNo"] = rs.string(forColumn: "SeqNo")!
                                
                                self.appDelegate.gtblCountry.append(gtblCountryAux)
                                
                            }
                        } else {
                            print("select failure: \(db.lastErrorMessage())")
                        }
                    }
                    
                }else{
                    self.appDelegate.gblynPreAuth = false
                    self.appDelegate.gtblAccPreAuth = nil
                }
                
            }
        }
        
    }
    
    @objc func clickCountry(_ sender: AnyObject) {
        
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectStay") as! vcSelectStay
        tercerViewController.strMode = "Country"
        self.navigationController?.pushViewController(tercerViewController, animated: true)
        
    }
    @objc func txtClickCCNumber() {
        
        ynCC = true

        let ccNumber = card.text!.trimmingCharacters(in: .whitespaces)
        if ccNumber == ""{
            let newPosition = card.beginningOfDocument
            card.selectedTextRange = card.textRange(from: newPosition, to: newPosition)
        }

        card.becomeFirstResponder()

    }
    
    @objc func txtClickExpMonth() {
        
        ynExpM = true
        
        let ExpMonth = txtExpMonth.text!.trimmingCharacters(in: .whitespaces)
        if ExpMonth == ""{
            let newPosition = txtExpMonth.beginningOfDocument
            txtExpMonth.selectedTextRange = txtExpMonth.textRange(from: newPosition, to: newPosition)
        }

        txtExpMonth.becomeFirstResponder()

    }
    
    @objc func txtClickExpYear() {
        
        ynExpY = true
        
        let ExpYear = txtExpYear.text!.trimmingCharacters(in: .whitespaces)
        if ExpYear == ""{
            let newPosition = txtExpYear.beginningOfDocument
            txtExpYear.selectedTextRange = txtExpYear.textRange(from: newPosition, to: newPosition)
        }

        txtExpYear.becomeFirstResponder()

    }
    
    @objc func switchValueDidChange(_ sender: DGRunkeeperSwitch!) {
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        var strQuery: String = ""
        if self.Stays != nil{
            
            if(PeopleFDeskID == "0"){
                
                if sender.selectedIndex == 1 {
                    
                    strQuery = ""
                    
                    strQuery = "SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ?"
                    
                    queueFM?.inDatabase() {
                        db in
                        
                        if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID]){
                            while rs.next() {
                                if rs.columnIsNull("Amount") != true {
                                    self.fAmount = Double(String(format: "%.2f", (rs.string(forColumn: "Amount")! as NSString).floatValue))!
                                }
                            }
                        } else {
                            print("select failure: \(db.lastErrorMessage())")
                        }
                        
                    }
                    
                    self.strPeopleName = ""
                    
                    strQuery = "SELECT FullName FROM tblPerson WHERE StayInfoID = ?"
                    
                    queueFM?.inDatabase() {
                        db in
                        if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID,self.PeopleFDeskID]){
                            while rs.next() {
                                self.strPeopleName = self.strPeopleName + rs.string(forColumn: "FullName")! + ", "
                            }
                            if self.strPeopleName != ""{
                                let strpre: String = self.strPeopleName
                                
                                let start = strpre.index(strpre.startIndex, offsetBy: 0)
                                let end = strpre.index(strpre.endIndex, offsetBy: -2)
                                let range = start..<end
                                
                                let mySubstring = strpre[range]
                                
                                self.strPeopleName = mySubstring.description
                            }
                        } else {
                            print("select failure: \(db.lastErrorMessage())")
                        }
                    }
                    
                    txtAmountToPay.isEnabled = false
                } else {
                    
                    /*strQuery = ""
                     
                     strQuery = "SELECT CASE WHEN SUM(Amount) > 0 THEN SUM(Amount) ELSE 0 END as Amount FROM tblAccount where StayInfoID = ? AND PeopleFDeskID =?"
                     
                     queueFM?.inDatabase() {
                     db in
                     
                     if let rs = db.executeQuery(strQuery, withArgumentsInArray: [self.StayInfoID, self.PeopleFDeskID]){
                     while rs.next() {
                     self.fAmount = Double(String(format: "%.2f", (rs.stringForColumn("Amount") as NSString).floatValue))!
                     }
                     } else {
                     print("select failure: \(db.lastErrorMessage())")
                     }
                     
                     }
                     
                     self.strPeopleName = ""
                     
                     strQuery = "SELECT FullName FROM tblPerson WHERE StayInfoID = ?"
                     
                     queueFM?.inDatabase() {
                     db in
                     if let rs = db.executeQuery(strQuery, withArgumentsInArray: [self.StayInfoID,self.PeopleFDeskID]){
                     while rs.next() {
                     self.strPeopleName = self.strPeopleName + rs.stringForColumn("FullName") + ", "
                     }
                     if self.strPeopleName != ""{
                     self.strPeopleName = self.strPeopleName.substringWithRange(Range<String.Index>(self.strPeopleName.startIndex ..< self.strPeopleName.endIndex.advancedBy(-2)))
                     }
                     } else {
                     print("select failure: \(db.lastErrorMessage())")
                     }
                     }*/
                    
                    txtAmountToPay.isEnabled = true
                }
                
                lblNames.frame = CGRect(x: 0.24*width, y: 0.017*height, width: 0.6*width, height: 0.08*height);
                lblNames.numberOfLines = 0
                lblNames.text = ""
                lblNames.text = self.strPeopleName
                lblNames.sizeToFit()
                
                str = String(format: "%.2f", (String(format: "%.2f0", (fAmount.description as NSString).floatValue) as NSString).floatValue)
                lblamount.text = str + " " + self.Stays["fkCurrencyID"]!
                
                if runkeeperSwitchForce.selectedIndex == 0 {
                    txtAmountToPay.text = String(format: "%.2f", (String(format: "%.2f0", (fAmount.description as NSString).floatValue) as NSString).floatValue)
                } else {
                    txtAmountToPay.text = String(format: "%.2f", (String(format: "%.2f0", ((fAmount/fDollar).description as NSString).floatValue) as NSString).floatValue)
                }
                
                labelUSD.text = String(format: "%.2f", (String(format: "%.2f0", ((fAmount/fDollar).description as NSString).floatValue) as NSString).floatValue) + " USD"
            }else{
                strQuery = ""
                
                strQuery = "SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ? AND PeopleFDeskID =?"
                
                queueFM?.inDatabase() {
                    db in
                    
                    if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID, self.PeopleFDeskID]){
                        while rs.next() {
                            if rs.columnIsNull("Amount") != true {
                                self.fAmount = Double(String(format: "%.2f", (rs.string(forColumn: "Amount")! as NSString).floatValue))!
                            }
                        }
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                    
                }
                
                self.strPeopleName = ""
                
                strQuery = "SELECT FullName FROM tblPerson WHERE StayInfoID = ? AND PeopleFDeskID =?"
                
                queueFM?.inDatabase() {
                    db in
                    if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID,self.PeopleFDeskID]){
                        while rs.next() {
                            self.strPeopleName = self.strPeopleName + rs.string(forColumn: "FullName")! + ", "
                        }
                        if self.strPeopleName != ""{
                            let strpre: String = self.strPeopleName
                            
                            let start = strpre.index(strpre.startIndex, offsetBy: 0)
                            let end = strpre.index(strpre.endIndex, offsetBy: -2)
                            let range = start..<end
                            
                            let mySubstring = strpre[range]
                            
                            self.strPeopleName = mySubstring.description
                        }
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                }
                txtAmountToPay.isEnabled = true
                
                lblNames.frame = CGRect(x: 0.24*width, y: 0.017*height, width: 0.6*width, height: 0.08*height);
                lblNames.numberOfLines = 0
                lblNames.text = ""
                lblNames.text = self.strPeopleName
                lblNames.sizeToFit()
                
                str = String(format: "%.2f", (String(format: "%.2f0", (fAmount.description as NSString).floatValue) as NSString).floatValue)
                lblamount.text = str + " " + self.Stays["fkCurrencyID"]!
                
                if runkeeperSwitchForce.selectedIndex == 0 {
                    txtAmountToPay.text = String(format: "%.2f", (String(format: "%.2f0", (fAmount.description as NSString).floatValue) as NSString).floatValue)
                } else {
                    txtAmountToPay.text = String(format: "%.2f", (String(format: "%.2f0", ((fAmount/fDollar).description as NSString).floatValue) as NSString).floatValue)
                }
                
                labelUSD.text = String(format: "%.2f", (String(format: "%.2f0", ((fAmount/fDollar).description as NSString).floatValue) as NSString).floatValue) + " USD"
                
            }
        }


    }
    
    @objc func switchForceMXN(_ sender: DGRunkeeperSwitch!) {
        
        ynCC = true
        
        if sender.selectedIndex == 0 {
            if ynUSD {
                strForceMexicanCc = "1"
            }else{
                strForceMexicanCc = "0"
            }
            //if self.ynRecargaCC == false{
                if runkeeperSwitch.selectedIndex == 1 {
                    txtAmountToPay.text = String(format: "%.2f", (String(format: "%.2f0", (fAmount.description as NSString).floatValue) as NSString).floatValue)
                }else{
                    txtAmountToPay.text = String(format: "%.2f", (String(format: "%.2f0", (Double((txtAmountToPay.text! as NSString).floatValue))*fDollar) as NSString).floatValue)
                }
            //}

            txtAmountToPay.placeholder = NSLocalizedString("txtAmountToPay",comment:"");
        } else {
            strForceMexicanCc = "0"
            //if self.ynRecargaCC == false{
                if runkeeperSwitch.selectedIndex == 1 {
                    txtAmountToPay.text = String(format: "%.2f", (String(format: "%.2f0", ((fAmount/fDollar).description as NSString).floatValue) as NSString).floatValue)
                }else{
                    txtAmountToPay.text = String(format: "%.2f", (String(format: "%.2f0", (Double((txtAmountToPay.text! as NSString).floatValue))/fDollar) as NSString).floatValue)
                }
            //}
            if self.Stays != nil{
                txtAmountToPay.placeholder = NSLocalizedString("txtAmountToPayUSD",comment:"") + self.Stays["fkCurrencyID"]!
            }

        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.registerForKeyboardNotifications()
        self.navigationController?.toolbar.isHidden = true
        
       if appDelegate.gstrCountry == ""{
           mas = NSMutableAttributedString(string: NSLocalizedString("lblCountry",comment:""), attributes: [
               NSAttributedString.Key.font: UIFont(name:"Futura-CondensedMedium", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont7)!,
               NSAttributedString.Key.foregroundColor: colorWithHexString ("000000")
               ])
       }else{
           mas = NSMutableAttributedString(string: appDelegate.gstrCountry, attributes: [
               NSAttributedString.Key.font: UIFont(name:"Futura-CondensedMedium", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont7)!,
               NSAttributedString.Key.foregroundColor: colorWithHexString ("000000")
               ])
       }
        
        btnCountry.setAttributedTitle(mas, for: UIControl.State())

        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Account_Payment",
            AnalyticsParameterItemName: "Account Payment",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Account Payment", screenClass: appDelegate.gstrAppName)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func registerForKeyboardNotifications() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(vcGuestAccountPayment.keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notification: Notification) {
        var scrollPoint: CGPoint = CGPoint()
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            scrollPoint = CGPoint(x: 0.0, y: 110)
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            scrollPoint = CGPoint(x: 0.0, y: 110)
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            scrollPoint = CGPoint(x: 0.0, y: 110)
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
            if ynCC || ynAmount || ynCvv || ynExpM ||  ynExpY || ynFirstName || ynLastName {
                scrollPoint = CGPoint(x: 0.0, y: 180)
            }else if ynAddress || ynCity || ynCountry || ynTel || ynEmail || ynState || ynZipCode {
                scrollPoint = CGPoint(x: 0.0, y: 300)
            }else{
                scrollPoint = CGPoint(x: 0.0, y: 180)
            }
        }

        self.scrollView.setContentOffset(scrollPoint, animated: true)

    }
    
    @objc func hideKeyboard() {
        txtCVV.resignFirstResponder()   //FirstResponder's must be resigned for hiding keyboard.
        txtExpMonth.resignFirstResponder()
        txtExpYear.resignFirstResponder()
        card.resignFirstResponder()
        txtAmountToPay.resignFirstResponder()
        txtFirstName.resignFirstResponder()
        txtLastName.resignFirstResponder()
        txtAddress.resignFirstResponder()
        txtCity.resignFirstResponder()
        txtTel.resignFirstResponder()
        txtEmail.resignFirstResponder()
        txtState.resignFirstResponder()
        txtZipCode.resignFirstResponder()
        
        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 80), animated: true)

        ynCC = false
        ynExpM = false
        ynExpY = false
        ynCvv = false
        ynAmount = false
        ynFirstName = false
        ynLastName = false
        ynAddress = false
        ynCity = false
        ynCountry = false
        ynTel = false
        ynEmail = false
        ynState = false
        ynZipCode = false
    }
    
    func recargarTablaStay(){
        
        ViewItem.rightBarButtonItem?.isEnabled = false
        ViewItem.leftBarButtonItem?.isEnabled = false
        self.btnApply.isEnabled = false
        app.beginIgnoringInteractionEvents()
        
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 100
        config.backgroundColor = UIColor(white: 1, alpha: 0.5)
        config.spinnerColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.titleTextColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.spinnerLineWidth = 2.0
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        SwiftLoader.show(title: NSLocalizedString("lblLoading",comment:""), animated: true)
        
        appDelegate.gtblStay = nil
        appDelegate.gStaysStatus = nil
        tblStayInfo = nil
        
        var tableItems = RRDataSet()
        var iRes: String = ""
        var ynAddStay: Bool = false
        var resultStayID: Int32 = 0
        var resultStatusID: Int32 = 0
        var DataStays = [String:String]()
        var Stays: [Dictionary<String, String>]
        var Index: Int = 0
        var Stay: Dictionary<String, String>
        
        Stay = [:]
        Stays = []
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        let queue = OperationQueue()
        
        queue.addOperation() {//1
            //accion webservice-db
            if Reachability.isConnectedToNetwork(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
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

                                            if db.executeUpdate("UPDATE tblStay SET StayInfoID = ?, DatabaseName = ?, PropertyCode = ?, UnitCode = ?, StatusCode = ?, StatusDesc = ?, ArrivalDate = ?, DepartureDate = ?, PropertyName = ?, PrimaryPeopleID = ?, OrderNo = ?, Intv= ?, IntvYear = ?, fkAccID = ?, fkTrxTypeID = ?, AccCode = ?, USDExchange = ?, UnitID = ?, FloorPlanDesc = ?, UnitViewDesc = ?, PrimAgeCFG = ?, fkPlaceID = ?, DepartureDateCheckOut = ?, ConfirmationCode = ?, fkCurrencyID = ? WHERE StayInfoID=?", withArgumentsIn: [((r as AnyObject).getColumnByName("StayInfoID").content as? String)!, ((r as AnyObject).getColumnByName("DatabaseName").content as? String)!, ((r as AnyObject).getColumnByName("PropertyCode").content as? String)!, ((r as AnyObject).getColumnByName("UnitCode").content as? String)!, ((r as AnyObject).getColumnByName("StatusCode").content as? String)!, ((r as AnyObject).getColumnByName("StatusDesc").content as? String)!, ((r as AnyObject).getColumnByName("ArrivalDate").content as? String)!, ((r as AnyObject).getColumnByName("DepartureDate").content as? String)!, ((r as AnyObject).getColumnByName("PropertyName").content as? String)!, ((r as AnyObject).getColumnByName("PrimaryPeopleID").content as? String)!, ((r as AnyObject).getColumnByName("OrderNo").content as? String)!, ((r as AnyObject).getColumnByName("Intv").content as? String)!, ((r as AnyObject).getColumnByName("IntvYear").content as? String)!, ((r as AnyObject).getColumnByName("fkAccID").content as? String)!, ((r as AnyObject).getColumnByName("fkTrxTypeCCID").content as? String)!, ((r as AnyObject).getColumnByName("AccCode").content as? String)!, ((r as AnyObject).getColumnByName("USDExchange").content as? String)!, ((r as AnyObject).getColumnByName("UnitID").content as? String)!, ((r as AnyObject).getColumnByName("FloorPlanDesc").content as? String)!, ((r as AnyObject).getColumnByName("UnitViewDesc").content as? String)!, ((r as AnyObject).getColumnByName("PrimAgeCFG").content as? String)!, ((r as AnyObject).getColumnByName("fkPlaceID").content as? String)!, ((r as AnyObject).getColumnByName("DepartureDateCheckOut").content as? String)!, ((r as AnyObject).getColumnByName("ConfirmationCode").content as? String)!, ((r as AnyObject).getColumnByName("fkCurrencyID").content as? String)!, ((r as AnyObject).getColumnByName("StayInfoID").content as? String)!]) {
                                                
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
                                    
                                    if (db.executeUpdate("UPDATE tblLogin SET LastStayUpdate=? WHERE PersonalID=?", withArgumentsIn: [DateInFormat,self.PeopleID])) {
                                        
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
                                                            DataStays["PrimaryPeopleID"] = String(describing: rs.string(forColumn: "PrimaryPeopleID")!)
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

                                                    OperationQueue.main.addOperation() {
                                                        
                                                        queue.addOperation() {//7
                                                            //accion webservice-db
                                                            var PeopleAux: Dictionary<String, String>
                                                            PeopleAux = [:]
                                                            
                                                            if self.appDelegate.gtblStay != nil{

                                                                queueFM?.inDatabase() {
                                                                    db in
                                                                    
                                                                    if let rs = db.executeQuery("SELECT * FROM tblLogin WHERE PersonalID = ?", withArgumentsIn: [self.appDelegate.gstrLoginPeopleID]){
                                                                        while rs.next() {
                                                                            PeopleAux["Email"] = rs.string(forColumn: "Email")!
                                                                            PeopleAux["Lenguage"] = rs.string(forColumn: "Lenguage")!
                                                                        }
                                                                        self.People = PeopleAux
                                                                    } else {
                                                                        print("select failure: \(db.lastErrorMessage())")
                                                                    }
                                                                    
                                                                }
                                                            }else{
                                                                self.People = nil
                                                            }
                                                            
                                                            OperationQueue.main.addOperation() {
                                                                queue.addOperation() {//8
                                                                    //accion webservice-db
                                                                    var strQuery: String = ""
                                                                    
                                                                    if self.appDelegate.gtblStay != nil{

                                                                        self.strPeopleName = ""
                                                                        
                                                                        if (self.PeopleFDeskID=="0"){
                                                                            strQuery = "SELECT FullName FROM tblPerson WHERE StayInfoID = ?"
                                                                        }else{
                                                                            strQuery = "SELECT FullName FROM tblPerson WHERE StayInfoID = ? AND PeopleFDeskID =?"
                                                                        }
                                                                        
                                                                        queueFM?.inDatabase() {
                                                                            db in
                                                                            if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID,self.PeopleFDeskID]){
                                                                                while rs.next() {
                                                                                    self.strPeopleName = self.strPeopleName + rs.string(forColumn: "FullName")! + ", "
                                                                                }
                                                                                if self.strPeopleName != ""{
                                                                                    let strpre: String = self.strPeopleName
                                                                                    
                                                                                    let start = strpre.index(strpre.startIndex, offsetBy: 0)
                                                                                    let end = strpre.index(strpre.endIndex, offsetBy: -2)
                                                                                    let range = start..<end
                                                                                    
                                                                                    let mySubstring = strpre[range]
                                                                                    
                                                                                    self.strPeopleName = mySubstring.description
                                                                                }
                                                                            } else {
                                                                                print("select failure: \(db.lastErrorMessage())")
                                                                            }
                                                                        }
                                                                    }else{
                                                                        self.strPeopleName = ""
                                                                    }
                                                                    
                                                                    OperationQueue.main.addOperation() {
                                                                        
                                                                        if self.appDelegate.gtblStay != nil{
                                                                            self.fDollar = Double(self.Stays["USDExchange"]! as String)!
                                                                            self.fkAccID = self.Stays["fkAccID"]!
                                                                            self.fkTrxTypeID = self.Stays["fkTrxTypeID"]!
                                                                            self.AccCode = self.Stays["AccCode"]!
                                                                            self.DataBase = self.Stays["DatabaseName"]!
                                                                            self.strAccountPlace = self.Stays["PropertyName"]! + " \n " + self.Stays["UnitCode"]!
                                                                            self.fkPlaceID = self.Stays["fkPlaceID"]!
                                                                            self.fkCurrencyID = self.Stays["fkCurrencyID"]!
                                                                            self.txtAmountToPay.placeholder = NSLocalizedString("txtAmountToPayUSD",comment:"") + self.Stays["fkCurrencyID"]!
                                                                        }else{
                                                                            self.fDollar = 0.0
                                                                            self.fkAccID = ""
                                                                            self.fkTrxTypeID = ""
                                                                            self.AccCode = ""
                                                                            self.DataBase = ""
                                                                            self.strAccountPlace = ""
                                                                            self.fkPlaceID = ""
                                                                            self.fkCurrencyID = ""
                                                                        }
                                                                        
                                                                        self.label.text = self.strAccountPlace;
                                                                        self.label.adjustsFontSizeToFitWidth = true;
                                                                        
                                                                        self.lblNames.text = self.strPeopleName
                                                                        self.lblNames.sizeToFit()

                                                                        var strQuery: String=""
                                                                        
                                                                        if (self.PeopleFDeskID=="0"){
                                                                            strQuery = "SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ?"
                                                                        }else{
                                                                            strQuery = "SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ? AND PeopleFDeskID =?"
                                                                        }

                                                                        queueFM?.inDatabase() {
                                                                            db in
                                                                            
                                                                            if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID, self.PeopleFDeskID]){
                                                                                while rs.next() {
                                                                                    if rs.columnIsNull("Amount") != true {
                                                                                        self.fAmount = Double(String(format: "%.2f", (rs.string(forColumn: "Amount")! as NSString).floatValue))!
                                                                                    }
                                                                                }
                                                                            } else {
                                                                                print("select failure: \(db.lastErrorMessage())")
                                                                            }
                                                                            
                                                                        }
                                                                        self.labelUSD.text = String(format: "%.2f", (String(format: "%.2f0", ((self.fAmount/self.fDollar).description as NSString).floatValue) as NSString).floatValue) + " USD"
                                                                        self.str = String(format: "%.2f", (String(format: "%.2f0", (self.fAmount.description as NSString).floatValue) as NSString).floatValue)
                                                                        self.lblamount.text = self.str + " " + self.Stays["fkCurrencyID"]!
                                                                        self.lblExchange.text = String(format: "%.2f", (String(format: "%.2f0", (self.fDollar.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]! + " x 1 USD"
                                                                        self.txtAmountToPay.text = String(format: "%.2f", (String(format: "%.2f0", (self.fAmount.description as NSString).floatValue) as NSString).floatValue)
                                                                        
                                                                        self.ViewItem.rightBarButtonItem?.isEnabled = true
                                                                        self.ViewItem.leftBarButtonItem?.isEnabled = true
                                                                        self.btnApply.isEnabled = true
                                                                        self.app.endIgnoringInteractionEvents()
                                                                        
                                                                        SwiftLoader.hide()
                                                                        
                                                                    }
                                                                }//8
                                                                
                                                            }
                                                        }//7
                                                        
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
    }

    func recargarCCNumber(){
        
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 100
        config.backgroundColor = UIColor(white: 1, alpha: 0.5)
        config.spinnerColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.titleTextColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.spinnerLineWidth = 2.0
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        SwiftLoader.show(title: NSLocalizedString("lblLoading",comment:""), animated: true)
        
        appDelegate.gtblStay = nil
        appDelegate.gStaysStatus = nil
        tblStayInfo = nil

        var prepareOrderResult:NSString="";
        
        let queue = OperationQueue()
        
        queue.addOperation() {//1
            //accion webservice-db
            if Reachability.isConnectedToNetwork(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
                let ccNumber = self.card.text!.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
                
                let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
                prepareOrderResult = service!.wmGetCCExchangeVwPCI(self.appDelegate.strDataBaseByStay, strCc: ccNumber, strAccID: self.fkAccID) as! NSString
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            OperationQueue.main.addOperation() {
                
                let separators = CharacterSet(charactersIn: ",")
                self.aRes = prepareOrderResult.components(separatedBy: separators)
                if(self.aRes[0]=="True")||(self.aRes[0]=="False"){
                    if self.aRes[3]=="USD"{
                        //self.fDollar = Double(self.aRes[1])!
                        self.ynUSD = true
                        self.runkeeperSwitchForce.isEnabled = true
                        self.runkeeperSwitchForce.isHidden = false
                        //self.txtAmountToPay.text = String(format: "%.2f", ((self.fAmount/self.fDollar).description as NSString).floatValue)
                        self.txtAmountToPay.placeholder = NSLocalizedString("txtAmountToPayUSD",comment:"") + self.Stays["fkCurrencyID"]!;
                        
                        if self.runkeeperSwitchForce.selectedIndex == 0{
                            self.runkeeperSwitchForce.setSelectedIndex(1, animated: false)
                        }
                        
                        if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                            self.runkeeperSwitchForce.backgroundColor = self.colorWithHexString ("5C9FCC")
                            self.runkeeperSwitchForce.selectedTitleColor = self.colorWithHexString ("5C9FCC")
                        }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                            self.runkeeperSwitchForce.backgroundColor = self.colorWithHexString ("ba8748")
                            self.runkeeperSwitchForce.selectedTitleColor = self.colorWithHexString ("ba8748")
                        }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                            self.runkeeperSwitchForce.backgroundColor = self.colorWithHexString ("5C9FCC")
                            self.runkeeperSwitchForce.selectedTitleColor = self.colorWithHexString ("5C9FCC")
                        }
                        
                    }else{
                        self.ynUSD = false
                        self.strForceMexicanCc = "0"
                        self.runkeeperSwitchForce.isHidden = false
                        self.runkeeperSwitchForce.isEnabled = false
                        //self.txtAmountToPay.text = self.fAmount.description
                        self.txtAmountToPay.placeholder = NSLocalizedString("txtAmountToPay",comment:"");
                        //self.runkeeperSwitchForce.setSelectedIndex(0, animated: false)
                        if self.runkeeperSwitchForce.selectedIndex == 1{
                            self.runkeeperSwitchForce.setSelectedIndex(0, animated: false)
                        }
                        self.runkeeperSwitchForce.backgroundColor = self.colorWithHexString ("C7C7CD")
                        self.runkeeperSwitchForce.selectedTitleColor = self.colorWithHexString ("C7C7CD")
                    }
                }else{
                    self.ynUSD = false
                    self.strForceMexicanCc = "0"
                    self.runkeeperSwitchForce.isHidden = false
                    self.runkeeperSwitchForce.isEnabled = false
                    //self.txtAmountToPay.text = self.fAmount.description
                    self.txtAmountToPay.placeholder = NSLocalizedString("txtAmountToPay",comment:"");
                    if self.runkeeperSwitchForce.selectedIndex == 1{
                        self.runkeeperSwitchForce.setSelectedIndex(0, animated: false)
                    }
                    //self.runkeeperSwitchForce.setSelectedIndex(0, animated: false)
                    self.runkeeperSwitchForce.backgroundColor = self.colorWithHexString ("C7C7CD")
                    self.runkeeperSwitchForce.selectedTitleColor = self.colorWithHexString ("C7C7CD")
                }
                self.ynRecargaCC = false
                SwiftLoader.hide()
            }
        }//1
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        ynCC = false
        ynExpM = false
        ynExpY = false
        ynCvv = false
        ynAmount = false
        ynFirstName = false
        ynLastName = false
        ynAddress = false
        ynCity = false
        ynCountry = false
        ynTel = false
        ynEmail = false
        ynState = false
        ynZipCode = false
        
        if textField == txtAmountToPay {
            ynAmount = true
        }else if textField == txtCVV {
            ynFocusCVV = true
        }else if textField == txtExpMonth {
            ynExpM = true
        }else if textField == txtExpYear {
            ynExpY = true
        }else if textField == txtFirstName {
            ynFirstName = true
        }else if textField == txtLastName {
            ynLastName = true
        }else if textField == txtAddress {
            ynAddress = true
        }else if textField == txtCity {
            ynCity = true
        }else if textField == txtTel {
            ynTel = true
        }else if textField == txtEmail {
            ynEmail = true
        }else if textField == txtState {
            ynState = true
        }else if textField == txtZipCode {
            ynZipCode = true
        }

        //registerForKeyboardNotifications()
        
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
            var result = true
            var ireturn: Int = 100

        if textField == txtAmountToPay {

                if string.characters.count > 0 {
                    let disallowedCharacterSet = CharacterSet(charactersIn: "0123456789.").inverted
                    let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
                    result = replacementStringIsLegal
                }

        }else if textField == txtCVV {

            ireturn = 4
            let newLength = textField.text!.utf16.count + string.utf16.count - range.length
            result = (newLength <= ireturn)
            if (string.characters.count > 0) && (result == true) {
                let disallowedCharacterSet = CharacterSet(charactersIn: "0123456789").inverted
                let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
                
                result = replacementStringIsLegal
            }
        }

        //registerForKeyboardNotifications()
        
        return result // Bool
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
    
    func AESCrypt(data:Data, keyData:Data, ivData:Data, operation:Int) -> NSData? {
        let cryptLength  = size_t(data.count + kCCBlockSizeAES128)
        var cryptData = Data(count:cryptLength)

        let keyLength             = size_t(kCCKeySizeAES128)
        let options   = CCOptions(kCCOptionPKCS7Padding)


        var numBytesEncrypted :size_t = 0

        let cryptStatus = cryptData.withUnsafeMutableBytes {cryptBytes in
            data.withUnsafeBytes {dataBytes in
                ivData.withUnsafeBytes {ivBytes in
                    keyData.withUnsafeBytes {keyBytes in
                        CCCrypt(CCOperation(operation),
                                  CCAlgorithm(kCCAlgorithmAES),
                                  options,
                                  keyBytes, keyLength,
                                  ivBytes,
                                  dataBytes, data.count,
                                  cryptBytes, cryptLength,
                                  &numBytesEncrypted)
                    }
                }
            }
        }

        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.removeSubrange(numBytesEncrypted..<cryptData.count)

        } else {
            print("Error: \(cryptStatus)")
        }

        return cryptData as NSData;
    }
    
    @IBAction func clickPayment(_ sender: AnyObject) {
        
        var strAmount: String = ""
        var strResultJSON: NSString = ""
        ViewItem.rightBarButtonItem?.isEnabled = false
        ViewItem.leftBarButtonItem?.isEnabled = false
        self.btnApply.isEnabled = false
        app.beginIgnoringInteractionEvents()
        
        var strExpDate: String = ""
        var ynApply: Bool = false
        var strEmail: String = ""
        var strLenguage: String = ""
        
        strExpDate = self.txtExpMonth.text! + self.txtExpYear.text!
        
        let todaysDate:Date = Date()
        let dtdateFormatter:DateFormatter = DateFormatter()
        dtdateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        let DateInFormat:String = dtdateFormatter.string(from: todaysDate)
        
        strEmail = self.People["Email"]!
        
        if self.People["Lenguage"]! == "Spanish"{
            if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                strLenguage = "ENG"
            }else{
                strLenguage = "ESP"
            }
        }else{
            strLenguage = "ENG"
        }

        if ynUSD == true{
            if runkeeperSwitchForce.selectedIndex == 1 {
                strAmount = String(format: "%.2f", (String(format: "%.2f0", ((Double(self.txtAmountToPay.text!)!*fDollar).description as NSString).floatValue) as NSString).floatValue)
            }else{
                strAmount = self.txtAmountToPay.text!
            }
        }else{
            strAmount = self.txtAmountToPay.text!
        }
        
        var prepareOrderResult:NSString="";
        let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
        
        let ccNumber = card.text!.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)

        if self.ynPreAuth == false
        {
            

            let x: Int? = (ccNumber as NSString).integerValue
            
            if x != nil
            {
                ynApply = self.PaymentValidate()
            }else{
                strValidError = "Invalid Credit Card Number"
                ynApply = false
            }
        }else{

            fAmount = Double(txtAmountToPay.text! as String)!
            if(fAmount>0){
            
                if(fAmount>fPreAmount){
                    self.txtAmountToPay.text = PreAmount
                }
            
            }
            
            ynApply = true
        }

        if (ynApply == true){
            
            
            self.ViewItem.rightBarButtonItem?.isEnabled = true
            self.ViewItem.leftBarButtonItem?.isEnabled = true
            self.btnApply.isEnabled = true
            self.app.endIgnoringInteractionEvents()
            
            if self.appDelegate.strDataBaseByStay == "FDESK_CLBR"{
                
                /*if txtEmail.text == ""{
                    strEmail = self.People["Email"]!
                }else{
                    strEmail = txtEmail.text!
                }*/
                
                let Billing = ["Phone": self.txtTel.text!,
                               "Country": self.appDelegate.gstrISOCountryCode,
                               "ZipCode": self.txtZipCode.text!,
                               "State": self.txtState.text!,
                               "City": self.txtCity.text!,
                               "Address1": self.txtAddress.text!,
                               "Last_name": self.txtLastName.text!,
                               "First_name": self.txtFirstName.text!,
                               "Email": txtEmail.text!
                ]
                let Sale = ["Amount": strAmount,
                "Currency": self.fkCurrencyID,
                "Order_description": self.AccCode + "/" + self.StayInfoID
                ]
                let Transaction = ["TrxTypeID": self.fkTrxTypeID,
                "AccountID": self.fkAccID,
                "PeopleFDeskID": self.strPeoplePay,
                "PlaceID": self.fkPlaceID,
                "Document": "",
                "Remark": "Posted from CLBR App",
                "UserLogin": "usrGuestApp",
                "Token1": "",
                "Token2": self.appDelegate.UserName,
                "Token3": "",
                "Token4": self.appDelegate.Password,
                "Token5": self.appDelegate.strDataBaseByStay,
                "TrxDate": DateInFormat,
                "Reference": self.AccCode,
                "UrlReturn": "CLPaymentResult.aspx"
                ]
                let CreditCard = ["Cvv": self.txtCVV.text!,
                "Cc_exp": strExpDate,
                "Cc_number": ccNumber
                ]
                let webDoc = ["Code": self.strDocumentCode,
                "Email": strEmail,
                "Lang": self.appDelegate.strLenguaje
                ]
                
                let jsonObject: [String: Any] = [
                    
                    "CreditCard": CreditCard,
                    "Transaction": Transaction,
                    "Sale": Sale,
                    "Billing": Billing,
                    "WebDocument": webDoc
                ]

                let valid = JSONSerialization.isValidJSONObject(jsonObject)
                
                if valid{
                    let jsonData = try! JSONSerialization.data(withJSONObject: jsonObject )
                    let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
                    strResultJSON = jsonString!
                }

                let data: NSData! = (strResultJSON as NSString).data(using: String.Encoding.utf8.rawValue) as NSData!
                
                let utf8str = AESCrypt(data: data as Data, keyData: (self.appDelegate.strCLBRTokenPay as NSString).data(using: String.Encoding.utf8.rawValue)!, ivData: (self.appDelegate.strCLBRTokenPay as NSString).data(using: String.Encoding.utf8.rawValue)!, operation: kCCEncrypt)
                
                let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
                
                let viewController: vcCLPaymentGateway = vcCLPaymentGateway()
                viewController.strJSONParams = base64Encoded as! NSString
                viewController.width = appDelegate.width
                viewController.height = appDelegate.height
                viewController.strAppName = appDelegate.gstrAppName
                self.navigationController?.pushViewController(viewController, animated: false)
                
            }else{
                
                var config : SwiftLoader.Config = SwiftLoader.Config()
                    config.size = 100
                    config.backgroundColor = UIColor(white: 1, alpha: 0.5)
                    config.spinnerColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
                    config.titleTextColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
                    config.spinnerLineWidth = 2.0
                    SwiftLoader.setConfig(config)
                    SwiftLoader.show(animated: true)
                    SwiftLoader.show(title: NSLocalizedString("msjApply",comment:""), animated: true)

                    let queue = OperationQueue()
                
                    queue.addOperation() {

                        if Reachability.isConnectedToNetwork(){
                            UIApplication.shared.isNetworkActivityIndicatorVisible = true
                            if self.ynPreAuth == true
                            {
                                prepareOrderResult = service!.wmCallPostAuthMobile("1", strDataBase: self.appDelegate.strDataBaseByStay, intAccTrxId: self.AccTrxID, dblAmount: self.txtAmountToPay.text, strTrxCode: "POSTAUTHBAN", strTrxTest: "Y", strMail: strEmail, strLenguageCode: self.appDelegate.strLenguaje, personalID: self.strPeoplePay, strDocumentCode: self.strDocumentCode) as! NSString
                            }else{
                                
                                /*print(self.appDelegate.gstrAppName)
                                print(self.appDelegate.strDataBaseByStay)
                                print(self.StayInfoID)
                                print(self.strPeoplePay)
                                print(strAmount)
                                print(ccNumber)
                                print(strExpDate)
                                print(self.txtCVV.text)
                                print(self.fkAccID)
                                print(self.fkTrxTypeID)
                                print(DateInFormat)
                                print(self.AccCode)
                                print(strEmail)
                                print(self.appDelegate.strLenguaje)
                                print(self.fkPlaceID)
                                print(self.strForceMexicanCc)
                                print(self.strDocumentCode)
                                print(self.fkCurrencyID)
                                print(self.strFirstName)
                                print(self.strLastName)*/

                                

                                prepareOrderResult = service!.wmPaymentCC("1", appCode: self.appDelegate.gstrAppName, dataBase: self.appDelegate.strDataBaseByStay, stayInfoID: self.StayInfoID, personalID: self.strPeoplePay, amount: strAmount, strCc: ccNumber, strExpDate: strExpDate, strCvc2: self.txtCVV.text, intAccId: self.fkAccID, intTrxType: self.fkTrxTypeID, strTrxDate: DateInFormat, strReference: self.AccCode, strMail: strEmail, strLenguageCode: self.appDelegate.strLenguaje, placeID: self.fkPlaceID, strForceMexicanCc: self.strForceMexicanCc, strDocumentCode: self.strDocumentCode, strFName: self.strFirstName, strLname: self.strLastName, strCurrency: self.Stays["fkCurrencyID"]!) as! NSString

                            }
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }else{
                            RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                        }
                    
                        OperationQueue.main.addOperation() {
                            
                            let separators = CharacterSet(charactersIn: ",")
                            var aRes = prepareOrderResult.components(separatedBy: separators)
                            if(aRes[0]=="1")||(aRes[0]=="0"){
                                GoogleWearAlert.showAlert(title: aRes[1], type: .success, duration: 4, iAction: 1, form: "Account Payment")
                                self.appDelegate.gblPay = true
                                
                                if self.ynPreAuth == true || self.ynPreAuthCreditCard == true
                                {
                                    self.appDelegate.gblExitPreAuth = true
                                }
                                
                                //let NextViewController = self.navigationController?.viewControllers[1]
                                //self.navigationController?.popToViewController(NextViewController!, animated: false)
                                
                                self.navigationController?.popViewController(animated: false)
                                
                            }else{
                                if self.ynPreAuth == true
                                {
                                    RKDropdownAlert.title(NSLocalizedString("msgTracDec",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
                                }else{
                                    if aRes[0] != ""{
                                        RKDropdownAlert.title(aRes[1], backgroundColor: UIColor.red, textColor: UIColor.black)
                                    }
                                }
                            }
                            
                            self.ViewItem.rightBarButtonItem?.isEnabled = true
                            self.ViewItem.leftBarButtonItem?.isEnabled = true
                            self.btnApply.isEnabled = true
                            self.app.endIgnoringInteractionEvents()
                            
                            SwiftLoader.hide()
                        
                        }
                        
                    }
                
            }
            
            

        
        }else{
            self.btnApply.isEnabled = true
            RKDropdownAlert.title(strValidError, backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
            
            self.ViewItem.rightBarButtonItem?.isEnabled = true
            self.ViewItem.leftBarButtonItem?.isEnabled = true
            self.btnApply.isEnabled = true
            self.app.endIgnoringInteractionEvents()
            
        }

        
    }

    func PaymentValidate()->Bool{
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        if (txtAmountToPay.text==""){
            strValidError = NSLocalizedString("msgProvAmt",comment:"")
            return false;
        }else{
            fAmount = Double(txtAmountToPay.text! as String)!
            if(fAmount>0){

                if(PeopleFDeskID=="0"){

                    queueFM?.inDatabase() {
                        db in
                        
                        if let rs = db.executeQuery("SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ?", withArgumentsIn: [self.StayInfoID, "0"]){
                            while rs.next() {
                                if rs.columnIsNull("Amount") != true {
                                    self.fTotalAmount = Double(String(format: "%.2f", (rs.string(forColumn: "Amount")! as NSString).floatValue))!
                                }
                            }
                        } else {
                            print("select failure: \(db.lastErrorMessage())")
                        }
                        
                    }
                    
                    if(fAmount > fTotalAmount){
                        
                        strValidError = NSLocalizedString("msgProvValAmt",comment:"")
                        return false;
                    }
                }else{
                    
                    
                    queueFM?.inDatabase() {
                        db in
                        
                        if let rs = db.executeQuery("SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ? AND PeopleFDeskID =?", withArgumentsIn: [self.StayInfoID, self.strPeoplePay]){
                            while rs.next() {
                                if rs.columnIsNull("Amount") != true {
                                    self.fTotalAmount = Double(String(format: "%.2f", (rs.string(forColumn: "Amount")! as NSString).floatValue))!
                                }
                            }
                        } else {
                            print("select failure: \(db.lastErrorMessage())")
                        }
                        
                    }
                    
                }
                
                if(fAmount > fTotalAmount){
                    
                    strValidError = NSLocalizedString("msgProvValAmt",comment:"")
                    return false;
                }
                
                queueFM?.inDatabase() {
                    db in
                    
                    if let rs = db.executeQuery("SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ?", withArgumentsIn: [self.StayInfoID, self.strPeoplePay]){
                        while rs.next() {
                            if rs.columnIsNull("Amount") != true {
                                self.fTotalAmount = Double(String(format: "%.2f", (rs.string(forColumn: "Amount")! as NSString).floatValue))!
                            }
                        }
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                    
                }
                
                if(fAmount > fTotalAmount){
                    
                    strValidError = NSLocalizedString("msgProvValAmt",comment:"")
                    return false;
                }

            }else{
                strValidError = NSLocalizedString("msgProvValAmt",comment:"")
                return false;
            }
        }
        
        let ccNumber = card.text!.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
        let trimmedString = ccNumber.trimmingCharacters(
            in: CharacterSet.whitespacesAndNewlines
        )
        if (trimmedString.isEmpty==true){
            strValidError = NSLocalizedString("msgProvCredCar",comment:"")
            return false;
        }
        
        if self.ynPreAuth == false
        {
            let ccNumber = card.text!.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            let x: Int? = (ccNumber as NSString).integerValue
            
            if x == nil
            {
                strValidError = NSLocalizedString("msgInvCredCar",comment:"")
                return false
            }
            
            if trimmedString.characters.count < 15{
                strValidError = NSLocalizedString("msgInvCredCar",comment:"")
                return false
            }
            
            let ExpMonth = txtExpMonth.text!.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
            let trimmedExpMonth = ExpMonth.trimmingCharacters(
                in: CharacterSet.whitespacesAndNewlines
            )
            
            if (trimmedExpMonth==""){
                strValidError = NSLocalizedString("msgNExpM",comment:"")
                return false;
            }
            
            if (trimmedExpMonth=="0"){
                strValidError = NSLocalizedString("msgNExpM",comment:"")
                return false;
            }
            
            if (trimmedExpMonth=="1"){
                strValidError = NSLocalizedString("msgNExpM",comment:"")
                return false;
            }
            
            let y: Int? = (txtExpMonth.text! as NSString).integerValue
            
            if y == nil
            {
                strValidError = NSLocalizedString("msgIExpM",comment:"")
                return false
            }
            
            let ExpYear = txtExpYear.text!.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
            let trimmedExpYear = ExpYear.trimmingCharacters(
                in: CharacterSet.whitespacesAndNewlines
            )
            
            if (trimmedExpYear==""){
                strValidError = NSLocalizedString("msgNExpY",comment:"")
                return false;
            }
            
            let z: Int? = (txtExpYear.text! as NSString).integerValue
            
            if z == nil
            {
                strValidError = NSLocalizedString("msgIExpY",comment:"")
                return false
            }
            
            let date = Date()
            let calendar = Calendar.current
            let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
            
            let year =  components.year
            
            let strpre: String = year!.description
            
            let start = strpre.index(strpre.startIndex, offsetBy: 2)
            let end = strpre.index(strpre.endIndex, offsetBy: 0)
            let range = start..<end
            
            let mySubstring = String(strpre[range])
            
            if z! < Int(mySubstring)!{
                strValidError = NSLocalizedString("msgNExpY",comment:"")
                return false;
            }
            
            if (txtCVV.text==""){
                strValidError = NSLocalizedString("msgNCVV",comment:"")
                return false;
            }
            
            let CVV = txtCVV.text!.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
            let trimmedCVV = CVV.trimmingCharacters(
                in: CharacterSet.whitespacesAndNewlines
            )
            
            if trimmedCVV.characters.count < 3{
                strValidError = NSLocalizedString("msgICVV",comment:"")
                return false
            }
            
            let w: Int? = (txtCVV.text! as NSString).integerValue
            
            if w == nil
            {
                strValidError = NSLocalizedString("msgICVV",comment:"")
                return false
            }
        }

        if self.ynPreAuth == true
        {
            fAmount = Double(txtAmountToPay.text! as String)!
            if self.fAmount > self.fPreAmount{
                
                strValidError = NSLocalizedString("msgMExPreAmt",comment:"")
                return false;
                
            }
        }
        
        if txtFirstName.text == ""{
            strValidError = "First Name is required"
            return false;
        }
        
        if txtLastName.text == ""{
            strValidError = "Last Name is required"
            return false;
        }
        
        if txtAddress.text == ""{
            strValidError = "Address is required"
            return false;
        }
        
        if txtCity.text == ""{
            strValidError = "City is required"
            return false;
        }
        
        if appDelegate.gstrCountry == ""{
            strValidError = "Country is required"
            return false;
        }
        
        if txtState.text == ""{
            strValidError = "State is required"
            return false;
        }
        
        if txtZipCode.text == ""{
            strValidError = "Zip Code is required"
            return false;
        }
        
        if txtTel.text == ""{
            strValidError = "Telephone is required"
            return false;
        }
        
        if txtEmail.text == ""{
            strValidError = "Email is required"
            return false;
        }

        return true;
    }

    
    @IBAction func clickAccount(_ sender: AnyObject) {

         self.navigationController?.popViewController(animated: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
}

// MARK: - AKMaskFieldDelegate
//         _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

extension vcGuestAccountPayment: AKMaskFieldDelegate {
    
    func maskField(_ maskField: AKMaskField, didChangedWithEvent event: AKMaskFieldEvent) {
        
        var statusColor, eventColor: UIColor!
        
        // Status
        
        //ynCC = true
        
        switch maskField.maskStatus {
        case .clear:
            statusColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0)
        case .incomplete:
            statusColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
        case .complete:
            statusColor = UIColor(red: 0/255, green: 219/255, blue: 86/255, alpha: 1.0)
            
            if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                if ynRecargaCC == false && maskField.maskExpression == "{dddd}-{dddd}-{dddd}-{dddd}" && ynPreAuth == false{
                    ynRecargaCC = true
                    recargarCCNumber()
                }
            }
            if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                if ynRecargaCC == false && maskField.maskExpression == "{dddd}-{dddd}-{dddd}-{dddd}" && ynPreAuth == false{
                    ynRecargaCC = true
                    recargarCCNumber()
                }
            }
        }
        
        UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseIn,
                       animations: { () -> Void in
                        
                        maskField.backgroundColor = eventColor
                        
        }
        ) { (Bool) -> Void in
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut,
                           animations: { () -> Void in
                            
                            maskField.backgroundColor = UIColor.clear
                            
                            if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                                
                            }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                                
                                maskField.backgroundColor = UIColor.white
                                
                            }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                                
                                maskField.backgroundColor = UIColor.white
                                
                            }
                            
            },
                           completion: nil
            )
        }
    }
}

