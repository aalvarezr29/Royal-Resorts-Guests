//
//  vcGuestPreCheckin.swift
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
  

class vcGuestPreCheckin: UIViewController , UITableViewDelegate, UITableViewDataSource{

    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var fSizeFont: CGFloat = 0
    
    //Parametro de entrada
    var StayInfoID: String = ""
    
    var Stays: Dictionary<String, String>!
    var tblPersonInfo: Dictionary<String, String>!
    var tblPersonInfoAux: [Dictionary<String, String>]!
    var tblPersonAIAux: Dictionary<String, String>!
    var tblPersonAI: [Dictionary<String, String>]!
    var tblPersonRangeAux: Dictionary<String, String>!
    var tblPersonRange: [Dictionary<String, String>]!
    
    //Variable global para pasar a vcGuestPeopleEdit.swift
    var PeopleFromCRDID: String = ""
    var StayInfoIDAux: String = ""
    
    var ynConn:Bool=false
    var ynPreRegisterAvailableForm:Bool=false
    var NumOfPeopleForStay: String = ""
    var iTotalPeople: Int = 0
    var width: CGFloat!
    var height: CGFloat!
    var tblPeopleID: [String]!
    var countMaxPeopleAvail: Int = 0
    var tblStayInfo: Dictionary<String, String>!
    var PrimAgeCFG: Int=0
    var strArrivalDate: String = ""
    var strDepartureDate: String = ""
    var lblPreregister = UILabel()
    var lblPreregisterText = UILabel()
    var ynActualiza: Bool = false
    var strStayType: String = ""
    var strPeoplePrimary: String = ""
    var strPeopleType: String = ""
    let app = UIApplication.shared
    var ynValiddate: Bool = false
    var imgCell = UIImage()
    var imgvwCell = UIImageView()
    var lastIndex = IndexPath()
    var PeopleAI: Dictionary<String, String>!
    var dtStayArrivalDate: Date = Date()
    var dtStayDepartureDate: Date = Date()
    
    @IBOutlet var bodyView: UIView!
    @IBOutlet weak var userView1: UIView!
    @IBOutlet weak var userView2: UIView!
    
    
    @IBOutlet weak var lblResort1: UILabel!
    @IBOutlet weak var lblView1: UILabel!
    @IBOutlet weak var lblDates1: UILabel!
    
    @IBOutlet weak var lblResortText: UILabel!
    @IBOutlet weak var lblViewText: UILabel!
    @IBOutlet weak var lblDatesText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblPreArrival: UILabel!
    
    @IBOutlet weak var lblNota: UILabel!
    @IBOutlet weak var tableView: UITableView!
    

    @IBOutlet var ViewItem: UINavigationItem!
    
    var btnBack = UIButton()
    var btnAddPeople = UIButton()
    
    var tblStay: [Dictionary<String, String>]!
    var StaysStatus: [[Dictionary<String, String>]]!
    var CountStay: Int32 = 0
    var ynAdd: Bool = false
    var ynRemove: Bool = false
    var ynEdit: Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var DataStays = [String:String]()
        var resultStayID: Int32 = 0
        var Index: Int = 0
        
        width = appDelegate.width
        height = appDelegate.height
        
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        
        bodyView.frame = CGRect(x: 0.0, y: 44, width: width, height: height);

        userView2.frame = CGRect(x: 0.05*width, y: 0.0*height, width: 0.905*width, height: 0.12*height);
        lblResort1.textAlignment = NSTextAlignment.right
        lblResort1.frame = CGRect(x: 0.15*width, y: 0.02*height, width: 0.25*width, height: 0.03*height);
        //lblView1.textAlignment = NSTextAlignment.right
        //lblView1.frame = CGRect(x: 0.15*width, y: 0.05*height, width: 0.25*width, height: 0.03*height);
        lblDates1.textAlignment = NSTextAlignment.right
        lblDates1.frame = CGRect(x: 0.15*width, y: 0.05*height, width: 0.25*width, height: 0.03*height);
            
        lblResortText.numberOfLines = 0
        lblResortText.frame = CGRect(x: 0.45*width, y: 0.02*height, width: 0.45*width, height: 0.03*height);
        //lblViewText.numberOfLines = 0
        //lblViewText.frame = CGRect(x: 0.45*width, y: 0.05*height, width: 0.45*width, height: 0.03*height);
        lblDatesText.numberOfLines = 0
        lblDatesText.frame = CGRect(x: 0.45*width, y: 0.05*height, width: 0.45*width, height: 0.03*height);
        lblPreArrival.numberOfLines = 0
        lblPreArrival.frame = CGRect(x: 0.45*width, y: 0.08*height, width: 0.45*width, height: 0.03*height);
        
        lblView1.removeFromSuperview()
        lblViewText.removeFromSuperview()
        
        if appDelegate.ynIPad {
            switch appDelegate.Model {
            case "iPad 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.45*height);
            case "iPad Air":
                tableView.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.45*height);
            case "iPad Air 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.45*height);
            case "iPad Pro":
                tableView.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.45*height);
            case "iPad Retina":
                tableView.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.45*height);
            default:
                tableView.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.45*height);
            }
        }else{
            switch appDelegate.Model {
            case "iPhone":
                tableView.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.37*height);
                imageView.frame = CGRect(x: 0.03*width, y: 0.0*height, width: 0.23*width, height: 0.12*height);
                userView1.frame = CGRect(x: 0.00*width, y: 0.102*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 4":
                tableView.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.37*height);
                imageView.frame = CGRect(x: 0.03*width, y: 0.0*height, width: 0.23*width, height: 0.12*height);
                userView1.frame = CGRect(x: 0.00*width, y: 0.102*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 4s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.37*height);
                imageView.frame = CGRect(x: 0.03*width, y: 0.0*height, width: 0.23*width, height: 0.12*height);
                userView1.frame = CGRect(x: 0.00*width, y: 0.102*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 5":
                tableView.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.39*height);
                imageView.frame = CGRect(x: 0.03*width, y: 0.0*height, width: 0.23*width, height: 0.12*height);
                userView1.frame = CGRect(x: 0.00*width, y: 0.102*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 5c":
                tableView.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.39*height);
                imageView.frame = CGRect(x: 0.03*width, y: 0.0*height, width: 0.23*width, height: 0.12*height);
                userView1.frame = CGRect(x: 0.00*width, y: 0.102*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 5s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.39*height);
                imageView.frame = CGRect(x: 0.03*width, y: 0.0*height, width: 0.23*width, height: 0.12*height);
                userView1.frame = CGRect(x: 0.00*width, y: 0.102*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 6":
                tableView.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.42*height);
                imageView.frame = CGRect(x: 0.03*width, y: 0.0*height, width: 0.23*width, height: 0.12*height);
                userView1.frame = CGRect(x: 0.00*width, y: 0.102*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 6 Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.42*height);
                imageView.frame = CGRect(x: 0.03*width, y: 0.0*height, width: 0.23*width, height: 0.12*height);
                userView1.frame = CGRect(x: 0.00*width, y: 0.102*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 6s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.42*height);
                imageView.frame = CGRect(x: 0.03*width, y: 0.0*height, width: 0.23*width, height: 0.12*height);
                userView1.frame = CGRect(x: 0.00*width, y: 0.102*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 6s Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.42*height);
                imageView.frame = CGRect(x: 0.03*width, y: 0.0*height, width: 0.23*width, height: 0.12*height);
                userView1.frame = CGRect(x: 0.00*width, y: 0.102*height, width: 0.9*width, height: 0.15*height);
            default:
                tableView.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.37*height);
                imageView.frame = CGRect(x: 0.03*width, y: 0.0*height, width: 0.23*width, height: 0.12*height);
                userView1.frame = CGRect(x: 0.00*width, y: 0.102*height, width: 0.9*width, height: 0.15*height);
            }
        }
        
        //Boton Refresh
        ViewItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(vcGuestPreCheckin.clickAdd(_:)))
        
        if self.appDelegate.strPeopleType != "MEMBER"{
            //Titulo de la vista
            ViewItem.title = NSLocalizedString("TitlePreArrival",comment:"")
        }else{
            //Titulo de la vista
            ViewItem.title = NSLocalizedString("lblMember",comment:"")
        }
        
        lblNota.frame = CGRect(x: 0.05*width, y: 0.15*height, width: 0.9*width, height: 0.2*height);
        
        //FONT
        lblNota.font = UIFont(name:"Helvetica", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
        lblNota.textAlignment = NSTextAlignment.center
        lblNota.adjustsFontSizeToFitWidth = true

        //Obtenemos los datos, para despues asignarlos
        
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
                }
            } else {
                print("select failure: \(db.lastErrorMessage())")
            }
            
        }
        
        self.Stays = StaysAux
        
        if self.Stays.count == 0{
            self.appDelegate.gblCheckOUT = true
            self.navigationController?.popViewController(animated: true)
        }else{
        
            lblResort1.text = NSLocalizedString("Resort",comment:"")
            lblView1.text = NSLocalizedString("View",comment:"")
            lblDates1.text = NSLocalizedString("Dates",comment:"")
            
            lblResort1.textColor = UIColor.black
            lblView1.textColor = UIColor.black
            lblDates1.textColor = UIColor.black
            lblPreArrival.textColor = UIColor.black
            
            lblResort1.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblView1.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblDates1.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            lblResortText.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblViewText.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblDatesText.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblPreArrival.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            
            lblResortText.textColor = UIColor.black
            lblViewText.textColor = UIColor.black
            lblDatesText.textColor = UIColor.black
            lblResortText.adjustsFontSizeToFitWidth = true
            lblViewText.adjustsFontSizeToFitWidth = true
            lblDatesText.adjustsFontSizeToFitWidth = true
            
            lblPreregister.frame = CGRect(x: 0.15*width, y: 0.08*height, width: 0.25*width, height: 0.03*height)
            lblPreregister.backgroundColor = UIColor.clear;
            lblPreregister.textAlignment = NSTextAlignment.right;
            lblPreregister.textColor = UIColor.black
            lblPreregister.numberOfLines = 1;
            lblPreregister.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblPreregister.text = NSLocalizedString("lblPreregister",comment:"")
            
            lblPreregisterText.frame = CGRect(x: 0.45*width, y: 0.08*height, width: 0.45*width, height: 0.03*height)
            lblPreregisterText.backgroundColor = UIColor.clear;
            lblPreregisterText.textAlignment = NSTextAlignment.left;
            lblPreregisterText.textColor = UIColor.black
            lblPreregisterText.numberOfLines = 1;
            lblPreregisterText.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblPreregisterText.text = ""
            lblPreregisterText.adjustsFontSizeToFitWidth = true
            
            userView2.addSubview(lblPreregister)
            userView2.addSubview(lblPreregisterText)
            
            strArrivalDate = ""
            strDepartureDate = ""
            
            let strdateFormatter = DateFormatter()
            strdateFormatter.dateFormat = "yyyy-MM-dd";
            
            let ArrivalDate = moment(Stays["ArrivalDate"]!)
            let DepartureDate = moment(Stays["DepartureDate"]!)
   
            strArrivalDate = strdateFormatter.string(from: ArrivalDate!.date)
            strDepartureDate = strdateFormatter.string(from: DepartureDate!.date)
            
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateStr = dateFormatter.string(from: ArrivalDate!.date)
            
            let strArrivalDateAux = dateStr + " 12:00 PM"
            
            dateFormatter.dateFormat = "yyyy/MM/dd h:mm a"
            
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            dtStayArrivalDate = dateFormatter.date(from: strArrivalDateAux)!
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let DepdateStr = dateFormatter.string(from: DepartureDate!.date)
            
            let strDepartureDateAux = DepdateStr + " 12:00 PM"
            
            dateFormatter.dateFormat = "yyyy/MM/dd h:mm a"
            
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            dtStayDepartureDate = dateFormatter.date(from: strDepartureDateAux)!
            
            lblResortText.text = Stays["PropertyName"]!
            lblViewText.text = Stays["UnitViewDesc"]!
            lblDatesText.text = NSLocalizedString("lblStayfrom",comment:"") + strArrivalDate + NSLocalizedString("lblStayto",comment:"") + strDepartureDate

            cargarDatos()
        
        }
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            imageView.isHidden = true
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            userView2.backgroundColor = UIColor.clear
            userView2.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.11*height);
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            //userView2.backgroundColor = colorWithHexString ("DDF4FF")
            //tableView.backgroundColor = colorWithHexString ("DDF4FF")
            //userView1.backgroundColor = colorWithHexString ("DDF4FF")
            
            userView2.backgroundColor = UIColor.white
            tableView.backgroundColor = UIColor.white
            userView1.backgroundColor = UIColor.white
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
            userView2.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.03*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.58
            userView2.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.06*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.56
            userView2.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlefooter.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.09*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.54
            userView2.addSubview(imgHdrVw)
            
            var strFontTitle: String = "Futura-CondensedExtraBold"
            var Color: UIColor = colorWithHexString("ba8748")
            
            lblResort1.textColor = Color
            lblView1.textColor = Color
            lblDates1.textColor = Color
            lblPreregister.textColor = Color
            lblResort1.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblView1.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblDates1.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblPreregister.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            strFontTitle = "Futura-CondensedMedium"
            Color = colorWithHexString("ba8748")
            
            lblResortText.textColor = Color
            lblViewText.textColor = Color
            lblDatesText.textColor = Color
            lblPreArrival.textColor = Color
            lblPreregisterText.textColor = Color
            lblResortText.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblViewText.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblDatesText.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblPreArrival.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblPreregisterText.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            
            lblResort1.textAlignment = NSTextAlignment.left
            lblResort1.frame = CGRect(x: 0.015*width, y: 0.00001*height, width: 0.2*width, height: 0.03*height);
            //lblView1.textAlignment = NSTextAlignment.left
            //lblView1.frame = CGRect(x: 0.015*width, y: 0.029*height, width: 0.2*width, height: 0.03*height);
            lblDates1.textAlignment = NSTextAlignment.left
            lblDates1.frame = CGRect(x: 0.015*width, y: 0.029*height, width: 0.2*width, height: 0.03*height);
            lblPreregister.textAlignment = NSTextAlignment.left
            lblPreregister.frame = CGRect(x: 0.015*width, y: 0.058*height, width: 0.23*width, height: 0.03*height);
            
            lblResortText.numberOfLines = 0
            lblResortText.frame = CGRect(x: 0.24*width, y: 0.0001*height, width: 0.45*width, height: 0.03*height);
            //lblViewText.numberOfLines = 0
            //lblViewText.frame = CGRect(x: 0.24*width, y: 0.0297*height, width: 0.45*width, height: 0.03*height);
            lblDatesText.numberOfLines = 0
            lblDatesText.frame = CGRect(x: 0.24*width, y: 0.0297*height, width: 0.45*width, height: 0.03*height);
            lblPreArrival.numberOfLines = 0
            lblPreArrival.frame = CGRect(x: 0.24*width, y: 0.059*height, width: 0.6*width, height: 0.03*height);
            lblPreregisterText.numberOfLines = 0
            lblPreregisterText.frame = CGRect(x: 0.24*width, y: 0.059*height, width: 0.6*width, height: 0.03*height);
            
            userView2.addSubview(lblResort1)
            //userView2.addSubview(lblView1)
            userView2.addSubview(lblDates1)
            userView2.addSubview(lblResortText)
            //userView2.addSubview(lblViewText)
            userView2.addSubview(lblDatesText)
            userView2.addSubview(lblPreArrival)
            userView2.addSubview(lblPreregister)
            userView2.addSubview(lblPreregisterText)
            
            self.view.addSubview(userView1)
            self.view.addSubview(userView2)
            
            lblNota.frame = CGRect(x: 0.05*width, y: 0.22*height, width: 0.9*width, height: 0.2*height);
            lblNota.textColor = colorWithHexString("ba8748")
            
            self.view.addSubview(lblNota)
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            imageView.isHidden = true
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            userView2.backgroundColor = UIColor.clear
            userView2.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.14*height);
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            //userView2.backgroundColor = colorWithHexString ("DDF4FF")
            //tableView.backgroundColor = colorWithHexString ("DDF4FF")
            //userView1.backgroundColor = colorWithHexString ("DDF4FF")
            
            userView2.backgroundColor = UIColor.white
            tableView.backgroundColor = UIColor.white
            userView1.backgroundColor = UIColor.white
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
            userView2.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.03*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.58
            userView2.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.06*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.56
            userView2.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlefooter.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.09*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.54
            userView2.addSubview(imgHdrVw)

            var strFontTitle: String = "Futura-CondensedExtraBold"
            var Color: UIColor = colorWithHexString("5c9fcc")
            
            lblResort1.textColor = Color
            lblView1.textColor = Color
            lblDates1.textColor = Color
            lblPreregister.textColor = Color
            lblResort1.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblView1.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblDates1.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblPreregister.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            strFontTitle = "Futura-CondensedMedium"
            Color = colorWithHexString("5c9fcc")
            
            lblResortText.textColor = Color
            lblViewText.textColor = Color
            lblDatesText.textColor = Color
            lblPreArrival.textColor = Color
            lblPreregisterText.textColor = Color
            lblResortText.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblViewText.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblDatesText.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblPreArrival.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblPreregisterText.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            
            lblResort1.textAlignment = NSTextAlignment.left
            lblResort1.frame = CGRect(x: 0.015*width, y: 0.00001*height, width: 0.2*width, height: 0.03*height);
            //lblView1.textAlignment = NSTextAlignment.left
            //lblView1.frame = CGRect(x: 0.015*width, y: 0.029*height, width: 0.2*width, height: 0.03*height);
            lblDates1.textAlignment = NSTextAlignment.left
            lblDates1.frame = CGRect(x: 0.015*width, y: 0.029*height, width: 0.2*width, height: 0.03*height);
            lblPreregister.textAlignment = NSTextAlignment.left
            lblPreregister.frame = CGRect(x: 0.015*width, y: 0.058*height, width: 0.23*width, height: 0.03*height);
            
            lblResortText.numberOfLines = 0
            lblResortText.frame = CGRect(x: 0.24*width, y: 0.0001*height, width: 0.45*width, height: 0.03*height);
            //lblViewText.numberOfLines = 0
            //lblViewText.frame = CGRect(x: 0.24*width, y: 0.0297*height, width: 0.45*width, height: 0.03*height);
            lblDatesText.numberOfLines = 0
            lblDatesText.frame = CGRect(x: 0.24*width, y: 0.0297*height, width: 0.45*width, height: 0.03*height);
            lblPreArrival.numberOfLines = 0
            lblPreArrival.frame = CGRect(x: 0.24*width, y: 0.059*height, width: 0.6*width, height: 0.03*height);
            lblPreregisterText.numberOfLines = 0
            lblPreregisterText.frame = CGRect(x: 0.24*width, y: 0.059*height, width: 0.6*width, height: 0.03*height);
            
            userView2.addSubview(lblResort1)
            //userView2.addSubview(lblView1)
            userView2.addSubview(lblDates1)
            userView2.addSubview(lblResortText)
            //userView2.addSubview(lblViewText)
            userView2.addSubview(lblDatesText)
            userView2.addSubview(lblPreArrival)
            userView2.addSubview(lblPreregister)
            userView2.addSubview(lblPreregisterText)
            
            self.view.addSubview(userView1)
            self.view.addSubview(userView2)

            lblNota.frame = CGRect(x: 0.05*width, y: 0.2*height, width: 0.9*width, height: 0.2*height);
            lblNota.textColor = colorWithHexString("00467f")
            
            self.view.addSubview(lblNota)
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            
        }

    }
    
    func cargarDatos(){
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        ViewItem.rightBarButtonItem?.isEnabled = false
        self.tableView.isUserInteractionEnabled = false
        app.beginIgnoringInteractionEvents()
        
        var tableItems = RRDataSet()
        var iRes: String = ""
        var strAge: String = ""
        var iIndex: Int = 0
        var resultAI: Int32 = 0
        
        //let sAppCode = "APPSTAY"
        let iPersonaID = Stays["PrimaryPeopleID"]!
        let iStayInfoID = Stays["StayInfoID"]!
        //variable para pasar a vcGuestPreCheckIn
        PeopleFromCRDID = iPersonaID
        StayInfoIDAux = Stays["StayInfoID"]!
        
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
            //print(1)
            
            if Reachability.isConnectedToNetwork(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
                let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
                tableItems = (service?.spGetAppStayPeople("1", appCode: self.appDelegate.gstrAppName, personalID: iPersonaID, stayInfoID: iStayInfoID, dataBase: self.appDelegate.strDataBaseByStay))!
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            OperationQueue.main.addOperation() {
                queue.addOperation() {//2
                    //accion base de datos
                    //print(2)
                    
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
                        
                        if (Int(iRes) > 0){
                            
                            var table = RRDataTable()
                            table = tableItems.tables.object(at: 1) as! RRDataTable
                            
                            var r = RRDataRow()
                            r = table.rows.object(at: 0) as! RRDataRow
                            
                            iRes = (r as AnyObject).getColumnByName("Result").content as! String
                            
                            if (Int(iRes) > 0){
                                
                                //Borramos
                                /*queueFM?.inTransaction() {
                                    db, rollback in
                                    
                                    if (db.executeUpdate("DELETE FROM tblPerson WHERE StayInfoID=?", withArgumentsIn: [iStayInfoID])) {
                                        rollback.initialize(to: true)
                                        return
                                    }
                                    
                                }*/
                                
                                queueFM?.inTransaction { db, rollback in
                                    do {
                                        
                                        try db.executeUpdate("DELETE FROM tblPerson WHERE StayInfoID=?", withArgumentsIn: [iStayInfoID])
                                        
                                    } catch {
                                        rollback.pointee = true
                                    }
                                }
                                
                                self.iTotalPeople = 0
                                    
                                    queueFM?.inTransaction() {
                                        db, rollback in
                                        
                                        for r in table.rows{
                                            
                                            self.appDelegate.gblPromoAI = false
                                            
                                            self.tblPersonInfo = [:]
                                            
                                            self.tblPersonInfo["StayInfoID"] = (r as AnyObject).getColumnByName("fkStayInfoID").content as? String
                                            self.tblPersonInfo["DatabaseName"] = "FDESK_CANCUN"
                                            self.tblPersonInfo["PersonID"] = (r as AnyObject).getColumnByName("fkPeopleFromCDRID").content as? String
                                            
                                            
                                            let FirstName = (r as AnyObject).getColumnByName("FirstName").content as? String
                                            let MiddleName = (r as AnyObject).getColumnByName("MiddleName").content as? String
                                            let LastName1 = (r as AnyObject).getColumnByName("LastName1").content as? String
                                            let LastName2 = (r as AnyObject).getColumnByName("LastName2").content as? String
                                            let EmailAddress = (r as AnyObject).getColumnByName("EmailAddress").content as? String
                                            
                                            self.tblPersonInfo["FullName"] = (FirstName! + " " + MiddleName! + " " + LastName1! + " " + LastName2!)
                                            self.tblPersonInfo["FirstName"] = FirstName
                                            self.tblPersonInfo["MiddleName"] = MiddleName
                                            self.tblPersonInfo["LastName"] = LastName1
                                            self.tblPersonInfo["SecondLName"] = LastName2
                                            self.tblPersonInfo["EmailAddress"] = EmailAddress
                                            self.tblPersonInfo["PeopleFDeskID"] = (r as AnyObject).getColumnByName("ID").content as? String
                                            self.tblPersonInfo["YearBirthDay"] = (r as AnyObject).getColumnByName("YearBirthday").content as? String
                                            self.tblPersonInfo["ynPrimary"] = (r as AnyObject).getColumnByName("ynPrimary").content as? String
                                            self.tblPersonInfo["ynPreRegisterAvailable"] = (r as AnyObject).getColumnByName("ynPreRegisterAvailable").content as? String
                                            self.tblPersonInfo["NumOfPeopleForStay"] = (r as AnyObject).getColumnByName("NumOfPeopleForStay").content as? String
                                            
                                            /*if Int(((r as AnyObject).getColumnByName("Age").content as? String)!) > 99{
                                                self.tblPersonInfo["Age"] = "0"
                                            }else{*/
                                                self.tblPersonInfo["Age"] = (r as AnyObject).getColumnByName("Age").content as? String
                                            //}
                                            
                                            if (r as AnyObject).getColumnByName("ynPrimary").content as? String == "True"{
                                                self.strPeoplePrimary = ((r as AnyObject).getColumnByName("fkPeopleFromCDRID").content as? String)!
                                            }
                                            
                                            self.NumOfPeopleForStay = ((r as AnyObject).getColumnByName("NumOfPeopleForStay").content as? String)!
                                            
                                            self.tblPersonInfo["pkPreRegisterID"] = (r as AnyObject).getColumnByName("pkPreRegisterID").content as? String
                                            self.tblPersonInfo["PreRegisterTypeDesc"] = (r as AnyObject).getColumnByName("PreRegisterTypeDesc").content as? String
                                            self.tblPersonInfo["GuestType"] = (r as AnyObject).getColumnByName("GuestType").content as? String
                                            self.tblPersonInfo["DateLimit"] = (r as AnyObject).getColumnByName("DateLimit").content as? String
                                            self.tblPersonInfo["ynValidDate"] = (r as AnyObject).getColumnByName("ynValidDate").content as? String
                                            self.tblPersonInfo["PhoneNo"] = (r as AnyObject).getColumnByName("PhoneNo").content as? String
                                            self.tblPersonInfo["dtExpectedArrival"] = (r as AnyObject).getColumnByName("dtExpectedArrival").content as? String
                            
                                            
                                            //Contamos las persona que ya estan agregadas
                                            self.iTotalPeople = self.iTotalPeople + 1
                                            
                                            /*if Int(((r as AnyObject).getColumnByName("Age").content as? String)!) > 99{
                                                strAge = "0"
                                            }else{*/
                                                strAge = ((r as AnyObject).getColumnByName("Age").content as? String)!
                                            //}

                                            //[StayInfoID, DatabaseName, PersonID, FullName, FirstName, MiddleName, LastName, SecondLName, EmailAddress, PeopleFDeskID, YearBirthDay, ynPrimary, ynPreRegisterAvailable, NumOfPeopleForStay, Age, pkPreRegisterID, PreRegisterTypeDesc, GuestType]
                                            if db.executeUpdate("INSERT INTO tblPerson (StayInfoID,DatabaseName,PersonID,FullName,FirstName, MiddleName, LastName, SecondLName, EmailAddress, PeopleFDeskID, YearBirthDay, ynPrimary, ynPreRegisterAvailable, NumOfPeopleForStay, Age, pkPreRegisterID, PreRegisterTypeDesc, GuestType, DateLimit, ynValidDate, PhoneNo, dtExpectedArrival) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [
                                                ((r as AnyObject).getColumnByName("fkStayInfoID").content as? String)!,
                                                "FDESK_CANCUN",
                                                ((r as AnyObject).getColumnByName("fkPeopleFromCDRID").content as? String)!,
                                                (((r as AnyObject).getColumnByName("FirstName").content as? String)! + " " + ((r as AnyObject).getColumnByName("MiddleName").content as? String)! + " " + ((r as AnyObject).getColumnByName("LastName1").content as? String)! + " " + ((r as AnyObject).getColumnByName("LastName2").content as? String)!),
                                                ((r as AnyObject).getColumnByName("FirstName").content as? String)!,
                                                ((r as AnyObject).getColumnByName("MiddleName").content as? String)!,
                                                ((r as AnyObject).getColumnByName("LastName1").content as? String)!,
                                                ((r as AnyObject).getColumnByName("LastName2").content as? String)!,
                                                ((r as AnyObject).getColumnByName("EmailAddress").content as? String)!,
                                                ((r as AnyObject).getColumnByName("ID").content as? String)!,
                                                ((r as AnyObject).getColumnByName("YearBirthday").content as? String)!,
                                                ((r as AnyObject).getColumnByName("ynPrimary").content as? String)!,
                                                ((r as AnyObject).getColumnByName("ynPreRegisterAvailable").content as? String)!,
                                                ((r as AnyObject).getColumnByName("NumOfPeopleForStay").content as? String)!,
                                                strAge,
                                                ((r as AnyObject).getColumnByName("pkPreRegisterID").content as? String)!,
                                                ((r as AnyObject).getColumnByName("PreRegisterTypeDesc").content as? String)!,
                                                ((r as AnyObject).getColumnByName("GuestType").content as? String)!,
                                                ((r as AnyObject).getColumnByName("DateLimit").content as? String)!,
                                                ((r as AnyObject).getColumnByName("ynValidDate").content as? String)!,
                                                ((r as AnyObject).getColumnByName("PhoneNo").content as? String)!,
                                                ((r as AnyObject).getColumnByName("dtExpectedArrival").content as? String)!
                                                ]) {
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                
                                
                            }
                            
                        }
                        
                        self.tblPersonAI = []
                        self.tblPersonAIAux = [:]
                        self.tblPersonRange = []
                        self.tblPersonRangeAux = [:]
                        
                        var tableAI = RRDataTable()
                        tableAI = tableItems.tables.object(at: 2) as! RRDataTable

                        if (Int(iRes) > 0) && tableItems.getTotalTables() > 1 && tableAI.getTotalRows() > 0{

                            var rAI = RRDataRow()
                            rAI = tableAI.rows.object(at: 0) as! RRDataRow
                            
                            iRes = (rAI as AnyObject).getColumnByName("pkGuestAgeID").content as! String
                            
                            if (Int(iRes) > 0){
                            
                            self.appDelegate.gblPromoAI = true

                            queueFM?.inTransaction { db, rollback in
                                    do {
                                        
                                        try db.executeUpdate("DELETE FROM tblPersonAI", withArgumentsIn: [])
                                        
                                    } catch {
                                        rollback.pointee = true
                                    }
                            }
                                
                            queueFM?.inTransaction() {
                                db, rollback in
                                
                                for r in tableAI.rows{

                                    if db.executeUpdate("INSERT INTO tblPersonAI (StayInfoID,GuestSequence,Age,pkGuestAgeID,pkPeopleID,fkPromoID,AdultChildTeen,fkPeopleID) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [
                                        self.StayInfoID,
                                        ((r as AnyObject).getColumnByName("GuestSequence").content as? String)!,
                                        ((r as AnyObject).getColumnByName("Age").content as? String)!,
                                        ((r as AnyObject).getColumnByName("pkGuestAgeID").content as? String)!,
                                        ((r as AnyObject).getColumnByName("pkPeopleID").content as? String)!,
                                        ((r as AnyObject).getColumnByName("fkPromoID").content as? String)!,
                                        ((r as AnyObject).getColumnByName("AdultChildTeen").content as? String)!,
                                        ((r as AnyObject).getColumnByName("fkPeopleID").content as? String)!]) {
                                        
                                    }

                                    
                                }
                                
                            }
                                
                                queueFM?.inDatabase() {
                                    db in
                                    
                                    let resultCountAI = db.intForQuery("SELECT COUNT(*) FROM tblPersonAI" as String,"" as AnyObject)
                                    
                                    if (resultCountAI == nil){
                                        resultAI = 0
                                    }else{
                                        if (String(describing: resultCountAI) == ""){
                                            resultAI = 0
                                        }else{
                                            resultAI = Int32(resultCountAI!)
                                        }
                                        
                                    }
                                    
                                }
                                
                                queueFM?.inDatabase() {
                                    db in
                                    
                                    for _ in 0...resultAI-1 {
                                        self.tblPersonAI.append([:])
                                    }
                                    
                                    if let rs = db.executeQuery("SELECT * FROM tblPersonAI ORDER BY GuestSequence DESC", withArgumentsIn: []){
                                        while rs.next() {
                                            self.tblPersonAIAux["StayInfoID"] = rs.string(forColumn: "StayInfoID")!
                                            self.tblPersonAIAux["GuestSequence"] = String(describing: rs.string(forColumn: "GuestSequence")!)
                                            self.tblPersonAIAux["Age"] = String(describing: rs.string(forColumn: "Age")!)
                                            self.tblPersonAIAux["pkGuestAgeID"] = String(describing: rs.string(forColumn: "pkGuestAgeID")!)
                                            self.tblPersonAIAux["pkPeopleID"] = String(describing: rs.string(forColumn: "pkPeopleID")!)
                                            self.tblPersonAIAux["fkPromoID"] = String(describing: rs.string(forColumn: "fkPromoID")!)
                                            self.tblPersonAIAux["AdultChildTeen"] = String(describing: rs.string(forColumn: "AdultChildTeen")!)
                                            self.tblPersonAIAux["fkPeopleID"] = String(describing: rs.string(forColumn: "fkPeopleID")!)
                                            self.tblPersonAI[iIndex] = self.tblPersonAIAux
                                            
                                            iIndex = iIndex + 1
                                        }
                                    } else {
                                        print("select failure: \(db.lastErrorMessage())")
                                    }
                                    
                                }
                            
                            
                        }
                        
                        
                    }
                        
                        var tableRangeAI = RRDataTable()
                        tableRangeAI = tableItems.tables.object(at: 3) as! RRDataTable
                        
                        if (Int(iRes) > 0) && tableItems.getTotalTables() > 2 && tableRangeAI.getTotalRows() > 0{

                            var rRangeAI = RRDataRow()
                            rRangeAI = tableRangeAI.rows.object(at: 0) as! RRDataRow
                            
                            iRes = (rRangeAI as AnyObject).getColumnByName("RangeMax").content as! String
                            
                            if (Int(iRes) > 0){
                                
                                self.appDelegate.gblPromoAI = true
                                
                                queueFM?.inTransaction() {
                                    db, rollback in
                                    
                                    for r in tableRangeAI.rows{
                                        
                                        self.tblPersonRangeAux = [:]

                                        self.tblPersonRangeAux["RangeMin"] = (r as AnyObject).getColumnByName("RangeMin").content as? String
                                        self.tblPersonRangeAux["RangeMax"] = (r as AnyObject).getColumnByName("RangeMax").content as? String
                                        self.tblPersonRangeAux["RangeCode"] = (r as AnyObject).getColumnByName("RangeCode").content as? String
                                        self.tblPersonRange.append(self.tblPersonRangeAux)
                                        
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            
                            
                        }
                        
                    }
                    OperationQueue.main.addOperation() {
                        queue.addOperation() {
                            
                            self.tblPersonInfoAux = []
                            
                            var Stays: [Dictionary<String, String>]
                            var DataStays = [String:String]()
                            
                            var Index: Int = 0
                            var TotalRow: Int = 0
                            
                            Stays = []
                            queueFM?.inDatabase() {
                                db in
                                //Para obtener el total de registros
                                if let rs = db.executeQuery("SELECT * FROM tblPerson WHERE StayInfoID = ?", withArgumentsIn: [self.StayInfoID]){
                                    while rs.next() {
                                        TotalRow = TotalRow + 1
                                    }
                                    for _ in 0...TotalRow-1 {
                                        Stays.append([:])
                                    }
                                } else {
                                    print("select failure: \(db.lastErrorMessage())")
                                }
                            }

                            queueFM?.inDatabase() {
                                db in
                                //Para obtener el total de registros
                                if let rs = db.executeQuery("SELECT * FROM tblPerson WHERE StayInfoID = ?", withArgumentsIn: [self.StayInfoID]){
                                    while rs.next() {
                                        DataStays["StayInfoID"] = rs.string(forColumn: "StayInfoID")!
                                        DataStays["DatabaseName"] = rs.string(forColumn: "DatabaseName")!
                                        DataStays["PersonID"] = rs.string(forColumn: "PersonID")!
                                        DataStays["FullName"] = rs.string(forColumn: "FullName")!
                                        DataStays["FirstName"] = rs.string(forColumn: "FirstName")!
                                        DataStays["MiddleName"] = rs.string(forColumn: "MiddleName")!
                                        DataStays["LastName"] = rs.string(forColumn: "LastName")!
                                        DataStays["SecondLName"] = rs.string(forColumn: "SecondLName")!
                                        DataStays["EmailAddress"] = rs.string(forColumn: "EmailAddress")!
                                        DataStays["PeopleFdeskID"] = rs.string(forColumn: "PeopleFdeskID")!
                                        DataStays["YearBirthDay"] = rs.string(forColumn: "YearBirthDay")!
                                        DataStays["ynPrimary"] = rs.string(forColumn: "ynPrimary")!
                                        DataStays["ynPreRegisterAvailable"] = rs.string(forColumn: "ynPreRegisterAvailable")!
                                        DataStays["NumOfPeopleForStay"] = rs.string(forColumn: "NumOfPeopleForStay")!
                                        DataStays["Age"] = rs.string(forColumn: "Age")!
                                        DataStays["pkPreRegisterID"] = rs.string(forColumn: "pkPreRegisterID")!
                                        DataStays["PreRegisterTypeDesc"] = rs.string(forColumn: "PreRegisterTypeDesc")!
                                        DataStays["GuestType"] = rs.string(forColumn: "GuestType")!
                                        DataStays["DateLimit"] = rs.string(forColumn: "DateLimit")!
                                        DataStays["ynValidDate"] = rs.string(forColumn: "ynValidDate")!
                                        DataStays["PhoneNo"] = rs.string(forColumn: "PhoneNo")!
                                        DataStays["dtExpectedArrival"] = rs.string(forColumn: "dtExpectedArrival")!
                                        Stays[Index] = DataStays
                                        
                                        Index = Index + 1
                                    }
                                    
                                } else {
                                    print("select failure: \(db.lastErrorMessage())")
                                }
                            }

                            self.tblPersonInfoAux = Stays
                            
                            OperationQueue.main.addOperation() {
                                
                                queue.addOperation() {

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
                                    
                                    OperationQueue.main.addOperation() {
                                        
                                        if !Reachability.isConnectedToNetwork(){
                                            RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                                        }
                                        
                                        if self.tblPersonInfoAux != nil{
                                            
                                            if self.tblPersonInfoAux[0]["pkPreRegisterID"]! as String == "0"{
                                                self.lblPreregisterText.text = NSLocalizedString("lblPreregisterText2",comment:"")
                                            }else{
                                                self.lblPreregisterText.text = NSLocalizedString("lblPreregisterText1",comment:"") + " " + self.tblPersonInfoAux[0]["PreRegisterTypeDesc"]! as String
                                            }
                                            
                                            if self.tblPersonInfoAux[0]["ynPreRegisterAvailable"]! == "True"
                                            {
                                                self.ynPreRegisterAvailableForm = true
                                            }else{
                                                self.ynPreRegisterAvailableForm = false
                                            }
                                            
                                            if self.tblPersonInfoAux[0]["ynValidDate"]! == "True"
                                            {
                                                self.ynValiddate = true
                                            }else{
                                                self.ynValiddate = false
                                            }

                                            self.NumOfPeopleForStay = self.tblPersonInfoAux[0]["NumOfPeopleForStay"]!
                                            
                                            self.countMaxPeopleAvail = Int(self.NumOfPeopleForStay)! - (self.tblPeopleID.count - 1)
                                            
                                            if (self.tblPersonInfoAux.count > 0){
                                                
                                                var dtDateLimit: Date = Date()
                                                var strDateLimit: String = ""
                                                
                                                if self.tblPersonInfoAux[0]["DateLimit"]! != ""{
                                                let dateFormatter: DateFormatter = DateFormatter()
                                                dateFormatter.dateFormat = "MM/dd/yyyy h:mm:ss a"
                                                dateFormatter.timeZone = TimeZone(identifier: "UTC")
                                                dateFormatter.locale = Locale(identifier: "en_US")
                                                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                                                dtDateLimit = dateFormatter.date(from: self.tblPersonInfoAux[0]["DateLimit"]!)!
                                                
                                                let strFormatter: DateFormatter = DateFormatter()
                                                strFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                                                strFormatter.timeZone = TimeZone(identifier: "UTC")
                                                strFormatter.locale = Locale(identifier: "en_US")
                                                strFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                                                strDateLimit = strFormatter.string(from: dtDateLimit)
                                                }
                                                //Se concatena NumOfPeopleForStay
                                                self.lblNota.text = NSLocalizedString("lblNoteGuest",comment:"") + self.NumOfPeopleForStay + ". " +  NSLocalizedString("lblDateLimit",comment:"") + strDateLimit + " hrs."
                                                
                                                if self.ynPreRegisterAvailableForm==false{
                                                    
                                                    self.lblPreArrival.text = NSLocalizedString("TitlePreArrivalRO",comment:"")
                                                    
                                                    //Titulo de la vista
                                                    if self.appDelegate.strPeopleType != "MEMBER"{
                                                        self.ViewItem.title = NSLocalizedString("TitlePreArrivalRO",comment:"")
                                                    }else{
                                                        self.ViewItem.title = NSLocalizedString("lblMemberRO",comment:"")
                                                    }
                                                    
                                                    self.ViewItem.rightBarButtonItem?.isEnabled = false
                                                    
                                                }else{
                                                    
                                                    self.lblPreArrival.text = ""
                                                    
                                                    //Titulo de la vista
                                                    if self.appDelegate.strPeopleType != "MEMBER"{
                                                        self.ViewItem.title = NSLocalizedString("TitlePreArrival",comment:"")
                                                    }else{
                                                        self.ViewItem.title = NSLocalizedString("lblMember",comment:"")
                                                    }
                                                    
                                                    //El botón “+” solamente se habilitará si se tienen menos personas del máximo permitido
                                                    if Int(self.NumOfPeopleForStay) > self.iTotalPeople {
                                                        self.ViewItem.rightBarButtonItem?.isEnabled = true
                                                    }
                                                    else{
                                                        self.ViewItem.rightBarButtonItem?.isEnabled = false
                                                    }
                                                    
                                                }
                                            }
                                            
                                            if self.strStayType == "OW"{
                                                if self.appDelegate.strPeopleType != "MEMBER"{
                                                    self.ViewItem.rightBarButtonItem?.isEnabled = false
                                                    self.tableView.isUserInteractionEnabled = false
                                                }else{
                                                    self.ViewItem.rightBarButtonItem?.isEnabled = true
                                                    self.tableView.isUserInteractionEnabled = true
                                                }
                                            }else{
                                                /*if self.appDelegate.gstrLoginPeopleID == self.strPeoplePrimary{
                                                    self.ViewItem.rightBarButtonItem?.enabled = true
                                                    self.tableView.userInteractionEnabled = true
                                                }else{
                                                    self.ViewItem.rightBarButtonItem?.enabled = false
                                                    self.tableView.userInteractionEnabled = false
                                                }*/
                                            }
                                            
                                            self.tableView.reloadData()
                                            self.ViewItem.rightBarButtonItem?.isEnabled = true
                                            self.tableView.isUserInteractionEnabled = true
                                            self.app.endIgnoringInteractionEvents()
                                            SwiftLoader.hide()
                                            
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(appDelegate.glbPreCheck)&&(appDelegate.glbPreCheckSave){
            appDelegate.NewPeople = false
            appDelegate.glbPreCheck = false
            cargarDatos()
            
        }

        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Stay Guests",
            AnalyticsParameterItemName: "Stay Guests",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Stay Guests", screenClass: appDelegate.gstrAppName)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var CountPeople: Int = 0
        if (tblPersonInfoAux != nil)
        {
            CountPeople = tblPersonInfoAux.count
        }
        //return Guests.count
        return CountPeople
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Guests"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title: UILabel = UILabel()
        title.backgroundColor = UIColor.clear;
        title.textAlignment = NSTextAlignment.left;
        title.textColor = UIColor.gray;
        title.font = UIFont(name:"HelveticaNeue-Light", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont4)
        title.numberOfLines = 0;

        title.text = NSLocalizedString("lblGuests",comment:"");
        
        return title
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return UITableViewCell()
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cellGuest")!
        
        
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
            }else if (tblPersonInfoAux.count-1) == indexPath.row{
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
            
            if (tblPersonInfoAux.count) == 1
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
            }else if (tblPersonInfoAux.count-1) == indexPath.row{
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
            
            if (tblPersonInfoAux.count) == 1
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
        
        cell.textLabel?.text = tblPersonInfoAux[indexPath.row]["FullName"]!
        cell.textLabel?.font = UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont3)
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.detailTextLabel?.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        
        if ( (tblPersonInfoAux[indexPath.row]["ynPrimary"]) == "True")
        {
            self.appDelegate.gstrPrimaryPeopleID = (tblPersonInfoAux[indexPath.row]["PersonID"])!
            cell.detailTextLabel?.text = NSLocalizedString("Primary",comment:"");
        }
        else{
            cell.detailTextLabel?.text = ""
        }
        
        //Para que no se selecciones la celda
        //cell.selectionStyle = .None
        
        return cell
        
    }
    
    
    //Para Eliminar el registro
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == UITableViewCell.EditingStyle.delete {
                    
                    let index = indexPath.row
                    self.EliminarPeople(index)

                }

    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if self.ynValiddate{
            if ( (tblPersonInfoAux[indexPath.row]["ynPrimary"]) == "True")
            {
                return false
            }
            else{
                return true
            }
        }else{
            self.ViewItem.rightBarButtonItem?.isEnabled = false
            return false
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if self.ynValiddate{
            ynAdd = false
            ynRemove = false
            ynEdit = true
            
            let index = indexPath.row
            
            recargarTablaStay(index)
        }
        
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
        
    }
    
    func recargarTablaStay(_ index: Int){
        
        ViewItem.rightBarButtonItem?.isEnabled = false
        ViewItem.leftBarButtonItem?.isEnabled = false
        self.tableView.isUserInteractionEnabled = false
        
        var tableItems = RRDataSet()
        var iRes: String = ""
        var sRes: String = ""
        var iCountMember: Int32 = 0
        var iMemberPeople: Int32 = 0
        var ynElimina: Bool = true
        var iType : String = ""
        var ynAddStay: Bool = false
        var ynInHouse: Bool = false
        var ynDeleted: Bool = false
        
        let PersonID = tblPersonInfoAux[index]["PeopleFdeskID"]
        let FirstName = tblPersonInfoAux[index]["FirstName"]!
        let MiddleName = tblPersonInfoAux[index]["MiddleName"]!
        let LastName = tblPersonInfoAux[index]["LastName"]!
        let SecondLName = tblPersonInfoAux[index]["SecondLName"]!
        let YearBirthDay = tblPersonInfoAux[index]["YearBirthDay"]!
        let EmailAddress = tblPersonInfoAux[index]["EmailAddress"]!
        let ynPrimary = tblPersonInfoAux[index]["ynPrimary"]!
        let ynPreRegisterAvailable = tblPersonInfoAux[index]["ynPreRegisterAvailable"]!
        var Age: String = ""
        Age = self.tblPersonInfoAux[index]["Age"]!
        let PhoneNo = tblPersonInfoAux[index]["PhoneNo"]!
        
        var resultStayID: Int32 = 0
        var Stays: [Dictionary<String, String>]
        var DataStays = [String:String]()
        var Index: Int = 0
        
        Stays = []
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        let queue = OperationQueue()
        
        queue.addOperation() {//1
            //accion base de datos
                //print("A1")
            if self.ynRemove == true{
                if self.strStayType == "OW"{
                    
                    queueFM?.inDatabase() {
                        db in
                        
                        let resultCount = db.intForQuery("SELECT COUNT(*) FROM tblPerson WHERE GuestType = 'MEMBER' and StayInfoID = " + self.StayInfoID as String,"" as AnyObject)
                        
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
                    iCountMember = resultStayID
                }
            }
            
            OperationQueue.main.addOperation() {
                queue.addOperation() {//7
                    //accion base de datos
                    //print(7)
                    if self.ynRemove == true{
                        if iCountMember == 1{
                            
                            resultStayID = 0
                            
                            queueFM?.inDatabase() {
                                db in
                                
                                let resultCount = db.intForQuery("SELECT PersonID FROM tblPerson WHERE GuestType = 'MEMBER' and StayInfoID = " + self.StayInfoID as String,"" as AnyObject)
                                
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
                            iMemberPeople = resultStayID
                        }
                    }
                    
                    OperationQueue.main.addOperation() {
                        queue.addOperation() {//8
                            //accion base de datos
                            //print(8)
                            if self.ynRemove == true{
                                if self.strStayType == "OW"{
                                    if iCountMember == 1{
                                        if iMemberPeople == Int32(PersonID!){
                                            sRes = NSLocalizedString("LastMember",comment:"")
                                            ynElimina = false
                                        }
                                    }
                                }
                                
                                if ynPrimary=="True"{
                                    sRes = NSLocalizedString("DelPrimary",comment:"")
                                    ynElimina = false
                                }
                                
                                
                            }
                            
                            OperationQueue.main.addOperation() {
                                queue.addOperation() {//9
                                    //accion base de datos
                                    //print(9)
                                    if self.ynRemove == true{
                                        
                                        iType = "3"
                                        
                                        if ynElimina{
                                            if Reachability.isConnectedToNetwork(){
                                                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                                                    
                                                let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
                                                tableItems = (service?.spSetAppStayPeople(iType,  appCode: self.appDelegate.gstrAppName, userPersonalID: self.PeopleFromCRDID, stayInfoID:self.StayInfoID, id:PersonID, firstName:FirstName, middleName:MiddleName, lastName1:LastName, lastName2:SecondLName, emailAddress:EmailAddress, yearBirthday:YearBirthDay, ynPrimary:ynPrimary, phoneNo: PhoneNo, dtExpectedArrival: "", pkGuestAgeID: "0", dataBase: self.appDelegate.strDataBaseByStay))!
                                                    
                                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                            }
                                        }
                                    }
                                    
                                    
                                    OperationQueue.main.addOperation() {
                                        queue.addOperation() {//10
                                            //accion base de datos
                                            //print(10)
                                            
                                            if self.ynRemove == true{
                                                if ynElimina{
                                                    
                                                    if !Reachability.isConnectedToNetwork(){
                                                        RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                                                    }else{
                                                        
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
                                                            }
                                                            
                                                            if (Int(iRes) > 0){
                                                                
                                                                var table = RRDataTable()
                                                                table = tableItems.tables.object(at: 1) as! RRDataTable
                                                                
                                                                var r = RRDataRow()
                                                                r = table.rows.object(at: 0) as! RRDataRow
                                                                
                                                                iRes = (r as AnyObject).getColumnByName("Result").content as! String
                                                                sRes = (r as AnyObject).getColumnByName("ResultDesc").content as! String
                                                                
                                                                if (Int(iRes) > 0){
                                                                    ynDeleted = true
                                                                    self.cargarDatos()
                                                                
                                                                }else{
                                                                    if (iRes == "-111"){
                                                                        if Reachability.isConnectedToNetwork(){
                                                                            UIApplication.shared.isNetworkActivityIndicatorVisible = true
                                                                            
                                                                            ynInHouse = true
                                                                            
                                                                            let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
                                                                            tableItems = (service?.spGetGuestStay("1", personalID: self.appDelegate.gstrLoginPeopleID, appCode: self.appDelegate.gstrAppName, dataBase: self.appDelegate.strDataBaseByStay))!
                                                                            
                                                                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                                                        }
                                                                    }
                                                                }

                                                            }
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                            OperationQueue.main.addOperation() {
                                                if Reachability.isConnectedToNetwork(){
                                                    if (tableItems.getTotalTables() > 0 ) && ynInHouse == true{
                                                        
                                                        self.tblStayInfo = [:]
                                                        
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
                                                                            
                                                                            if (db.executeUpdate("INSERT INTO tblStay (StayInfoID, DatabaseName, PropertyCode, UnitCode, StatusCode, StatusDesc, ArrivalDate, DepartureDate, PropertyName, PrimaryPeopleID, OrderNo, Intv, IntvYear, fkAccID, fkTrxTypeID, AccCode, USDExchange, UnitID, FloorPlanDesc, UnitViewDesc, ynPostCheckout, LastAccountUpdate, PrimAgeCFG, fkPlaceID, DepartureDateCheckOut, ConfirmationCode, fkCurrencyID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [((r as AnyObject).getColumnByName("StayInfoID").content as? String)!, ((r as AnyObject).getColumnByName("DatabaseName").content as? String)!, ((r as AnyObject).getColumnByName("PropertyCode").content as? String)!, ((r as AnyObject).getColumnByName("UnitCode").content as? String)!, ((r as AnyObject).getColumnByName("StatusCode").content as? String)!, ((r as AnyObject).getColumnByName("StatusDesc").content as? String)!, ((r as AnyObject).getColumnByName("ArrivalDate").content as? String)!, ((r as AnyObject).getColumnByName("DepartureDate").content as? String)!, ((r as AnyObject).getColumnByName("PropertyName").content as? String)!, ((r as AnyObject).getColumnByName("PrimaryPeopleID").content as? String)!, ((r as AnyObject).getColumnByName("OrderNo").content as? String)!, ((r as AnyObject).getColumnByName("Intv").content as? String)!, ((r as AnyObject).getColumnByName("IntvYear").content as? String)!, ((r as AnyObject).getColumnByName("fkAccID").content as? String)!, ((r as AnyObject).getColumnByName("fkTrxTypeCCID").content as? String)!, ((r as AnyObject).getColumnByName("AccCode").content as? String)!, ((r as AnyObject).getColumnByName("USDExchange").content as? String)!, ((r as AnyObject).getColumnByName("UnitID").content as? String)!, ((r as AnyObject).getColumnByName("FloorPlanDesc").content as? String)!, ((r as AnyObject).getColumnByName("UnitViewDesc").content as? String)!, "0", "", ((r as AnyObject).getColumnByName("PrimAgeCFG").content as? String)!, ((r as AnyObject).getColumnByName("fkPlaceID").content as? String)!, ((r as AnyObject).getColumnByName("DepartureDateCheckOut").content as? String)!, ((r as AnyObject).getColumnByName("ConfirmationCode").content as? String)!, ((r as AnyObject).getColumnByName("fkCurrencyID").content as? String)!])) {
                                                                                
                                                                            }
                                                                            
                                                                        }
                                                                    }else{
                                                                        queueFM?.inTransaction() {
                                                                            db, rollback in
                                                                            
                                                                            if (db.executeUpdate("UPDATE tblStay SET StayInfoID = ?, DatabaseName = ?, PropertyCode = ?, UnitCode = ?, StatusCode = ?, StatusDesc = ?, ArrivalDate = ?, DepartureDate = ?, PropertyName = ?, PrimaryPeopleID = ?, OrderNo = ?, Intv= ?, IntvYear = ?, fkAccID = ?, fkTrxTypeID = ?, AccCode = ?, USDExchange = ?, UnitID = ?, FloorPlanDesc = ?, UnitViewDesc = ? WHERE StayInfoID=?", withArgumentsIn: [((r as AnyObject).getColumnByName("StayInfoID").content as? String)!, ((r as AnyObject).getColumnByName("DatabaseName").content as? String)!, ((r as AnyObject).getColumnByName("PropertyCode").content as? String)!, ((r as AnyObject).getColumnByName("UnitCode").content as? String)!, ((r as AnyObject).getColumnByName("StatusCode").content as? String)!, ((r as AnyObject).getColumnByName("StatusDesc").content as? String)!, ((r as AnyObject).getColumnByName("ArrivalDate").content as? String)!, ((r as AnyObject).getColumnByName("DepartureDate").content as? String)!, ((r as AnyObject).getColumnByName("PropertyName").content as? String)!, ((r as AnyObject).getColumnByName("PrimaryPeopleID").content as? String)!, ((r as AnyObject).getColumnByName("OrderNo").content as? String)!, ((r as AnyObject).getColumnByName("Intv").content as? String)!, ((r as AnyObject).getColumnByName("IntvYear").content as? String)!, ((r as AnyObject).getColumnByName("fkAccID").content as? String)!, ((r as AnyObject).getColumnByName("fkTrxTypeCCID").content as? String)!, ((r as AnyObject).getColumnByName("AccCode").content as? String)!, ((r as AnyObject).getColumnByName("USDExchange").content as? String)!, ((r as AnyObject).getColumnByName("UnitID").content as? String)!, ((r as AnyObject).getColumnByName("FloorPlanDesc").content as? String)!, ((r as AnyObject).getColumnByName("UnitViewDesc").content as? String)!, ((r as AnyObject).getColumnByName("StayInfoID").content as? String)!])) {
                                                                                
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
                                                    
                                                    if ynInHouse==false{
                                                        
                                                        if self.ynRemove == true{
                                                            if ynElimina{
                                                                if ynDeleted{
                                                                    RKDropdownAlert.title(NSLocalizedString("Deleted",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                                                                }else{
                                                                    RKDropdownAlert.title(NSLocalizedString("NotDeleted",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                                                                }
                                                            }
                                                            
                                                        }else{
                                                            if self.countMaxPeopleAvail <= 0 && self.ynAdd == true
                                                            {
                                                                RKDropdownAlert.title(NSLocalizedString("msgOcup",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                                                                
                                                            }else{
                                                                
                                                                let vct = self.storyboard?.instantiateViewController(withIdentifier: "vcGuestPeopleEdit") as! vcGuestPeopleEdit
                                                                
                                                                if self.ynAdd == true {
                                                                    self.appDelegate.NewPeople = true;
                                                                    vct.fkPeopleFromCDRID = "0"
                                                                    vct.PeopleFromCRDID = self.PeopleFromCRDID
                                                                    vct.StayInfoID = self.StayInfoID
                                                                    vct.PrimAgeCFG = self.PrimAgeCFG
                                                                    vct.dtExpectedArrival = self.tblPersonInfoAux[0]["dtExpectedArrival"]!
                                                                    vct.dtStayArrivalDate = self.dtStayArrivalDate
                                                                    vct.dtStayDepartureDate = self.dtStayDepartureDate
                                                                    vct.tblPersonAI = self.tblPersonAI
                                                                    vct.tblPersonRange = self.tblPersonRange
                                                                    self.navigationController?.pushViewController(vct, animated: true)
                                                                    self.ynAdd = false
                                                                }else{
                                                                    if self.ynEdit == true{
                                                                        vct.fkPeopleFromCDRID = self.PeopleFromCRDID
                                                                        
                                                                        //Pasamos los parametros para edicion
                                                                        
                                                                        vct.PeopleFromCRDID =  self.PeopleFromCRDID
                                                                        vct.PersonID = PersonID!
                                                                        vct.StayInfoID = self.StayInfoID
                                                                        vct.FirstName = FirstName
                                                                        vct.MiddleName = MiddleName
                                                                        vct.LastName = LastName
                                                                        vct.SecondLName = SecondLName
                                                                        vct.YearBirthDay = YearBirthDay
                                                                        vct.EmailAddress = EmailAddress
                                                                        vct.ynPrimary = ynPrimary
                                                                        vct.ynPreRegisterAvailable = ynPreRegisterAvailable
                                                                        vct.Age = Age
                                                                        vct.PrimAgeCFG = self.PrimAgeCFG
                                                                        vct.strPeoplePrimary = self.strPeoplePrimary
                                                                        vct.strStayType = self.strStayType
                                                                        vct.strPeopleType = self.tblPersonInfoAux[index]["GuestType"]!
                                                                        vct.fkPeopleFromCDRID = self.tblPersonInfoAux[index]["PersonID"]!
                                                                        vct.PhoneNo = self.tblPersonInfoAux[index]["PhoneNo"]!
                                                                        vct.dtExpectedArrival = self.tblPersonInfoAux[index]["dtExpectedArrival"]!
                                                                        vct.dtStayArrivalDate = self.dtStayArrivalDate
                                                                        vct.dtStayDepartureDate = self.dtStayDepartureDate
                                                                        vct.tblPersonAI = self.tblPersonAI
                                                                        vct.tblPersonRange = self.tblPersonRange
                                                                        self.navigationController?.pushViewController(vct, animated: true)
                                                                        self.ynEdit = false
                                                                        
                                                                    }
                                                                }
                                                                
                                                            }
                                                        }
                                                        
                                                    }else{
                                                        RKDropdownAlert.title(NSLocalizedString("msgResInH",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                                                    }
                                                }else{
                                                    RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                                                }
                                                
                                                self.ViewItem.rightBarButtonItem?.isEnabled = true
                                                self.ViewItem.leftBarButtonItem?.isEnabled = true
                                                self.tableView.isUserInteractionEnabled = true
                                                self.app.endIgnoringInteractionEvents()
                                                
                                                SwiftLoader.hide()
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

        }//1
        
    }

    
    @IBAction func clickAdd(_ sender: AnyObject) {
        ynAdd = true
        ynRemove = false
        ynEdit = false
       recargarTablaStay(0)

    }

    @IBAction func ClickBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
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
    
    
    func clickStays(_ sender: AnyObject) {
        
        //Regresamos a la vista anterior
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func EliminarPeople(_ index: Int){
        ynAdd = false
        ynRemove = true
        ynEdit = false
        recargarTablaStay(index)
    }

}

