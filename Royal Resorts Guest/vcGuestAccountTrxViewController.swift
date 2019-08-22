//
//  vcGuestAccountTrxViewController.swift
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


class vcGuestAccountTrxViewController: UIViewController  , UITableViewDelegate, UITableViewDataSource
{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var width: CGFloat!
    var height: CGFloat!
    var fkAccTrxID: String!
    var StayInfoID: String!
    var PeopleID: String!
    var Voucher: String!
    var fSizeFont: CGFloat = 0
    var ynConn:Bool=false
    var btnBack = UIButton()
    var imgCell = UIImage()
    var imgvwCell = UIImageView()
    var URLTicket: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var BodyView: UIView!
    @IBOutlet weak var AccView: UIView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblKeycard: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblPlaceTrx: UILabel!
    @IBOutlet weak var lblDateTrx: UILabel!
    @IBOutlet weak var lblNameTrx: UILabel!
    @IBOutlet weak var lblAmountTrx: UILabel!
    @IBOutlet weak var lblSubTot: UILabel!
    @IBOutlet weak var lblSubTotTrx: UILabel!
    @IBOutlet weak var lblTip: UILabel!
    @IBOutlet weak var lblTipTrx: UILabel!
    @IBOutlet weak var barNavigate: UINavigationBar!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var btnAccount: UIBarButtonItem!
    @IBOutlet var ViewItem: UINavigationItem!
    
    var sinDatos = true;
    //var Account: Dictionary<String, String>!
    var VoucherDetail: [Dictionary<String, String>]!
    var formatter = NumberFormatter()

    
    @IBAction func clickGetDatos(_ sender: AnyObject) {
        sinDatos = false;
        tableView.reloadData()
    }
    
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
        ViewItem.title = "Voucher " + Voucher;
        
        BodyView.frame = CGRect(x: 0.0, y: 0.05*height, width: width, height: height);
        AccView.frame = CGRect(x: 0.05*width, y: 44 + 0.01*height, width: 0.9*width, height: 0.2*height);
        AccView.layer.cornerRadius = 10
        lblLocation.textAlignment = NSTextAlignment.right
        lblLocation.frame = CGRect(x: 0.02*width, y: 0.01*height, width: 0.2*width, height: 0.03*height);
        lblPlaceTrx.frame = CGRect(x: 0.3*width, y: 0.01*height, width: 0.6*width, height: 0.03*height);
        lblDate.textAlignment = NSTextAlignment.right
        lblDate.frame = CGRect(x: 0.02*width, y: 0.04*height, width: 0.2*width, height: 0.03*height);
        lblDateTrx.frame = CGRect(x: 0.3*width, y: 0.04*height, width: 0.6*width, height: 0.03*height);
        lblKeycard.textAlignment = NSTextAlignment.right
        lblKeycard.frame = CGRect(x: 0.02*width, y: 0.07*height, width: 0.2*width, height: 0.03*height);
        lblNameTrx.frame = CGRect(x: 0.3*width, y: 0.07*height, width: 0.6*width, height: 0.03*height);
        lblSubTot.textAlignment = NSTextAlignment.right
        lblSubTot.frame = CGRect(x: 0.02*width, y: 0.1*height, width: 0.2*width, height: 0.03*height);
        lblSubTotTrx.frame = CGRect(x: 0.3*width, y: 0.1*height, width: 0.6*width, height: 0.03*height);
        lblTip.textAlignment = NSTextAlignment.right
        lblTip.frame = CGRect(x: 0.02*width, y: 0.13*height, width: 0.2*width, height: 0.03*height);
        lblTipTrx.frame = CGRect(x: 0.3*width, y: 0.13*height, width: 0.6*width, height: 0.03*height);
        lblAmount.textAlignment = NSTextAlignment.right
        lblAmount.frame = CGRect(x: 0.02*width, y: 0.16*height, width: 0.2*width, height: 0.03*height);
        lblAmountTrx.frame = CGRect(x: 0.3*width, y: 0.16*height, width: 0.6*width, height: 0.03*height);
        btnApply.frame = CGRect(x: 0.1*width, y: 0.313*height, width: 0.8*width, height: 0.06*height);
        btnApply.layer.cornerRadius = 5

        tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.45*height);
        
        if appDelegate.ynIPad {
            switch appDelegate.Model {
            case "iPad 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
            case "iPad Air":
                tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
            case "iPad Air 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
            case "iPad Pro":
                tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
            case "iPad Retina":
                tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
            default:
                tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
            }
        }else{
            switch appDelegate.Model {
            case "iPhone":
                tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.45*height);
            case "iPhone 4":
                tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.45*height);
            case "iPhone 4s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.45*height);
            case "iPhone 5":
                tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.47*height);
            case "iPhone 5c":
                tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.47*height);
            case "iPhone 5s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.47*height);
            case "iPhone 6":
                tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.49*height);
            case "iPhone 6 Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.49*height);
            case "iPhone 6s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.49*height);
            case "iPhone 6s Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.49*height);
            default:
                tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.45*height);
            }
        }
        
        lblLocation.text = NSLocalizedString("lblLocation",comment:"")
        lblLocation.textColor = UIColor.black
        lblLocation.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblDate.text = NSLocalizedString("lblDate",comment:"")
        lblDate.textColor = UIColor.black
        lblDate.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblKeycard.text = NSLocalizedString("lblKeycard",comment:"")
        lblKeycard.textColor = UIColor.black
        lblKeycard.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblSubTot.text = NSLocalizedString("lblSubTot",comment:"")
        lblSubTot.textColor = UIColor.black
        lblSubTot.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblTip.text = NSLocalizedString("lblTip",comment:"")
        lblTip.textColor = UIColor.black
        lblTip.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblAmount.text = NSLocalizedString("lblAmount",comment:"")
        lblAmount.textColor = UIColor.black
        lblAmount.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        
        lblPlaceTrx.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        lblDateTrx.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        lblNameTrx.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        lblSubTotTrx.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        lblTipTrx.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        lblAmountTrx.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
        
        lblPlaceTrx.adjustsFontSizeToFitWidth = true
        lblDateTrx.adjustsFontSizeToFitWidth = true
        lblNameTrx.adjustsFontSizeToFitWidth = true
        lblSubTotTrx.adjustsFontSizeToFitWidth = true
        lblTipTrx.adjustsFontSizeToFitWidth = true
        lblAmountTrx.adjustsFontSizeToFitWidth = true
        
        mas = NSMutableAttributedString(string: NSLocalizedString("btnConsumption",comment:""), attributes: [
            NSAttributedString.Key.font: UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont3)!
            ])
        btnApply.setAttributedTitle(mas, for: UIControl.State())
        btnApply.titleLabel?.textAlignment = NSTextAlignment.center
        btnApply.titleLabel?.adjustsFontSizeToFitWidth = true
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        var Account: Dictionary<String, String>!
        var index: Int = 0
        
        Account = [:]
        
        queueFM?.inDatabase() {
            db in
            
            if let rs = db.executeQuery("SELECT PlaceDesc, TrxDate as TrxTime, FullName, SubTotal, Tips, Amount, a.StayInfoID FROM tblAccount a LEFT JOIN tblPerson p ON p.PersonID = a.PersonID WHERE a.fkAccTrxID = ?", withArgumentsIn: [self.fkAccTrxID]){
                while rs.next() {
                    Account["PlaceDesc"] = rs.string(forColumn: "PlaceDesc")!
                    Account["TrxTime"] = rs.string(forColumn: "TrxTime")!
                    Account["FullName"] = rs.string(forColumn: "FullName")!
                    Account["SubTotal"] = rs.string(forColumn: "SubTotal")!
                    Account["Tips"] = rs.string(forColumn: "Tips")!
                    Account["Amount"] = rs.string(forColumn: "Amount")!
                    Account["StayInfoID"] = rs.string(forColumn: "StayInfoID")!
                }
            } else {
                print("select failure: \(db.lastErrorMessage())")
            }
            
        }
                
        lblPlaceTrx.text = Account["PlaceDesc"]
        
        var fSubTotal: Float = 0
        var fTips: Float = 0
        var fAmount: Double = 0
        var str: String = ""
        
        var strdtDate: String=""
        
        let dtDate = moment(Account["TrxTime"]!)
        
        let strdateFormatter = DateFormatter()
        strdateFormatter.dateFormat = "yyyy-MM-dd";
        strdtDate = strdateFormatter.string(from: dtDate!.date)
        
        lblDateTrx.text = strdtDate
        lblNameTrx.text = Account["FullName"]
        
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        fSubTotal = (String(Account["SubTotal"]!) as NSString).floatValue

        str = String(format: "%.2f", (String(format: "%.2f0", (fSubTotal.description as NSString).floatValue) as NSString).floatValue)
        
        lblSubTotTrx.text = str
        
        fTips = (String(Account["Tips"]!) as NSString).floatValue
        
        str = String(format: "%.2f", (String(format: "%.2f0", (fTips.description as NSString).floatValue) as NSString).floatValue)
        
        lblTipTrx.text = str
        
        fAmount = Double(String(format: "%.2f", (Account["Amount"]! as NSString).floatValue))!
        
        str = String(format: "%.2f", (String(format: "%.2f0", (fAmount.description as NSString).floatValue) as NSString).floatValue)
        
        lblAmountTrx.text = str
        
        StayInfoID = Account["StayInfoID"]

        var VoucherDetailAux: [Dictionary<String, String>]

        VoucherDetailAux = []
        
        queueFM?.inDatabase() {
            db in
            
            if let rs = db.executeQuery("SELECT ItemCode, Quantity, ItemDesc, Total FROM tblAccountDetail WHERE fkAccTrxID = ?", withArgumentsIn: [self.fkAccTrxID]){
                while rs.next() {
                    VoucherDetailAux.append([:])
                    VoucherDetailAux[index]["ItemCode"] = rs.string(forColumn: "ItemCode")!
                    VoucherDetailAux[index]["Quantity"] = rs.string(forColumn: "Quantity")!
                    VoucherDetailAux[index]["ItemDesc"] = rs.string(forColumn: "ItemDesc")!
                    VoucherDetailAux[index]["Total"] = rs.string(forColumn: "Total")!
                    index = index + 1
                }
            } else {
                print("select failure: \(db.lastErrorMessage())")
            }
            
        }
        
        self.VoucherDetail = VoucherDetailAux
        
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            if (VoucherDetail.count>0)
            {
                btnApply.isEnabled = false
                btnApply.tintColor = UIColor.gray
                self.tableView.reloadData()
            }else{
                btnApply.tintColor = colorWithHexString("0080FF")
                btnApply.isEnabled = true
            }
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            AccView.backgroundColor = UIColor.clear
            AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.2*height);
            
            self.view.backgroundColor = UIColor.white
            tableView.backgroundColor = UIColor.white
            
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
            
            imgHdr = UIImage(named:"Titlefooter.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.15*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.5
            AccView.addSubview(imgHdrVw)
            
            var strFontTitle: String = "Futura-CondensedExtraBold"
            var Color: UIColor = colorWithHexString("ba8748")
            
            lblLocation.textColor = Color
            lblDate.textColor = Color
            lblKeycard.textColor = Color
            lblSubTot.textColor = Color
            lblTip.textColor = Color
            lblAmount.textColor = Color
            lblLocation.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblDate.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblKeycard.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblSubTot.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblTip.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblAmount.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            strFontTitle = "Futura-CondensedMedium"
            Color = colorWithHexString("ba8748")
            
            lblPlaceTrx.textColor = Color
            lblDateTrx.textColor = Color
            lblNameTrx.textColor = Color
            lblSubTotTrx.textColor = Color
            lblTipTrx.textColor = Color
            lblAmountTrx.textColor = Color
            lblPlaceTrx.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblDateTrx.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblNameTrx.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblSubTotTrx.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblTipTrx.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblAmountTrx.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            
            lblLocation.textAlignment = NSTextAlignment.left
            lblLocation.frame = CGRect(x: 0.02*width, y: 0.00001*height, width: 0.2*width, height: 0.03*height);
            lblDate.textAlignment = NSTextAlignment.left
            lblDate.frame = CGRect(x: 0.02*width, y: 0.029*height, width: 0.2*width, height: 0.03*height);
            lblKeycard.textAlignment = NSTextAlignment.left
            lblKeycard.frame = CGRect(x: 0.02*width, y: 0.058*height, width: 0.2*width, height: 0.03*height);
            lblSubTot.textAlignment = NSTextAlignment.left
            lblSubTot.frame = CGRect(x: 0.02*width, y: 0.087*height, width: 0.2*width, height: 0.03*height);
            lblTip.textAlignment = NSTextAlignment.left
            lblTip.frame = CGRect(x: 0.02*width, y: 0.116*height, width: 0.2*width, height: 0.03*height);
            lblAmount.textAlignment = NSTextAlignment.left
            lblAmount.frame = CGRect(x: 0.02*width, y: 0.146*height, width: 0.2*width, height: 0.03*height);
            
            lblPlaceTrx.numberOfLines = 0
            lblPlaceTrx.frame = CGRect(x: 0.24*width, y: 0.0001*height, width: 0.45*width, height: 0.03*height);
            lblDateTrx.numberOfLines = 0
            lblDateTrx.frame = CGRect(x: 0.24*width, y: 0.0297*height, width: 0.45*width, height: 0.03*height);
            lblNameTrx.numberOfLines = 0
            lblNameTrx.frame = CGRect(x: 0.24*width, y: 0.059*height, width: 0.45*width, height: 0.03*height);
            lblSubTotTrx.numberOfLines = 0
            lblSubTotTrx.frame = CGRect(x: 0.24*width, y: 0.0885*height, width: 0.6*width, height: 0.03*height);
            lblTipTrx.numberOfLines = 0
            lblTipTrx.frame = CGRect(x: 0.24*width, y: 0.117*height, width: 0.6*width, height: 0.03*height);
            lblAmountTrx.numberOfLines = 0
            lblAmountTrx.frame = CGRect(x: 0.24*width, y: 0.147*height, width: 0.6*width, height: 0.03*height);
            
            btnApply.frame = CGRect(x: 0.1*width, y: 0.313*height, width: 0.8*width, height: 0.06*height);
            
            AccView.addSubview(lblLocation)
            AccView.addSubview(lblPlaceTrx)
            AccView.addSubview(lblDate)
            AccView.addSubview(lblDateTrx)
            AccView.addSubview(lblKeycard)
            AccView.addSubview(lblNameTrx)
            AccView.addSubview(lblSubTot)
            AccView.addSubview(lblSubTotTrx)
            AccView.addSubview(lblTip)
            AccView.addSubview(lblTipTrx)
            AccView.addSubview(lblAmount)
            AccView.addSubview(lblAmountTrx)
            
            self.view.addSubview(btnApply)
            
            self.view.addSubview(AccView)
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            
            mas = NSMutableAttributedString(string: NSLocalizedString("btnConsumption",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:strFontTitle, size:appDelegate.gblFont7 + appDelegate.gblDeviceFont3)!
                ])
            btnApply.setAttributedTitle(mas, for: UIControl.State())
            btnApply.titleLabel?.textAlignment = NSTextAlignment.center
            btnApply.titleLabel?.adjustsFontSizeToFitWidth = true
            //btnApply.backgroundColor = self.colorWithHexString("ddf4ff")
            //btnApply.layer.borderColor = self.colorWithHexString("94cce5").CGColor
            //btnApply.layer.borderWidth = 3
            
            self.btnApply.setTitleColor(self.colorWithHexString("ba8748"), for: UIControl.State())
            self.btnApply.layer.borderWidth = 4
            self.btnApply.layer.borderColor = self.colorWithHexString("7c6a56").cgColor
            self.btnApply.backgroundColor = self.colorWithHexString("eee7dd")
            
            if (VoucherDetail.count>0)
            {
                btnApply.isEnabled = false
                btnApply.tintColor = UIColor.gray
                self.tableView.reloadData()
            }else{
                //btnApply.tintColor = colorWithHexString("00467f")
                btnApply.tintColor = colorWithHexString("ba8748")
                btnApply.isEnabled = true
            }
            
            if appDelegate.ynIPad {
                switch appDelegate.Model {
                case "iPad 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
                case "iPad Air":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
                case "iPad Air 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
                case "iPad Pro":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
                case "iPad Retina":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
                }
            }else{
                switch appDelegate.Model {
                case "iPhone":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.45*height);
                case "iPhone 4":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.45*height);
                case "iPhone 4s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.45*height);
                case "iPhone 5":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.47*height);
                case "iPhone 5c":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.47*height);
                case "iPhone 5s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.47*height);
                case "iPhone 6":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.49*height);
                case "iPhone 6 Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.49*height);
                case "iPhone 6s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.49*height);
                case "iPhone 6s Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.49*height);
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.45*height);
                }
            }
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            AccView.backgroundColor = UIColor.clear
            AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.2*height);
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            //tableView.backgroundColor = colorWithHexString ("DDF4FF")
            
            self.view.backgroundColor = UIColor.white
            tableView.backgroundColor = UIColor.white
                
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
            
            imgHdr = UIImage(named:"Titlerow.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.12*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.52
            AccView.addSubview(imgHdrVw)
            
            imgHdr = UIImage(named:"Titlefooter.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.15*height, width: 0.9*width, height: 0.03*height);
            imgHdrVw.contentMode = UIView.ContentMode.scaleToFill
            imgHdrVw.alpha = 0.5
            AccView.addSubview(imgHdrVw)
            
            var strFontTitle: String = "Futura-CondensedExtraBold"
            var Color: UIColor = colorWithHexString("5c9fcc")

            lblLocation.textColor = Color
            lblDate.textColor = Color
            lblKeycard.textColor = Color
            lblSubTot.textColor = Color
            lblTip.textColor = Color
            lblAmount.textColor = Color
            lblLocation.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblDate.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblKeycard.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblSubTot.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblTip.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            lblAmount.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
            
            strFontTitle = "Futura-CondensedMedium"
            Color = colorWithHexString("5c9fcc")
            
            lblPlaceTrx.textColor = Color
            lblDateTrx.textColor = Color
            lblNameTrx.textColor = Color
            lblSubTotTrx.textColor = Color
            lblTipTrx.textColor = Color
            lblAmountTrx.textColor = Color
            lblPlaceTrx.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblDateTrx.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblNameTrx.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblSubTotTrx.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblTipTrx.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            lblAmountTrx.font = UIFont(name:strFontTitle, size:appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
            
            lblLocation.textAlignment = NSTextAlignment.left
            lblLocation.frame = CGRect(x: 0.02*width, y: 0.00001*height, width: 0.2*width, height: 0.03*height);
            lblDate.textAlignment = NSTextAlignment.left
            lblDate.frame = CGRect(x: 0.02*width, y: 0.029*height, width: 0.2*width, height: 0.03*height);
            lblKeycard.textAlignment = NSTextAlignment.left
            lblKeycard.frame = CGRect(x: 0.02*width, y: 0.058*height, width: 0.2*width, height: 0.03*height);
            lblSubTot.textAlignment = NSTextAlignment.left
            lblSubTot.frame = CGRect(x: 0.02*width, y: 0.087*height, width: 0.2*width, height: 0.03*height);
            lblTip.textAlignment = NSTextAlignment.left
            lblTip.frame = CGRect(x: 0.02*width, y: 0.116*height, width: 0.2*width, height: 0.03*height);
            lblAmount.textAlignment = NSTextAlignment.left
            lblAmount.frame = CGRect(x: 0.02*width, y: 0.146*height, width: 0.2*width, height: 0.03*height);
            
            lblPlaceTrx.numberOfLines = 0
            lblPlaceTrx.frame = CGRect(x: 0.24*width, y: 0.0001*height, width: 0.45*width, height: 0.03*height);
            lblDateTrx.numberOfLines = 0
            lblDateTrx.frame = CGRect(x: 0.24*width, y: 0.0297*height, width: 0.45*width, height: 0.03*height);
            lblNameTrx.numberOfLines = 0
            lblNameTrx.frame = CGRect(x: 0.24*width, y: 0.059*height, width: 0.45*width, height: 0.03*height);
            lblSubTotTrx.numberOfLines = 0
            lblSubTotTrx.frame = CGRect(x: 0.24*width, y: 0.0885*height, width: 0.6*width, height: 0.03*height);
            lblTipTrx.numberOfLines = 0
            lblTipTrx.frame = CGRect(x: 0.24*width, y: 0.117*height, width: 0.6*width, height: 0.03*height);
            lblAmountTrx.numberOfLines = 0
            lblAmountTrx.frame = CGRect(x: 0.24*width, y: 0.147*height, width: 0.6*width, height: 0.03*height);

            btnApply.frame = CGRect(x: 0.1*width, y: 0.313*height, width: 0.8*width, height: 0.06*height);
            
            AccView.addSubview(lblLocation)
            AccView.addSubview(lblPlaceTrx)
            AccView.addSubview(lblDate)
            AccView.addSubview(lblDateTrx)
            AccView.addSubview(lblKeycard)
            AccView.addSubview(lblNameTrx)
            AccView.addSubview(lblSubTot)
            AccView.addSubview(lblSubTotTrx)
            AccView.addSubview(lblTip)
            AccView.addSubview(lblTipTrx)
            AccView.addSubview(lblAmount)
            AccView.addSubview(lblAmountTrx)
            
            self.view.addSubview(btnApply)
            
            self.view.addSubview(AccView)
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

            mas = NSMutableAttributedString(string: NSLocalizedString("btnConsumption",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:strFontTitle, size:appDelegate.gblFont7 + appDelegate.gblDeviceFont3)!
                ])
            btnApply.setAttributedTitle(mas, for: UIControl.State())
            btnApply.titleLabel?.textAlignment = NSTextAlignment.center
            btnApply.titleLabel?.adjustsFontSizeToFitWidth = true
            //btnApply.backgroundColor = self.colorWithHexString("ddf4ff")
            //btnApply.layer.borderColor = self.colorWithHexString("94cce5").CGColor
            //btnApply.layer.borderWidth = 3
            
            self.btnApply.setTitleColor(self.colorWithHexString("ffffff"), for: UIControl.State())
            self.btnApply.layer.borderWidth = 4
            self.btnApply.layer.borderColor = self.colorWithHexString("a18015").cgColor
            self.btnApply.backgroundColor = self.colorWithHexString("c39b1a")
            
            if (VoucherDetail.count>0)
            {
                btnApply.isEnabled = false
                btnApply.tintColor = UIColor.gray
                self.tableView.reloadData()
            }else{
                //btnApply.tintColor = colorWithHexString("00467f")
                btnApply.tintColor = colorWithHexString("ffffff")
                btnApply.isEnabled = true
            }
            
            if appDelegate.ynIPad {
                switch appDelegate.Model {
                case "iPad 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
                case "iPad Air":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
                case "iPad Air 2":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
                case "iPad Pro":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
                case "iPad Retina":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.53*height);
                }
            }else{
                switch appDelegate.Model {
                case "iPhone":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.45*height);
                case "iPhone 4":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.45*height);
                case "iPhone 4s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.45*height);
                case "iPhone 5":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.47*height);
                case "iPhone 5c":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.47*height);
                case "iPhone 5s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.47*height);
                case "iPhone 6":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.49*height);
                case "iPhone 6 Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.49*height);
                case "iPhone 6s":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.49*height);
                case "iPhone 6s Plus":
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.49*height);
                default:
                    tableView.frame = CGRect(x: 0.05*width, y: 0.4*height, width: 0.9*width, height: 0.45*height);
                }
            }
            
        }
        
        let downIco  = UIImage(named: "ic_download")!
        
        ViewItem.rightBarButtonItem = UIBarButtonItem(image: downIco,  style: UIBarButtonItem.Style.plain, target: self, action: #selector(vcGuestAccountTrxViewController.barButtonItemOpenPDF))
        
        if self.URLTicket == ""{
            ViewItem.rightBarButtonItem?.isEnabled = false
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
    
    func CargarVoucherDetail(){
        var iRes: String = ""
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        var VoucherInfo: Dictionary<String, String>
        
        var strfkAccTrxID: String = "", DatabaseName: String = "", ItemCode: String = "", Quantity: String = "", ItemDesc: String = "", Total: String = ""
        
        VoucherInfo = [:]
        if Reachability.isConnectedToNetwork(){
            ynConn = true
            
            var tableItems = RRDataSet()
            let service=RRRestaurantService(url: appDelegate.URLService as String, host: appDelegate.Host as String, userNameMobile:appDelegate.UserName, passwordMobile:appDelegate.Password);
            tableItems = (service?.spGetVoucherDetail("1", appCode: self.appDelegate.gstrAppName, personalID: PeopleID, iValue: fkAccTrxID, dataBase: self.appDelegate.strDataBaseByStay))!
            
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
                    
                    iRes = r.getColumnByName("Result").content as! String
                    
                    if (Int(iRes) > 0){

                            queueFM?.inTransaction() {
                                db, rollback in
                                
                                
                                for r in table.rows{
                                    
                                    if (db.executeUpdate("INSERT INTO tblAccountDetail (fkAccTrxID, ItemCode, Quantity, ItemDesc, Total) VALUES (?, ?, ?, ?, ?)", withArgumentsIn: [self.fkAccTrxID, (r as AnyObject).getColumnByName("ItemCode").content as! String, (r as AnyObject).getColumnByName("Quantity").content as! String, (r as AnyObject).getColumnByName("ItemDesc").content as! String, (r as AnyObject).getColumnByName("Total").content as! String])) {

                                        }
                                    
                                }

                        }
                        
                        var VoucherDetailAux: [Dictionary<String, String>]
                        var index: Int = 0
                        VoucherDetailAux = []
                        
                        queueFM?.inDatabase() {
                            db in
                            
                            if let rs = db.executeQuery("SELECT ItemCode, Quantity, ItemDesc, Total FROM tblAccountDetail WHERE fkAccTrxID = ?", withArgumentsIn: [self.fkAccTrxID]){
                                while rs.next() {
                                    VoucherDetailAux.append([:])
                                    VoucherDetailAux[index]["ItemCode"] = rs.string(forColumn: "ItemCode")!
                                    VoucherDetailAux[index]["Quantity"] = rs.string(forColumn: "Quantity")!
                                    VoucherDetailAux[index]["ItemDesc"] = rs.string(forColumn: "ItemDesc")!
                                    VoucherDetailAux[index]["Total"] = rs.string(forColumn: "Total")!
                                    index = index + 1
                                }
                            } else {
                                print("select failure: \(db.lastErrorMessage())")
                            }
                            
                        }
                        
                        self.VoucherDetail = VoucherDetailAux
                        
                    }
                    
                }
                
            }
        }else{
            RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
            ynConn = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return VoucherDetail.count;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var fAmount: Double = 0
        var str: String = ""
        
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        fAmount = Double(String(format: "%.2f", (VoucherDetail[indexPath.row]["Total"]! as NSString).floatValue))!
        
        str = String(format: "%.2f", (String(format: "%.2f0", (fAmount.description as NSString).floatValue) as NSString).floatValue)
        
        tableView.rowHeight = 0.04*height
        tableView.sectionHeaderHeight = 0.04*height
        tableView.sectionFooterHeight = 0.04*height
        
        //tableView.
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellVoucher") as! tvcVoucherDetail
        
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
            
            if indexPath.row == 0{
                imgCell = UIImage(named:"tblacchdr.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblacchdrSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }else if (VoucherDetail.count-1) == indexPath.row{
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
            
            if (VoucherDetail.count) == 1
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
            
            if indexPath.row == 0{
                imgCell = UIImage(named:"tblacchdr.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblacchdrSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }else if (VoucherDetail.count-1) == indexPath.row{
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
            
            if (VoucherDetail.count) == 1
            {
                imgCell = UIImage(named:"tblaccrowsingle.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblaccrowsingleSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
                
            }
        }
        
        cell.frame = CGRect(x: 0, y: 0, width: 0.9*width, height: 0.05*height)
        
        cell.SetValues(ItemCode: String(VoucherDetail[indexPath.row]["ItemCode"]!), Quantity: String(VoucherDetail[indexPath.row]["Quantity"]!), Desc: String(VoucherDetail[indexPath.row]["ItemDesc"]!), Total: str, width: width, height: height)
        
        //cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    @IBAction func clickAccount(_ sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func clickVoucher(_ sender: AnyObject) {
        
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 100
        config.backgroundColor = UIColor(white: 1, alpha: 0.5)
        config.spinnerColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.titleTextColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.spinnerLineWidth = 2.0
        SwiftLoader.setConfig(config)
        
        self.btnApply.isEnabled = false
        
        SwiftLoader.show(animated: true)
        SwiftLoader.show(title: NSLocalizedString("lblLoading",comment:""), animated: true)
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        let queue = OperationQueue()
        
        queue.addOperation() {
            
            if Reachability.isConnectedToNetwork(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                self.CargarVoucherDetail()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            OperationQueue.main.addOperation() {
                
                var VoucherDetailAux: [Dictionary<String, String>]
                var index: Int = 0
                
                VoucherDetailAux = []
                
                queueFM?.inDatabase() {
                    db in
                    
                    if let rs = db.executeQuery("SELECT ItemCode, Quantity, ItemDesc, Total FROM tblAccountDetail WHERE fkAccTrxID = ?", withArgumentsIn: [self.fkAccTrxID]){
                        while rs.next() {
                            VoucherDetailAux.append([:])
                            VoucherDetailAux[index]["ItemCode"] = rs.string(forColumn: "ItemCode")!
                            VoucherDetailAux[index]["Quantity"] = rs.string(forColumn: "Quantity")!
                            VoucherDetailAux[index]["ItemDesc"] = rs.string(forColumn: "ItemDesc")!
                            VoucherDetailAux[index]["Total"] = rs.string(forColumn: "Total")!
                            index = index + 1
                        }
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                    
                }
                
                self.VoucherDetail = VoucherDetailAux
                
                
                if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                    if (self.VoucherDetail.count>0)
                    {
                        self.btnApply.isEnabled = false
                        self.btnApply.titleLabel?.textColor = UIColor.gray
                        self.tableView.reloadData()
                        
                    }else{
                        self.btnApply.titleLabel?.textColor = self.colorWithHexString("0080FF")
                        self.btnApply.isEnabled = true
                        
                    }
                    
                }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                    if (self.VoucherDetail.count>0)
                    {
                        self.btnApply.isEnabled = false
                        self.btnApply.titleLabel?.textColor = UIColor.gray
                        self.tableView.reloadData()
                        
                    }else{
                        self.btnApply.titleLabel?.textColor = self.colorWithHexString("ba8748")
                        self.btnApply.isEnabled = true
                        
                    }
                    
                }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                    
                    if (self.VoucherDetail.count>0)
                    {
                        self.btnApply.isEnabled = false
                        self.btnApply.tintColor = UIColor.gray
                        self.tableView.reloadData()
                    }else{
                        self.btnApply.tintColor = self.colorWithHexString("00467f")
                        self.btnApply.isEnabled = true
                    }
                    
                }
                
                if !Reachability.isConnectedToNetwork(){
                    RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                }
                
                SwiftLoader.hide()
                
                
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Account_Voucher_Detail",
            AnalyticsParameterItemName: "Account Voucher Detail",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Account Voucher Detail", screenClass: appDelegate.gstrAppName)
        
    }
    
    @objc func barButtonItemOpenPDF(){
        
        let viewController: vcDigitalTicket = vcDigitalTicket()
        viewController.URLTicket = URLTicket
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }

}
