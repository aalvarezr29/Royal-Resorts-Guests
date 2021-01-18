//
//  vcRRRewards.swift
//  Royal Resorts Guest
//
//  Created by Soluciones on 10/9/19.
//  Copyright © 2019 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging

class vcRRRewards: UIViewController, UITextFieldDelegate {
    
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
    var aRes: [String] = []
    var fRewardsAmount: Double = 0
    
    var lblRewards: UILabel = UILabel()
    var lblAvailRewards: UILabel = UILabel()
    var lblAvailRewardsAmount: UILabel = UILabel()
    var lblAmountRewardsText: UILabel = UILabel()
    var txtAmountRewards: UITextField = UITextField()
    var lblAmountRewardsUSDText: UILabel = UILabel()
    var lblAmountRewardsUSD: UILabel = UILabel()
    var lblAmountRewardsMXNText: UILabel = UILabel()
    var lblAmountRewardsMXN: UILabel = UILabel()
    var lblResCredNota: UILabel = UILabel()
    var USDExchange: String = ""
    var fBalance: Double = 0.0
    var strPlaceID: String = ""
    var strAccCode: String = ""
    var dblMaxAmount: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height

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
                    StaysAux["fkPropertyID"] = String(describing: rs.string(forColumn: "fkPropertyID")!)
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
        strPlaceID = Stays["fkPlaceID"]!.description
        strAccCode = Stays["AccCode"]!.description
            
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
                
                if let rs = db.executeQuery("SELECT p.* FROM tblPerson p inner join tblStay s on s.StayInfoID = p.StayInfoID WHERE s.StayInfoID = ? AND p.personID = ? AND p.iKeycardid > 0", withArgumentsIn: [self.StayInfoID, self.appDelegate.gstrLoginPeopleID]){
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
                
                if let rs = db.executeQuery("SELECT p.* FROM tblPerson p inner join tblStay s on s.StayInfoID = p.StayInfoID WHERE s.StayInfoID = ? AND p.PeopleFDeskID = ? AND p.iKeycardid > 0", withArgumentsIn: [self.StayInfoID, PeopleFDeskID]){
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

        self.dblMaxAmount = (self.fAmount/self.fDollar) * self.appDelegate.RewardPerDollar
        
        let lblHuesped = UILabel(frame: CGRect(x: 0.01*width, y: 0.01*height, width: 0.25*width, height: 0.04*height));
        lblHuesped.backgroundColor = UIColor.clear;
        lblHuesped.textAlignment = NSTextAlignment.left;
        lblHuesped.numberOfLines = 1;
        lblHuesped.font = UIFont(name: "Verdana-Bold", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblHuesped.text = NSLocalizedString("lblKeys",comment:"") + ":";
        lblHuesped.adjustsFontSizeToFitWidth = true
        
        let lblHuespedNames = UILabel(frame: CGRect(x: 0.27*width, y: 0, width: 0.65*width, height: 0.08*height));
        lblHuespedNames.backgroundColor = UIColor.clear;
        lblHuespedNames.textAlignment = NSTextAlignment.left;
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
        lblBalance.numberOfLines = 1;
        lblBalance.font = UIFont(name: "Verdana", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblBalance.text = NSLocalizedString("strBalance",comment:"");
        lblBalance.adjustsFontSizeToFitWidth = true
        
        let lblMontoPesos = UILabel(frame: CGRect(x: 0.0, y: 0.12*height, width: 0.4*width, height: 0.06*height));
        lblMontoPesos.backgroundColor = UIColor.clear;
        lblMontoPesos.textAlignment = NSTextAlignment.center;
        lblMontoPesos.numberOfLines = 1;
        lblMontoPesos.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
        lblMontoPesos.text = "$" + String(format: "%.2f", (String(format: "%.2f0", ((fAmount).description as NSString).floatValue) as NSString).floatValue);
        lblMontoPesos.adjustsFontSizeToFitWidth = true
        
        let lblMontoDolares = UILabel(frame: CGRect(x: 0.5*width, y: 0.12*height, width: 0.4*width, height: 0.06*height));
        lblMontoDolares.backgroundColor = UIColor.clear;
        lblMontoDolares.textAlignment = NSTextAlignment.center;
        lblMontoDolares.numberOfLines = 1;
        lblMontoDolares.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
        lblMontoDolares.text = "$" + String(format: "%.2f", (String(format: "%.2f0", ((fAmount/fDollar).description as NSString).floatValue) as NSString).floatValue);
        lblMontoDolares.adjustsFontSizeToFitWidth = true
        
        let lblPesos = UILabel(frame: CGRect(x: 0.0, y: 0.16*height, width: 0.4*width, height: 0.06*height));
        lblPesos.backgroundColor = UIColor.clear;
        lblPesos.textAlignment = NSTextAlignment.center;
        lblPesos.numberOfLines = 1;
        lblPesos.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
        lblPesos.text = "MXN";
        lblPesos.adjustsFontSizeToFitWidth = true
        
        let lblDolares = UILabel(frame: CGRect(x: 0.5*width, y: 0.16*height, width: 0.4*width, height: 0.06*height));
        lblDolares.backgroundColor = UIColor.clear;
        lblDolares.textAlignment = NSTextAlignment.center;
        lblDolares.numberOfLines = 1;
        lblDolares.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
        lblDolares.text = "USD";
        lblDolares.adjustsFontSizeToFitWidth = true
        
        let lblTipoCambio = UILabel(frame: CGRect(x: 0.0, y: 0.25*height, width: 0.9*width, height: 0.03*height));
        lblTipoCambio.backgroundColor = UIColor.clear;
        lblTipoCambio.textAlignment = NSTextAlignment.center;
        lblTipoCambio.numberOfLines = 1;
        lblTipoCambio.font = UIFont(name: "Verdana", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblTipoCambio.text = "$" + String(format: "%.2f", (String(format: "%.2f0", ((fDollar).description as NSString).floatValue) as NSString).floatValue) + " MXN = 1 USD";
        lblTipoCambio.adjustsFontSizeToFitWidth = true
        
        let lblFormaPago = UILabel(frame: CGRect(x: 0.0, y: 0.28*height, width: 0.9*width, height: 0.04*height));
        lblFormaPago.backgroundColor = UIColor.clear;
        lblFormaPago.textAlignment = NSTextAlignment.center;
        lblFormaPago.numberOfLines = 1;
        lblFormaPago.font = UIFont(name: "Verdana", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblFormaPago.text = NSLocalizedString("strPayment",comment:"") + ":";
        lblFormaPago.adjustsFontSizeToFitWidth = true
        
        
        imgResCred = UIImage(named: "ic_check")!
        imgvw = UIImageView(image: imgResCred)
        imgvw.frame = CGRect(x: 0.17*width, y: 0.01*height, width: imgvw.image!.size.width, height: imgvw.image!.size.height);
        imgvw.image = imgvw.image?.withRenderingMode(.alwaysTemplate)
        
        lblRewards = UILabel(frame: CGRect(x: 0.25*width, y: 0.01*height, width: 0.5*width, height: 0.03*height));
        lblRewards.backgroundColor = UIColor.clear;
        lblRewards.textAlignment = NSTextAlignment.left;
        lblRewards.numberOfLines = 1;
        lblRewards.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
        lblRewards.text = "RR REWARDS";
        lblRewards.adjustsFontSizeToFitWidth = true

        lblAvailRewards = UILabel(frame: CGRect(x: 0.01*width, y: 0.06*height, width: 0.5*width, height: 0.03*height));
        lblAvailRewards.backgroundColor = UIColor.clear;
        lblAvailRewards.textAlignment = NSTextAlignment.left;
        lblAvailRewards.numberOfLines = 1;
        lblAvailRewards.font = UIFont(name: "Verdana", size: appDelegate.gblFont7 + appDelegate.gblDeviceFont7)
        lblAvailRewards.text = NSLocalizedString("strAvailRewards",comment:"");
        lblAvailRewards.adjustsFontSizeToFitWidth = true
        
        lblAvailRewardsAmount = UILabel(frame: CGRect(x: 0.6*width, y: 0.06*height, width: 0.2*width, height: 0.03*height));
        lblAvailRewardsAmount.backgroundColor = UIColor.clear;
        lblAvailRewardsAmount.textAlignment = NSTextAlignment.right;
        lblAvailRewardsAmount.numberOfLines = 1;
        lblAvailRewardsAmount.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
        lblAvailRewardsAmount.text = String(format: "%.2f", (String(format: "%.2f0", 0.0) as NSString).floatValue);
        lblAvailRewardsAmount.adjustsFontSizeToFitWidth = true
        
        lblAmountRewardsText = UILabel(frame: CGRect(x: 0.01*width, y: 0.1*height, width: 0.5*width, height: 0.03*height));
        lblAmountRewardsText.backgroundColor = UIColor.clear;
        lblAmountRewardsText.textAlignment = NSTextAlignment.left;
        lblAmountRewardsText.numberOfLines = 1;
        lblAmountRewardsText.font = UIFont(name: "Verdana", size: appDelegate.gblFont7 + appDelegate.gblDeviceFont7)
        lblAmountRewardsText.text = NSLocalizedString("strAmountRewards",comment:"");
        lblAmountRewardsText.adjustsFontSizeToFitWidth = true

        txtAmountRewards = UITextField(frame: CGRect(x: 0.6*width, y: 0.1*height, width: 0.2*width, height: 0.03*height));
        txtAmountRewards.backgroundColor = UIColor.clear;
        txtAmountRewards.textAlignment = NSTextAlignment.right;
        txtAmountRewards.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
        txtAmountRewards.layer.borderColor = UIColor.black.cgColor
        txtAmountRewards.borderStyle = UITextField.BorderStyle.roundedRect
        txtAmountRewards.keyboardType = UIKeyboardType.numberPad
        txtAmountRewards.text = String(format: "%.2f", (String(format: "%.2f0", self.dblMaxAmount) as NSString).floatValue);
        txtAmountRewards.delegate = self

        lblAmountRewardsUSDText = UILabel(frame: CGRect(x: 0.01*width, y: 0.14*height, width: 0.5*width, height: 0.03*height));
        lblAmountRewardsUSDText.backgroundColor = UIColor.clear;
        lblAmountRewardsUSDText.textAlignment = NSTextAlignment.left;
        lblAmountRewardsUSDText.numberOfLines = 1;
        lblAmountRewardsUSDText.font = UIFont(name: "Verdana", size: appDelegate.gblFont7 + appDelegate.gblDeviceFont7)
        lblAmountRewardsUSDText.text = NSLocalizedString("strUSDAmountRewards",comment:"")
        lblAmountRewardsUSDText.adjustsFontSizeToFitWidth = true
        
        lblAmountRewardsUSD = UILabel(frame: CGRect(x: 0.6*width, y: 0.14*height, width: 0.2*width, height: 0.03*height));
        lblAmountRewardsUSD.backgroundColor = UIColor.clear;
        lblAmountRewardsUSD.textAlignment = NSTextAlignment.left;
        lblAmountRewardsUSD.numberOfLines = 1;
        lblAmountRewardsUSD.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
        lblAmountRewardsUSD.text = "$" + String(format: "%.2f", (String(format: "%.2f0", 0.0) as NSString).floatValue) + " USD";
        lblAmountRewardsUSD.adjustsFontSizeToFitWidth = true
        
        lblAmountRewardsMXNText = UILabel(frame: CGRect(x: 0.01*width, y: 0.18*height, width: 0.5*width, height: 0.03*height));
        lblAmountRewardsMXNText.backgroundColor = UIColor.clear;
        lblAmountRewardsMXNText.textAlignment = NSTextAlignment.left;2
        lblAmountRewardsMXNText.numberOfLines = 1;
        lblAmountRewardsMXNText.font = UIFont(name: "Verdana", size: appDelegate.gblFont7 + appDelegate.gblDeviceFont7)
        lblAmountRewardsMXNText.text = NSLocalizedString("strMXNAmountRewards",comment:"")
        lblAmountRewardsMXNText.adjustsFontSizeToFitWidth = true
        
        lblAmountRewardsMXN = UILabel(frame: CGRect(x: 0.6*width, y: 0.18*height, width: 0.2*width, height: 0.03*height));
        lblAmountRewardsMXN.backgroundColor = UIColor.clear;
        lblAmountRewardsMXN.textAlignment = NSTextAlignment.left;
        lblAmountRewardsMXN.numberOfLines = 1;
        lblAmountRewardsMXN.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont7)
        lblAmountRewardsMXN.text = "$" + String(format: "%.2f", (String(format: "%.2f0", 0.0) as NSString).floatValue) + " MXN";
        lblAmountRewardsMXN.adjustsFontSizeToFitWidth = true
        
        lblResCredNota = UILabel(frame: CGRect(x: 0.01*width, y: 0.26*height, width: 0.9*width, height: 0.1*height));
        lblResCredNota.backgroundColor = UIColor.clear;
        lblResCredNota.textAlignment = NSTextAlignment.left;
        lblResCredNota.numberOfLines = 0;
        lblResCredNota.font = UIFont(name: "Verdana", size: appDelegate.gblFont7 + appDelegate.gblDeviceFont7)
        lblResCredNota.text = NSLocalizedString("strRewardsText",comment:"");
        lblResCredNota.adjustsFontSizeToFitWidth = true

        btnResCredApply.frame = CGRect(x: 0.01*width, y: 0.42*height, width: 0.9*width, height: 0.05*height);
        btnResCredApply.setTitle(NSLocalizedString("strPagar",comment:""), for: UIControl.State())
        btnResCredApply.titleLabel?.font = UIFont(name: "Helvetica", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont4)
        btnResCredApply.layer.borderWidth = 0.8
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
        ResCredView.addSubview(lblRewards)
        ResCredView.addSubview(lblAvailRewards)
        ResCredView.addSubview(lblAvailRewardsAmount)
        ResCredView.addSubview(lblAmountRewardsText)
        ResCredView.addSubview(txtAmountRewards)
        ResCredView.addSubview(lblAmountRewardsUSDText)
        ResCredView.addSubview(lblAmountRewardsUSD)
        ResCredView.addSubview(lblAmountRewardsMXNText)
        ResCredView.addSubview(lblAmountRewardsMXN)
        ResCredView.addSubview(lblResCredNota)
        ResCredView.addSubview(btnResCredApply)
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            lblHuesped.textColor = colorWithHexString("206ec6")
            lblHuespedNames.textColor = colorWithHexString("465261")
            lblBalance.textColor = colorWithHexString("a6a6a6")
            lblMontoPesos.textColor = colorWithHexString("011125")
            lblMontoDolares.textColor = colorWithHexString("011125")
            lblPesos.textColor = colorWithHexString("011125")
            lblDolares.textColor = colorWithHexString("011125")
            lblTipoCambio.textColor = colorWithHexString("a6a6a6")
            lblFormaPago.textColor = colorWithHexString("a6a6a6")
            imgvw.tintColor = colorWithHexString("206ec6")
            lblRewards.textColor = colorWithHexString("465261")
            lblAvailRewards.textColor = colorWithHexString("206ec6")
            lblAvailRewardsAmount.textColor = colorWithHexString("465261")
            lblAmountRewardsText.textColor = colorWithHexString("206ec6")
            txtAmountRewards.textColor = colorWithHexString("465261")
            lblAmountRewardsUSDText.textColor = colorWithHexString("206ec6")
            lblAmountRewardsUSD.textColor = colorWithHexString("465261")
            lblAmountRewardsMXNText.textColor = colorWithHexString("206ec6")
            lblAmountRewardsMXN.textColor = colorWithHexString("465261")
            lblResCredNota.textColor = colorWithHexString("465261")
            btnResCredApply.backgroundColor = colorWithHexString("206ec6")
            btnResCredApply.setTitleColor(UIColor.white, for: UIControl.State())
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            lblHuesped.textColor = colorWithHexString("ba8748")
            lblHuespedNames.textColor = colorWithHexString("ba8748")
            lblBalance.textColor = colorWithHexString("ba8748")
            lblMontoPesos.textColor = colorWithHexString("ba8748")
            lblMontoDolares.textColor = colorWithHexString("ba8748")
            lblPesos.textColor = colorWithHexString("ba8748")
            lblDolares.textColor = colorWithHexString("ba8748")
            lblTipoCambio.textColor = colorWithHexString("ba8748")
            lblFormaPago.textColor = colorWithHexString("ba8748")
            imgvw.tintColor = colorWithHexString("ba8748")
            lblRewards.textColor = colorWithHexString("ba8748")
            lblAvailRewards.textColor = colorWithHexString("ba8748")
            lblAvailRewardsAmount.textColor = colorWithHexString("ba8748")
            lblAmountRewardsText.textColor = colorWithHexString("ba8748")
            txtAmountRewards.textColor = colorWithHexString("ba8748")
            lblAmountRewardsUSDText.textColor = colorWithHexString("ba8748")
            lblAmountRewardsUSD.textColor = colorWithHexString("ba8748")
            lblAmountRewardsMXNText.textColor = colorWithHexString("ba8748")
            lblAmountRewardsMXN.textColor = colorWithHexString("ba8748")
            lblResCredNota.textColor = colorWithHexString("ba8748")
            btnResCredApply.setTitleColor(self.colorWithHexString("ba8748"), for: UIControl.State())
            btnResCredApply.layer.borderWidth = 4
            btnResCredApply.layer.borderColor = self.colorWithHexString("7c6a56").cgColor
            btnResCredApply.backgroundColor = self.colorWithHexString("eee7dd")
        }
        
        bodyView.addSubview(itemsView)
        bodyView.addSubview(ResCredView)
        
        self.view.addSubview(bodyView)
        
        btnResCredApply.addTarget(self, action: #selector(vcRRRewards.clickResCred(_:)), for: UIControl.Event.touchUpInside)
        txtAmountRewards.addTarget(self, action: #selector(vcRRRewards.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        btnResCredApply.isEnabled = false

        recargarCCNumber()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if Double((textField.text! as NSString).floatValue) > 0{
            if Double((textField.text! as NSString).floatValue) > self.fRewardsAmount{
                RKDropdownAlert.title(NSLocalizedString("strRewardsAvail",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                textField.text = self.fRewardsAmount.description
                btnResCredApply.isEnabled = false
            }else{
 
                if Double((textField.text! as NSString).floatValue) > dblMaxAmount{
                    RKDropdownAlert.title(NSLocalizedString("strRewardsAvail",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                    textField.text = String(format: "%.2f0", self.dblMaxAmount)
                }else{
                    btnResCredApply.isEnabled = true
                }
                
            }
        }else{
            btnResCredApply.isEnabled = false
        }

        self.lblAmountRewardsUSD.text = "$" + String(format: "%.2f", (String(format: "%.2f0", Double((textField.text! as NSString).floatValue)/self.appDelegate.RewardPerDollar) as NSString).floatValue) + " USD";
        self.lblAmountRewardsMXN.text = "$" + String(format: "%.2f", (String(format: "%.2f0", (Double((textField.text! as NSString).floatValue)/self.appDelegate.RewardPerDollar) * self.fDollar) as NSString).floatValue) + " MXN"
        
    }
    
    func recargarCCNumber(){
        
        var tableItems = RRDataSet()
        var iRes: String = ""
        var sRes: String = ""
        
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 100
        config.backgroundColor = UIColor(white: 1, alpha: 0.5)
        config.spinnerColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.titleTextColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.spinnerLineWidth = 2.0
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        SwiftLoader.show(title: NSLocalizedString("lblLoading",comment:""), animated: true)
        
        /*appDelegate.gtblStay = nil
        appDelegate.gStaysStatus = nil*/

        var prepareOrderResult:NSString="";
        
        let queue = OperationQueue()
        
        queue.addOperation() {//1
            //accion webservice-db
            if Reachability.isConnectedToNetwork(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = true

                let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                tableItems = service!.wmGetRewardBalance(self.appDelegate.strDataBaseByStay, strPersonalID: self.appDelegate.gstrLoginPeopleID, ynDecryCred: "true")
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            OperationQueue.main.addOperation() {
                
                
                if (tableItems.getTotalTables() > 0 ){
                    
                    var tableResult = RRDataTable()
                    tableResult = tableItems.tables.object(at: 0) as! RRDataTable
                    
                    var rowResult = RRDataRow()
                    rowResult = tableResult.rows.object(at: 0) as! RRDataRow
                    
                    if rowResult.getColumnByName("intResult") != nil{
                        iRes = rowResult.getColumnByName("intResult").content as! String
                        self.fRewardsAmount = Double(((rowResult.getColumnByName("Balance").content as! String) as NSString).floatValue)
                        //self.fRewardsAmount = (rowResult.getColumnByName("Balance").content as! String) as! Double
                    }else{
                        iRes = "-1"
                    }
                    
                    if (Int(iRes)! > 0){

                        self.lblAvailRewardsAmount.text = String(format: "%.2f", (String(format: "%.2f0", self.fRewardsAmount) as NSString).floatValue);
                        
                        //self.lblAmountRewardsUSD.text = "$" + String(format: "%.2f", (String(format: "%.2f0", self.fRewardsAmount/self.appDelegate.RewardPerDollar) as NSString).floatValue) + " USD";
                        //self.lblAmountRewardsMXN.text = "$" + String(format: "%.2f", (String(format: "%.2f0", (self.fRewardsAmount/self.appDelegate.RewardPerDollar) * self.fDollar) as NSString).floatValue) + " MXN"
                        if self.dblMaxAmount > self.fRewardsAmount{
                            self.txtAmountRewards.text = String(format: "%.2f", (String(format: "%.2f0", self.fRewardsAmount) as NSString).floatValue);
                            self.lblAmountRewardsUSD.text = "$" + String(format: "%.2f", (String(format: "%.2f0", self.fRewardsAmount/self.appDelegate.RewardPerDollar) as NSString).floatValue) + " USD";
                            self.lblAmountRewardsMXN.text = "$" + String(format: "%.2f", (String(format: "%.2f0", (self.fRewardsAmount/self.appDelegate.RewardPerDollar) * self.fDollar) as NSString).floatValue) + " MXN"
                        }else{
                            self.lblAmountRewardsUSD.text = "$" + String(format: "%.2f", (String(format: "%.2f0", self.dblMaxAmount/self.appDelegate.RewardPerDollar) as NSString).floatValue) + " USD";
                            self.lblAmountRewardsMXN.text = "$" + String(format: "%.2f", (String(format: "%.2f0", (self.dblMaxAmount/self.appDelegate.RewardPerDollar) * self.fDollar) as NSString).floatValue) + " MXN"
                        }


                    }else{
                        
                        self.fRewardsAmount = 0.0
                        self.lblAvailRewardsAmount.text = "0.00"
                        self.lblAmountRewardsUSD.text = "$ 0.00 USD";
                        self.lblAmountRewardsMXN.text = "$ 0.00 MXN";
                        
                    }
                    self.btnResCredApply.isEnabled = true
                }
                
                SwiftLoader.hide()
                
            }
        }//1
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
        var sRes: String = ""
        
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
        
        var prepareOrderResult:NSString="";
        
        let queue = OperationQueue()
        
        queue.addOperation() {//1
            //accion webservice-db
            if Reachability.isConnectedToNetwork(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
                let todaysDate:Date = Date()
                let dateFormatter:DateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
                let DateInFormat:String = dateFormatter.string(from: todaysDate)
                
                let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                tableItems = service!.wmApplyRewardCharge(self.appDelegate.strDataBaseByStay, strAccId: self.iAccID, strTypeCode: "RRPPAY", iPersonaId: self.appDelegate.gstrLoginPeopleID, iKeycardID: self.iKeycardid, strPlaceCode: self.PlaceCode, mAmount: self.txtAmountRewards.text, iStoreId: self.strPlaceID, sCurrencyCode: "RRP", sDocument: "", sRemark: "RRR PAYMENT, " + self.strAccCode, dTrxDate: DateInFormat, sUserLogin: "usrGuestApp")
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            OperationQueue.main.addOperation() {
                
                
                if (tableItems.getTotalTables() > 0 ){
                    
                    var tableResult = RRDataTable()
                    tableResult = tableItems.tables.object(at: 0) as! RRDataTable
                    
                    var rowResult = RRDataRow()
                    rowResult = tableResult.rows.object(at: 0) as! RRDataRow
                    
                    if rowResult.getColumnByName("intResult") != nil{
                        iRes = rowResult.getColumnByName("intResult").content as! String
                    }else{
                        iRes = "-1"
                    }
                    
                    if (Int(iRes)! > 0){
                        self.appDelegate.gblPay = true
                        SwiftLoader.hide()
                        GoogleWearAlert.showAlert(title: NSLocalizedString("strPayRewards",comment:"") + " " + (rowResult.getColumnByName("AccTrxID").content as! String), type: .success, duration: 4, iAction: 1, form: "Account Payment")
                        let NextViewController = self.navigationController?.viewControllers[1]
                        self.navigationController?.popToViewController(NextViewController!, animated: false)
                    }else{
                        SwiftLoader.hide()
                        RKDropdownAlert.title(NSLocalizedString("strRewardsError",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
                        self.navigationController?.popViewController(animated: false)
                        
                    }
                    
                }

            }
        }//1
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var result = true
        var ireturn: Int = 11
        
        if textField == txtAmountRewards {

            let newLength = textField.text!.utf16.count + string.utf16.count - range.length
            result = (newLength <= ireturn)
            
            if string.characters.count > 0 && (result == true) {
                let disallowedCharacterSet = CharacterSet(charactersIn: "0123456789.").inverted
                let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }
            
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
    
    
}
