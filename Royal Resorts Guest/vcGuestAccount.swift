//
//  vcGuestAccount.swift
//  Royal Resorts Guest
//
//  Created by Marco Cocom on 11/19/14.
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


class vcGuestAccount: UIViewController , UITableViewDelegate, UITableViewDataSource
{
    var navController : UINavigationController = UINavigationController()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let app = UIApplication.shared
    
    var width: CGFloat!
    var height: CGFloat!
    
    var StayInfoID: String = ""
    var PeopleID: String = ""
    var LastAccTrxID: String = ""
    var FullName: String = ""
    var Dates: String = ""
    var Status: String = ""
    var LastAccountUpdate: String = ""
    var iHour: Int=0
    var ynRefresh: Bool=false
    var CountGroupTrx: Int = 0
    var ynReloadTable: Bool = false
    var tblAccountInfo: [Dictionary<String, String>]!
    var DateAccountInfo: [[Dictionary<String, String>]]!
    var tblPerson: [String]!
    var tblPeopleID: [String]!
    var fAmount: Double = 0
    var fDollar: Double = 0
    var segmentedControl: HMSegmentedControl!
    var strAmountPay: String = ""
    var str: String = ""
    var formatter = NumberFormatter()
    var tblLogin: Dictionary<String, String>!
    var Stays: Dictionary<String, String>!
    var AccCode: String = ""
    var fTotalAmount: Double = 0
    //var fSizeFont: CGFloat = 0
    var ynConn:Bool=false
    var strDinamicMonto: String = ""
    var length: Int = 0
    var lblResort = UILabel()
    var lblResortText = UILabel()
    var lblUnit = UILabel()
    var lblRRBalance = UILabel()
    var lblRRBalanceTxt = UILabel()
    var lblUnitText = UILabel()
    var lblView = UILabel()
    var lblViewText = UILabel()
    var lblDates = UILabel()
    var lblPrimary = UILabel()
    var btnBack = UIButton()
    var hdrlabel1 = UILabel()
    var PeopleFDeskID: String = ""
    var ynReload: Bool = false
    var ynInPostCheckOutProcess: Bool = false
    var btnCheckOutSlip = UIButton()
    var strArrivalDate: String = ""
    var strDepartureDate: String = ""
    var ynActualiza: Bool = false
    var ynClickPay: Bool = false
    var hdrlabel2 = UILabel()
    var hdrlabel = UIView()
    var LogOutView: UIView = UIView()
    var imgCell = UIImage()
    var imgvwCell = UIImageView()
    var lastIndex = IndexPath()
    var ynForceDelete: Bool = false
    var iKeycardid: Int = 0
    var RewardPerDollar: Double = 0
    
    @IBOutlet weak var btnPayment: UIButton!
    @IBOutlet weak var lblStayStatus: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblBalanceUSD: UILabel!
    @IBOutlet weak var AccView: UIView!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblDatesText: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var itemsView: UIView!
    @IBOutlet var ViewItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        bodyView.frame = CGRect(x: 0.0, y: 44, width: width, height: height);
        itemsView.frame = CGRect(x: 0.0, y: 44 + 0.001*height, width: width, height: 0.33*height);
        AccView.frame = CGRect(x: 0.05*width, y: 0.01*height, width: 0.9*width, height: 0.2*height);
        lblResort.textAlignment = NSTextAlignment.right
        lblResort.frame = CGRect(x: 0.001*width, y: 0.01*height, width: 0.2*width, height: 0.03*height);
        lblUnit.textAlignment = NSTextAlignment.right
        lblUnit.frame = CGRect(x: 0.001*width, y: 0.04*height, width: 0.2*width, height: 0.03*height);
        lblView.textAlignment = NSTextAlignment.right
        lblView.frame = CGRect(x: 0.001*width, y: 0.07*height, width: 0.2*width, height: 0.03*height);
        lblDates.textAlignment = NSTextAlignment.right
        lblDates.frame = CGRect(x: 0.001*width, y: 0.1*height, width: 0.2*width, height: 0.03*height);
        lblPrimary.textAlignment = NSTextAlignment.right
        lblPrimary.frame = CGRect(x: 0.001*width, y: 0.13*height, width: 0.2*width, height: 0.03*height);
        lblRRBalance.textAlignment = NSTextAlignment.right
        lblRRBalance.frame = CGRect(x: 0.001*width, y: 0.16*height, width: 0.2*width, height: 0.03*height);
        lblResortText.numberOfLines = 0
        
        lblResortText.frame = CGRect(x: 0.23*width, y: 0.01*height, width: 0.45*width, height: 0.03*height);
        lblUnitText.numberOfLines = 0
        lblUnitText.frame = CGRect(x: 0.23*width, y: 0.04*height, width: 0.45*width, height: 0.03*height);
        lblViewText.numberOfLines = 0
        lblViewText.frame = CGRect(x: 0.23*width, y: 0.07*height, width: 0.45*width, height: 0.03*height);
        lblDatesText.numberOfLines = 0
        lblDatesText.frame = CGRect(x: 0.23*width, y: 0.1*height, width: 0.6*width, height: 0.03*height);
        lblFullName.numberOfLines = 0
        lblFullName.frame = CGRect(x: 0.23*width, y: 0.13*height, width: 0.6*width, height: 0.03*height);
        lblRRBalanceTxt.numberOfLines = 0
        lblRRBalanceTxt.frame = CGRect(x: 0.23*width, y: 0.16*height, width: 0.6*width, height: 0.03*height);
        lblStatus.frame = CGRect(x: 0.67*width, y: 0.07*height, width: 0.2*width, height: 0.03*height);
        
        tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.45*height);
        
        if appDelegate.ynIPad {
            switch appDelegate.Model {
            case "iPad 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.52*height);
            case "iPad Air":
                tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.52*height);
            case "iPad Air 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.52*height);
            case "iPad Pro":
                tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.52*height);
            case "iPad Retina":
                tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.52*height);
            default:
                tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.52*height);
            }
        }else{
            switch appDelegate.Model {
            case "iPhone":
                tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.44*height);
            case "iPhone 4":
                tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.44*height);
            case "iPhone 4s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.44*height);
            case "iPhone 5":
                tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.45*height);
            case "iPhone 5c":
                tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.45*height);
            case "iPhone 5s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.45*height);
            case "iPhone 6":
                tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.47*height);
            case "iPhone 6 Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.47*height);
            case "iPhone 6s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.47*height);
            case "iPhone 6s Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.47*height);
            default:
                tableView.frame = CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.45*height);
            }
        }
        
        tblLogin = appDelegate.gtblLogin
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        var StaysAux: Dictionary<String, String>
        
        StaysAux = [:]
        
        queueFM?.inDatabase() {
            db in
            
            if let rs = db.executeQuery("SELECT * FROM tblStay WHERE StayInfoID = ?", withArgumentsIn: [self.StayInfoID]){
                while rs.next() {
                    StaysAux["StayInfoID"] = rs.string(forColumn: "StayInfoID")!
                    StaysAux["DatabaseName"] = rs.string(forColumn: "DatabaseName")!
                    StaysAux["PropertyCode"] = rs.string(forColumn: "PropertyCode")!
                    StaysAux["PropertyName"] = rs.string(forColumn: "PropertyName")!
                    StaysAux["UnitCode"] = rs.string(forColumn: "UnitCode")!
                    StaysAux["StatusCode"] = rs.string(forColumn: "StatusCode")!
                    StaysAux["StatusDesc"] = rs.string(forColumn: "StatusDesc")!
                    StaysAux["ArrivalDate"] = rs.string(forColumn: "ArrivalDate")!
                    StaysAux["DepartureDate"] = rs.string(forColumn: "DepartureDate")!
                    StaysAux["PrimaryPeopleID"] = rs.string(forColumn: "PrimaryPeopleID")!
                    StaysAux["OrderNo"] = rs.string(forColumn: "OrderNo")!
                    StaysAux["Intv"] = rs.string(forColumn: "Intv")!
                    StaysAux["IntvYear"] = rs.string(forColumn: "IntvYear")!
                    StaysAux["fkAccID"] = rs.string(forColumn: "fkAccID")!
                    StaysAux["fkTrxTypeID"] = rs.string(forColumn: "fkTrxTypeID")!
                    StaysAux["AccCode"] = rs.string(forColumn: "AccCode")!
                    StaysAux["USDExchange"] = rs.string(forColumn: "USDExchange")!
                    StaysAux["UnitID"] = rs.string(forColumn: "UnitID")!
                    StaysAux["FloorPlanDesc"] = rs.string(forColumn: "FloorPlanDesc")!
                    StaysAux["UnitViewDesc"] = rs.string(forColumn: "UnitViewDesc")!
                    StaysAux["ynPostCheckout"] = rs.string(forColumn: "ynPostCheckout")!
                    StaysAux["LastAccountUpdate"] = rs.string(forColumn: "LastAccountUpdate")!
                    StaysAux["PrimAgeCFG"] = rs.string(forColumn: "PrimAgeCFG")!
                    StaysAux["fkPlaceID"] = rs.string(forColumn: "fkPlaceID")!
                    StaysAux["DepartureDateCheckOut"] = rs.string(forColumn: "DepartureDateCheckOut")!
                    StaysAux["ConfirmationCode"] = rs.string(forColumn: "ConfirmationCode")!
                    StaysAux["fkCurrencyID"] = String(describing: rs.string(forColumn: "fkCurrencyID")!)
                    //StaysAux["RRRBalance"] = String(describing: rs.string(forColumn: "RRRBalance")!)
                }
            } else {
                print("select failure: \(db.lastErrorMessage())")
            }
            
        }
        
        Stays = StaysAux
        
        strDinamicMonto = NSLocalizedString("Pay",comment:"") + Stays["fkCurrencyID"]!
        length = strDinamicMonto.characters.count
        btnApply.frame = CGRect(x: 0.628*width, y: 0.3*height, width: (CGFloat(length)*0.025)*width, height: 0.04*height);
        btnCheckOutSlip.frame = CGRect(x: 0.7*width, y: 0.3*height, width: 0.25*width, height: 0.04*height);
        btnCheckOutSlip.layer.cornerRadius = 5
        lblAmount.frame = CGRect(x: 0.05*width, y: 0.29*height, width: 0.3*width, height: 0.04*height);
        
        //fSizeFont = 12.0 + appDelegate.gblDeviceFont
        lblStatus.font = UIFont(name:"Helvetica", size:appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
        
        /*btnApply.layer.borderWidth = 0.8
        btnApply.titleLabel?.textColor = UIColor.whiteColor()//colorWithHexString("0080FF")
        btnApply.layer.borderColor = UIColor.blueColor().CGColor
        btnApply.setTitle(NSLocalizedString("Pay",comment:"") + " 0.0", forState: UIControlState.Normal)
        btnApply.titleLabel?.baselineAdjustment = UIBaselineAdjustment.AlignCenters*/

        btnCheckOutSlip.setTitle(NSLocalizedString("btnCheckOutSlip",comment:""), for: UIControl.State())
        btnCheckOutSlip.titleLabel?.font = UIFont(name: "Helvetica", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont4)
        btnCheckOutSlip.backgroundColor = UIColor.darkGray
        btnCheckOutSlip.layer.borderWidth = 0.8
        btnCheckOutSlip.layer.borderColor = UIColor.black.cgColor
        btnCheckOutSlip.setTitleColor(UIColor.white, for: UIControl.State())
        
        btnCheckOutSlip.addTarget(self, action: #selector(vcGuestAccount.clickCheckOutSlip(_:)), for: UIControl.Event.touchUpInside)
        itemsView.addSubview(btnCheckOutSlip)
        
        btnCheckOutSlip.isHidden = true
        
        //lblAmount.textAlignment = NSTextAlignment.Right
        lblAmount.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblAmount.text = "0.00 USD"

        AccCode = NSLocalizedString("Account",comment:"") + " " + Stays["AccCode"]!
        
        appDelegate.strStayInfoIDCheckOut = Stays["StayInfoID"]!
        appDelegate.strAccCodeCheckOut = Stays["AccCode"]!
        appDelegate.strArrivalDateCheckOut = Stays["ArrivalDate"]!
        appDelegate.strDepartureDateCheckOut = Stays["DepartureDateCheckOut"]!
        
        //Titulo de la vista
        ViewItem.title = AccCode

        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        self.navigationController?.isToolbarHidden = true;

        strArrivalDate = ""
        strDepartureDate = ""
        
        let strdateFormatter = DateFormatter()
        strdateFormatter.dateFormat = "yyyy-MM-dd";
        
        let ArrivalDate = moment(Stays["ArrivalDate"]!)
        let DepartureDate = moment(Stays["DepartureDate"]!)
        var CheckOutDate = Stays["DepartureDateCheckOut"]!
        
        strArrivalDate = strdateFormatter.string(from: ArrivalDate!.date)
        strDepartureDate = strdateFormatter.string(from: DepartureDate!.date)
        
        let timeFormatter: DateFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        timeFormatter.timeZone = TimeZone(secondsFromGMT: 0)

            if CheckOutDate != nil{
                let dateFormatter = DateFormatter();
                dateFormatter.dateFormat = "M/dd/yyyy hh:mm:ss a Z";
                dateFormatter.locale = Locale(identifier: "US_en")
                CheckOutDate = CheckOutDate + " UTC"
                let date = dateFormatter.date(from: String(CheckOutDate));
                let dtCheckOut = dateFormatter.date(from: String(CheckOutDate));
                let timeStr = timeFormatter.string(from: date!);
                appDelegate.strCheckOutTime = timeStr
                appDelegate.strCheckOutDate = strdateFormatter.string(from: dtCheckOut!)
            }

        
        FullName = ""
        
        LastAccountUpdate = Stays["LastAccountUpdate"]!
        Dates = NSLocalizedString("lblStayfrom",comment:"") + strArrivalDate + NSLocalizedString("lblStayto",comment:"") + strDepartureDate
        Status = Stays["StatusCode"]!
        
        lblResort.text = NSLocalizedString("Resort",comment:"")
        lblUnit.text = NSLocalizedString("Unit",comment:"")
        lblView.text = NSLocalizedString("View",comment:"")
        lblDates.text = NSLocalizedString("Dates",comment:"")
        lblPrimary.text = NSLocalizedString("Primary",comment:"")
        lblRRBalance.text = NSLocalizedString("RRewards",comment:"")
        lblResort.textColor = UIColor.black
        lblUnit.textColor = UIColor.black
        lblView.textColor = UIColor.black
        lblDates.textColor = UIColor.black
        lblPrimary.textColor = UIColor.black
        lblRRBalance.textColor = UIColor.black
        lblResort.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblUnit.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblView.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblDates.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblPrimary.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblRRBalance.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        
        lblResortText.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        lblUnitText.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        lblRRBalanceTxt.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        lblViewText.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        lblFullName.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        lblDatesText.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        lblResortText.textColor = UIColor.black
        lblUnitText.textColor = UIColor.black
        lblRRBalanceTxt.textColor = UIColor.black
        lblViewText.textColor = UIColor.black
        lblDatesText.textColor = UIColor.black
        lblFullName.textColor = UIColor.blue
        lblResortText.adjustsFontSizeToFitWidth = true
        lblUnitText.adjustsFontSizeToFitWidth = true
        lblRRBalanceTxt.adjustsFontSizeToFitWidth = true
        lblViewText.adjustsFontSizeToFitWidth = true
        lblFullName.adjustsFontSizeToFitWidth = true
        lblDatesText.adjustsFontSizeToFitWidth = true
        lblResortText.text = Stays["PropertyName"]!
        lblUnitText.text = Stays["AccCode"]!
        //lblRRBalanceTxt.text = Stays["RRRBalance"]!
        lblViewText.text = Stays["UnitViewDesc"]!
        lblFullName.text = FullName
        lblDatesText.text = Dates

        //Boton Refresh
        ViewItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(vcGuestAccount.clickHome(_:)))
        

        fDollar = Double(String(format: "%.2f", (Stays["USDExchange"]! as NSString).floatValue))!
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            hdrlabel.frame = CGRect(x: 0.0, y: 0.0, width: 0.9*width, height: 0.12*height)
            
            hdrlabel1 = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 0.9*width, height: 0.06*height));
            hdrlabel1.textAlignment = NSTextAlignment.left;
            hdrlabel1.numberOfLines = 0;
            hdrlabel1.font = UIFont(name: "Helvetica", size: appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            
            hdrlabel2 = UILabel(frame: CGRect(x: 0.0, y: 0.06*height, width: 0.9*width, height: 0.06*height));
            hdrlabel2.textAlignment = NSTextAlignment.left;
            hdrlabel2.numberOfLines = 0;
            hdrlabel2.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont5 + appDelegate.gblDeviceFont3);
            
            hdrlabel1.text = NSLocalizedString("lblPartialEarly",comment:"")
            
            hdrlabel.addSubview(hdrlabel1)
            hdrlabel.addSubview(hdrlabel2)
            
            switch Status{
            case "OUT":
                lblStatus.backgroundColor = colorWithHexString("8A8A8A")
            case "INHOUSE":
                lblStatus.backgroundColor = colorWithHexString("1BC232")
            case "ASSIGNED":
                lblStatus.backgroundColor = colorWithHexString("FFE911")
            default:
                lblStatus.backgroundColor = colorWithHexString("1BC232")
            };
            
            lblStatus.text = Status
            lblStatus.adjustsFontSizeToFitWidth = true
            
            AccView.addSubview(lblResort)
            AccView.addSubview(lblUnit)
            AccView.addSubview(lblView)
            AccView.addSubview(lblDates)
            AccView.addSubview(lblPrimary)
            AccView.addSubview(lblRRBalance)
            
            AccView.addSubview(lblResortText)
            AccView.addSubview(lblUnitText)
            AccView.addSubview(lblViewText)
            AccView.addSubview(lblRRBalanceTxt)
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            AccView.backgroundColor = UIColor.clear
            
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
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.09*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.54
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlefooter.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.12*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.52
            AccView.addSubview(imgHdrVw)
            
            var strFontTitle: String = "Futura-CondensedExtraBold"
            var Color: UIColor = colorWithHexString("ba8748")
            
            lblResort.textColor = Color
            lblUnit.textColor = Color
            lblRRBalance.textColor = Color
            lblView.textColor = Color
            lblDates.textColor = Color
            lblPrimary.textColor = Color
            lblResort.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblUnit.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblRRBalance.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblView.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblDates.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblPrimary.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            strFontTitle = "Futura-CondensedMedium"
            Color = colorWithHexString("ba8748")
            
            lblResortText.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblUnitText.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblRRBalanceTxt.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblViewText.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblFullName.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblDatesText.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblResortText.textColor = Color
            lblUnitText.textColor = Color
            lblRRBalanceTxt.textColor = Color
            lblViewText.textColor = Color
            lblDatesText.textColor = Color
            lblFullName.textColor = Color
            
            lblResort.textAlignment = NSTextAlignment.left
            lblResort.frame = CGRect(x: 0.02*width, y: 0.00001*height, width: 0.2*width, height: 0.03*height);
            lblUnit.textAlignment = NSTextAlignment.left
            lblUnit.frame = CGRect(x: 0.02*width, y: 0.029*height, width: 0.2*width, height: 0.03*height);
            lblView.textAlignment = NSTextAlignment.left
            lblView.frame = CGRect(x: 0.02*width, y: 0.058*height, width: 0.2*width, height: 0.03*height);
            lblDates.textAlignment = NSTextAlignment.left
            lblDates.frame = CGRect(x: 0.02*width, y: 0.087*height, width: 0.2*width, height: 0.03*height);
            lblPrimary.textAlignment = NSTextAlignment.left
            lblPrimary.frame = CGRect(x: 0.02*width, y: 0.116*height, width: 0.2*width, height: 0.03*height);
            lblRRBalance.textAlignment = NSTextAlignment.left
            lblRRBalance.frame = CGRect(x: 0.02*width, y: 0.145*height, width: 0.2*width, height: 0.03*height);
            
            lblResortText.numberOfLines = 0
            lblResortText.frame = CGRect(x: 0.24*width, y: 0.0001*height, width: 0.45*width, height: 0.03*height);
            lblUnitText.numberOfLines = 0
            lblUnitText.frame = CGRect(x: 0.24*width, y: 0.0297*height, width: 0.45*width, height: 0.03*height);
            lblViewText.numberOfLines = 0
            lblViewText.frame = CGRect(x: 0.24*width, y: 0.059*height, width: 0.45*width, height: 0.03*height);
            lblDatesText.numberOfLines = 0
            lblDatesText.frame = CGRect(x: 0.24*width, y: 0.0885*height, width: 0.6*width, height: 0.03*height);
            lblFullName.numberOfLines = 0
            lblFullName.frame = CGRect(x: 0.24*width, y: 0.117*height, width: 0.6*width, height: 0.03*height);
            lblRRBalanceTxt.numberOfLines = 0
            lblRRBalanceTxt.frame = CGRect(x: 0.24*width, y: 0.147*height, width: 0.6*width, height: 0.03*height);
            lblStatus.frame = CGRect(x: 0.01*width, y: 0.03*height, width: 0.133*width, height: 0.03*height);
            
            AccView.addSubview(lblResort)
            AccView.addSubview(lblUnit)
            AccView.addSubview(lblView)
            AccView.addSubview(lblDates)
            AccView.addSubview(lblPrimary)
            AccView.addSubview(lblRRBalance)
            
            AccView.addSubview(lblResortText)
            AccView.addSubview(lblUnitText)
            AccView.addSubview(lblViewText)
            AccView.addSubview(lblDatesText)
            AccView.addSubview(lblFullName)
            AccView.addSubview(lblRRBalanceTxt)
            
            itemsView.backgroundColor = UIColor.clear
            
            itemsView.frame = CGRect(x: 0.0, y: 44 + 0.001*height, width: width, height: 0.33*height);
            
            self.view.addSubview(itemsView)
            
            AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.17*height);
            
            self.view.addSubview(AccView)
            
            lblStatus.textAlignment = NSTextAlignment.center
            lblStatus.backgroundColor = UIColor.clear
            lblStatus.text = Status
            lblStatus.adjustsFontSizeToFitWidth = true
            
            strFontTitle = "MarkerFelt-Wide"
            Color = colorWithHexString("ba8748")
            
            lblStatus.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblStatus.textColor = Color
            
            LogOutView.frame = CGRect(x: 0.81*width, y: 0.08*height, width: 0.1562*self.width, height: 0.0881*self.height);
            LogOutView.layer.cornerRadius = 25
            LogOutView.clipsToBounds = true
            LogOutView.layer.borderWidth = 3
            LogOutView.layer.borderColor = colorWithHexString("7c6a56").cgColor
            LogOutView.backgroundColor = colorWithHexString("eee7dd")
            LogOutView.addSubview(lblStatus)
            self.view.addSubview(LogOutView)
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            
            strFontTitle = "Futura-MediumItalic"
            Color = colorWithHexString("ba8748")
            
            hdrlabel1 = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 0.9*width, height: 0.06*height));
            hdrlabel1.textAlignment = NSTextAlignment.left;
            hdrlabel1.numberOfLines = 0;
            hdrlabel1.font = UIFont(name: strFontTitle, size: appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            hdrlabel1.textColor = Color
            
            strFontTitle = "Futura-CondensedMedium"
            
            hdrlabel.frame = CGRect(x: 0.0, y: 0.0, width: 0.9*width, height: 0.12*height)
            
            hdrlabel2 = UILabel(frame: CGRect(x: 0.0, y: 0.06*height, width: 0.9*width, height: 0.06*height));
            hdrlabel2.textAlignment = NSTextAlignment.left;
            hdrlabel2.numberOfLines = 0;
            hdrlabel2.font = UIFont(name: strFontTitle, size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            hdrlabel2.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont5 + appDelegate.gblDeviceFont3);
            hdrlabel2.textColor = Color
            
            hdrlabel1.text = NSLocalizedString("lblPartialEarly",comment:"")
            
            hdrlabel.addSubview(hdrlabel1)
            hdrlabel.addSubview(hdrlabel2)
            
            btnApply.frame = CGRect(x: 0.628*width, y: 0.3*height, width: (CGFloat(length)*0.025)*width, height: 0.04*height);
            btnCheckOutSlip.frame = CGRect(x: 0.7*width, y: 0.3*height, width: 0.25*width, height: 0.04*height);
            
            self.btnCheckOutSlip.setTitleColor(self.colorWithHexString("ba8748"), for: UIControl.State())
            self.btnCheckOutSlip.layer.borderWidth = 4
            self.btnCheckOutSlip.layer.borderColor = self.colorWithHexString("7c6a56").cgColor
            self.btnCheckOutSlip.backgroundColor = self.colorWithHexString("eee7dd")
            
            lblUnitText.text = Stays["UnitCode"]!
            //lblRRBalanceTxt.text = Stays["RRRBalance"]!
            
            btnCheckOutSlip.isHidden = true
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()

            AccView.backgroundColor = UIColor.clear
            
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
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.09*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.54
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlefooter.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.12*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.52
            AccView.addSubview(imgHdrVw)
            
            var strFontTitle: String = "Futura-CondensedExtraBold"
            var Color: UIColor = colorWithHexString("5c9fcc")
            
            lblResort.textColor = Color
            lblUnit.textColor = Color
            lblView.textColor = Color
            lblDates.textColor = Color
            lblPrimary.textColor = Color
            lblResort.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblUnit.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblView.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblDates.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblPrimary.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            strFontTitle = "Futura-CondensedMedium"
            Color = colorWithHexString("5c9fcc")
            
            lblResortText.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblUnitText.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblViewText.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblFullName.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblDatesText.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblResortText.textColor = Color
            lblUnitText.textColor = Color
            lblViewText.textColor = Color
            lblDatesText.textColor = Color
            lblFullName.textColor = Color
            
            lblResort.textAlignment = NSTextAlignment.left
            lblResort.frame = CGRect(x: 0.02*width, y: 0.00001*height, width: 0.2*width, height: 0.03*height);
            lblUnit.textAlignment = NSTextAlignment.left
            lblUnit.frame = CGRect(x: 0.02*width, y: 0.029*height, width: 0.2*width, height: 0.03*height);
            lblView.textAlignment = NSTextAlignment.left
            lblView.frame = CGRect(x: 0.02*width, y: 0.058*height, width: 0.2*width, height: 0.03*height);
            lblDates.textAlignment = NSTextAlignment.left
            lblDates.frame = CGRect(x: 0.02*width, y: 0.087*height, width: 0.2*width, height: 0.03*height);
            lblPrimary.textAlignment = NSTextAlignment.left
            lblPrimary.frame = CGRect(x: 0.02*width, y: 0.116*height, width: 0.2*width, height: 0.03*height);
            
            lblResortText.numberOfLines = 0
            lblResortText.frame = CGRect(x: 0.24*width, y: 0.0001*height, width: 0.45*width, height: 0.03*height);
            lblUnitText.numberOfLines = 0
            lblUnitText.frame = CGRect(x: 0.24*width, y: 0.0297*height, width: 0.45*width, height: 0.03*height);
            lblViewText.numberOfLines = 0
            lblViewText.frame = CGRect(x: 0.24*width, y: 0.059*height, width: 0.45*width, height: 0.03*height);
            lblDatesText.numberOfLines = 0
            lblDatesText.frame = CGRect(x: 0.24*width, y: 0.0885*height, width: 0.6*width, height: 0.03*height);
            lblFullName.numberOfLines = 0
            lblFullName.frame = CGRect(x: 0.24*width, y: 0.117*height, width: 0.6*width, height: 0.03*height);
            lblStatus.frame = CGRect(x: 0.01*width, y: 0.03*height, width: 0.133*width, height: 0.03*height);
            
            AccView.addSubview(lblResort)
            AccView.addSubview(lblUnit)
            AccView.addSubview(lblView)
            AccView.addSubview(lblDates)
            AccView.addSubview(lblPrimary)
            
            AccView.addSubview(lblResortText)
            AccView.addSubview(lblUnitText)
            AccView.addSubview(lblViewText)
            AccView.addSubview(lblDatesText)
            AccView.addSubview(lblFullName)

            itemsView.backgroundColor = UIColor.clear
            
            itemsView.frame = CGRect(x: 0.0, y: 44 + 0.001*height, width: width, height: 0.33*height);
            
            self.view.addSubview(itemsView)
            
            AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.17*height);
            
            self.view.addSubview(AccView)
            
            lblStatus.textAlignment = NSTextAlignment.center
            lblStatus.backgroundColor = UIColor.clear
            lblStatus.text = Status
            lblStatus.adjustsFontSizeToFitWidth = true
            
            strFontTitle = "MarkerFelt-Wide"
            Color = colorWithHexString("5c9fcc")
            
            lblStatus.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblStatus.textColor = Color
            
            LogOutView.frame = CGRect(x: 0.81*width, y: 0.08*height, width: 0.1562*self.width, height: 0.0881*self.height);
            LogOutView.layer.cornerRadius = 25
            LogOutView.clipsToBounds = true
            LogOutView.layer.borderWidth = 3
            LogOutView.layer.borderColor = colorWithHexString("94cce5").cgColor
            LogOutView.backgroundColor = colorWithHexString("ddf4ff")
            LogOutView.addSubview(lblStatus)
            self.view.addSubview(LogOutView)
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

            strFontTitle = "Futura-MediumItalic"
            Color = colorWithHexString("00467f")
            
            hdrlabel1 = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 0.9*width, height: 0.06*height));
            hdrlabel1.textAlignment = NSTextAlignment.left;
            hdrlabel1.numberOfLines = 0;
            hdrlabel1.font = UIFont(name: strFontTitle, size: appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            hdrlabel1.textColor = Color
            
            strFontTitle = "Futura-CondensedMedium"
            
            hdrlabel.frame = CGRect(x: 0.0, y: 0.0, width: 0.9*width, height: 0.12*height)
            
            hdrlabel2 = UILabel(frame: CGRect(x: 0.0, y: 0.06*height, width: 0.9*width, height: 0.06*height));
            hdrlabel2.textAlignment = NSTextAlignment.left;
            hdrlabel2.numberOfLines = 0;
            hdrlabel2.font = UIFont(name: strFontTitle, size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            hdrlabel2.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont5 + appDelegate.gblDeviceFont3);
            hdrlabel2.textColor = Color
            
            hdrlabel1.text = NSLocalizedString("lblPartialEarly",comment:"")
            
            hdrlabel.addSubview(hdrlabel1)
            hdrlabel.addSubview(hdrlabel2)
            
            btnApply.frame = CGRect(x: 0.628*width, y: 0.3*height, width: (CGFloat(length)*0.025)*width, height: 0.04*height);
            btnCheckOutSlip.frame = CGRect(x: 0.7*width, y: 0.3*height, width: 0.25*width, height: 0.04*height);
            
            self.btnCheckOutSlip.setTitleColor(self.colorWithHexString("ffffff"), for: UIControl.State())
            self.btnCheckOutSlip.layer.borderWidth = 4
            self.btnCheckOutSlip.layer.borderColor = self.colorWithHexString("a18015").cgColor
            self.btnCheckOutSlip.backgroundColor = self.colorWithHexString("c39b1a")
            
            lblUnitText.text = Stays["UnitCode"]!
            
        }
        
        //DeleteAccountData()
        
        if (LastAccountUpdate != "")
        {
            
            let todaysDate:Date = Date()
            let dtdateFormatter:DateFormatter = DateFormatter()
            dtdateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
            let DateInFormat:String = dtdateFormatter.string(from: todaysDate)
            
            let startDate = moment(LastAccountUpdate)
            let endDate = moment(DateInFormat)

            let cal = Calendar.current
            
            let unit:NSCalendar.Unit = [.hour]
            
            let components = (cal as NSCalendar).components(unit, from: startDate!.date, to: endDate!.date, options: [])
            
            iHour = components.hour!
            
            if (iHour >= 2){
                ynActualiza = true
                recargarTablas()
            }else{
                ynActualiza = false
                recargarTablas()
            }
            
        }else{
            //print(1)
            ynActualiza = true
            recargarTablas()
        }
    }
    
    func recargarTablas(){
        ViewItem.rightBarButtonItem?.isEnabled = false
        ViewItem.leftBarButtonItem?.isEnabled = false
        self.btnApply.isEnabled = false
        self.btnCheckOutSlip.isEnabled = false
        self.btnPayment.isEnabled = false
        self.tableView.isUserInteractionEnabled = false
        app.beginIgnoringInteractionEvents()
        
        var tableItems = RRDataSet()
        var iRes: String = ""
        var AccountInfo: Dictionary<String, String>
        var PeopleInfo: Dictionary<String, String>
        var iCountPeople: Int32 = 0
        var USDExchange: String = ""
        var ynExist: Bool=false
        var fkAccTrxID: Int = 0

        var strFullName: String = ""
        
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 100
        config.backgroundColor = UIColor(white: 1, alpha: 0.5)
        config.spinnerColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.titleTextColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.spinnerLineWidth = 2.0
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        SwiftLoader.show(title: NSLocalizedString("lblLoading",comment:""), animated: true)
        
        AccountInfo = [:]
        PeopleInfo = [:]
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        let queue = OperationQueue()
        
        if self.ynActualiza {
            if self.ynForceDelete {
                
                self.ynForceDelete = false
                self.LastAccTrxID  = ""
                
                queueFM?.inTransaction { db, rollback in
                    do {
                        
                        try db.executeUpdate("DELETE FROM tblAccount", withArgumentsIn: [])
                        
                    } catch {
                        rollback.pointee = true
                    }
                }
                
            }

            queueFM?.inDatabase() {
                db in
                
                if let rs = db.executeQuery("SELECT fkAccTrxID FROM tblAccount where StayInfoID = ? ORDER BY fkAccTrxID DESC LIMIT 1", withArgumentsIn: [self.StayInfoID]){
                    while rs.next() {
                        self.LastAccTrxID = rs.string(forColumn: "fkAccTrxID")!
                    }
                } else {
                    print("select failure: \(db.lastErrorMessage())")
                }
                
            }
            
            queue.addOperation() {//1
                
                if Reachability.isConnectedToNetwork(){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    
                    let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                    tableItems = (service?.spGetGuestAccount("1", appCode: self.appDelegate.gstrAppName, personalID: self.appDelegate.gstrLoginPeopleID, stayInfoID: self.StayInfoID, lastAccTrxID: self.LastAccTrxID, dataBase: self.appDelegate.strDataBaseByStay))!
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
                OperationQueue.main.addOperation() {
                    
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
                                
                                queueFM?.inTransaction() {
                                    db, rollback in
                                    
                                    
                                    for r in table.rows{
                                        
                                        ynExist = false
                                        fkAccTrxID = Int(((r as AnyObject).getColumnByName("fkAccTrxID").content as? String)!)!
                                        
                                        if let rs = db.executeQuery("SELECT fkAccTrxID FROM tblAccount where fkAccTrxID = ?", withArgumentsIn: [fkAccTrxID]){
                                            while rs.next() {
                                                ynExist = true
                                            }
                                        } else {
                                            print("select failure: \(db.lastErrorMessage())")
                                        }
                                        
                                        if !ynExist{
                                            /*if ((r as AnyObject).getColumnByName("PersonID").content as? String)! == "0"
                                            {
                                                peopleidAux = self.appDelegate.gstrPrimaryPeopleID
                                            }else{
                                                peopleidAux = ((r as AnyObject).getColumnByName("PersonID").content as? String)!
                                            }*/
                                            if db.executeUpdate("INSERT INTO tblAccount (StayInfoID, DatabaseName, fkAccTrxID, Voucher, PlaceDesc, Amount, TrxDate, PersonID, SubTotal, Tips, Cashier, TrxTypeCode, TrxTime, PeopleFDeskID, URLTicket) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [((r as AnyObject).getColumnByName("StayInfoID").content as? String)!, ((r as AnyObject).getColumnByName("DatabaseName").content as? String)!, ((r as AnyObject).getColumnByName("fkAccTrxID").content as? String)!, ((r as AnyObject).getColumnByName("Voucher").content as? String)!, ((r as AnyObject).getColumnByName("PlaceDesc").content as? String)!, ((r as AnyObject).getColumnByName("Amount").content as? String)!, ((r as AnyObject).getColumnByName("TrxDate").content as? String)!, ((r as AnyObject).getColumnByName("PersonID").content as? String)!, ((r as AnyObject).getColumnByName("SubTotal").content as? String)!, ((r as AnyObject).getColumnByName("Tips").content as? String)!, ((r as AnyObject).getColumnByName("Cashier").content as? String)!, ((r as AnyObject).getColumnByName("TrxTypeCode").content as? String)!, ((r as AnyObject).getColumnByName("TrxTime").content as? String)!, ((r as AnyObject).getColumnByName("PeopleFDeskID").content as? String)!, ((r as AnyObject).getColumnByName("URLTicket").content as? String)!]) {
                                                
                                            }
                                        }
                                        
                                    }
                                    
                                }
                                
                            }

                        /*queueFM?.inTransaction() {
                            db, rollback in
                            
                            if (db.executeUpdate("DELETE FROM tblPerson WHERE StayInfoID=?", withArgumentsIn: [self.StayInfoID])) {
                                rollback.initialize(to: true)
                                return
                            }
                            
                        }*/
                        
                        queueFM?.inTransaction { db, rollback in
                            do {
                                    
                                try db.executeUpdate("DELETE FROM tblPerson WHERE StayInfoID=?", withArgumentsIn: [self.StayInfoID])
                                    
                            } catch {
                                rollback.pointee = true
                            }
                        }
                            
                        var strAge: String = ""
                        var tablePeople = RRDataTable()
                        tablePeople = tableItems.tables.object(at: 2) as! RRDataTable
                        
                        iCountPeople = tablePeople.getTotalRows()
                        
                        if iCountPeople > 0{
                            
                            var rPeople = RRDataRow()
                            rPeople = tablePeople.rows.object(at: 0) as! RRDataRow
                            
                            queueFM?.inTransaction() {
                                db, rollback in
                                
                                for r in tablePeople.rows{
                                    
                                    if Int(((r as AnyObject).getColumnByName("Age").content as? String)!) > 99{
                                        strAge = "0"
                                    }else{
                                        strAge = ((r as AnyObject).getColumnByName("Age").content as? String)!
                                    }
                                    
                                    if db.executeUpdate("INSERT INTO tblPerson (StayInfoID,DatabaseName,PersonID,FullName,FirstName, MiddleName, LastName, SecondLName, EmailAddress, PeopleFDeskID, YearBirthDay, ynPrimary, ynPreRegisterAvailable, NumOfPeopleForStay, Age, pkPreRegisterID, PreRegisterTypeDesc, GuestType, RRRBalance, iKeycardid) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [((r as AnyObject).getColumnByName("StayInfoID").content as? String)!, ((r as AnyObject).getColumnByName("DatabaseName").content as? String)!, ((r as AnyObject).getColumnByName("PersonID").content as? String)!, ((r as AnyObject).getColumnByName("FullName").content as? String)!, ((r as AnyObject).getColumnByName("FirstName").content as? String)!, "", ((r as AnyObject).getColumnByName("LastName").content as? String)!, "", "", ((r as AnyObject).getColumnByName("PeopleFDeskID").content as? String)!, "0", "0", "0", "0", strAge, "0", "", "",((r as AnyObject).getColumnByName("RRRBalance").content as? String)!, ((r as AnyObject).getColumnByName("KeyCardID").content as? String)!]) {
                                        

                                        
                                    }else{

                                    }
                                    
                                    if self.appDelegate.gstrPrimaryPeopleID == ((r as AnyObject).getColumnByName("PersonID").content as? String)!
                                    {
                                        self.appDelegate.gstrPrimaryPeopleFdeskID = ((r as AnyObject).getColumnByName("PeopleFDeskID").content as? String)!
                                    }
                                    
                                }
                                
                            }
                            
                            /*queueFM?.inTransaction() {
                                db, rollback in
                                
                                if !db.executeUpdate("UPDATE tblAccount SET PeopleFDeskID = ? WHERE StayInfoID=? and PeopleFDeskID = 0", withArgumentsInArray: [self.appDelegate.gstrPrimaryPeopleFdeskID, self.StayInfoID]) {
                                    rollback.initialize(true)
                                    return
                                }
                                
                            }*/
                            
                        }//if iCountPeople > 0{
                        
                        var tableUSD = RRDataTable()
                        tableUSD = tableItems.tables.object(at: 4) as! RRDataTable
                        
                        
                        if tableUSD.getTotalRows() > 0
                        {
                            var rUSD = RRDataRow()
                            rUSD = tableUSD.rows.object(at: 0) as! RRDataRow
                            
                            for rUSD in tableUSD.rows{
                                
                                USDExchange = ((rUSD as AnyObject).getColumnByName("USDExchange").content as? String)!
                                
                            }
                            
                            if USDExchange != ""
                            {
                                
                                self.fDollar = Double(String(format: "%.2f", (USDExchange as NSString).floatValue))!
                                
                                /*queueFM?.inTransaction() {
                                    db, rollback in
                                    
                                    if (db.executeUpdate("UPDATE tblStay SET USDExchange = ? WHERE StayInfoID=?", withArgumentsIn: [USDExchange,self.StayInfoID])) {
                                        rollback.initialize(to: true)
                                        return
                                    }
                                    
                                }*/
                                
                                queueFM?.inTransaction { db, rollback in
                                    do {
                                        
                                        try db.executeUpdate("UPDATE tblStay SET USDExchange = ? WHERE StayInfoID=?", withArgumentsIn: [USDExchange,self.StayInfoID])
                                        
                                    } catch {
                                        rollback.pointee = true
                                        return
                                    }
                                }
                                
                            }
                            
                        }//if tableUSD.getTotalRows() > 0
                        
                        var tblPostCheckOut = RRDataTable()
                        tblPostCheckOut = tableItems.tables.object(at: 3) as! RRDataTable
                        
                        var rowResPostCheckOut = RRDataRow()
                        rowResPostCheckOut = tblPostCheckOut.rows.object(at: 0) as! RRDataRow
                        
                        var strInPostCheckOutProcess: String = ""
                        
                        strInPostCheckOutProcess = rowResPostCheckOut.getColumnByName("ynInPostCheckOutProcess").content as! String
                        
                        if strInPostCheckOutProcess == "False"{
                            self.ynInPostCheckOutProcess = false
                        }else{
                            self.ynInPostCheckOutProcess = true
                            /*queueFM?.inTransaction() {
                                db, rollback in
                                
                                if (db.executeUpdate("UPDATE tblStay SET ynPostCheckout=1 WHERE StayInfoID=?", withArgumentsIn: [self.StayInfoID])) {
                                    rollback.initialize(to: true)
                                    return
                                }
                                
                            }*/
                            
                            queueFM?.inTransaction { db, rollback in
                                do {
                                    
                                    try db.executeUpdate("UPDATE tblStay SET ynPostCheckout=1 WHERE StayInfoID=?", withArgumentsIn: [self.StayInfoID])
                                    
                                } catch {
                                    rollback.pointee = true
                                    return
                                }
                            }
                        }
                            
                            var tableResortCredits = RRDataTable()
                            tableResortCredits = tableItems.tables.object(at: 5) as! RRDataTable
                            
                            
                            if tableResortCredits.getTotalRows() > 0
                            {
                                var rResortCresdits = RRDataRow()
                                rResortCresdits = tableResortCredits.rows.object(at: 0) as! RRDataRow
                                
                                for rResortCresdits in tableResortCredits.rows{

                                    self.appDelegate.gblResCredMax = Double(String(format: "%.2f", (((rResortCresdits as AnyObject).getColumnByName("TotalResCred").content as? NSString)!).floatValue))!
                                    self.appDelegate.gblResCredAmount = Double(String(format: "%.2f", (((rResortCresdits as AnyObject).getColumnByName("ResCredBalance").content as? NSString)!).floatValue))!
                                    self.appDelegate.gblynResCredApply = (rResortCresdits as AnyObject).getColumnByName("ynResCredApply").content as! String
                                    self.appDelegate.gblStayInfoCatProductID = (rResortCresdits as AnyObject).getColumnByName("sStayInfoCatProductID").content as! String
                                    self.appDelegate.gblChargesApplied = Double(String(format: "%.2f", (((rResortCresdits as AnyObject).getColumnByName("ChargesApplied").content as? NSString)!).floatValue))!
                                    
                                    if self.appDelegate.gblynResCredApply == "0" && self.appDelegate.gblResCredAmount > 0 {
                                        
                                        self.appDelegate.gblynResortCredits = true
                                        
                                    }else{
                                        
                                        self.appDelegate.gblynResortCredits = false
                                        
                                    }
                                    
                                    //appDelegate.gblynResortCredits = false
                                }
                                
                                if USDExchange != ""
                                {
                                    
                                    self.fDollar = Double(String(format: "%.2f", (USDExchange as NSString).floatValue))!
                                    
                                    /*queueFM?.inTransaction() {
                                     db, rollback in
                                     
                                     if (db.executeUpdate("UPDATE tblStay SET USDExchange = ? WHERE StayInfoID=?", withArgumentsIn: [USDExchange,self.StayInfoID])) {
                                     rollback.initialize(to: true)
                                     return
                                     }
                                     
                                     }*/
                                    
                                    queueFM?.inTransaction { db, rollback in
                                        do {
                                            
                                            try db.executeUpdate("UPDATE tblStay SET USDExchange = ? WHERE StayInfoID=?", withArgumentsIn: [USDExchange,self.StayInfoID])
                                            
                                        } catch {
                                            rollback.pointee = true
                                            return
                                        }
                                    }
                                    
                                }
                                
                            }
                            
                            var tableRewardPerDollar = RRDataTable()
                            tableRewardPerDollar = tableItems.tables.object(at: 6) as! RRDataTable

                            if tableRewardPerDollar.getTotalRows() > 0
                            {
                                
                                var rRewardPerDollar = RRDataRow()
                                rRewardPerDollar = tableRewardPerDollar.rows.object(at: 0) as! RRDataRow
                                
                                for rRewardPerDollar in tableRewardPerDollar.rows{
                                    
                                    self.appDelegate.RewardPerDollar = Double(String(format: "%.2f", (((rRewardPerDollar as AnyObject).getColumnByName("RewardPerDollar").content as? NSString)!).floatValue))!
                                    
                                }

                            }
                            
                        queueFM?.inTransaction() {
                            db, rollback in
                            
                            let todaysDate:Date = Date()
                            let dateFormatter:DateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
                            let DateInFormat:String = dateFormatter.string(from: todaysDate)
                            
                            if (db.executeUpdate("UPDATE tblStay SET LastAccountUpdate=? WHERE StayInfoID=?", withArgumentsIn: [DateInFormat,self.StayInfoID])) {
                                
                            }
                            
                        }
                        
                        queueFM?.inDatabase() {
                            db in
                            
                            if let rs = db.executeQuery("SELECT p.* FROM tblPerson p where PeopleFdeskID = ?", withArgumentsIn: [self.appDelegate.gstrPrimaryPeopleFdeskID]){
                                while rs.next() {
                                    self.lblRRBalanceTxt.text = rs.string(forColumn: "RRRBalance")!
                                }
                            } else {
                                print("select failure: \(db.lastErrorMessage())")
                            }
                            
                        }
                        
                            queueFM?.inDatabase() {
                                db in
                                
                                if let rs = db.executeQuery("SELECT p.* FROM tblPerson p inner join tblLogin l on l.PersonalID = p.personID", withArgumentsIn: []){
                                    while rs.next() {
                                        self.appDelegate.gstrLoginFDESKPeopleID = rs.string(forColumn: "PeopleFdeskID")!
                                    }
                                } else {
                                    print("select failure: \(db.lastErrorMessage())")
                                }
                                
                            }
                            
                        if self.ynClickPay{
                            var iRes: String = ""
                            
                            var tblPre: Dictionary<String, String>!
                            var tblPreAuth: [Dictionary<String, String>]!
                            tblPreAuth = []
                            var tableItems = RRDataSet()
                            let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                            tableItems = (service?.spGetGuestAccPreAuthTrx("1", appCode: self.appDelegate.gstrAppName, personalID: self.appDelegate.gstrLoginPeopleID, stayInfoID: self.StayInfoID, dataBase: self.appDelegate.strDataBaseByStay))!
                            
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
                                        self.appDelegate.gblynPreAuth = true
                                        
                                        for r in table.rows{
                                            
                                            tblPre = [:]
                                            tblPre["StayInfoID"] = (r as AnyObject).getColumnByName("StayInfoID").content as? String
                                            tblPre["DatabaseName"] = (r as AnyObject).getColumnByName("DatabaseName").content as? String
                                            tblPre["Voucher"] = (r as AnyObject).getColumnByName("Voucher").content as? String
                                            tblPre["PlaceDesc"] = (r as AnyObject).getColumnByName("PlaceDesc").content as? String
                                            tblPre["Amount"] = (r as AnyObject).getColumnByName("Amount").content as? String
                                            tblPre["TrxDate"] = (r as AnyObject).getColumnByName("TrxDate").content as? String
                                            tblPre["TrxTime"] = (r as AnyObject).getColumnByName("TrxTime").content as? String
                                            tblPre["PeopleID"] = (r as AnyObject).getColumnByName("PeopleID").content as? String
                                            tblPre["KeyCardID"] = (r as AnyObject).getColumnByName("KeyCardID").content as? String
                                            tblPre["CcNumber"] = (r as AnyObject).getColumnByName("CcNumber").content as? String
                                            tblPre["AccTrxID"] = (r as AnyObject).getColumnByName("AccTrxID").content as? String
                                            tblPre["ExpDate"] = (r as AnyObject).getColumnByName("ExpDate").content as? String
                                            tblPre["CcType"] = (r as AnyObject).getColumnByName("CcType").content as? String
                                            tblPreAuth.append(tblPre)
                                        }
                                        
                                        self.appDelegate.gtblAccPreAuth = tblPreAuth
                                        
                                    }else{
                                        self.appDelegate.gblynPreAuth = false
                                        self.appDelegate.gtblAccPreAuth = nil
                                    }
                                    
                                }
                            }
                        }
                        
                        self.tblAccountInfo = nil
                        
                        if (self.PeopleFDeskID==""){
                            self.PeopleFDeskID="0"
                        }
                        
                        var AccountInfo: [Dictionary<String, String>]
                        var Index: Int = 0
                        var strQuery: String = ""
                        
                        if (self.PeopleFDeskID=="0"){
                            strQuery = "SELECT * FROM tblAccount WHERE StayInfoID = ?"
                        }else{
                            strQuery = "SELECT * FROM tblAccount WHERE StayInfoID = ? AND PeopleFDeskID =?"
                        }
                        
                        AccountInfo = []
                        
                        queueFM?.inDatabase() {
                            db in
                            
                            if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID,self.PeopleFDeskID]){
                                while rs.next() {
                                    AccountInfo.append([:])
                                    AccountInfo[Index]["StayInfoID"] = rs.string(forColumn: "StayInfoID")!
                                    AccountInfo[Index]["DatabaseName"] = rs.string(forColumn: "DatabaseName")!
                                    AccountInfo[Index]["fkAccTrxID"] = rs.string(forColumn: "fkAccTrxID")!
                                    AccountInfo[Index]["Voucher"] = rs.string(forColumn: "Voucher")!
                                    AccountInfo[Index]["PlaceDesc"] = rs.string(forColumn: "PlaceDesc")!
                                    AccountInfo[Index]["Amount"] = rs.string(forColumn: "Amount")!
                                    AccountInfo[Index]["TrxDate"] = rs.string(forColumn: "TrxDate")!
                                    if rs.string(forColumn: "PersonID")! == "0"
                                     {
                                        AccountInfo[Index]["PersonID"] = self.appDelegate.gstrPrimaryPeopleID
                                     }else{
                                        AccountInfo[Index]["PersonID"] = rs.string(forColumn: "PersonID")!
                                     }
                                    
                                    AccountInfo[Index]["SubTotal"] = rs.string(forColumn: "SubTotal")!
                                    AccountInfo[Index]["Tips"] = rs.string(forColumn: "Tips")!
                                    AccountInfo[Index]["Cashier"] = rs.string(forColumn: "Cashier")!
                                    AccountInfo[Index]["TrxTypeCode"] = rs.string(forColumn: "TrxTypeCode")!
                                    AccountInfo[Index]["TrxTime"] = rs.string(forColumn: "TrxTime")!
                                    if rs.string(forColumn: "PeopleFDeskID") == "0"
                                    {
                                        AccountInfo[Index]["PeopleFDeskID"] = self.appDelegate.gstrPrimaryPeopleFdeskID
                                    }else{
                                        AccountInfo[Index]["PeopleFDeskID"] = rs.string(forColumn: "PeopleFDeskID")!
                                    }
                                    AccountInfo[Index]["URLTicket"] = rs.string(forColumn: "URLTicket")!
                                    Index = Index + 1
                                }
                            } else {
                                print("select failure: \(db.lastErrorMessage())")
                            }
                            
                        }
                        
                        self.tblAccountInfo = AccountInfo
                        
                        if AccountInfo.count > 0{
                            
                        queueFM?.inDatabase() {
                                db in
                                
                                if let rs = db.executeQuery("SELECT fkAccTrxID FROM tblAccount where StayInfoID = ? ORDER BY fkAccTrxID DESC LIMIT 1", withArgumentsIn: [self.StayInfoID]){
                                    while rs.next() {
                                        self.LastAccTrxID = rs.string(forColumn: "fkAccTrxID")!
                                    }
                                } else {
                                    print("select failure: \(db.lastErrorMessage())")
                                }
                                
                            }

                        queueFM?.inDatabase() {
                            db in
                            
                            if let rs = db.executeQuery("SELECT p.* FROM tblPerson p inner join tblStay s on s.StayInfoID = ? AND s.PrimaryPeopleID = p.personID", withArgumentsIn: [self.StayInfoID]){
                                while rs.next() {
                                    self.FullName = rs.string(forColumn: "FullName")!
                                }
                            } else {
                                print("select failure: \(db.lastErrorMessage())")
                            }
                            
                        }
                            
                            queueFM?.inDatabase() {
                                db in
                                
                                if let rs = db.executeQuery("SELECT p.* FROM tblPerson p where PeopleFdeskID = ?", withArgumentsIn: [self.appDelegate.gstrPrimaryPeopleFdeskID]){
                                    while rs.next() {
                                        self.lblRRBalanceTxt.text = rs.string(forColumn: "RRRBalance")!
                                    }
                                } else {
                                    print("select failure: \(db.lastErrorMessage())")
                                }
                                
                            }
                            
                        strQuery = ""

                        if (self.PeopleFDeskID=="0"){
                            strQuery = "SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ?"
                        }else{
                            strQuery = "SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ? AND PeopleFDeskID = ?"
                        }
                        
                        queueFM?.inDatabase() {
                            db in
                            
                            if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID, self.PeopleFDeskID]){
                                while rs.next() {
                                    self.fAmount = Double(String(format: "%.2f", (rs.string(forColumn: "Amount")! as NSString).floatValue))!
                                }
                            } else {
                                print("select failure: \(db.lastErrorMessage())")
                            }
                            
                        }

                        strQuery = ""
                        
                        strQuery = "SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ?"
                        
                        queueFM?.inDatabase() {
                            db in
                            
                            if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID, "0"]){
                                while rs.next() {
                                    self.fTotalAmount = Double(String(format: "%.2f", (rs.string(forColumn: "Amount")! as NSString).floatValue))!
                                }
                            } else {
                                print("select failure: \(db.lastErrorMessage())")
                            }
                            
                        }
                        
                        var strDate: [String]
                        var DateAccountInfo: [[Dictionary<String, String>]]
                        
                        var CountAccountTot: Int32 = 0
                        var CountTrx: Int = 0
                        Index = 0
                        var CountTotTrx: Int = 0
                        strQuery = ""
                        var strQueryAcc: String = ""
                        
                        CountTotTrx = AccountInfo.count
                        
                        if (self.PeopleFDeskID=="0"){
                            strQuery = "SELECT COUNT(*) as CountAccountTot FROM (SELECT TrxDate FROM tblAccount WHERE StayInfoID = ? GROUP BY TrxDate)"
                        }else{
                            strQuery = "SELECT COUNT(*) as CountAccountTot FROM (SELECT TrxDate FROM tblAccount WHERE StayInfoID = ? AND PeopleFDeskID =? GROUP BY TrxDate)"
                        }
                        
                        queueFM?.inDatabase() {
                            db in
                            
                            if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID, self.PeopleFDeskID]){
                                while rs.next() {
                                    CountAccountTot = rs.int(forColumn: "CountAccountTot")
                                }
                            } else {
                                print("select failure: \(db.lastErrorMessage())")
                            }
                            
                        }
                        
                        //if AccountInfo.count > 0{
                            
                            DateAccountInfo = []
                            strDate = [""]
                            
                            if (self.PeopleFDeskID=="0"){
                                strQueryAcc = "SELECT count(*) as CountTrx, TrxDate FROM tblAccount WHERE StayInfoID = ? GROUP BY TrxDate ORDER BY TrxDate DESC"
                            }else{
                                strQueryAcc = "SELECT count(*) as CountTrx, TrxDate FROM tblAccount WHERE StayInfoID = ? AND PeopleFDeskID =? GROUP BY TrxDate ORDER BY TrxDate DESC"
                            }
                            
                            queueFM?.inDatabase() {
                                db in
                                
                                if let rs = db.executeQuery(strQueryAcc, withArgumentsIn: [self.StayInfoID, self.PeopleFDeskID]){
                                    while rs.next() {
                                        if (Index==0){
                                            strDate[0] = rs.string(forColumn: "TrxDate")!
                                            CountTrx = Int(rs.int(forColumn: "CountTrx"))
                                            DateAccountInfo.append([])
                                            for _ in 0...CountTrx-1 {
                                                DateAccountInfo[0].append([:])
                                            }
                                            
                                        }else{
                                            strDate.append(rs.string(forColumn: "TrxDate")!)
                                            CountTrx = Int(rs.int(forColumn: "CountTrx"))
                                            DateAccountInfo.append([])
                                            for _ in 0...CountTrx-1 {
                                                DateAccountInfo[Index].append([:])
                                            }
                                            
                                        }
                                        Index = Index + 1
                                    }
                                } else {
                                    print("select failure: \(db.lastErrorMessage())")
                                }
                                
                            }
                            
                            let xCountStatus = Int(CountAccountTot)
                            let xCountStays = Int(CountTotTrx)
                            var sCount: Int = 0
                            
                            for xIndex in 0...xCountStatus-1 {
                                sCount = 0
                                for yIndex in 0...xCountStays-1 {
                                    if (strDate[xIndex]==AccountInfo[yIndex]["TrxDate"]){
                                        DateAccountInfo[xIndex][sCount] = AccountInfo[yIndex]
                                        sCount = sCount + 1
                                    }
                                    
                                }
                                
                            }
                            
                            self.DateAccountInfo = DateAccountInfo
                            
                            self.tblPerson = nil
                            
                            var People: [String]
                            
                            People = ["ALL"]
                            
                            queueFM?.inDatabase() {
                                db in
                                
                                if let rs = db.executeQuery("SELECT * FROM tblPerson WHERE StayInfoID = ?", withArgumentsIn: [self.StayInfoID]){
                                    while rs.next() {
                                        People.append(rs.string(forColumn: "FirstName")!)
                                        
                                    }
                                } else {
                                    print("select failure: \(db.lastErrorMessage())")
                                }
                                
                            }
                            
                            self.tblPerson = People
                            
                            self.tblPeopleID = nil
                            
                            var PeoplesID: [String]
                            
                            PeoplesID = ["0"]
                            
                            queueFM?.inDatabase() {
                                db in
                                
                                if let rs = db.executeQuery("SELECT * FROM tblPerson WHERE StayInfoID = ? ORDER BY rowid ASC", withArgumentsIn: [self.StayInfoID]){
                                    while rs.next() {
                                        if (rs.string(forColumn: "PeopleFDeskID")! == "0"){
                                            PeoplesID.append("-1")
                                        }else{
                                            PeoplesID.append(rs.string(forColumn: "PeopleFDeskID")!)
                                        }
                                    }
                                } else {
                                    print("select failure: \(db.lastErrorMessage())")
                                }
                                
                            }
                            
                            self.tblPeopleID = PeoplesID
                            
                            var Stays: Dictionary<String, String>
                            
                            Stays = [:]
                            
                            queueFM?.inDatabase() {
                                db in
                                
                                if let rs = db.executeQuery("SELECT * FROM tblStay WHERE StayInfoID = ?", withArgumentsIn: [self.StayInfoID]){
                                    while rs.next() {
                                        Stays["StayInfoID"] = rs.string(forColumn: "StayInfoID")!
                                        Stays["DatabaseName"] = rs.string(forColumn: "DatabaseName")!
                                        Stays["PropertyCode"] = rs.string(forColumn: "PropertyCode")!
                                        Stays["PropertyName"] = rs.string(forColumn: "PropertyName")!
                                        Stays["UnitCode"] = rs.string(forColumn: "UnitCode")!
                                        Stays["StatusCode"] = rs.string(forColumn: "StatusCode")!
                                        Stays["StatusDesc"] = rs.string(forColumn: "StatusDesc")!
                                        Stays["ArrivalDate"] = rs.string(forColumn: "ArrivalDate")!
                                        Stays["DepartureDate"] = rs.string(forColumn: "DepartureDate")!
                                        Stays["PrimaryPeopleID"] = rs.string(forColumn: "PrimaryPeopleID")!
                                        Stays["OrderNo"] = rs.string(forColumn: "OrderNo")!
                                        Stays["Intv"] = rs.string(forColumn: "Intv")!
                                        Stays["IntvYear"] = rs.string(forColumn: "IntvYear")!
                                        Stays["fkAccID"] = rs.string(forColumn: "fkAccID")!
                                        Stays["fkTrxTypeID"] = rs.string(forColumn: "fkTrxTypeID")!
                                        Stays["AccCode"] = rs.string(forColumn: "AccCode")!
                                        Stays["USDExchange"] = rs.string(forColumn: "USDExchange")!
                                        Stays["UnitID"] = rs.string(forColumn: "UnitID")!
                                        Stays["FloorPlanDesc"] = rs.string(forColumn: "FloorPlanDesc")!
                                        Stays["UnitViewDesc"] = rs.string(forColumn: "UnitViewDesc")!
                                        Stays["ynPostCheckout"] = rs.string(forColumn: "ynPostCheckout")!
                                        Stays["LastAccountUpdate"] = rs.string(forColumn: "LastAccountUpdate")!
                                        Stays["PrimAgeCFG"] = rs.string(forColumn: "PrimAgeCFG")!
                                        Stays["fkPlaceID"] = rs.string(forColumn: "fkPlaceID")!
                                        Stays["DepartureDateCheckOut"] = rs.string(forColumn: "DepartureDateCheckOut")!
                                        Stays["ConfirmationCode"] = rs.string(forColumn: "ConfirmationCode")!
                                        Stays["fkCurrencyID"] = String(describing: rs.string(forColumn: "fkCurrencyID")!)
                                    }
                                } else {
                                    print("select failure: \(db.lastErrorMessage())")
                                }
                                
                            }
                            
                            self.Stays = Stays
                            
                        }

                        //Todo lo que no sea una accion base de datos
                        if (self.tblAccountInfo.count > 0){

                                
                                var queueFM: FMDatabaseQueue?
                                
                                queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
                                
                                var strQueryAux: String = ""
                                
                                if (self.PeopleFDeskID=="0"){
                                    strQueryAux = "SELECT FullName FROM tblPerson WHERE StayInfoID = ?"
                                }else{
                                    strQueryAux = "SELECT FullName FROM tblPerson WHERE StayInfoID = ? AND PeopleFDeskID =?"
                                }
                                
                                queueFM?.inDatabase() {
                                    db in
                                    if let rs = db.executeQuery(strQueryAux, withArgumentsIn: [self.StayInfoID,self.PeopleFDeskID]){
                                        while rs.next() {
                                            strFullName = strFullName + rs.string(forColumn: "FullName")! + ", "
                                        }
                                        if strFullName != ""{
                                            let strpre: String = strFullName
                                            
                                            let start = strpre.index(strpre.startIndex, offsetBy: 0)
                                            let end = strpre.index(strpre.endIndex, offsetBy: -2)
                                            let range = start..<end
                                            
                                            let mySubstring = strpre[range]
                                            
                                            strFullName = String(mySubstring)
                                        }
                                    } else {
                                        print("select failure: \(db.lastErrorMessage())")
                                    }
                                }

                            if (self.fTotalAmount<=0.01){

                                if (self.fTotalAmount <= 0.01){
                                    self.btnApply.setTitle(NSLocalizedString("Checkout",comment:""), for: UIControl.State())
                                    self.btnApply.titleLabel?.font = UIFont(name: "Helvetica", size: self.appDelegate.gblFont5 + self.appDelegate.gblDeviceFont4)
                                    
                                    if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                                        
                                        self.btnApply.setTitleColor(UIColor.white, for: UIControl.State())
                                        self.btnApply.backgroundColor = UIColor.darkGray
                                        self.btnApply.layer.borderWidth = 0.8
                                        self.btnApply.layer.borderColor = UIColor.black.cgColor
                                        
                                    }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                                        //self.btnApply.setTitleColor(self.colorWithHexString("ddf4ff"), forState: UIControlState.Normal)
                                        //self.btnApply.backgroundColor = self.colorWithHexString("94cce5")
                                        //self.btnApply.layer.borderWidth = 0.8
                                        //self.btnApply.layer.borderColor = self.colorWithHexString("00467f").CGColor
                                        self.btnApply.setTitleColor(self.colorWithHexString("ba8748"), for: UIControl.State())
                                        self.btnApply.layer.borderWidth = 4
                                        self.btnApply.layer.borderColor = self.colorWithHexString("7c6a56").cgColor
                                        self.btnApply.backgroundColor = self.colorWithHexString("eee7dd")
                                    }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                                        

                                        //self.btnApply.setTitleColor(self.colorWithHexString("ddf4ff"), forState: UIControlState.Normal)
                                        //self.btnApply.backgroundColor = self.colorWithHexString("94cce5")
                                        //self.btnApply.layer.borderWidth = 0.8
                                        //self.btnApply.layer.borderColor = self.colorWithHexString("00467f").CGColor
                                        self.btnApply.setTitleColor(self.colorWithHexString("ffffff"), for: UIControl.State())
                                        self.btnApply.layer.borderWidth = 4
                                        self.btnApply.layer.borderColor = self.colorWithHexString("a18015").cgColor
                                        self.btnApply.backgroundColor = self.colorWithHexString("c39b1a")

                                    }

                                    self.btnApply.frame = CGRect(x: 0.65*self.width, y: 0.3*self.height, width: 0.3*self.width, height: 0.04*self.height);
                                    self.lblAmount.text = "0.00 USD"
                                    self.lblAmount.isHidden = true
                                    
                                    if self.PeopleFDeskID != "0"{
                                        self.hdrlabel2.text = NSLocalizedString("lblPersonAmount",comment:"") + strFullName + ":\n" + String(format: "%.2f", (String(format: "%.2f0", (self.fAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                                    }else{
                                        self.hdrlabel2.text = NSLocalizedString("lblTotalAmount",comment:"") + String(format: "%.2f", (String(format: "%.2f0", (self.fTotalAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                                    }
                                    
                                    self.tableView.tableHeaderView = self.hdrlabel
                                    
                                    if (self.Stays["ynPostCheckout"]==nil){
                                        self.btnApply.isEnabled = true
                                        self.btnCheckOutSlip.isHidden = true
                                        self.btnApply.isHidden = false
                                    }else{
                                        if (self.Stays["ynPostCheckout"]!=="1"){
                                            self.btnApply.isEnabled = false
                                            if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                                                self.btnCheckOutSlip.isHidden = true
                                            }else{
                                                self.btnCheckOutSlip.isHidden = false
                                            }
                                            self.btnApply.isHidden = true
                                        }else{
                                            self.btnApply.isEnabled = true
                                            self.btnCheckOutSlip.isHidden = true
                                            self.btnApply.isHidden = false
                                        }
                                    }
                                    
                                }
                                
                            }else{
                                
                                self.str = String(format: "%.2f", (String(format: "%.2f0", (self.fAmount.description as NSString).floatValue) as NSString).floatValue)
                                
                                self.strAmountPay = NSLocalizedString("Pay",comment:"") + " " + self.str + " " + self.Stays["fkCurrencyID"]!
                                
                                self.strDinamicMonto = self.strAmountPay
                                self.length = self.strDinamicMonto.characters.count
                                
                                self.btnApply.frame = CGRect(x: 0.05*self.width, y: 0.3*self.height, width: (CGFloat(self.length)*0.025)*self.width, height: 0.04*self.height);
                                self.btnApply.titleLabel?.font = UIFont(name: "Helvetica", size: self.appDelegate.gblFont5 + self.appDelegate.gblDeviceFont4)
                                self.btnApply.setTitle(self.strAmountPay, for: UIControl.State())
                                
                                if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{

                                    self.btnApply.backgroundColor = UIColor.white
                                    self.btnApply.layer.borderColor = UIColor.white.cgColor
                                    self.btnApply.setTitleColor(self.colorWithHexString("0080FF"), for: UIControl.State())
                                    
                                }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                                    //self.btnApply.backgroundColor = self.colorWithHexString("ddf4ff")
                                    //self.btnApply.layer.borderColor = self.colorWithHexString("94cce5").CGColor
                                    //self.btnApply.setTitleColor(self.colorWithHexString("00467f"), forState: UIControlState.Normal)
                                    //self.btnApply.layer.borderWidth = 3
                                    self.btnApply.setTitleColor(self.colorWithHexString("ba8748"), for: UIControl.State())
                                    self.btnApply.layer.borderWidth = 4
                                    self.btnApply.layer.borderColor = self.colorWithHexString("7c6a56").cgColor
                                    self.btnApply.backgroundColor = self.colorWithHexString("eee7dd")
                                }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                                    
                                    //self.btnApply.backgroundColor = self.colorWithHexString("ddf4ff")
                                    //self.btnApply.layer.borderColor = self.colorWithHexString("94cce5").CGColor
                                    //self.btnApply.setTitleColor(self.colorWithHexString("00467f"), forState: UIControlState.Normal)
                                    //self.btnApply.layer.borderWidth = 3
                                    self.btnApply.setTitleColor(self.colorWithHexString("ffffff"), for: UIControl.State())
                                    self.btnApply.layer.borderWidth = 4
                                    self.btnApply.layer.borderColor = self.colorWithHexString("a18015").cgColor
                                    self.btnApply.backgroundColor = self.colorWithHexString("c39b1a")
                                    
                                }
                                
                                if (self.fAmount>0.1){
                                    
                                    self.str = String(format: "%.2f", (String(format: "%.2f0", ((self.fAmount/self.fDollar).description as NSString).floatValue) as NSString).floatValue)
                                    
                                    self.lblAmount.text = self.str + " USD"
                                    
                                    self.btnApply.isEnabled = true
                                    
                                }else{
                                    if self.Status=="OUT"{
                                        self.lblAmount.text = ""
                                    }else{
                                        self.lblAmount.text = "0.00 USD"
                                    }
                                }
                                
                                if self.PeopleFDeskID != "0"{
                                    self.hdrlabel2.text = NSLocalizedString("lblPersonAmount",comment:"") + strFullName + ":\n" + String(format: "%.2f", (String(format: "%.2f0", (self.fAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                                }else{
                                    self.hdrlabel2.text = NSLocalizedString("lblTotalAmount",comment:"") + String(format: "%.2f", (String(format: "%.2f0", (self.fTotalAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                                }
                                
                                self.tableView.tableHeaderView = self.hdrlabel
                                
                            }
                            
                            self.CountGroupTrx = self.DateAccountInfo.count
                            
                            if self.ynClickPay != true
                            {
                            
                                self.segmentedControl = HMSegmentedControl(sectionTitles: self.tblPerson, strBundleIdentifier: self.appDelegate.strBundleIdentifier)
                                self.segmentedControl.autoresizingMask = [UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleWidth]
                                self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
                                self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
                                self.segmentedControl.isVerticalDividerEnabled = true
 
                                if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                                    self.segmentedControl.verticalDividerColor = UIColor.black
                                    self.segmentedControl.frame = CGRect(x: 0.05*self.width, y: 0.2*self.height, width: 0.9*self.width, height: 0.04*self.height);
                                    self.segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
                                }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                                    self.segmentedControl.verticalDividerColor = self.colorWithHexString("e4c29c")
                                    self.segmentedControl.frame = CGRect(x: 0.05*self.width, y: 0.23*self.height, width: 0.9*self.width, height: 0.04*self.height);
                                    self.segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
                                }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                                    self.segmentedControl.verticalDividerColor = self.colorWithHexString("94cce5")
                                    self.segmentedControl.frame = CGRect(x: 0.05*self.width, y: 0.23*self.height, width: 0.9*self.width, height: 0.04*self.height);
                                    self.segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
                                }
                            
                                self.segmentedControl.verticalDividerWidth = 0.1
                                self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic
                                self.segmentedControl.fontDevice = self.appDelegate.gblFont5 + self.appDelegate.gblDeviceFont4
                                self.segmentedControl.addTarget(self, action: #selector(vcGuestAccount.segmentedControlValueChanged(_:)), for: UIControl.Event.valueChanged)
                                self.itemsView.addSubview(self.segmentedControl)
                                
                                if self.PeopleFDeskID != ""{
                                    for index in 0...self.tblPeopleID.count-1 {
                                        if(self.tblPeopleID[index]==self.PeopleFDeskID){
                                            self.segmentedControl.setSelectedSegmentIndex(UInt(index), animated: true)
                                        }
                                    }
                                }else{
                                    if self.StayInfoID != ""
                                    {
                                        for index in 0...self.tblPeopleID.count-1 {
                                            if(self.tblPeopleID[index]==self.PeopleFDeskID){
                                                self.segmentedControl.setSelectedSegmentIndex(UInt(index), animated: true)
                                            }
                                        }
                                    }else{
                                        self.segmentedControl.setSelectedSegmentIndex(UInt(0), animated: true)
                                    }
                                }
                            }
                            
                            self.tableView.reloadData()
                            
                        } else{
                            if (self.Status=="INHOUSE")&&(self.fTotalAmount<=0.01){
                                if Reachability.isConnectedToNetwork(){
                                    if (self.fTotalAmount <= 0.01){
                                        self.CountGroupTrx = 0
                                        self.btnApply.setTitle(NSLocalizedString("Checkout",comment:""), for: UIControl.State())
                                        self.btnApply.titleLabel?.font = UIFont(name: "Helvetica", size: self.appDelegate.gblFont5 + self.appDelegate.gblDeviceFont4)
                                        
                                        if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                                            
                                            self.btnApply.setTitleColor(UIColor.white, for: UIControl.State())
                                            self.btnApply.backgroundColor = UIColor.darkGray
                                            self.btnApply.layer.borderWidth = 0.8
                                            self.btnApply.layer.borderColor = UIColor.black.cgColor
                                            
                                        }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                                            //self.btnApply.setTitleColor(self.colorWithHexString("ddf4ff"), forState: UIControlState.Normal)
                                            //self.btnApply.backgroundColor = self.colorWithHexString("94cce5")
                                            //self.btnApply.layer.borderWidth = 0.8
                                            //self.btnApply.layer.borderColor = self.colorWithHexString("00467f").CGColor
                                            self.btnApply.setTitleColor(self.colorWithHexString("ba8748"), for: UIControl.State())
                                            self.btnApply.layer.borderWidth = 4
                                            self.btnApply.layer.borderColor = self.colorWithHexString("7c6a56").cgColor
                                            self.btnApply.backgroundColor = self.colorWithHexString("eee7dd")
                                        }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                                            
                                            
                                            //self.btnApply.setTitleColor(self.colorWithHexString("ddf4ff"), forState: UIControlState.Normal)
                                            //self.btnApply.backgroundColor = self.colorWithHexString("94cce5")
                                            //self.btnApply.layer.borderWidth = 0.8
                                            //self.btnApply.layer.borderColor = self.colorWithHexString("00467f").CGColor
                                            self.btnApply.setTitleColor(self.colorWithHexString("ffffff"), for: UIControl.State())
                                            self.btnApply.layer.borderWidth = 4
                                            self.btnApply.layer.borderColor = self.colorWithHexString("a18015").cgColor
                                            self.btnApply.backgroundColor = self.colorWithHexString("c39b1a")
                                            
                                        }
                                        
                                        self.btnApply.frame = CGRect(x: 0.65*self.width, y: 0.3*self.height, width: 0.3*self.width, height: 0.04*self.height);
                                        self.lblAmount.text = "0.00 USD"
                                        self.hdrlabel2.text = NSLocalizedString("lblTotalAmount",comment:"") + String(format: "%.2f", (String(format: "%.2f0", (self.fTotalAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                                        self.tableView.tableHeaderView = self.hdrlabel
                                        self.lblAmount.isHidden = true
                                    }
                                }
                                
                            }else{
                                
                                if (self.Status != "INHOUSE"){
                                    self.btnCheckOutSlip.isHidden = true
                                    self.btnApply.isHidden = true
                                    self.lblAmount.isHidden = true
                                    self.tableView.reloadData()
                                }
                                
                            }
                            
                        }
                        
                        self.lblFullName.text = ""
                        self.lblFullName.text = self.FullName

                        if self.ynClickPay
                        {
                            self.ynClickPay = false
                            
                            if (self.fTotalAmount<=0.01){
                                
                                self.appDelegate.gblCheckOutVw = true
                                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "tvcPosCheckOut") as! DateCellTableViewController
                                self.navigationController?.pushViewController(tercerViewController, animated: true)
                                
                            }else{
                                
                                if (self.fTotalAmount>0.1){
                                    
                                    self.appDelegate.gblRRRewards = Double((self.lblRRBalanceTxt.text as! NSString).floatValue)

                                    self.ViewItem.rightBarButtonItem?.isEnabled = true
                                    self.ViewItem.leftBarButtonItem?.isEnabled = true
                                    self.btnApply.isEnabled = true
                                    self.btnCheckOutSlip.isEnabled = true
                                    self.btnPayment.isEnabled = true
                                    self.tableView.isUserInteractionEnabled = true
                                    self.app.endIgnoringInteractionEvents()
                                    
                                    SwiftLoader.hide()
                                    
                                    if self.appDelegate.gblynPreAuth == false && self.appDelegate.gblynResortCredits == false && self.appDelegate.gblRRRewards == 0{
                                        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcGuestAccountPayment") as! vcGuestAccountPayment
                                        tercerViewController.StayInfoID = self.StayInfoID
                                        tercerViewController.PeopleID = self.PeopleID
                                        tercerViewController.PeopleFDeskID = self.PeopleFDeskID
                                        tercerViewController.ynPreAuth = false
                                        tercerViewController.ynPreAuthCreditCard = false
                                        tercerViewController.PreAmount = "0"
                                        self.navigationController?.pushViewController(tercerViewController, animated: true)
                                    }else{
                                        let vcSelectPaymentAux = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectPayment") as! vcSelectPayment
                                        vcSelectPaymentAux.StayInfoID = self.StayInfoID
                                        vcSelectPaymentAux.PeopleID = self.PeopleID
                                        vcSelectPaymentAux.PeopleFDeskID = self.PeopleFDeskID
                                        self.navigationController?.pushViewController(vcSelectPaymentAux, animated: true)
                                    }

                                    /*if self.appDelegate.gblynPreAuth == true
                                    {
                                        SwiftLoader.hide()
                                        
                                        self.ViewItem.rightBarButtonItem?.isEnabled = true
                                        self.ViewItem.leftBarButtonItem?.isEnabled = true
                                        self.btnApply.isEnabled = true
                                        self.btnCheckOutSlip.isEnabled = true
                                        self.btnPayment.isEnabled = true
                                        self.tableView.isUserInteractionEnabled = true
                                        self.app.endIgnoringInteractionEvents()
                                        
                                        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcPreAuth") as! vcPreAuth
                                        tercerViewController.StayInfoID = self.StayInfoID
                                        tercerViewController.PeopleID = self.PeopleID
                                        tercerViewController.PeopleFDeskID = self.PeopleFDeskID
                                        self.navigationController?.pushViewController(tercerViewController, animated: true)
                                    }else{
                                        
                                        SwiftLoader.hide()
                                        
                                        self.ViewItem.rightBarButtonItem?.isEnabled = true
                                        self.ViewItem.leftBarButtonItem?.isEnabled = true
                                        self.btnApply.isEnabled = true
                                        self.btnCheckOutSlip.isEnabled = true
                                        self.btnPayment.isEnabled = true
                                        self.tableView.isUserInteractionEnabled = true
                                        self.app.endIgnoringInteractionEvents()

                                        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcGuestAccountPayment") as! vcGuestAccountPayment
                                        tercerViewController.StayInfoID = self.StayInfoID
                                        tercerViewController.PeopleID = self.PeopleID
                                        tercerViewController.PeopleFDeskID = self.PeopleFDeskID
                                        tercerViewController.ynPreAuth = false
                                        tercerViewController.ynPreAuthCreditCard = false
                                        tercerViewController.PreAmount = "0"
                                        self.navigationController?.pushViewController(tercerViewController, animated: true)
                                    }*/
                                }
                            }
                        }
                        
                         let todaysDate:Date = Date()
                         let dtdateFormatter:DateFormatter = DateFormatter()
                         dtdateFormatter.dateFormat = "yyyy-MM-dd"
                         let DateInFormat:String = dtdateFormatter.string(from: todaysDate)
                         
                         let endDate = moment(DateInFormat)
                         let DepartureDate = moment(self.Stays["DepartureDate"]!)
                         
                            if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                                /*if endDate > DepartureDate{
                                    self.btnApply.isHidden = true
                                    self.btnCheckOutSlip.isHidden = true
                                    self.btnPayment.isHidden = true
                                    self.lblAmount.isHidden = true
                                }*/
                            }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                                
                                if endDate > DepartureDate{
                                    self.btnApply.isHidden = true
                                    self.btnCheckOutSlip.isHidden = true
                                    self.btnPayment.isHidden = true
                                    self.lblAmount.isHidden = true
                                }
                                
                            }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                                
                                if endDate > DepartureDate{
                                    self.btnApply.isHidden = true
                                    self.btnCheckOutSlip.isHidden = true
                                    self.btnPayment.isHidden = true
                                    self.lblAmount.isHidden = true
                                }
                                
                            }

                        }
                        
                        SwiftLoader.hide()
                        
                        self.ViewItem.rightBarButtonItem?.isEnabled = true
                        self.ViewItem.leftBarButtonItem?.isEnabled = true
                        self.btnApply.isEnabled = true
                        self.btnCheckOutSlip.isEnabled = true
                        self.btnPayment.isEnabled = true
                        self.tableView.isUserInteractionEnabled = true
                        self.app.endIgnoringInteractionEvents()
                        
                    }//if (tableItems.getTotalTables() > 0 )
                }
            }//1
            
        }else{
            
            self.tblAccountInfo = nil
            
            if (self.PeopleFDeskID==""){
                self.PeopleFDeskID="0"
            }
            
            var AccountInfo: [Dictionary<String, String>]
            var Index: Int = 0
            var strQuery: String = ""
            
            if (self.PeopleFDeskID=="0"){
                strQuery = "SELECT * FROM tblAccount WHERE StayInfoID = ?"
            }else{
                strQuery = "SELECT * FROM tblAccount WHERE StayInfoID = ? AND PeopleFDeskID =?"
            }
            
            AccountInfo = []
            
            queueFM?.inDatabase() {
                db in
                
                if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID,self.PeopleFDeskID]){
                    while rs.next() {
                        AccountInfo.append([:])
                        AccountInfo[Index]["StayInfoID"] = rs.string(forColumn: "StayInfoID")!
                        AccountInfo[Index]["DatabaseName"] = rs.string(forColumn: "DatabaseName")!
                        AccountInfo[Index]["fkAccTrxID"] = rs.string(forColumn: "fkAccTrxID")!
                        AccountInfo[Index]["Voucher"] = rs.string(forColumn: "Voucher")!
                        AccountInfo[Index]["PlaceDesc"] = rs.string(forColumn: "PlaceDesc")!
                        AccountInfo[Index]["Amount"] = rs.string(forColumn: "Amount")!
                        AccountInfo[Index]["TrxDate"] = rs.string(forColumn: "TrxDate")!
                        
                        if rs.string(forColumn: "PersonID") == "0"
                        {
                            AccountInfo[Index]["PersonID"] = self.appDelegate.gstrPrimaryPeopleID
                        }else{
                            AccountInfo[Index]["PersonID"] = rs.string(forColumn: "PersonID")!
                        }
                        
                        AccountInfo[Index]["SubTotal"] = rs.string(forColumn: "SubTotal")!
                        AccountInfo[Index]["Tips"] = rs.string(forColumn: "Tips")!
                        AccountInfo[Index]["Cashier"] = rs.string(forColumn: "Cashier")!
                        AccountInfo[Index]["TrxTypeCode"] = rs.string(forColumn: "TrxTypeCode")!
                        AccountInfo[Index]["TrxTime"] = rs.string(forColumn: "TrxTime")!
                        AccountInfo[Index]["URLTicket"] = rs.string(forColumn: "URLTicket")!
                        if rs.string(forColumn: "PeopleFDeskID") == "0"
                        {
                            AccountInfo[Index]["PeopleFDeskID"] = self.appDelegate.gstrPrimaryPeopleFdeskID
                        }else{
                            AccountInfo[Index]["PeopleFDeskID"] = rs.string(forColumn: "PeopleFDeskID")!
                        }
                        
                        Index = Index + 1
                    }
                } else {
                    print("select failure: \(db.lastErrorMessage())")
                }
                
            }
            
            
            
            self.tblAccountInfo = AccountInfo
            
            queueFM?.inDatabase() {
                db in
                
                if let rs = db.executeQuery("SELECT fkAccTrxID FROM tblAccount where StayInfoID = ? ORDER BY fkAccTrxID DESC LIMIT 1", withArgumentsIn: [self.StayInfoID]){
                    while rs.next() {
                        self.LastAccTrxID = rs.string(forColumn: "fkAccTrxID")!
                    }
                } else {
                    print("select failure: \(db.lastErrorMessage())")
                }
                
            }
            
            queueFM?.inDatabase() {
                db in
                
                if let rs = db.executeQuery("SELECT p.* FROM tblPerson p inner join tblStay s on s.StayInfoID = ? AND s.PrimaryPeopleID = p.personID", withArgumentsIn: [self.StayInfoID]){
                    while rs.next() {
                        self.FullName = rs.string(forColumn: "FullName")!
                    }
                } else {
                    print("select failure: \(db.lastErrorMessage())")
                }
                
            }
            
            queueFM?.inDatabase() {
                db in
                
                if let rs = db.executeQuery("SELECT p.* FROM tblPerson p where PeopleFdeskID = ?", withArgumentsIn: [self.appDelegate.gstrPrimaryPeopleFdeskID]){
                    while rs.next() {
                        self.lblRRBalanceTxt.text = rs.string(forColumn: "RRRBalance")!
                    }
                } else {
                    print("select failure: \(db.lastErrorMessage())")
                }
                
            }
            
            if self.LastAccTrxID != ""{
                strQuery = ""
                
                if (self.PeopleFDeskID=="0"){
                    strQuery = "SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ?"
                }else{
                    strQuery = "SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ? AND PeopleFDeskID =?"
                }
                
                queueFM?.inDatabase() {
                    db in
                    
                    if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID, self.PeopleFDeskID]){
                        while rs.next() {
                            self.fAmount = Double(String(format: "%.2f", (rs.string(forColumn: "Amount")! as NSString).floatValue))!
                        }
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                    
                }
                
                strQuery = ""
                
                strQuery = "SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ?"
                
                queueFM?.inDatabase() {
                    db in
                    
                    if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID, "0"]){
                        while rs.next() {
                            self.fTotalAmount = Double(String(format: "%.2f", (rs.string(forColumn: "Amount")! as NSString).floatValue))!
                        }
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                    
                }
            }
            
            if AccountInfo.count > 0
            {
                var strDate: [String]
                var DateAccountInfo: [[Dictionary<String, String>]]
            
                var CountAccountTot: Int32 = 0
                var CountTrx: Int = 0
                Index = 0
                var CountTotTrx: Int = 0
                strQuery = ""
                var strQueryAcc: String = ""

                var queueFM: FMDatabaseQueue?
                
                queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
                
                var strQueryAux: String = ""
                
                if (self.PeopleFDeskID=="0"){
                    strQueryAux = "SELECT FullName FROM tblPerson WHERE StayInfoID = ?"
                }else{
                    strQueryAux = "SELECT FullName FROM tblPerson WHERE StayInfoID = ? AND PeopleFDeskID =?"
                }
                
                queueFM?.inDatabase() {
                    db in
                    if let rs = db.executeQuery(strQueryAux, withArgumentsIn: [self.StayInfoID,self.PeopleFDeskID]){
                        while rs.next() {
                            strFullName = strFullName + rs.string(forColumn: "FullName")! + ", "
                        }
                        if strFullName != ""{
                            let strpre: String = strFullName
                            
                            let start = strpre.index(strpre.startIndex, offsetBy: 0)
                            let end = strpre.index(strpre.endIndex, offsetBy: -2)
                            let range = start..<end
                            
                            let mySubstring = strpre[range]
                            
                            strFullName = String(mySubstring)
                        }
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                }
            
                CountTotTrx = AccountInfo.count
            
                if (self.PeopleFDeskID=="0"){
                    strQuery = "SELECT COUNT(*) as CountAccountTot FROM (SELECT TrxDate FROM tblAccount WHERE StayInfoID = ? GROUP BY TrxDate)"
                }else{
                    strQuery = "SELECT COUNT(*) as CountAccountTot FROM (SELECT TrxDate FROM tblAccount WHERE StayInfoID = ? AND PeopleFDeskID =? GROUP BY TrxDate)"
                }
            
                queueFM?.inDatabase() {
                    db in
                
                    if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID, self.PeopleFDeskID]){
                        while rs.next() {
                            CountAccountTot = rs.int(forColumn: "CountAccountTot")
                        }
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                
                }
            
                DateAccountInfo = []
                strDate = [""]
            
                if (self.PeopleFDeskID=="0"){
                    strQueryAcc = "SELECT count(*) as CountTrx, TrxDate FROM tblAccount WHERE StayInfoID = ? GROUP BY TrxDate ORDER BY TrxDate DESC"
                }else{
                    strQueryAcc = "SELECT count(*) as CountTrx, TrxDate FROM tblAccount WHERE StayInfoID = ? AND PeopleFDeskID =? GROUP BY TrxDate ORDER BY TrxDate DESC"
                }
            
                queueFM?.inDatabase() {
                    db in
                
                    if let rs = db.executeQuery(strQueryAcc, withArgumentsIn: [self.StayInfoID, self.PeopleFDeskID]){
                        while rs.next() {
                            if (Index==0){
                                strDate[0] = rs.string(forColumn: "TrxDate")!
                                CountTrx = Int(rs.int(forColumn: "CountTrx"))
                                DateAccountInfo.append([])
                                for _ in 0...CountTrx-1 {
                                    DateAccountInfo[0].append([:])
                                }
                            
                            }else{
                                strDate.append(rs.string(forColumn: "TrxDate")!)
                                CountTrx = Int(rs.int(forColumn: "CountTrx"))
                                DateAccountInfo.append([])
                                for _ in 0...CountTrx-1 {
                                    DateAccountInfo[Index].append([:])
                                }
                            
                            }
                            Index = Index + 1
                        }
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                
                }
            
                let xCountStatus = Int(CountAccountTot)
                let xCountStays = Int(CountTotTrx)
                var sCount: Int = 0
            
                for xIndex in 0...xCountStatus-1 {
                    sCount = 0
                    for yIndex in 0...xCountStays-1 {
                        if (strDate[xIndex]==AccountInfo[yIndex]["TrxDate"]){
                            DateAccountInfo[xIndex][sCount] = AccountInfo[yIndex]
                            sCount = sCount + 1
                        }
                    
                    }
                
                }
            
                self.DateAccountInfo = DateAccountInfo
            }
            self.tblPerson = nil
            
            var People: [String]
            
            People = ["ALL"]
            
            queueFM?.inDatabase() {
                db in
                
                if let rs = db.executeQuery("SELECT * FROM tblPerson WHERE StayInfoID = ?", withArgumentsIn: [self.StayInfoID]){
                    while rs.next() {
                        People.append(rs.string(forColumn: "FirstName")!)
                        
                    }
                } else {
                    print("select failure: \(db.lastErrorMessage())")
                }
                
            }
            
            self.tblPerson = People
            
            self.tblPeopleID = nil
            
            var PeoplesID: [String]
            
            PeoplesID = ["0"]
            
            queueFM?.inDatabase() {
                db in
                
                if let rs = db.executeQuery("SELECT * FROM tblPerson WHERE StayInfoID = ? ORDER BY rowid ASC", withArgumentsIn: [self.StayInfoID]){
                    while rs.next() {
                        if (rs.string(forColumn: "PeopleFDeskID")! == "0"){
                            PeoplesID.append("-1")
                        }else{
                            PeoplesID.append(rs.string(forColumn: "PeopleFDeskID")!)
                        }
                    }
                } else {
                    print("select failure: \(db.lastErrorMessage())")
                }
                
            }
            
            self.tblPeopleID = PeoplesID
            
            var Stays: Dictionary<String, String>
            
            Stays = [:]
            
            queueFM?.inDatabase() {
                db in
                
                if let rs = db.executeQuery("SELECT * FROM tblStay WHERE StayInfoID = ?", withArgumentsIn: [self.StayInfoID]){
                    while rs.next() {
                        Stays["StayInfoID"] = rs.string(forColumn: "StayInfoID")!
                        Stays["DatabaseName"] = rs.string(forColumn: "DatabaseName")!
                        Stays["PropertyCode"] = rs.string(forColumn: "PropertyCode")!
                        Stays["PropertyName"] = rs.string(forColumn: "PropertyName")!
                        Stays["UnitCode"] = rs.string(forColumn: "UnitCode")!
                        Stays["StatusCode"] = rs.string(forColumn: "StatusCode")!
                        Stays["StatusDesc"] = rs.string(forColumn: "StatusDesc")!
                        Stays["ArrivalDate"] = rs.string(forColumn: "ArrivalDate")!
                        Stays["DepartureDate"] = rs.string(forColumn: "DepartureDate")!
                        Stays["PrimaryPeopleID"] = rs.string(forColumn: "PrimaryPeopleID")!
                        Stays["OrderNo"] = rs.string(forColumn: "OrderNo")!
                        Stays["Intv"] = rs.string(forColumn: "Intv")!
                        Stays["IntvYear"] = rs.string(forColumn: "IntvYear")!
                        Stays["fkAccID"] = rs.string(forColumn: "fkAccID")!
                        Stays["fkTrxTypeID"] = rs.string(forColumn: "fkTrxTypeID")!
                        Stays["AccCode"] = rs.string(forColumn: "AccCode")!
                        Stays["USDExchange"] = rs.string(forColumn: "USDExchange")!
                        Stays["UnitID"] = rs.string(forColumn: "UnitID")!
                        Stays["FloorPlanDesc"] = rs.string(forColumn: "FloorPlanDesc")!
                        Stays["UnitViewDesc"] = rs.string(forColumn: "UnitViewDesc")!
                        Stays["ynPostCheckout"] = rs.string(forColumn: "ynPostCheckout")!
                        Stays["LastAccountUpdate"] = rs.string(forColumn: "LastAccountUpdate")!
                        Stays["PrimAgeCFG"] = rs.string(forColumn: "PrimAgeCFG")!
                        Stays["fkPlaceID"] = rs.string(forColumn: "fkPlaceID")!
                        Stays["DepartureDateCheckOut"] = rs.string(forColumn: "DepartureDateCheckOut")!
                        Stays["ConfirmationCode"] = rs.string(forColumn: "ConfirmationCode")!
                        Stays["fkCurrencyID"] = String(describing: rs.string(forColumn: "fkCurrencyID")!)
                    }
                } else {
                    print("select failure: \(db.lastErrorMessage())")
                }
                
            }
            
            self.Stays = Stays
            
            //Todo lo que no sea una accion base de datos
            if (self.tblAccountInfo.count > 0){
                
                if (self.fTotalAmount<=0.01){
                    
                    if (self.fTotalAmount <= 0.01){
                        self.btnApply.setTitle(NSLocalizedString("Checkout",comment:""), for: UIControl.State())
                        self.btnApply.titleLabel?.font = UIFont(name: "Helvetica", size: self.appDelegate.gblFont5 + self.appDelegate.gblDeviceFont4)
                        
                        if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                            
                            self.btnApply.setTitleColor(UIColor.white, for: UIControl.State())
                            self.btnApply.backgroundColor = UIColor.darkGray
                            self.btnApply.layer.borderWidth = 0.8
                            self.btnApply.layer.borderColor = UIColor.black.cgColor
                            
                        }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                            
                            //self.btnApply.setTitleColor(self.colorWithHexString("ddf4ff"), forState: UIControlState.Normal)
                            //self.btnApply.backgroundColor = self.colorWithHexString("94cce5")
                            //self.btnApply.layer.borderWidth = 0.8
                            //self.btnApply.layer.borderColor = self.colorWithHexString("00467f").CGColor
                            self.btnApply.setTitleColor(self.colorWithHexString("ba8748"), for: UIControl.State())
                            self.btnApply.layer.borderWidth = 4
                            self.btnApply.layer.borderColor = self.colorWithHexString("7c6a56").cgColor
                            self.btnApply.backgroundColor = self.colorWithHexString("eee7dd")
                            
                        }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                            
                            
                            //self.btnApply.setTitleColor(self.colorWithHexString("ddf4ff"), forState: UIControlState.Normal)
                            //self.btnApply.backgroundColor = self.colorWithHexString("94cce5")
                            //self.btnApply.layer.borderWidth = 0.8
                            //self.btnApply.layer.borderColor = self.colorWithHexString("00467f").CGColor
                            self.btnApply.setTitleColor(self.colorWithHexString("ffffff"), for: UIControl.State())
                            self.btnApply.layer.borderWidth = 4
                            self.btnApply.layer.borderColor = self.colorWithHexString("a18015").cgColor
                            self.btnApply.backgroundColor = self.colorWithHexString("c39b1a")
                        }
                        
                        self.btnApply.frame = CGRect(x: 0.65*self.width, y: 0.3*self.height, width: 0.3*self.width, height: 0.04*self.height);
                        self.lblAmount.text = "0.00 USD"
                        self.lblAmount.isHidden = true
                        self.hdrlabel2.text = NSLocalizedString("lblTotalAmount",comment:"") + String(format: "%.2f", (String(format: "%.2f0", (self.fTotalAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                        
                        self.tableView.tableHeaderView = self.hdrlabel
                        
                        if (self.Stays["ynPostCheckout"]==nil){
                            self.btnApply.isEnabled = true
                            self.btnCheckOutSlip.isHidden = true
                            self.btnApply.isHidden = false
                        }else{
                            if (self.Stays["ynPostCheckout"]!=="1"){
                                self.btnApply.isEnabled = false
                                if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                                    self.btnCheckOutSlip.isHidden = true
                                }else{
                                    self.btnCheckOutSlip.isHidden = false
                                }
                                self.btnApply.isHidden = true
                            }else{
                                self.btnApply.isEnabled = true
                                self.btnCheckOutSlip.isHidden = true
                                self.btnApply.isHidden = false
                            }
                        }
                        
                    }
                    
                }else{
                    
                    self.str = String(format: "%.2f", (String(format: "%.2f0", (self.fAmount.description as NSString).floatValue) as NSString).floatValue)
                    
                    self.strAmountPay = NSLocalizedString("Pay",comment:"") + " " + self.str + " " + self.Stays["fkCurrencyID"]!
                    
                    self.strDinamicMonto = self.strAmountPay
                    self.length = self.strDinamicMonto.characters.count
                    self.btnApply.frame = CGRect(x: 0.05*self.width, y: 0.3*self.height, width: (CGFloat(self.length)*0.025)*self.width, height: 0.04*self.height);
                    self.btnApply.titleLabel?.font = UIFont(name: "Helvetica", size: self.appDelegate.gblFont5 + self.appDelegate.gblDeviceFont4)
                    self.btnApply.setTitle(self.strAmountPay, for: UIControl.State())
                    
                    if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                        
                        self.btnApply.backgroundColor = UIColor.white
                        self.btnApply.layer.borderColor = UIColor.white.cgColor
                        self.btnApply.setTitleColor(self.colorWithHexString("0080FF"), for: UIControl.State())
                        
                    }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                        
                        //self.btnApply.backgroundColor = self.colorWithHexString("ddf4ff")
                        //self.btnApply.layer.borderColor = self.colorWithHexString("94cce5").CGColor
                        //self.btnApply.setTitleColor(self.colorWithHexString("00467f"), forState: UIControlState.Normal)
                        //self.btnApply.layer.borderWidth = 3
                        self.btnApply.setTitleColor(self.colorWithHexString("ba8748"), for: UIControl.State())
                        self.btnApply.layer.borderWidth = 4
                        self.btnApply.layer.borderColor = self.colorWithHexString("7c6a56").cgColor
                        self.btnApply.backgroundColor = self.colorWithHexString("eee7dd")
                        
                    }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                        
                        //self.btnApply.backgroundColor = self.colorWithHexString("ddf4ff")
                        //self.btnApply.layer.borderColor = self.colorWithHexString("94cce5").CGColor
                        //self.btnApply.setTitleColor(self.colorWithHexString("00467f"), forState: UIControlState.Normal)
                        //self.btnApply.layer.borderWidth = 3
                        self.btnApply.setTitleColor(self.colorWithHexString("ffffff"), for: UIControl.State())
                        self.btnApply.layer.borderWidth = 4
                        self.btnApply.layer.borderColor = self.colorWithHexString("a18015").cgColor
                        self.btnApply.backgroundColor = self.colorWithHexString("c39b1a")
                    }
                    
                    if (self.fAmount>0.1){
                        
                        self.str = String(format: "%.2f", (String(format: "%.2f0", ((self.fAmount/self.fDollar).description as NSString).floatValue) as NSString).floatValue)
                        
                        self.lblAmount.text = self.str + " USD"
                        
                        self.btnApply.isEnabled = true
                        
                    }else{
                        if self.Status=="OUT"{
                            self.lblAmount.text = ""
                        }else{
                            self.lblAmount.text = "0.00 USD"
                        }
                    }
                    
                    if self.PeopleFDeskID != "0"{
                        self.hdrlabel2.text = NSLocalizedString("lblPersonAmount",comment:"") + strFullName + ":\n" + String(format: "%.2f", (String(format: "%.2f0", (self.fAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]! ;
                    }else{
                        self.hdrlabel2.text = NSLocalizedString("lblTotalAmount",comment:"") + String(format: "%.2f", (String(format: "%.2f0", (self.fTotalAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                    }
                    
                    self.tableView.tableHeaderView = self.hdrlabel
                    
                }
                
                self.CountGroupTrx = self.DateAccountInfo.count
                
                self.segmentedControl = HMSegmentedControl(sectionTitles: self.tblPerson, strBundleIdentifier: self.appDelegate.strBundleIdentifier)
                self.segmentedControl.autoresizingMask = [UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleWidth]
                self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
                self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
                self.segmentedControl.isVerticalDividerEnabled = true
                if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                    self.segmentedControl.verticalDividerColor = UIColor.black
                    self.segmentedControl.frame = CGRect(x: 0.05*self.width, y: 0.2*self.height, width: 0.9*self.width, height: 0.04*self.height);
                    self.segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
                }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                    self.segmentedControl.verticalDividerColor = self.colorWithHexString("e4c29c")
                    self.segmentedControl.frame = CGRect(x: 0.05*self.width, y: 0.23*self.height, width: 0.9*self.width, height: 0.04*self.height);
                    self.segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
                }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                    self.segmentedControl.verticalDividerColor = self.colorWithHexString("94cce5")
                    self.segmentedControl.frame = CGRect(x: 0.05*self.width, y: 0.23*self.height, width: 0.9*self.width, height: 0.04*self.height);
                    self.segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
                }
                self.segmentedControl.verticalDividerWidth = 0.1
                self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic
                self.segmentedControl.fontDevice = self.appDelegate.gblFont5 + self.appDelegate.gblDeviceFont4
                self.segmentedControl.addTarget(self, action: #selector(vcGuestAccount.segmentedControlValueChanged(_:)), for: UIControl.Event.valueChanged)
                self.itemsView.addSubview(self.segmentedControl)

                if self.PeopleFDeskID != ""{
                    for index in 0...self.tblPeopleID.count-1 {
                        if(self.tblPeopleID[index]==self.PeopleFDeskID){
                            self.segmentedControl.setSelectedSegmentIndex(UInt(index), animated: true)
                        }
                    }
                }else{
                    if self.StayInfoID != ""
                    {
                        for index in 0...self.tblPeopleID.count-1 {
                            if(self.tblPeopleID[index]==self.PeopleFDeskID){
                                self.segmentedControl.setSelectedSegmentIndex(UInt(index), animated: true)
                            }
                        }
                    }else{
                        self.segmentedControl.setSelectedSegmentIndex(UInt(0), animated: true)
                    }
                }
                
                self.tableView.reloadData()
                
            } else{
                if (self.Status=="INHOUSE")&&(self.fTotalAmount<=0.01){
                    if Reachability.isConnectedToNetwork(){
                        if (self.fTotalAmount <= 0.01){
                            self.CountGroupTrx = 0
                            self.btnApply.setTitle(NSLocalizedString("Checkout",comment:""), for: UIControl.State())
                            self.btnApply.titleLabel?.font = UIFont(name: "Helvetica", size: self.appDelegate.gblFont5 + self.appDelegate.gblDeviceFont4)
                            
                            if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                                
                                self.btnApply.setTitleColor(UIColor.white, for: UIControl.State())
                                self.btnApply.backgroundColor = UIColor.darkGray
                                self.btnApply.layer.borderWidth = 0.8
                                self.btnApply.layer.borderColor = UIColor.black.cgColor
                                
                            }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                                
                                //self.btnApply.setTitleColor(self.colorWithHexString("ddf4ff"), forState: UIControlState.Normal)
                                //self.btnApply.backgroundColor = self.colorWithHexString("94cce5")
                                //self.btnApply.layer.borderWidth = 0.8
                                //self.btnApply.layer.borderColor = self.colorWithHexString("00467f").CGColor
                                self.btnApply.setTitleColor(self.colorWithHexString("ba8748"), for: UIControl.State())
                                self.btnApply.layer.borderWidth = 4
                                self.btnApply.layer.borderColor = self.colorWithHexString("7c6a56").cgColor
                                self.btnApply.backgroundColor = self.colorWithHexString("eee7dd")
                                
                            }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                                
                                
                                //self.btnApply.setTitleColor(self.colorWithHexString("ddf4ff"), forState: UIControlState.Normal)
                                //self.btnApply.backgroundColor = self.colorWithHexString("94cce5")
                                //self.btnApply.layer.borderWidth = 0.8
                                //self.btnApply.layer.borderColor = self.colorWithHexString("00467f").CGColor
                                self.btnApply.setTitleColor(self.colorWithHexString("ffffff"), for: UIControl.State())
                                self.btnApply.layer.borderWidth = 4
                                self.btnApply.layer.borderColor = self.colorWithHexString("a18015").cgColor
                                self.btnApply.backgroundColor = self.colorWithHexString("c39b1a")
                            }
                            
                            self.btnApply.frame = CGRect(x: 0.65*self.width, y: 0.3*self.height, width: 0.3*self.width, height: 0.04*self.height);
                            self.lblAmount.text = "0.00 USD"
                            self.hdrlabel2.text = NSLocalizedString("lblTotalAmount",comment:"") + String(format: "%.2f", (String(format: "%.2f0", (self.fTotalAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                            self.tableView.tableHeaderView = self.hdrlabel
                            self.lblAmount.isHidden = true
                            
                            if (self.Stays["ynPostCheckout"]==nil){
                                self.btnApply.isEnabled = true
                                self.btnCheckOutSlip.isHidden = true
                                self.btnApply.isHidden = false
                            }else{
                                if (self.Stays["ynPostCheckout"]!=="1"){
                                    self.btnApply.isEnabled = false
                                    if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                                        self.btnCheckOutSlip.isHidden = true
                                    }else{
                                        self.btnCheckOutSlip.isHidden = false
                                    }
                                    self.btnApply.isHidden = true
                                }else{
                                    self.btnApply.isEnabled = true
                                    self.btnCheckOutSlip.isHidden = true
                                    self.btnApply.isHidden = false
                                }
                            }
                            
                        }
                    }
                    
                }else{
                    
                    if (self.Status != "INHOUSE"){
                        self.btnCheckOutSlip.isHidden = true
                        self.btnApply.isHidden = true
                        self.lblAmount.isHidden = true
                    }
                }
                
            }
            
            self.lblFullName.text = ""
            self.lblFullName.text = self.FullName
            
            SwiftLoader.hide()
            
            if self.ynClickPay
            {
                self.ynClickPay = false
                
                if (self.fTotalAmount<=0.01){
                    
                    self.appDelegate.gblCheckOutVw = true
                    let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "tvcPosCheckOut") as! DateCellTableViewController
                    self.navigationController?.pushViewController(tercerViewController, animated: true)
                    
                }else{
                    
                    if (self.fTotalAmount>0.1){
                        if self.appDelegate.gblynPreAuth == true
                        {
                            let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcPreAuth") as! vcPreAuth
                            tercerViewController.StayInfoID = self.StayInfoID
                            tercerViewController.PeopleID = self.PeopleID
                            tercerViewController.PeopleFDeskID = self.PeopleFDeskID
                            self.navigationController?.pushViewController(tercerViewController, animated: true)
                        }else{
                            let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcGuestAccountPayment") as! vcGuestAccountPayment
                            tercerViewController.StayInfoID = self.StayInfoID
                            tercerViewController.PeopleID = self.PeopleID
                            tercerViewController.PeopleFDeskID = self.PeopleFDeskID
                            tercerViewController.ynPreAuth = false
                            tercerViewController.ynPreAuthCreditCard = false
                            tercerViewController.PreAmount = "0"
                            self.navigationController?.pushViewController(tercerViewController, animated: true)
                        }
                    }
                }
            }
            
            let todaysDate:Date = Date()
            let dtdateFormatter:DateFormatter = DateFormatter()
            dtdateFormatter.dateFormat = "yyyy-MM-dd"
            let DateInFormat:String = dtdateFormatter.string(from: todaysDate)
            
            let endDate = moment(DateInFormat)
            let DepartureDate = moment(self.Stays["DepartureDate"]!)
            
            if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                /*if endDate > DepartureDate{
                    self.btnApply.isHidden = true
                    self.btnCheckOutSlip.isHidden = true
                    self.btnPayment.isHidden = true
                    self.lblAmount.isHidden = true
                }*/
            }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                
                if endDate > DepartureDate{
                    self.btnApply.isHidden = true
                    self.btnCheckOutSlip.isHidden = true
                    self.btnPayment.isHidden = true
                    self.lblAmount.isHidden = true
                }
                
            }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                
                if endDate > DepartureDate{
                    self.btnApply.isHidden = true
                    self.btnCheckOutSlip.isHidden = true
                    self.btnPayment.isHidden = true
                    self.lblAmount.isHidden = true
                }
                
            }
            
            self.ViewItem.rightBarButtonItem?.isEnabled = true
            self.ViewItem.leftBarButtonItem?.isEnabled = true
            self.btnApply.isEnabled = true
            self.btnCheckOutSlip.isEnabled = true
            self.btnPayment.isEnabled = true
            self.tableView.isUserInteractionEnabled = true
            self.app.endIgnoringInteractionEvents()
        
        }//ynactualiza
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Account",
            AnalyticsParameterItemName: "Account",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Account", screenClass: appDelegate.gstrAppName)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if !Reachability.isConnectedToNetwork(){
            RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
        }else{
        if (appDelegate.gblPay == true) || (self.appDelegate.gblCheckOutVw == true) {
            ynActualiza = true
            recargarTablas()

        }
        
        if (appDelegate.gblExitPreAuth == true)&&(self.Status=="INHOUSE")&&(self.fTotalAmount<=0.01) {
            appDelegate.gblExitPreAuth = false
            appDelegate.gblCheckOutVw = true
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "tablePosCheckOut")
            self.present(vc, animated: true, completion: nil)
        }else{
            appDelegate.gblExitPreAuth = false
            }
        }


    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CountGroupTrx;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DateAccountInfo[section].count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var strdtDate: String=""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm"
        
        let dtDate = moment(DateAccountInfo[section][0]["TrxDate"]!)
        
        let strdateFormatter = DateFormatter()
        //strdateFormatter.locale = NSLocale.currentLocale()
        //strdateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        strdateFormatter.dateFormat = "yyyy-MM-dd";
        strdtDate = strdateFormatter.string(from: dtDate!.date)
        
        return strdtDate
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title: UILabel = UILabel()
        title.backgroundColor = UIColor.clear;
        title.textAlignment = NSTextAlignment.left;
        title.textColor = UIColor.gray;
        title.font = UIFont(name:"HelveticaNeue-Light", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont4)
        title.numberOfLines = 0;
        
        var strdtDate: String=""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm"
        
        let dtDate = moment(DateAccountInfo[section][0]["TrxDate"]!)
        
        let strdateFormatter = DateFormatter()
        //strdateFormatter.locale = NSLocale.currentLocale()
        //strdateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        strdateFormatter.dateFormat = "yyyy-MM-dd";
        strdtDate = strdateFormatter.string(from: dtDate!.date)
        
        title.text = strdtDate;

        return title
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0.04*height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.03*height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01*height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        fAmount = Double(String(format: "%.2f", (String(format: "%.2f0", (DateAccountInfo[indexPath.section][indexPath.row]["Amount"]! as NSString).floatValue) as NSString).floatValue))!
        
        str = String(format: "%.2f", (String(format: "%.2f0", (DateAccountInfo[indexPath.section][indexPath.row]["Amount"]! as NSString).floatValue) as NSString).floatValue)

        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAccountTrx") as! tvcVoucher

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
            
            if (fAmount > 0.1)
            {
                cell.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("e4c29c"))
            }else{
                cell.accessoryView = STKColorAccessoryView.init(color: UIColor.clear)
            }
            
            if indexPath.row == 0{
                imgCell = UIImage(named:"tblacchdr.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblacchdrSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }else if (DateAccountInfo[indexPath.section].count-1) == indexPath.row{
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
            
            if (DateAccountInfo[indexPath.section].count) == 1
            {
                imgCell = UIImage(named:"tblaccrowsingle.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblaccrowsingleSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
                
            }
            
            lastIndex = IndexPath.init()
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            cell.backgroundColor = UIColor.clear
            
            if (fAmount > 0.1)
            {
                cell.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("94cce5"))
            }else{
                cell.accessoryView = STKColorAccessoryView.init(color: UIColor.clear)
            }

            if indexPath.row == 0{
                imgCell = UIImage(named:"tblacchdr.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblacchdrSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }else if (DateAccountInfo[indexPath.section].count-1) == indexPath.row{
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
            
            if (DateAccountInfo[indexPath.section].count) == 1
            {
                imgCell = UIImage(named:"tblaccrowsingle.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblaccrowsingleSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
                
            }
            
            lastIndex = IndexPath.init()
            
        }

        cell.frame = CGRect(x: 0, y: 0, width: 0.9*width, height: 0.05*height)
        
        cell.SetValues(Voucher: String(DateAccountInfo[indexPath.section][indexPath.row]["Voucher"]!), Place: String(DateAccountInfo[indexPath.section][indexPath.row]["PlaceDesc"]!), Amount: str, width: width, height: height)

        if (fAmount > 0.1)
        {
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }else{
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        fAmount = Double(String(format: "%.2f", (String(format: "%.2f0", (DateAccountInfo[indexPath.section][indexPath.row]["Amount"]! as NSString).floatValue) as NSString).floatValue))!
        
            if (fAmount > 0.1)
            {
                if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                    
                }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                    
                    tableView.cellForRow(at: indexPath)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("ba8748"))
                    
                }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
  
                    tableView.cellForRow(at: indexPath)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("00467f"))
                }
                
                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcGuestAccountTrxViewController") as! vcGuestAccountTrxViewController
                tercerViewController.fkAccTrxID = DateAccountInfo[indexPath.section][indexPath.row]["fkAccTrxID"]!
                tercerViewController.Voucher = DateAccountInfo[indexPath.section][indexPath.row]["Voucher"]!
                tercerViewController.URLTicket = DateAccountInfo[indexPath.section][indexPath.row]["URLTicket"]!
                self.navigationController?.pushViewController(tercerViewController, animated: true)
            }
        
        if lastIndex != indexPath && lastIndex.count > 0{
            if (Double(String(format: "%.2f", (String(format: "%.2f0", (DateAccountInfo[lastIndex.section][lastIndex.row]["Amount"]! as NSString).floatValue) as NSString).floatValue))!) > 0{
                if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                    
                }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                    
                    tableView.cellForRow(at: indexPath)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("e4c29c"))
                    
                }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                    
                    tableView.cellForRow(at: indexPath)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("94cce5"))
                }
                
            }else{
                tableView.cellForRow(at: lastIndex)?.accessoryView = STKColorAccessoryView.init(color: UIColor.clear)
            }

        }
        
        lastIndex = indexPath
        
    }

    @IBAction func clickPayment(_ sender: AnyObject) {
      
        self.btnApply.isEnabled = false
        self.ViewItem.rightBarButtonItem?.isEnabled = false
        ynClickPay = true
        ynActualiza = true
        
        //if (self.Status != "OUT") {
            if Reachability.isConnectedToNetwork(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
                //////////////////////
                
                self.recargarTablas()
                
                //////////////////////

                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }else{
                RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
            }
        //}
        self.btnApply.isEnabled = true
        self.ViewItem.rightBarButtonItem?.isEnabled = true
    }

    @IBAction func clickAccount(_ sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func clickHome(_ sender: AnyObject) {
        //print(1)
        self.btnApply.isEnabled = false
        self.ViewItem.rightBarButtonItem?.isEnabled = false
        if !Reachability.isConnectedToNetwork(){
            RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
        }else{
            
            ynForceDelete = true
            ynActualiza = true
            recargarTablas()

        }
        self.btnApply.isEnabled = true
        self.ViewItem.rightBarButtonItem?.isEnabled = true
    }
    
    @objc func segmentedControlValueChanged(_ segmentedControl1: HMSegmentedControl){
        var Index: Int = 0
        var strPeopleFDeskID: String = ""
        let formatter = NumberFormatter()
        var fabsAmount: Double = 0
        var fabsTotalAmount: Double = 0
        var strFullName: String = ""
        
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        Index = segmentedControl1.selectedSegmentIndex
        
        strPeopleFDeskID = tblPeopleID[Index]

        if (strPeopleFDeskID==""){
            strPeopleFDeskID="0"
        }
        
        PeopleFDeskID = strPeopleFDeskID
        
        if Index==0
        {
            strPeopleFDeskID="0"
        }
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        var strQueryAux: String = ""
        
        if (strPeopleFDeskID=="0"){
            strQueryAux = "SELECT FullName FROM tblPerson WHERE StayInfoID = ?"
        }else{
            strQueryAux = "SELECT FullName FROM tblPerson WHERE StayInfoID = ? AND PeopleFDeskID =?"
        }
        
        queueFM?.inDatabase() {
            db in
            if let rs = db.executeQuery(strQueryAux, withArgumentsIn: [self.StayInfoID,self.PeopleFDeskID]){
                while rs.next() {
                    strFullName = strFullName + rs.string(forColumn: "FullName")! + ", "
                }
                if strFullName != ""{
                    let strpre: String = strFullName
                    
                    let start = strpre.index(strpre.startIndex, offsetBy: 0)
                    let end = strpre.index(strpre.endIndex, offsetBy: -2)
                    let range = start..<end
                    
                    let mySubstring = strpre[range]
                    
                    strFullName = String(mySubstring)
                }
            } else {
                print("select failure: \(db.lastErrorMessage())")
            }
        }
        
        var AccountInfo: [Dictionary<String, String>]
        var IndexAux: Int = 0
        var strQuery: String = ""
        
        if (self.PeopleFDeskID=="0"){
            strQuery = "SELECT * FROM tblAccount WHERE StayInfoID = ?"
        }else{
            strQuery = "SELECT * FROM tblAccount WHERE StayInfoID = ? AND PeopleFDeskID =?"
        }
        
        AccountInfo = []
        
        queueFM?.inDatabase() {
            db in
            
            if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID,self.PeopleFDeskID]){
                while rs.next() {
                    AccountInfo.append([:])
                    AccountInfo[IndexAux]["StayInfoID"] = rs.string(forColumn: "StayInfoID")!
                    AccountInfo[IndexAux]["DatabaseName"] = rs.string(forColumn: "DatabaseName")!
                    AccountInfo[IndexAux]["fkAccTrxID"] = rs.string(forColumn: "fkAccTrxID")!
                    AccountInfo[IndexAux]["Voucher"] = rs.string(forColumn: "Voucher")!
                    AccountInfo[IndexAux]["PlaceDesc"] = rs.string(forColumn: "PlaceDesc")!
                    AccountInfo[IndexAux]["Amount"] = rs.string(forColumn: "Amount")!
                    AccountInfo[IndexAux]["TrxDate"] = rs.string(forColumn: "TrxDate")!
                    AccountInfo[IndexAux]["PersonID"] = rs.string(forColumn: "PersonID")!
                    AccountInfo[IndexAux]["SubTotal"] = rs.string(forColumn: "SubTotal")!
                    AccountInfo[IndexAux]["Tips"] = rs.string(forColumn: "Tips")!
                    AccountInfo[IndexAux]["Cashier"] = rs.string(forColumn: "Cashier")!
                    AccountInfo[IndexAux]["TrxTypeCode"] = rs.string(forColumn: "TrxTypeCode")!
                    AccountInfo[IndexAux]["TrxTime"] = rs.string(forColumn: "TrxTime")!
                    AccountInfo[IndexAux]["PeopleFDeskID"] = rs.string(forColumn: "PeopleFDeskID")!
                    AccountInfo[IndexAux]["URLTicket"] = rs.string(forColumn: "URLTicket")!
                    IndexAux = IndexAux + 1
                }
            } else {
                print("select failure: \(db.lastErrorMessage())")
            }
            
        }
        
        self.tblAccountInfo = AccountInfo
        
        if (tblAccountInfo.count > 0){
            
            strQuery = ""
            
            if (self.PeopleFDeskID=="0"){
                strQuery = "SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ?"
            }else{
                strQuery = "SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ? AND PeopleFDeskID =?"
            }
            
            queueFM?.inDatabase() {
                db in
                
                if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID, self.PeopleFDeskID]){
                    while rs.next() {
                        self.fAmount = Double(String(format: "%.2f", (rs.string(forColumn: "Amount")! as NSString).floatValue))!
                    }
                } else {
                    print("select failure: \(db.lastErrorMessage())")
                }
                
            }
            
            strQuery = ""
            
            strQuery = "SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ?"
            
            queueFM?.inDatabase() {
                db in
                
                if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID, "0"]){
                    while rs.next() {
                        self.fTotalAmount = Double(String(format: "%.2f", (rs.string(forColumn: "Amount")! as NSString).floatValue))!
                    }
                } else {
                    print("select failure: \(db.lastErrorMessage())")
                }
                
            }
            
            strQuery = ""
            
            if (self.PeopleFDeskID=="0"){
                strQuery = "SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ?"
            }else{
                strQuery = "SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ? AND PeopleFDeskID =?"
            }
            
            queueFM?.inDatabase() {
                db in
                
                if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID, self.PeopleFDeskID]){
                    while rs.next() {
                        fabsAmount = Double(String(format: "%.2f", (rs.string(forColumn: "Amount")! as NSString).floatValue))!
                    }
                } else {
                    print("select failure: \(db.lastErrorMessage())")
                }
                
            }
            
            strQuery = ""
            
            strQuery = "SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ?"
            
            queueFM?.inDatabase() {
                db in
                
                if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID, "0"]){
                    while rs.next() {
                        fabsTotalAmount = Double(String(format: "%.2f", (rs.string(forColumn: "Amount")! as NSString).floatValue))!
                    }
                } else {
                    print("select failure: \(db.lastErrorMessage())")
                }
                
            }
            
            if (Status=="INHOUSE")&&(fTotalAmount<=0.01){
                btnApply.setTitle(NSLocalizedString("Checkout",comment:""), for: UIControl.State())
                
                if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                    
                    self.btnApply.setTitleColor(UIColor.white, for: UIControl.State())
                    self.btnApply.backgroundColor = UIColor.darkGray
                    self.btnApply.layer.borderWidth = 0.8
                    self.btnApply.layer.borderColor = UIColor.black.cgColor
                    
                }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                    
                    //self.btnApply.setTitleColor(self.colorWithHexString("ddf4ff"), forState: UIControlState.Normal)
                    //self.btnApply.backgroundColor = self.colorWithHexString("94cce5")
                    //self.btnApply.layer.borderWidth = 0.8
                    //self.btnApply.layer.borderColor = self.colorWithHexString("00467f").CGColor
                    self.btnApply.setTitleColor(self.colorWithHexString("ba8748"), for: UIControl.State())
                    self.btnApply.layer.borderWidth = 4
                    self.btnApply.layer.borderColor = self.colorWithHexString("7c6a56").cgColor
                    self.btnApply.backgroundColor = self.colorWithHexString("eee7dd")
                    
                }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                    
                    
                    //self.btnApply.setTitleColor(self.colorWithHexString("ddf4ff"), forState: UIControlState.Normal)
                    //self.btnApply.backgroundColor = self.colorWithHexString("94cce5")
                    //self.btnApply.layer.borderWidth = 0.8
                    //self.btnApply.layer.borderColor = self.colorWithHexString("00467f").CGColor
                    self.btnApply.setTitleColor(self.colorWithHexString("ffffff"), for: UIControl.State())
                    self.btnApply.layer.borderWidth = 4
                    self.btnApply.layer.borderColor = self.colorWithHexString("a18015").cgColor
                    self.btnApply.backgroundColor = self.colorWithHexString("c39b1a")
                }
                
                btnApply.frame = CGRect(x: 0.65*width, y: 0.3*height, width: 0.3*width, height: 0.04*height);
                lblAmount.text = "0.00 USD"
                self.lblAmount.isHidden = true
                
                if (strPeopleFDeskID=="0")
                {
                    hdrlabel2.text = NSLocalizedString("lblTotalAmount",comment:"") + String(format: "%.2f", (String(format: "%.2f0", (fabsTotalAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                }else
                {
                    hdrlabel2.text = NSLocalizedString("lblPersonAmount",comment:"") + strFullName + ":\n" + String(format: "%.2f", (String(format: "%.2f0", (fabsAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                }
                
                tableView.tableHeaderView = hdrlabel
                
                var strDate: [String]
                var DateAccountInfo: [[Dictionary<String, String>]]
                
                var CountAccountTot: Int32 = 0
                var CountTrx: Int = 0
                IndexAux = 0
                var CountTotTrx: Int = 0
                strQuery = ""
                var strQueryAcc: String = ""
                
                CountTotTrx = AccountInfo.count
                
                if (self.PeopleFDeskID=="0"){
                    strQuery = "SELECT COUNT(*) as CountAccountTot FROM (SELECT TrxDate FROM tblAccount WHERE StayInfoID = ? GROUP BY TrxDate)"
                }else{
                    strQuery = "SELECT COUNT(*) as CountAccountTot FROM (SELECT TrxDate FROM tblAccount WHERE StayInfoID = ? AND PeopleFDeskID =? GROUP BY TrxDate)"
                }
                
                queueFM?.inDatabase() {
                    db in
                    
                    if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID, self.PeopleFDeskID]){
                        while rs.next() {
                            CountAccountTot = rs.int(forColumn: "CountAccountTot")
                        }
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                    
                }
                
                DateAccountInfo = []
                strDate = [""]
                
                if (self.PeopleFDeskID=="0"){
                    strQueryAcc = "SELECT count(*) as CountTrx, TrxDate FROM tblAccount WHERE StayInfoID = ? GROUP BY TrxDate ORDER BY TrxDate DESC"
                }else{
                    strQueryAcc = "SELECT count(*) as CountTrx, TrxDate FROM tblAccount WHERE StayInfoID = ? AND PeopleFDeskID =? GROUP BY TrxDate ORDER BY TrxDate DESC"
                }
                
                queueFM?.inDatabase() {
                    db in
                    
                    if let rs = db.executeQuery(strQueryAcc, withArgumentsIn: [self.StayInfoID, self.PeopleFDeskID]){
                        while rs.next() {
                            if (IndexAux==0){
                                strDate[0] = rs.string(forColumn: "TrxDate")!
                                CountTrx = Int(rs.int(forColumn: "CountTrx"))
                                DateAccountInfo.append([])
                                for _ in 0...CountTrx-1 {
                                    DateAccountInfo[0].append([:])
                                }
                                
                            }else{
                                strDate.append(rs.string(forColumn: "TrxDate")!)
                                CountTrx = Int(rs.int(forColumn: "CountTrx"))
                                DateAccountInfo.append([])
                                for _ in 0...CountTrx-1 {
                                    DateAccountInfo[IndexAux].append([:])
                                }
                                
                            }
                            IndexAux = IndexAux + 1
                        }
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                    
                }
                
                let xCountStatus = Int(CountAccountTot)
                let xCountStays = Int(CountTotTrx)
                var sCount: Int = 0
                
                for xIndex in 0...xCountStatus-1 {
                    sCount = 0
                    for yIndex in 0...xCountStays-1 {
                        if (strDate[xIndex]==AccountInfo[yIndex]["TrxDate"]){
                            DateAccountInfo[xIndex][sCount] = AccountInfo[yIndex]
                            sCount = sCount + 1
                        }
                        
                    }
                    
                }
                
                self.DateAccountInfo = DateAccountInfo
                
                CountGroupTrx = DateAccountInfo.count
                
            }else{
                
                if (Status=="OUT")&&(fTotalAmount<=0.01){
                    self.btnApply.setTitle(NSLocalizedString("Checkout",comment:""), for: UIControl.State())
                    self.btnApply.titleLabel?.font = UIFont(name: "Helvetica", size: self.appDelegate.gblFont5 + self.appDelegate.gblDeviceFont4)
                    if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                        
                        self.btnApply.setTitleColor(UIColor.white, for: UIControl.State())
                        self.btnApply.backgroundColor = UIColor.darkGray
                        self.btnApply.layer.borderWidth = 0.8
                        self.btnApply.layer.borderColor = UIColor.black.cgColor
                        
                    }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                        
                        //self.btnApply.setTitleColor(self.colorWithHexString("ddf4ff"), forState: UIControlState.Normal)
                        //self.btnApply.backgroundColor = self.colorWithHexString("94cce5")
                        //self.btnApply.layer.borderWidth = 0.8
                        //self.btnApply.layer.borderColor = self.colorWithHexString("00467f").CGColor
                        self.btnApply.setTitleColor(self.colorWithHexString("ba8748"), for: UIControl.State())
                        self.btnApply.layer.borderWidth = 4
                        self.btnApply.layer.borderColor = self.colorWithHexString("7c6a56").cgColor
                        self.btnApply.backgroundColor = self.colorWithHexString("eee7dd")
                        
                    }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                        
                        
                        //self.btnApply.setTitleColor(self.colorWithHexString("ddf4ff"), forState: UIControlState.Normal)
                        //self.btnApply.backgroundColor = self.colorWithHexString("94cce5")
                        //self.btnApply.layer.borderWidth = 0.8
                        //self.btnApply.layer.borderColor = self.colorWithHexString("00467f").CGColor
                        self.btnApply.setTitleColor(self.colorWithHexString("ffffff"), for: UIControl.State())
                        self.btnApply.layer.borderWidth = 4
                        self.btnApply.layer.borderColor = self.colorWithHexString("a18015").cgColor
                        self.btnApply.backgroundColor = self.colorWithHexString("c39b1a")
                    }
                    self.btnApply.frame = CGRect(x: 0.65*self.width, y: 0.3*self.height, width: 0.3*self.width, height: 0.04*self.height);
                    self.lblAmount.text = "0.00 USD"
                    self.lblAmount.isHidden = true
                    self.hdrlabel2.text = NSLocalizedString("lblTotalAmount",comment:"") + String(format: "%.2f", (String(format: "%.2f0", (self.fTotalAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                    
                    self.tableView.tableHeaderView = self.hdrlabel
                    
                    if (self.Stays["ynPostCheckout"]==nil){
                        self.btnApply.isEnabled = true
                        self.btnCheckOutSlip.isHidden = true
                        self.btnApply.isHidden = false
                    }else{
                        if (self.Stays["ynPostCheckout"]!=="1"){
                            self.btnApply.isEnabled = false
                            if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                                self.btnCheckOutSlip.isHidden = true
                            }else{
                                self.btnCheckOutSlip.isHidden = false
                            }
                            self.btnApply.isHidden = true
                        }else{
                            self.btnApply.isEnabled = true
                            self.btnCheckOutSlip.isHidden = true
                            self.btnApply.isHidden = false
                        }
                    }
                    
                    if (strPeopleFDeskID=="0")
                    {
                        hdrlabel2.text = NSLocalizedString("lblTotalAmount",comment:"") + String(format: "%.2f", (String(format: "%.2f0", (fabsTotalAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                    }else
                    {
                        hdrlabel2.text = NSLocalizedString("lblPersonAmount",comment:"") + strFullName + ":\n" + String(format: "%.2f", (String(format: "%.2f0", (fabsAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                    }
                    
                    tableView.tableHeaderView = hdrlabel
                    
                    var strDate: [String]
                    var DateAccountInfo: [[Dictionary<String, String>]]
                    
                    var CountAccountTot: Int32 = 0
                    var CountTrx: Int = 0
                    IndexAux = 0
                    var CountTotTrx: Int = 0
                    strQuery = ""
                    var strQueryAcc: String = ""
                    
                    CountTotTrx = AccountInfo.count
                    
                    if (self.PeopleFDeskID=="0"){
                        strQuery = "SELECT COUNT(*) as CountAccountTot FROM (SELECT TrxDate FROM tblAccount WHERE StayInfoID = ? GROUP BY TrxDate)"
                    }else{
                        strQuery = "SELECT COUNT(*) as CountAccountTot FROM (SELECT TrxDate FROM tblAccount WHERE StayInfoID = ? AND PeopleFDeskID =? GROUP BY TrxDate)"
                    }
                    
                    queueFM?.inDatabase() {
                        db in
                        
                        if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID, self.PeopleFDeskID]){
                            while rs.next() {
                                CountAccountTot = rs.int(forColumn: "CountAccountTot")
                            }
                        } else {
                            print("select failure: \(db.lastErrorMessage())")
                        }
                        
                    }
                    
                    DateAccountInfo = []
                    strDate = [""]
                    
                    if (self.PeopleFDeskID=="0"){
                        strQueryAcc = "SELECT count(*) as CountTrx, TrxDate FROM tblAccount WHERE StayInfoID = ? GROUP BY TrxDate ORDER BY TrxDate DESC"
                    }else{
                        strQueryAcc = "SELECT count(*) as CountTrx, TrxDate FROM tblAccount WHERE StayInfoID = ? AND PeopleFDeskID =? GROUP BY TrxDate ORDER BY TrxDate DESC"
                    }
                    
                    queueFM?.inDatabase() {
                        db in
                        
                        if let rs = db.executeQuery(strQueryAcc, withArgumentsIn: [self.StayInfoID, self.PeopleFDeskID]){
                            while rs.next() {
                                if (IndexAux==0){
                                    strDate[0] = rs.string(forColumn: "TrxDate")!
                                    CountTrx = Int(rs.int(forColumn: "CountTrx"))
                                    DateAccountInfo.append([])
                                    for _ in 0...CountTrx-1 {
                                        DateAccountInfo[0].append([:])
                                    }
                                    
                                }else{
                                    strDate.append(rs.string(forColumn: "TrxDate")!)
                                    CountTrx = Int(rs.int(forColumn: "CountTrx"))
                                    DateAccountInfo.append([])
                                    for _ in 0...CountTrx-1 {
                                        DateAccountInfo[IndexAux].append([:])
                                    }
                                    
                                }
                                IndexAux = IndexAux + 1
                            }
                        } else {
                            print("select failure: \(db.lastErrorMessage())")
                        }
                        
                    }
                    
                    let xCountStatus = Int(CountAccountTot)
                    let xCountStays = Int(CountTotTrx)
                    var sCount: Int = 0
                    
                    for xIndex in 0...xCountStatus-1 {
                        sCount = 0
                        for yIndex in 0...xCountStays-1 {
                            if (strDate[xIndex]==AccountInfo[yIndex]["TrxDate"]){
                                DateAccountInfo[xIndex][sCount] = AccountInfo[yIndex]
                                sCount = sCount + 1
                            }
                            
                        }
                        
                    }
                    
                    self.DateAccountInfo = DateAccountInfo
                    
                    CountGroupTrx = DateAccountInfo.count
                    
                }else{
                    str = String(format: "%.2f", (String(format: "%.2f0", (fAmount.description as NSString).floatValue) as NSString).floatValue)
                    
                    strAmountPay = NSLocalizedString("Pay",comment:"") + " " + str + " " + self.Stays["fkCurrencyID"]!
                    
                    strDinamicMonto = strAmountPay
                    length = strDinamicMonto.characters.count
                    if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                        
                        btnApply.setTitleColor(colorWithHexString("00467f"), for: UIControl.State())
                        
                    }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                        
                        self.btnApply.setTitleColor(self.colorWithHexString("ba8748"), for: UIControl.State())
                        
                    }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{

                        self.btnApply.setTitleColor(self.colorWithHexString("ffffff"), for: UIControl.State())

                    }
                    
                    btnApply.frame = CGRect(x: 0.05*width, y: 0.3*height, width: (CGFloat(length)*0.025)*width, height: 0.04*height);
                    btnApply.setTitle(strAmountPay, for: UIControl.State())
                    
                    if (fAmount>0.1){
                        
                        str = String(format: "%.2f", (String(format: "%.2f0", ((fAmount/fDollar).description as NSString).floatValue) as NSString).floatValue)
                        
                        lblAmount.text = str + " USD"
                        
                        btnApply.isEnabled = true
                        
                    }else{
                        lblAmount.text = "0.00 USD"
                    }
                    
                    if (strPeopleFDeskID=="0")
                    {
                        hdrlabel2.text = NSLocalizedString("lblTotalAmount",comment:"") + String(format: "%.2f", (String(format: "%.2f0", (fabsTotalAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                    }else
                    {
                        hdrlabel2.text = NSLocalizedString("lblPersonAmount",comment:"") + strFullName + ":\n" + String(format: "%.2f", (String(format: "%.2f0", (fabsAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                    }
                    
                    tableView.tableHeaderView = hdrlabel
                    
                    var strDate: [String]
                    var DateAccountInfo: [[Dictionary<String, String>]]
                    
                    var CountAccountTot: Int32 = 0
                    var CountTrx: Int = 0
                    IndexAux = 0
                    var CountTotTrx: Int = 0
                    strQuery = ""
                    var strQueryAcc: String = ""
                    
                    CountTotTrx = AccountInfo.count
                    
                    if (self.PeopleFDeskID=="0"){
                        strQuery = "SELECT COUNT(*) as CountAccountTot FROM (SELECT TrxDate FROM tblAccount WHERE StayInfoID = ? GROUP BY TrxDate)"
                    }else{
                        strQuery = "SELECT COUNT(*) as CountAccountTot FROM (SELECT TrxDate FROM tblAccount WHERE StayInfoID = ? AND PeopleFDeskID =? GROUP BY TrxDate)"
                    }
                    
                    queueFM?.inDatabase() {
                        db in
                        
                        if let rs = db.executeQuery(strQuery, withArgumentsIn: [self.StayInfoID, self.PeopleFDeskID]){
                            while rs.next() {
                                CountAccountTot = rs.int(forColumn: "CountAccountTot")
                            }
                        } else {
                            print("select failure: \(db.lastErrorMessage())")
                        }
                        
                    }
                    
                    DateAccountInfo = []
                    strDate = [""]
                    
                    if (self.PeopleFDeskID=="0"){
                        strQueryAcc = "SELECT count(*) as CountTrx, TrxDate FROM tblAccount WHERE StayInfoID = ? GROUP BY TrxDate ORDER BY TrxDate DESC"
                    }else{
                        strQueryAcc = "SELECT count(*) as CountTrx, TrxDate FROM tblAccount WHERE StayInfoID = ? AND PeopleFDeskID =? GROUP BY TrxDate ORDER BY TrxDate DESC"
                    }
                    
                    queueFM?.inDatabase() {
                        db in
                        
                        if let rs = db.executeQuery(strQueryAcc, withArgumentsIn: [self.StayInfoID, self.PeopleFDeskID]){
                            while rs.next() {
                                if (IndexAux==0){
                                    strDate[0] = rs.string(forColumn: "TrxDate")!
                                    CountTrx = Int(rs.int(forColumn: "CountTrx"))
                                    DateAccountInfo.append([])
                                    for _ in 0...CountTrx-1 {
                                        DateAccountInfo[0].append([:])
                                    }
                                    
                                }else{
                                    strDate.append(rs.string(forColumn: "TrxDate")!)
                                    CountTrx = Int(rs.int(forColumn: "CountTrx"))
                                    DateAccountInfo.append([])
                                    for _ in 0...CountTrx-1 {
                                        DateAccountInfo[IndexAux].append([:])
                                    }
                                    
                                }
                                IndexAux = IndexAux + 1
                            }
                        } else {
                            print("select failure: \(db.lastErrorMessage())")
                        }
                        
                    }
                    
                    let xCountStatus = Int(CountAccountTot)
                    let xCountStays = Int(CountTotTrx)
                    var sCount: Int = 0
                    
                    for xIndex in 0...xCountStatus-1 {
                        sCount = 0
                        for yIndex in 0...xCountStays-1 {
                            if (strDate[xIndex]==AccountInfo[yIndex]["TrxDate"]){
                                DateAccountInfo[xIndex][sCount] = AccountInfo[yIndex]
                                sCount = sCount + 1
                            }
                            
                        }
                        
                    }
                    
                    self.DateAccountInfo = DateAccountInfo
                    
                    CountGroupTrx = DateAccountInfo.count
                }
                
            }
            
            self.tableView.reloadData()
            
        }else{
            
                if (Status=="INHOUSE")&&(fTotalAmount<=0.01){
                    btnApply.setTitle(NSLocalizedString("Checkout",comment:""), for: UIControl.State())
                    if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                        
                        self.btnApply.setTitleColor(UIColor.white, for: UIControl.State())
                        self.btnApply.backgroundColor = UIColor.darkGray
                        self.btnApply.layer.borderWidth = 0.8
                        self.btnApply.layer.borderColor = UIColor.black.cgColor
                        
                    }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                        
                        //self.btnApply.setTitleColor(self.colorWithHexString("ddf4ff"), forState: UIControlState.Normal)
                        //self.btnApply.backgroundColor = self.colorWithHexString("94cce5")
                        //self.btnApply.layer.borderWidth = 0.8
                        //self.btnApply.layer.borderColor = self.colorWithHexString("00467f").CGColor
                        self.btnApply.setTitleColor(self.colorWithHexString("ba8748"), for: UIControl.State())
                        self.btnApply.layer.borderWidth = 4
                        self.btnApply.layer.borderColor = self.colorWithHexString("7c6a56").cgColor
                        self.btnApply.backgroundColor = self.colorWithHexString("eee7dd")
                        
                    }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                        
                        
                        //self.btnApply.setTitleColor(self.colorWithHexString("ddf4ff"), forState: UIControlState.Normal)
                        //self.btnApply.backgroundColor = self.colorWithHexString("94cce5")
                        //self.btnApply.layer.borderWidth = 0.8
                        //self.btnApply.layer.borderColor = self.colorWithHexString("00467f").CGColor
                        self.btnApply.setTitleColor(self.colorWithHexString("ffffff"), for: UIControl.State())
                        self.btnApply.layer.borderWidth = 4
                        self.btnApply.layer.borderColor = self.colorWithHexString("a18015").cgColor
                        self.btnApply.backgroundColor = self.colorWithHexString("c39b1a")
                    }
                    btnApply.frame = CGRect(x: 0.65*width, y: 0.3*height, width: 0.3*width, height: 0.04*height);
                    lblAmount.text = "0.00 USD"
                    self.lblAmount.isHidden = true
                    CountGroupTrx = 0
                    
                    if (strPeopleFDeskID=="0")
                    {
                        hdrlabel2.text = NSLocalizedString("lblTotalAmount",comment:"") + String(format: "%.2f", (String(format: "%.2f0", (fabsTotalAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                    }else
                    {
                        hdrlabel2.text = NSLocalizedString("lblPersonAmount",comment:"") + strFullName + ":\n" + String(format: "%.2f", (String(format: "%.2f0", (fabsAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                    }
                    
                    tableView.tableHeaderView = hdrlabel
                    
                    self.tableView.reloadData()
                
                }else{
            
                    /*tblAccountInfo = nil
                    DateAccountInfo = nil
                    strDinamicMonto = NSLocalizedString("Pay",comment:"") + " 0.00"
                    length = strDinamicMonto.characters.count
                    btnApply.frame = CGRectMake(0.628*width, 0.25*height, (CGFloat(length)*0.025)*width, 0.04*height);
                    btnApply.setTitle(NSLocalizedString("Pay",comment:"") + " 0.00", forState: UIControlState.Normal)
                    btnApply.enabled = true
                    btnApply.setTitleColor(colorWithHexString("0080FF"), forState: UIControlState.Normal)
                    lblAmount.text = "0.00 USD"
                    CountGroupTrx = 0
                    self.lblAmount.hidden = true
                    hdrlabel2.text = NSLocalizedString("lblPersonAmount",comment:"") + strFullName + ":\n 0.00" ;
                
                    tableView.tableHeaderView = hdrlabel
                    
                    if ((Status=="OUT")){
                        self.btnApply.enabled = false
                    }else{
                        self.btnApply.enabled = true
                    }*/
                    
                    if (Status=="OUT")&&(fTotalAmount<=0.01){
                        self.btnApply.setTitle(NSLocalizedString("Checkout",comment:""), for: UIControl.State())
                        self.btnApply.titleLabel?.font = UIFont(name: "Helvetica", size: self.appDelegate.gblFont5 + self.appDelegate.gblDeviceFont4)
                        if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                            
                            self.btnApply.setTitleColor(UIColor.white, for: UIControl.State())
                            self.btnApply.backgroundColor = UIColor.darkGray
                            self.btnApply.layer.borderWidth = 0.8
                            self.btnApply.layer.borderColor = UIColor.black.cgColor
                            
                        }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                            
                            //self.btnApply.setTitleColor(self.colorWithHexString("ddf4ff"), forState: UIControlState.Normal)
                            //self.btnApply.backgroundColor = self.colorWithHexString("94cce5")
                            //self.btnApply.layer.borderWidth = 0.8
                            //self.btnApply.layer.borderColor = self.colorWithHexString("00467f").CGColor
                            self.btnApply.setTitleColor(self.colorWithHexString("ba8748"), for: UIControl.State())
                            self.btnApply.layer.borderWidth = 4
                            self.btnApply.layer.borderColor = self.colorWithHexString("7c6a56").cgColor
                            self.btnApply.backgroundColor = self.colorWithHexString("eee7dd")
                            
                        }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                            
                            
                            //self.btnApply.setTitleColor(self.colorWithHexString("ddf4ff"), forState: UIControlState.Normal)
                            //self.btnApply.backgroundColor = self.colorWithHexString("94cce5")
                            //self.btnApply.layer.borderWidth = 0.8
                            //self.btnApply.layer.borderColor = self.colorWithHexString("00467f").CGColor
                            self.btnApply.setTitleColor(self.colorWithHexString("ffffff"), for: UIControl.State())
                            self.btnApply.layer.borderWidth = 4
                            self.btnApply.layer.borderColor = self.colorWithHexString("a18015").cgColor
                            self.btnApply.backgroundColor = self.colorWithHexString("c39b1a")
                        }
                        self.btnApply.frame = CGRect(x: 0.65*width, y: 0.3*height, width: 0.3*width, height: 0.04*height);
                        self.lblAmount.text = "0.00 USD"
                        self.lblAmount.isHidden = true
                        
                        if (strPeopleFDeskID=="0")
                        {
                            hdrlabel2.text = NSLocalizedString("lblTotalAmount",comment:"") + String(format: "%.2f", (String(format: "%.2f0", (fabsTotalAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                        }else
                        {
                            hdrlabel2.text = NSLocalizedString("lblPersonAmount",comment:"") + strFullName + ":\n" + String(format: "%.2f", (String(format: "%.2f0", (fabsAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                        }
                        
                        CountGroupTrx = 0
                        
                        self.tableView.tableHeaderView = self.hdrlabel
                        
                        if (self.Stays["ynPostCheckout"]==nil){
                            self.btnApply.isEnabled = true
                            self.btnCheckOutSlip.isHidden = true
                            self.btnApply.isHidden = false
                        }else{
                            if (self.Stays["ynPostCheckout"]!=="1"){
                                self.btnApply.isEnabled = false
                                if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                                    self.btnCheckOutSlip.isHidden = true
                                }else{
                                    self.btnCheckOutSlip.isHidden = false
                                }
                                self.btnApply.isHidden = true
                            }else{
                                self.btnApply.isEnabled = true
                                self.btnCheckOutSlip.isHidden = true
                                self.btnApply.isHidden = false
                            }
                        }
                        
                        if ((Status=="OUT")){
                            self.btnApply.isEnabled = false
                        }else{
                            self.btnApply.isEnabled = true
                        }
                        
                    }else{
                    
                        tblAccountInfo = nil
                        DateAccountInfo = nil
                        strDinamicMonto = NSLocalizedString("Pay",comment:"") + " 0.00 " + self.Stays["fkCurrencyID"]!
                        length = strDinamicMonto.characters.count
                        btnApply.setTitle(NSLocalizedString("Pay",comment:"") + " 0.00 " + self.Stays["fkCurrencyID"]!, for: UIControl.State())
                        btnApply.isEnabled = true
                        if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                            
                            btnApply.setTitleColor(colorWithHexString("00467f"), for: UIControl.State())
                            
                        }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                            
                            self.btnApply.setTitleColor(self.colorWithHexString("ba8748"), for: UIControl.State())
                            
                        }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                            
                            self.btnApply.setTitleColor(self.colorWithHexString("ffffff"), for: UIControl.State())
                            
                        }
                        lblAmount.text = "0.00 " + self.Stays["fkCurrencyID"]!
                        CountGroupTrx = 0
                        self.lblAmount.isHidden = true
                        
                        if (strPeopleFDeskID=="0")
                        {
                            hdrlabel2.text = NSLocalizedString("lblTotalAmount",comment:"") + String(format: "%.2f", (String(format: "%.2f0", (fabsTotalAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                        }else
                        {
                            hdrlabel2.text = NSLocalizedString("lblPersonAmount",comment:"") + strFullName + ":\n" + String(format: "%.2f", (String(format: "%.2f0", (fabsAmount.description as NSString).floatValue) as NSString).floatValue) + " " + self.Stays["fkCurrencyID"]!;
                        }
                        
                        tableView.tableHeaderView = hdrlabel
                        
                        if ((Status=="OUT")){
                            self.btnApply.isEnabled = false
                        }else{
                            self.btnApply.isEnabled = true
                        }
                    
                    }
                    
                    self.tableView.reloadData()
                }

            }
        
        let todaysDate:Date = Date()
        let dtdateFormatter:DateFormatter = DateFormatter()
        dtdateFormatter.dateFormat = "yyyy-MM-dd"
        let DateInFormat:String = dtdateFormatter.string(from: todaysDate)
        
        let endDate = moment(DateInFormat)
        let DepartureDate = moment(self.Stays["DepartureDate"]!)
        
        if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            /*if endDate > DepartureDate{
                self.btnApply.isHidden = true
                self.btnCheckOutSlip.isHidden = true
                self.btnPayment.isHidden = true
                self.lblAmount.isHidden = true
            }*/
        }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            if endDate > DepartureDate{
                self.btnApply.isHidden = true
                self.btnCheckOutSlip.isHidden = true
                self.btnPayment.isHidden = true
                self.lblAmount.isHidden = true
            }
            
        }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            if endDate > DepartureDate{
                self.btnApply.isHidden = true
                self.btnCheckOutSlip.isHidden = true
                self.btnPayment.isHidden = true
                self.lblAmount.isHidden = true
            }
        }

    
    }
    
    @objc func clickCheckOutSlip(_ sender: AnyObject) {
        
        var numPerson: String = ""
        
        if tblPerson == nil{
            numPerson = "0"
        }else{
            numPerson = tblPerson.count.description
        }
        
        if appDelegate.strCheckOutTimeAux != ""{

            appDelegate.strCheckOutTime = appDelegate.strCheckOutTimeAux
            appDelegate.strCheckOutDate = appDelegate.strCheckOutDateAux
            
        }
        
        let viewController: vcCheckOutSlip = vcCheckOutSlip()
        viewController.strDate = appDelegate.strCheckOutDate
        viewController.strOutDate = appDelegate.strCheckOutTime
        viewController.strUnitCode = Stays["UnitCode"]!
        viewController.strName = FullName
        viewController.strNumPerson = numPerson
        viewController.StayInfoID = StayInfoID
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }

}

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}
