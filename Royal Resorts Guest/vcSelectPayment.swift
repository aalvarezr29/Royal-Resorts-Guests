//
//  vcSelectPayment.swift
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

class vcSelectPayment: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var width: CGFloat!
    var height: CGFloat!
    var StayInfoID: String = ""
    var PeopleID: String = ""
    var PeopleFDeskID: String = ""
    var Stays: Dictionary<String, String>!
    var AccCode: String = ""
    var myArray: NSArray = [NSLocalizedString("strCreditCard",comment:""),NSLocalizedString("strPreAuth",comment:""),NSLocalizedString("strResortCred",comment:""), NSLocalizedString("strRewards",comment:"")]
    var tblFormaPago: UITableView!
    var fDollar: Double = 0.0
    var fAmount: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        self.view.backgroundColor = UIColor.white
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);

        let bodyView: UIView = UIView()
        let itemsView: UIView = UIView()
        
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

        bodyView.frame = CGRect(x: 0.0, y: 44, width: width, height: height);
        itemsView.frame = CGRect(x: 0.05*width, y: 0.01*height, width: 0.9*width, height: 0.4*height);

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
        
        let lblTipoCambio = UILabel(frame: CGRect(x: 0.0, y: 0.27*height, width: 0.9*width, height: 0.03*height));
        lblTipoCambio.backgroundColor = UIColor.clear;
        lblTipoCambio.textAlignment = NSTextAlignment.center;
        lblTipoCambio.numberOfLines = 1;
        lblTipoCambio.font = UIFont(name: "Verdana", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblTipoCambio.text = "$" + String(format: "%.2f", (String(format: "%.2f0", ((fDollar).description as NSString).floatValue) as NSString).floatValue) + " MXN = 1 USD";
        lblTipoCambio.adjustsFontSizeToFitWidth = true
        
        let lblFormaPago = UILabel(frame: CGRect(x: 0.0, y: 0.3*height, width: 0.9*width, height: 0.04*height));
        lblFormaPago.backgroundColor = UIColor.clear;
        lblFormaPago.textAlignment = NSTextAlignment.center;
        lblFormaPago.numberOfLines = 1;
        lblFormaPago.font = UIFont(name: "Verdana", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblFormaPago.text = NSLocalizedString("strPayment",comment:"") + ":";
        lblFormaPago.adjustsFontSizeToFitWidth = true

        itemsView.addSubview(lblHuesped)
        itemsView.addSubview(lblHuespedNames)
        itemsView.addSubview(lblBalance)
        itemsView.addSubview(lblMontoPesos)
        itemsView.addSubview(lblMontoDolares)
        itemsView.addSubview(lblPesos)
        itemsView.addSubview(lblDolares)
        itemsView.addSubview(lblTipoCambio)
        itemsView.addSubview(lblFormaPago)
        
        tblFormaPago = UITableView(frame: CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.3*height));
        tblFormaPago.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tblFormaPago.dataSource = self
        tblFormaPago.delegate = self
        
        tblFormaPago.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        let lblFooterMsg = UILabel(frame: CGRect(x: 0.05*width, y: 0.7*height, width: 0.9*width, height: 0.1*height));
        lblFooterMsg.backgroundColor = UIColor.clear;
        lblFooterMsg.textAlignment = NSTextAlignment.left;
        lblFooterMsg.numberOfLines = 0;
        lblFooterMsg.font = UIFont(name: "Verdana", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblFooterMsg.text = NSLocalizedString("strRewardsMsj",comment:"");
        lblFooterMsg.adjustsFontSizeToFitWidth = true
        
        bodyView.addSubview(itemsView)
        bodyView.addSubview(tblFormaPago)
        //bodyView.addSubview(lblFooterMsg)
        
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
            lblFooterMsg.textColor = colorWithHexString("a6a6a6")
            
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
            lblFooterMsg.textColor = colorWithHexString("ba8748")
            
        }
        
        self.view.addSubview(bodyView)
        
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch myArray[indexPath.row] as! String {
        case NSLocalizedString("strCreditCard",comment:""):
            
            if (fAmount > 0.1)
            {
                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcGuestAccountPayment") as! vcGuestAccountPayment
                tercerViewController.StayInfoID = self.StayInfoID
                tercerViewController.PeopleID = self.PeopleID
                tercerViewController.PeopleFDeskID = self.PeopleFDeskID
                tercerViewController.ynPreAuth = false
                tercerViewController.ynPreAuthCreditCard = false
                tercerViewController.PreAmount = "0"
                self.navigationController?.pushViewController(tercerViewController, animated: true)
            }
            
        case NSLocalizedString("strResortCred",comment:""):
            
            if appDelegate.gblynResortCredits == true
            {
                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcResortCred") as! vcResortCred
                tercerViewController.StayInfoID = self.StayInfoID
                tercerViewController.PeopleID = self.PeopleID
                tercerViewController.PeopleFDeskID = self.PeopleFDeskID
                self.navigationController?.pushViewController(tercerViewController, animated: true)
            }
            
        case NSLocalizedString("strPreAuth",comment:""):
            
            if appDelegate.gblynPreAuth == true
            {
                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcPreAuth") as! vcPreAuth
                tercerViewController.StayInfoID = self.StayInfoID
                tercerViewController.PeopleID = self.PeopleID
                tercerViewController.PeopleFDeskID = self.PeopleFDeskID
                self.navigationController?.pushViewController(tercerViewController, animated: true)
            }
            
        case NSLocalizedString("strRewards",comment:""):
            
            if appDelegate.gblRRRewards > 0
            {
                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcRRRewards") as! vcRRRewards
                tercerViewController.StayInfoID = self.StayInfoID
                tercerViewController.PeopleID = self.PeopleID
                tercerViewController.PeopleFDeskID = self.PeopleFDeskID
                self.navigationController?.pushViewController(tercerViewController, animated: true)
            }
            
        default:
            if (fAmount > 0.1)
            {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var haux: CGFloat
        
        if appDelegate.ynIPad{
            haux = 0.07*height
        }else{
            haux = 0.07*height
        }
        
        return haux
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 0.05
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.textLabel!.text = "\(myArray[indexPath.row])"
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        //appDelegate.gblynPreAuth
        //appDelegate.gblynResortCredits
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            cell.layer.borderColor = colorWithHexString("2b3b6a").cgColor
            cell.tintColor = colorWithHexString("2b3b6a")
            cell.textLabel?.textColor = UIColor.black
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            cell.layer.borderColor = colorWithHexString("ba8748").cgColor
            cell.tintColor = colorWithHexString("ba8748")
            cell.textLabel?.textColor = colorWithHexString("ba8748")
            
        }
        
        switch myArray[indexPath.row] as! String {
        case NSLocalizedString("strCreditCard",comment:""):
            if (fAmount > 0.1)
            {
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            }else{
                cell.accessoryType = UITableViewCell.AccessoryType.none
            }
        case NSLocalizedString("strResortCred",comment:""):
            if appDelegate.gblynResortCredits == true
            {
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            }else{
                cell.accessoryType = UITableViewCell.AccessoryType.none
            }
        case NSLocalizedString("strPreAuth",comment:""):
            if appDelegate.gblynPreAuth == true
            {
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            }else{
                cell.accessoryType = UITableViewCell.AccessoryType.none
            }
        case NSLocalizedString("strRewards",comment:""):

            if appDelegate.gblRRRewards > 0
            {
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            }else{
                cell.accessoryType = UITableViewCell.AccessoryType.none
            }
        default:
                cell.accessoryType = UITableViewCell.AccessoryType.none

        }

        return cell
    }
    
}
