//
//  vcResortCred.swift
//  Royal Resorts Guest
//
//  Created by Alan Alvarez Ramirez on 7/15/19.
//  Copyright © 2019 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging

class vcResortCred: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var width: CGFloat!
    var height: CGFloat!
    var StayInfoID: String = ""
    var PeopleID: String = ""
    var PeopleFDeskID: String = ""
    var Stays: Dictionary<String, String>!
    var AccCode: String = ""
    var fDollar: Double = 0.0
    var fAmount: Double = 0
    var btnResCredApply: UIButton = UIButton()
    var imgResCred: UIImage = UIImage()
    var imgvw: UIImageView = UIImageView()
    var iAccID: String = ""
    var iKeycardid: String = ""
    var tblPersonSelect: Dictionary<String, String>!
    var PlaceCode: String = ""
    var LastAccTrxID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        print("Nuevo cambio")
        
        self.view.backgroundColor = UIColor.white
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        
        let bodyView: UIView = UIView()
        let itemsView: UIView = UIView()
        let ResCredView: UIView = UIView()
        
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
                    StaysAux["PlaceCode"] = String(describing: rs.string(forColumn: "PlaceCode")!)
                }
            } else {
                print("select failure: \(db.lastErrorMessage())")
            }
            
        }
        
        Stays = StaysAux
        
        AccCode = NSLocalizedString("Account",comment:"") + " " + Stays["AccCode"]!
        fDollar = Double(Stays["USDExchange"]!.description)!
        iAccID = Stays["fkAccID"]!.description
        PlaceCode = Stays["PlaceCode"]!.description
        //Titulo de la vista
        self.title = AccCode
        
        
        var strQuery: String = ""
        var strPeopleName: String = ""
        
        
        strQuery = "SELECT SUM(Amount) as Amount FROM tblAccount where StayInfoID = ?"
        
        queueFM?.inDatabase() {
            db in
            
            if let rs = db.executeQuery(strQuery, withArgumentsIn: [StayInfoID]){
                while rs.next() {
                    if rs.columnIsNull("Amount") != true {
                        fAmount = Double(String(format: "%.2f", (rs.string(forColumn: "Amount")! as NSString).floatValue))!
                    }
                }
            } else {
                print("select failure: \(db.lastErrorMessage())")
            }
            
        }
        
        strQuery = "SELECT FullName FROM tblPerson WHERE StayInfoID = ?"
        
        queueFM?.inDatabase() {
            db in
            if let rs = db.executeQuery(strQuery, withArgumentsIn: [StayInfoID]){
                while rs.next() {
                    strPeopleName = strPeopleName + rs.string(forColumn: "FullName")! + ", "
                }
                if strPeopleName != ""{
                    let strpre: String = strPeopleName
                    
                    let start = strpre.index(strpre.startIndex, offsetBy: 0)
                    let end = strpre.index(strpre.endIndex, offsetBy: -2)
                    let range = start..<end
                    
                    let mySubstring = strpre[range]
                    
                    strPeopleName = mySubstring.description
                }
            } else {
                print("select failure: \(db.lastErrorMessage())")
            }
        }

        if PeopleFDeskID=="0"
        {

            queueFM?.inDatabase() {
                db in
                
                if let rs = db.executeQuery("SELECT p.* FROM tblPerson p inner join tblStay s on s.StayInfoID = ? AND p.personID = ?", withArgumentsIn: [self.StayInfoID, self.appDelegate.gstrLoginPeopleID]){
                    while rs.next() {
                        self.iKeycardid = rs.string(forColumn: "iKeycardid")!
                    }
                } else {
                    print("select failure: \(db.lastErrorMessage())")
                }
                
            }
            
        }else{
            
            queueFM?.inDatabase() {
                db in
                
                if let rs = db.executeQuery("SELECT p.* FROM tblPerson p inner join tblStay s on s.StayInfoID = ? AND p.PeopleFDeskID = ?", withArgumentsIn: [self.StayInfoID, PeopleFDeskID]){
                    while rs.next() {
                        self.iKeycardid = rs.string(forColumn: "iKeycardid")!
                    }
                } else {
                    print("select failure: \(db.lastErrorMessage())")
                }
                
            }
            
            
        }
        
        bodyView.frame = CGRect(x: 0.0, y: 44, width: width, height: height);
        itemsView.frame = CGRect(x: 0.05*width, y: 0.01*height, width: 0.9*width, height: 0.35*height);
        ResCredView.frame = CGRect(x: 0.05*width, y: 0.34*height, width: 0.9*width, height: 0.45*height);
        
        let lblHuesped = UILabel(frame: CGRect(x: 0.01*width, y: 0.01*height, width: 0.25*width, height: 0.04*height));
        lblHuesped.backgroundColor = UIColor.clear;
        lblHuesped.textAlignment = NSTextAlignment.left;
        lblHuesped.textColor = colorWithHexString("206ec6")
        lblHuesped.numberOfLines = 1;
        lblHuesped.font = UIFont(name: "Verdana-Bold", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblHuesped.text = NSLocalizedString("lblKeys",comment:"") + ":";
        lblHuesped.adjustsFontSizeToFitWidth = true
        
        let lblHuespedNames = UILabel(frame: CGRect(x: 0.27*width, y: 0, width: 0.65*width, height: 0.08*height));
        lblHuespedNames.backgroundColor = UIColor.clear;
        lblHuespedNames.textAlignment = NSTextAlignment.left;
        lblHuespedNames.textColor = colorWithHexString("465261")
        lblHuespedNames.numberOfLines = 0;
        lblHuespedNames.font = UIFont(name: "Verdana", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblHuespedNames.text = strPeopleName;
        lblHuespedNames.adjustsFontSizeToFitWidth = true
        //lblHuespedNames.sizeToFit()
        
        let lineView = UIView(frame: CGRect(x: 0.45*width, y: 0.13*height, width: 1.0, height: 0.1*height))
        lineView.layer.borderWidth = 1.0
        lineView.layer.borderColor = colorWithHexString("a6a6a6").cgColor
        
        itemsView.addSubview(lineView)
        
        let lblBalance = UILabel(frame: CGRect(x: 0.3*width, y: 0.09*height, width: 0.3*width, height: 0.03*height));
        lblBalance.backgroundColor = UIColor.clear;
        lblBalance.textAlignment = NSTextAlignment.center;
        lblBalance.textColor = colorWithHexString("a6a6a6")
        lblBalance.numberOfLines = 1;
        lblBalance.font = UIFont(name: "Verdana", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblBalance.text = NSLocalizedString("strBalance",comment:"");
        lblBalance.adjustsFontSizeToFitWidth = true
        
        let lblMontoPesos = UILabel(frame: CGRect(x: 0.0, y: 0.12*height, width: 0.4*width, height: 0.06*height));
        lblMontoPesos.backgroundColor = UIColor.clear;
        lblMontoPesos.textAlignment = NSTextAlignment.center;
        lblMontoPesos.textColor = colorWithHexString("011125")
        lblMontoPesos.numberOfLines = 1;
        lblMontoPesos.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
        lblMontoPesos.text = "$" + String(format: "%.2f", (String(format: "%.2f0", ((fAmount).description as NSString).floatValue) as NSString).floatValue);
        lblMontoPesos.adjustsFontSizeToFitWidth = true
        
        let lblMontoDolares = UILabel(frame: CGRect(x: 0.5*width, y: 0.12*height, width: 0.4*width, height: 0.06*height));
        lblMontoDolares.backgroundColor = UIColor.clear;
        lblMontoDolares.textAlignment = NSTextAlignment.center;
        lblMontoDolares.textColor = colorWithHexString("011125")
        lblMontoDolares.numberOfLines = 1;
        lblMontoDolares.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
        lblMontoDolares.text = "$" + String(format: "%.2f", (String(format: "%.2f0", ((fAmount/fDollar).description as NSString).floatValue) as NSString).floatValue);
        lblMontoDolares.adjustsFontSizeToFitWidth = true
        
        let lblPesos = UILabel(frame: CGRect(x: 0.0, y: 0.16*height, width: 0.4*width, height: 0.06*height));
        lblPesos.backgroundColor = UIColor.clear;
        lblPesos.textAlignment = NSTextAlignment.center;
        lblPesos.textColor = colorWithHexString("011125")
        lblPesos.numberOfLines = 1;
        lblPesos.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
        lblPesos.text = "MXN";
        lblPesos.adjustsFontSizeToFitWidth = true
        
        let lblDolares = UILabel(frame: CGRect(x: 0.5*width, y: 0.16*height, width: 0.4*width, height: 0.06*height));
        lblDolares.backgroundColor = UIColor.clear;
        lblDolares.textAlignment = NSTextAlignment.center;
        lblDolares.textColor = colorWithHexString("011125")
        lblDolares.numberOfLines = 1;
        lblDolares.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
        lblDolares.text = "USD";
        lblDolares.adjustsFontSizeToFitWidth = true
        
        let lblTipoCambio = UILabel(frame: CGRect(x: 0.0, y: 0.25*height, width: 0.9*width, height: 0.03*height));
        lblTipoCambio.backgroundColor = UIColor.clear;
        lblTipoCambio.textAlignment = NSTextAlignment.center;
        lblTipoCambio.textColor = colorWithHexString("a6a6a6")
        lblTipoCambio.numberOfLines = 1;
        lblTipoCambio.font = UIFont(name: "Verdana", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblTipoCambio.text = "$" + String(format: "%.2f", (String(format: "%.2f0", ((fDollar).description as NSString).floatValue) as NSString).floatValue) + " MXN = 1 USD";
        lblTipoCambio.adjustsFontSizeToFitWidth = true
        
        let lblFormaPago = UILabel(frame: CGRect(x: 0.0, y: 0.28*height, width: 0.9*width, height: 0.04*height));
        lblFormaPago.backgroundColor = UIColor.clear;
        lblFormaPago.textAlignment = NSTextAlignment.center;
        lblFormaPago.textColor = colorWithHexString("a6a6a6")
        lblFormaPago.numberOfLines = 1;
        lblFormaPago.font = UIFont(name: "Verdana", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblFormaPago.text = NSLocalizedString("strPayment",comment:"") + ":";
        lblFormaPago.adjustsFontSizeToFitWidth = true
        

        imgResCred = UIImage(named: "ic_check")!
        imgvw = UIImageView(image: imgResCred)
        imgvw.frame = CGRect(x: 0.17*width, y: 0.01*height, width: imgvw.image!.size.width, height: imgvw.image!.size.height);
        imgvw.image = imgvw.image?.withRenderingMode(.alwaysTemplate)
        imgvw.tintColor = colorWithHexString("206ec6")
        
        let lblResortCred = UILabel(frame: CGRect(x: 0.25*width, y: 0.01*height, width: 0.5*width, height: 0.03*height));
        lblResortCred.backgroundColor = UIColor.clear;
        lblResortCred.textAlignment = NSTextAlignment.left;
        lblResortCred.textColor = colorWithHexString("465261")
        lblResortCred.numberOfLines = 1;
        lblResortCred.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
        lblResortCred.text = "RESORT CREDITS";
        lblResortCred.adjustsFontSizeToFitWidth = true

        let lblCredMax = UILabel(frame: CGRect(x: 0.01*width, y: 0.06*height, width: 0.5*width, height: 0.03*height));
        lblCredMax.backgroundColor = UIColor.clear;
        lblCredMax.textAlignment = NSTextAlignment.left;
        lblCredMax.textColor = colorWithHexString("206ec6")
        lblCredMax.numberOfLines = 1;
        lblCredMax.font = UIFont(name: "Verdana", size: appDelegate.gblFont7 + appDelegate.gblDeviceFont7)
        lblCredMax.text = NSLocalizedString("strMaxCred",comment:"");
        lblCredMax.adjustsFontSizeToFitWidth = true
        
        let lblCredMaxAmount = UILabel(frame: CGRect(x: 0.6*width, y: 0.06*height, width: 0.2*width, height: 0.03*height));
        lblCredMaxAmount.backgroundColor = UIColor.clear;
        lblCredMaxAmount.textAlignment = NSTextAlignment.left;
        lblCredMaxAmount.textColor = colorWithHexString("465261")
        lblCredMaxAmount.numberOfLines = 1;
        lblCredMaxAmount.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
        lblCredMaxAmount.text = "$" + String(format: "%.2f", (String(format: "%.2f0", ((appDelegate.gblResCredMax).description as NSString).floatValue) as NSString).floatValue) + " USD";
        lblCredMaxAmount.adjustsFontSizeToFitWidth = true
        
        let lblDispAcc = UILabel(frame: CGRect(x: 0.01*width, y: 0.1*height, width: 0.5*width, height: 0.03*height));
        lblDispAcc.backgroundColor = UIColor.clear;
        lblDispAcc.textAlignment = NSTextAlignment.left;
        lblDispAcc.textColor = colorWithHexString("206ec6")
        lblDispAcc.numberOfLines = 1;
        lblDispAcc.font = UIFont(name: "Verdana", size: appDelegate.gblFont7 + appDelegate.gblDeviceFont7)
        lblDispAcc.text = NSLocalizedString("strAvailAcc",comment:"");
        lblDispAcc.adjustsFontSizeToFitWidth = true
        
        let lblDispAccAmount = UILabel(frame: CGRect(x: 0.6*width, y: 0.1*height, width: 0.2*width, height: 0.03*height));
        lblDispAccAmount.backgroundColor = UIColor.clear;
        lblDispAccAmount.textAlignment = NSTextAlignment.left;
        lblDispAccAmount.textColor = colorWithHexString("465261")
        lblDispAccAmount.numberOfLines = 1;
        lblDispAccAmount.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
        lblDispAccAmount.text = "$" + String(format: "%.2f", (String(format: "%.2f0", ((appDelegate.gblResCredAmount).description as NSString).floatValue) as NSString).floatValue) + " USD";
        lblDispAccAmount.adjustsFontSizeToFitWidth = true
        
        
        let lblSaldoApp = UILabel(frame: CGRect(x: 0.01*width, y: 0.14*height, width: 0.5*width, height: 0.03*height));
        lblSaldoApp.backgroundColor = UIColor.clear;
        lblSaldoApp.textAlignment = NSTextAlignment.left;
        lblSaldoApp.textColor = colorWithHexString("206ec6")
        lblSaldoApp.numberOfLines = 1;
        lblSaldoApp.font = UIFont(name: "Verdana", size: appDelegate.gblFont7 + appDelegate.gblDeviceFont7)
        lblSaldoApp.text = NSLocalizedString("strCredApply",comment:"")
        lblSaldoApp.adjustsFontSizeToFitWidth = true
        
        let lblSaldoAppAmount = UILabel(frame: CGRect(x: 0.6*width, y: 0.14*height, width: 0.2*width, height: 0.03*height));
        lblSaldoAppAmount.backgroundColor = UIColor.clear;
        lblSaldoAppAmount.textAlignment = NSTextAlignment.left;
        lblSaldoAppAmount.textColor = colorWithHexString("465261")
        lblSaldoAppAmount.numberOfLines = 1;
        lblSaldoAppAmount.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
        lblSaldoAppAmount.text = "$" + String(format: "%.2f", (String(format: "%.2f0", ((((fAmount/fDollar) - appDelegate.gblResCredAmount)).description as NSString).floatValue) as NSString).floatValue) + " USD";
        lblSaldoAppAmount.adjustsFontSizeToFitWidth = true
        
        let lblResCredNota = UILabel(frame: CGRect(x: 0.01*width, y: 0.2*height, width: 0.9*width, height: 0.1*height));
        lblResCredNota.backgroundColor = UIColor.clear;
        lblResCredNota.textAlignment = NSTextAlignment.left;
        lblResCredNota.textColor = colorWithHexString("465261")
        lblResCredNota.numberOfLines = 0;
        lblResCredNota.font = UIFont(name: "Verdana", size: appDelegate.gblFont7 + appDelegate.gblDeviceFont7)
        lblResCredNota.text = NSLocalizedString("strTextResCred",comment:"");
        lblResCredNota.adjustsFontSizeToFitWidth = true
        
        let lblFooterMsg = UILabel(frame: CGRect(x: 0.01*width, y: 0.31*height, width: 0.9*width, height: 0.1*height));
        lblFooterMsg.backgroundColor = UIColor.clear;
        lblFooterMsg.textAlignment = NSTextAlignment.left;
        lblFooterMsg.textColor = colorWithHexString("a6a6a6")
        lblFooterMsg.numberOfLines = 0;
        lblFooterMsg.font = UIFont(name: "Verdana", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblFooterMsg.text = NSLocalizedString("strResortCreditRestrictionsMsj",comment:"");
        lblFooterMsg.adjustsFontSizeToFitWidth = true
        
        btnResCredApply.frame = CGRect(x: 0.01*width, y: 0.42*height, width: 0.9*width, height: 0.05*height);
        btnResCredApply.setTitle(NSLocalizedString("strPagar",comment:""), for: UIControl.State())
        btnResCredApply.titleLabel?.font = UIFont(name: "Helvetica", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont4)
        btnResCredApply.backgroundColor = colorWithHexString("206ec6")
        btnResCredApply.layer.borderWidth = 0.8
        btnResCredApply.setTitleColor(UIColor.white, for: UIControl.State())
        btnResCredApply.titleLabel?.textAlignment = NSTextAlignment.center
        
        itemsView.addSubview(lblHuesped)
        itemsView.addSubview(lblHuespedNames)
        itemsView.addSubview(lblBalance)
        itemsView.addSubview(lblMontoPesos)
        itemsView.addSubview(lblMontoDolares)
        itemsView.addSubview(lblPesos)
        itemsView.addSubview(lblDolares)
        itemsView.addSubview(lblTipoCambio)
        itemsView.addSubview(lblFormaPago)
        
        ResCredView.addSubview(imgvw)
        ResCredView.addSubview(lblResortCred)
        ResCredView.addSubview(lblCredMax)
        ResCredView.addSubview(lblCredMaxAmount)
        ResCredView.addSubview(lblDispAcc)
        ResCredView.addSubview(lblDispAccAmount)
        ResCredView.addSubview(lblSaldoApp)
        ResCredView.addSubview(lblSaldoAppAmount)
        ResCredView.addSubview(lblResCredNota)
        ResCredView.addSubview(lblFooterMsg)
        ResCredView.addSubview(btnResCredApply)

        bodyView.addSubview(itemsView)
        bodyView.addSubview(ResCredView)
        
        self.view.addSubview(bodyView)
        
        btnResCredApply.addTarget(self, action: #selector(vcResortCred.clickResCred(_:)), for: UIControl.Event.touchUpInside)

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
    
    @objc func clickResCred(_ sender: AnyObject) {
        
            var tableItems = RRDataSet()
            var iRes: String = ""
            var tblRestResult: Dictionary<String, String>!
            var sRes: String = "Error"
            var iResult: String = ""
            var sResult: String = ""
            var ispResult: String = ""
            var sspResult: String = ""
        
            self.btnResCredApply.isUserInteractionEnabled = false
            self.btnResCredApply.isEnabled = false
        
            let todaysDate:Date = Date()
            let dtdateFormatter:DateFormatter = DateFormatter()
            dtdateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
            let DateInFormat:String = dtdateFormatter.string(from: todaysDate)
        
            var config : SwiftLoader.Config = SwiftLoader.Config()
            config.size = 100
            config.backgroundColor = UIColor(white: 1, alpha: 0.5)
            config.spinnerColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
            config.titleTextColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
            config.spinnerLineWidth = 2.0
            SwiftLoader.setConfig(config)
            SwiftLoader.show(animated: true)
            SwiftLoader.show(title: NSLocalizedString("lblLoading",comment:""), animated: true)
            
            var queueFM: FMDatabaseQueue?
            
            queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
            
            let queue = OperationQueue()

                    var AccountInfo: Dictionary<String, String>
                    var PeopleInfo: Dictionary<String, String>
                    var iCountPeople: Int32 = 0
                    var USDExchange: String = ""
                    var ynExist: Bool=false
                    var fkAccTrxID: Int = 0
                    
                    var strFullName: String = ""
                    
                    AccountInfo = [:]
                    PeopleInfo = [:]

                    
                    self.LastAccTrxID  = ""
                    
                    queueFM?.inTransaction { db, rollback in
                        do {
                            
                            try db.executeUpdate("DELETE FROM tblAccount", withArgumentsIn: [])
                            
                        } catch {
                            rollback.pointee = true
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
                                    
                                    if (Int(iRes)! > 0){
                                        
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
                                                
                                                if Int(((r as AnyObject).getColumnByName("Age").content as? String)!)! > 99{
                                                    strAge = "0"
                                                }else{
                                                    strAge = ((r as AnyObject).getColumnByName("Age").content as? String)!
                                                }
                                                
                                                if db.executeUpdate("INSERT INTO tblPerson (StayInfoID,DatabaseName,PersonID,FullName,FirstName, MiddleName, LastName, SecondLName, EmailAddress, PeopleFDeskID, YearBirthDay, ynPrimary, ynPreRegisterAvailable, NumOfPeopleForStay, Age, pkPreRegisterID, PreRegisterTypeDesc, GuestType, RRRBalance, iKeycardid) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [((r as AnyObject).getColumnByName("StayInfoID").content as? String)!, ((r as AnyObject).getColumnByName("DatabaseName").content as? String)!, ((r as AnyObject).getColumnByName("PersonID").content as? String)!, ((r as AnyObject).getColumnByName("FullName").content as? String)!, ((r as AnyObject).getColumnByName("FirstName").content as? String)!, "", ((r as AnyObject).getColumnByName("LastName").content as? String)!, "", "", ((r as AnyObject).getColumnByName("PeopleFDeskID").content as? String)!, "0", "0", "0", "0", strAge, "0", "", "",((r as AnyObject).getColumnByName("RRRBalance").content as? String)!, ((r as AnyObject).getColumnByName("KeyCardID").content as? String)!]) {
                                                    
                                                    
                                                }
                                                
                                                if self.appDelegate.gstrPrimaryPeopleID == ((r as AnyObject).getColumnByName("PersonID").content as? String)!
                                                {
                                                    self.appDelegate.gstrPrimaryPeopleFdeskID = ((r as AnyObject).getColumnByName("PeopleFDeskID").content as? String)!
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                        
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
                                    
                                    /*var tblPostCheckOut = RRDataTable()
                                     tblPostCheckOut = tableItems.tables.object(at: 3) as! RRDataTable
                                     
                                     var rowResPostCheckOut = RRDataRow()
                                     rowResPostCheckOut = tblPostCheckOut.rows.object(at: 0) as! RRDataRow
                                     
                                     var strInPostCheckOutProcess: String = ""
                                     
                                     strInPostCheckOutProcess = rowResPostCheckOut.getColumnByName("ynInPostCheckOutProcess").content as! String
                                     
                                     if strInPostCheckOutProcess == "False"{
                                     self.ynInPostCheckOutProcess = false
                                     }else{
                                     self.ynInPostCheckOutProcess = true
                                     
                                     queueFM?.inTransaction { db, rollback in
                                     do {
                                     
                                     try db.executeUpdate("UPDATE tblStay SET ynPostCheckout=1 WHERE StayInfoID=?", withArgumentsIn: [self.StayInfoID])
                                     
                                     } catch {
                                     rollback.pointee = true
                                     return
                                     }
                                     }
                                     }*/
                                    
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
                                            
                                        }

                                    }else{
                                        
                                        self.appDelegate.gblynResortCredits = false
                                        
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
                                    
                                    
                                }

                            }//if (tableItems.getTotalTables() > 0 )
                            if self.appDelegate.gblynResortCredits == true
                            {
                            queue.addOperation() {//1
                                //accion base de datos
                                //print("A1")
                                if Reachability.isConnectedToNetwork(){
                                    UIApplication.shared.isNetworkActivityIndicatorVisible = true

                                        let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                                        tableItems = (service!.spAddFdeskAccTrx(self.appDelegate.strDataBaseByStay, iAccid: self.iAccID.description, sTrxTypeCode: "RESCRED", iKeycardid: self.iKeycardid.description, sPlacecode: self.PlaceCode, sDocument: self.appDelegate.gblStayInfoCatProductID, sRemark: "RESORT CREDIT" + self.appDelegate.gblStayInfoCatProductID, dTrxdate: DateInFormat, mSubTotal: self.appDelegate.gblResCredAmount.description, mTax1: "0", mTax2: "0", mTax3: "0", mSubtotalExento: "0", mSubtotalBaseCero: "0", mTip1: "0", mTip2: "0", mTotal: self.appDelegate.gblResCredAmount.description, sFolioType: "FDESKTRX", iAccFolioID: "0", iCompleted:ispResult, sMsg:sspResult, sUserLogin: "", sOperation: "C", ynSkipConsumptionLimit: "1"))
                                    
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
                                                
                                                if rowResult.getColumnByName("iCompleted") != nil{
                                                    iRes = rowResult.getColumnByName("iCompleted").content as! String
                                                    sRes = rowResult.getColumnByName("sMsg").content as! String
                                                }else{
                                                    iRes = "-1"
                                                    sRes = rowResult.getColumnByName("sMsg").content as! String
                                                }
                                                
                                                if ( (iRes != "0") && (iRes != "-1")){
                                                    
                                                    
                                                    iResult = iRes
                                                    sResult = sRes
                                                    
                                                }else{
                                                    RKDropdownAlert.title(sRes, backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                                                }
                                                
                                            }
                                            
                                            OperationQueue.main.addOperation() {
                                                //accion
                                                if !Reachability.isConnectedToNetwork(){
                                                    RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                                                }
                                                
                                                if ( (iRes != "0") && (iRes != "-1")){
                                                    
                                                    if (Int(iResult)! > 0){
                                                        SwiftLoader.hide()
                                                        
                                                        GoogleWearAlert.showAlert(title:"ID: " + iResult, type: .success, duration: 4, iAction: 1, form: "Account Payment")
                                                        
                                                        let NextViewController = self.navigationController?.viewControllers[0]
                                                        self.navigationController?.popToViewController(NextViewController!, animated: false)
                                                        
                                                    }else{
                                                        SwiftLoader.hide()
                                                        RKDropdownAlert.title(sResult, backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                                                    }
                                                    
                                                }else{
                                                    SwiftLoader.hide()
                                                    RKDropdownAlert.title(sRes, backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                                                }
                                                
                                            }
                                    }//2
                                }//1
                            }
                            }else{
                                SwiftLoader.hide()
                                GoogleWearAlert.showAlert(title:NSLocalizedString("strResortCreditMsjError",comment:""), type: .error, duration: 4, iAction: 1, form: "Resort Credit Error")
                                
                                
                            }//ynResortCredits
                            
                            
                        }

                    }//1

    }

    
}
