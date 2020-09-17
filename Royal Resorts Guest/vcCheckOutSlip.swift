//
//  vcCheckOutSlip.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 7/12/15.
//  Copyright © 2015 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging

class vcCheckOutSlip: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var width: CGFloat!
    var height: CGFloat!
    var btnBack = UIButton()
    var barNavigate: UINavigationBar = UINavigationBar()
    var NavigationItem: UINavigationItem = UINavigationItem()
    var btnAccount: UIBarButtonItem = UIBarButtonItem()
    
    var strDate: String = ""
    var strOutDate: String = ""
    var strUnitCode: String = ""
    var strName: String = ""
    var strNumPerson: String = ""
    var StayInfoID: String = ""
    var Stays: Dictionary<String, String>!
    var Peoples: Dictionary<String, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        self.view.backgroundColor = UIColor.white
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);

        //Titulo de la vista
        self.title = NSLocalizedString("btnCheckOutSlip",comment:"");
        
        let BodyView: UIView = UIView()
        let AccView: UIView = UIView()
        let footerView: UIView = UIView()
        let headerView: UIView = UIView()

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
        
        Stays = StaysAux
        
        BodyView.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height-44);
        AccView.frame = CGRect(x: 0.0, y: 0.15*height, width: width, height: 0.8*height);
        footerView.frame = CGRect(x: 0.0, y: 0.78*height, width: width, height: 0.1*height);
        headerView.frame = CGRect(x: 0.0, y: 0.01*height, width: width, height: 0.1*height);
        
        var colorprim: UIColor = UIColor.black
        var colorprim2: UIColor = UIColor.black
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            colorprim = colorWithHexString("011125")
            colorprim2 = colorWithHexString("465261")
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            colorprim = colorWithHexString("011125")
            colorprim2 = colorWithHexString("465261")
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            colorprim = colorWithHexString("011125")
            colorprim2 = colorWithHexString("465261")
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
            
            colorprim = colorWithHexString("2e3634")
            colorprim2 = colorWithHexString("2e3634")
            
        }
        
        let lblProperty = UILabel(frame: CGRect(x: 0.0, y: 0.1*height, width: width, height: 0.08*height));
        lblProperty.backgroundColor = UIColor.clear;
        lblProperty.textAlignment = NSTextAlignment.center;
        lblProperty.textColor = colorprim
        lblProperty.numberOfLines = 1;
        lblProperty.font = UIFont(name: "Verdana-Bold", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
        lblProperty.text = Stays["PropertyName"]! + " - " + Stays["UnitCode"]!;
        lblProperty.adjustsFontSizeToFitWidth = true
        
        let lblstrDate = UILabel(frame: CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.06*height));
        lblstrDate.backgroundColor = UIColor.clear;
        lblstrDate.textAlignment = NSTextAlignment.center;
        lblstrDate.textColor = colorprim
        lblstrDate.numberOfLines = 1;
        lblstrDate.font = UIFont(name: "Verdana-Bold", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont6)
        lblstrDate.text = strDate;
        
        let lblstrTime = UILabel(frame: CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.06*height));
        lblstrTime.backgroundColor = UIColor.clear;
        lblstrTime.textAlignment = NSTextAlignment.center;
        lblstrTime.textColor = colorprim
        lblstrTime.numberOfLines = 1;
        lblstrTime.font = UIFont(name: "Verdana-Bold", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont6)
        lblstrTime.text = "CHECK OUT TIME: " + strOutDate;
        
        var PeoplesStay: Dictionary<String, String>
        
        let lblstrName = UILabel(frame: CGRect(x: 0.05*width, y: 0.18*height, width: 0.9*width, height: 0.15*height));
        lblstrName.backgroundColor = UIColor.clear;
        lblstrName.textAlignment = NSTextAlignment.left;
        lblstrName.textColor = colorprim
        lblstrName.numberOfLines = 0;
        lblstrName.font = UIFont(name: "Verdana-Bold", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7);
        lblstrName.lineBreakMode = .byWordWrapping
        strName = "";
        
        PeoplesStay = [:]
        
        queueFM?.inDatabase() {
            db in
            
            if let rs = db.executeQuery("SELECT * FROM tblPerson WHERE StayInfoID = ?", withArgumentsIn: [self.StayInfoID]){
                while rs.next() {
                    PeoplesStay["PeopleName"] = rs.string(forColumn: "FullName")!;
                    lblstrName.numberOfLines += 1;
                    strName += String(lblstrName.numberOfLines) + ".- " + rs.string(forColumn: "FullName")! + "\r\n";
                }
            }
            
        }
        
        Peoples = PeoplesStay
        
        lblstrName.text = strName;

        let lblMsgCheck = UILabel(frame: CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.1*height));
        lblMsgCheck.backgroundColor = UIColor.clear;
        lblMsgCheck.textAlignment = NSTextAlignment.center;
        lblMsgCheck.textColor = colorprim2
        lblMsgCheck.numberOfLines = 0;
        lblMsgCheck.font = UIFont(name: "Verdana-Bold", size: appDelegate.gblFont9 + appDelegate.gblDeviceFont8)
        lblMsgCheck.text = NSLocalizedString("lblCheckOutSlip",comment:"");
        
        AccView.addSubview(lblProperty)
        AccView.addSubview(lblstrDate)
        AccView.addSubview(lblstrName)

        let lblMsg = UILabel(frame: CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.33*height));
        lblMsg.backgroundColor = UIColor.clear;
        lblMsg.textAlignment = NSTextAlignment.center;
        lblMsg.textColor = colorprim2
        lblMsg.numberOfLines = 0;
        lblMsg.font = UIFont(name: "Verdana-Bold", size: appDelegate.gblFont9 + appDelegate.gblDeviceFont4)
        lblMsg.text = NSLocalizedString("lblMsgCheckOutSlip",comment:"");
        lblMsg.adjustsFontSizeToFitWidth = true
        
        let lblMsg2 = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 0.1*height));
        lblMsg2.backgroundColor = UIColor.clear;
        lblMsg2.textAlignment = NSTextAlignment.center;
        lblMsg2.textColor = colorprim2
        lblMsg2.numberOfLines = 0;
        lblMsg2.font = UIFont(name: "Verdana-Bold", size: appDelegate.gblFont9 + appDelegate.gblDeviceFont7)
        lblMsg2.text = NSLocalizedString("lblTimeCheckOutSlip",comment:"");
        
        headerView.addSubview(lblMsgCheck)
        AccView.addSubview(lblMsg)
        //AccView.addSubview(lblstrTime)
        footerView.addSubview(lblstrTime)//lblMsg2)
        
        BodyView.addSubview(headerView)
        BodyView.addSubview(AccView)
        BodyView.addSubview(footerView)
        
        /*let colors = Colors()
        
        BodyView.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height);
        BodyView.layer.insertSublayer(backgroundLayer, at: 0)*/
        
        self.view.addSubview(BodyView)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.backBarButtonItem?.tintColor = UIColor.white

        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Account Exit Pass",
            AnalyticsParameterItemName: "Account Exit Pass",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Account Exit Pass", screenClass: appDelegate.gstrAppName)
        
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

    func clickAccount(_ sender:UIButton!)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}

class Colors {
    let colorTop = UIColor(red: 82.0/255.0, green: 199.0/255.0, blue: 219.0/255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor(red: 55.0/255.0, green: 153.0/255.0, blue: 185.0/255.0, alpha: 1.0).cgColor
    
    let gl: CAGradientLayer
    
    init() {
        gl = CAGradientLayer()
        gl.colors = [ colorTop, colorBottom]
        gl.locations = [ 0.0, 1.0]
    }
    
}
