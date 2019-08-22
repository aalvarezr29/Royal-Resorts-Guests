//
//  vcReservRest2.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 17/03/17.
//  Copyright © 2017 Marco Cocom. All rights reserved.
//

import UIKit
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


class vcReservRest: UIViewController, UITextViewDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var ViewItem: UINavigationItem!
    
    var width: CGFloat!
    var height: CGFloat!
    var AccView: UIView = UIView()
    var RestaurantName: String = ""
    var ReservDesc: String = ""
    var PeopleName: String = ""
    var Unit: String = ""
    var tblRestAvail: [[[Dictionary<String, String>]]]!
    var iseccion: Int = 0
    var panel: UIView = UIView()
    var tblRestAvailAll: [Dictionary<String, String>]!
    let txtCommentRequest = UITextView()
    var date: String = ""
    var time: String = ""
    var restaurantCode: String = ""
    var numAdult: String = ""
    var numChildren: String = ""
    var propertyCode: String = ""
    var hotelName: String = ""
    var roomNum: String = ""
    var ZoneCode: String = ""
    var ZoneDescripcion: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var ynReadOnly: Bool = false
    var ConfirmationNumber: String = ""
    var Comments: String! = ""
    var mas: NSMutableAttributedString = NSMutableAttributedString()
    
    @IBOutlet weak var btnApply: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        width = appDelegate.width
        height = appDelegate.height
        
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        //self.navigationController?.navigationBar.hidden = true;
        
        self.tabBarController?.navigationController?.navigationBar.isHidden = true;
        
        self.navigationController?.navigationBar.isHidden = false;
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString("lblTitleRestReserv",comment:"");
        
        AccView.backgroundColor = UIColor.clear
        AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.5*height);
        
        self.view.backgroundColor = UIColor.white
        
        var strFontTitleExtra: String = "Futura-CondensedExtraBold"
        var strFontTitleMedium: String = "Futura-CondensedMedium"
        
        var Color: UIColor = colorWithHexString("ba8748")
        var ColorR: UIColor = colorWithHexString("ba8748")
        
        var Colorbtn1: UIColor = colorWithHexString("ba8748")
        var Colorbtn2: UIColor = colorWithHexString("7c6a56")
        var Colorbtn3: UIColor = colorWithHexString("eee7dd")
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            Color = colorWithHexString("000000")
            ColorR = colorWithHexString("000000")
            
            Colorbtn1 = colorWithHexString("5d5854")
            Colorbtn2 = colorWithHexString("616167")
            Colorbtn3 = colorWithHexString("F2F2F2")
            
            strFontTitleExtra = "HelveticaNeue-Bold"
            strFontTitleMedium = "Helvetica"
            
            btnApply.setTitleColor(UIColor.white, for: UIControl.State())
            btnApply.layer.borderWidth = 4
            btnApply.layer.borderColor = colorWithHexString("00467f").cgColor
            btnApply.backgroundColor = colorWithHexString("00467f")
            btnApply.tintColor = UIColor.white
            mas = NSMutableAttributedString(string: NSLocalizedString("btnReserv",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:strFontTitleMedium, size:appDelegate.gblFont7 + appDelegate.gblDeviceFont3)!
                ])
            btnApply.setAttributedTitle(mas, for: UIControl.State())
            
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
            
            imgHdr = UIImage(named:"Titlefooter.png")!
            imgHdrVw = UIImageView(image: imgHdr)
            imgHdrVw.frame = CGRect(x: 0.0, y: 0.12*height, width: 0.9*width, height: 0.03*height);
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
            
            btnApply.setTitleColor(Colorbtn1, for: UIControl.State())
            btnApply.layer.borderWidth = 4
            btnApply.layer.borderColor = Colorbtn2.cgColor
            btnApply.backgroundColor = Colorbtn3
            btnApply.tintColor = Colorbtn1
            mas = NSMutableAttributedString(string: NSLocalizedString("btnReserv",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:strFontTitleMedium, size:appDelegate.gblFont7 + appDelegate.gblDeviceFont3)!
                ])
            btnApply.setAttributedTitle(mas, for: UIControl.State())
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{

            Color = colorWithHexString("ba8748")
            ColorR = colorWithHexString("ba8748")
            
            Colorbtn1 = colorWithHexString("ba8748")
            Colorbtn2 = colorWithHexString("7c6a56")
            Colorbtn3 = colorWithHexString("eee7dd")
            
            strFontTitleExtra = "Futura-CondensedExtraBold"
            strFontTitleMedium = "Futura-CondensedMedium"
            
            btnApply.setTitleColor(Colorbtn1, for: UIControl.State())
            btnApply.layer.borderWidth = 4
            btnApply.layer.borderColor = Colorbtn2.cgColor
            btnApply.backgroundColor = Colorbtn3
            btnApply.tintColor = Colorbtn1
            mas = NSMutableAttributedString(string: NSLocalizedString("btnReserv",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:strFontTitleMedium, size:appDelegate.gblFont7 + appDelegate.gblDeviceFont3)!
                ])
            btnApply.setAttributedTitle(mas, for: UIControl.State())
            
        }

        var lblRestaurantName: UILabel = UILabel()
        //var lblConfirmationNumber: UILabel = UILabel()
        var lblReservDesc: UILabel = UILabel()
        var lblPeopleName: UILabel = UILabel()
        var lblUnit: UITextField = UITextField()
        
        lblRestaurantName.text = RestaurantName
        //lblConfirmationNumber.text = ConfirmationNumber
        lblReservDesc.text = ReservDesc
        lblPeopleName.text = PeopleName
        lblUnit.text = Unit

        lblRestaurantName.textColor = Color
        lblReservDesc.textColor = Color
        lblPeopleName.textColor = Color
        lblUnit.textColor = Color
        
        lblRestaurantName.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont10 + appDelegate.gblDeviceFont3)
        //lblConfirmationNumber.font = UIFont(name:strFontTitle, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblReservDesc.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblPeopleName.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblUnit.font = UIFont(name:strFontTitleExtra, size:appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        
        lblRestaurantName.textAlignment = NSTextAlignment.left
        lblRestaurantName.frame = CGRect(x: 0.02*width, y: 0.01*height, width: 0.6*width, height: 0.03*height);
        //lblConfirmationNumber.textAlignment = NSTextAlignment.Right
        //lblConfirmationNumber.frame = CGRectMake(0.65*width, 0.01*height, 0.2*width, 0.03*height);
        lblReservDesc.textAlignment = NSTextAlignment.left
        lblReservDesc.frame = CGRect(x: 0.02*width, y: 0.03*height, width: 0.85*width, height: 0.08*height);
        lblReservDesc.numberOfLines = 0
        lblPeopleName.textAlignment = NSTextAlignment.left
        lblPeopleName.frame = CGRect(x: 0.02*width, y: 0.1*height, width: 0.5*width, height: 0.03*height);
        lblUnit.frame = CGRect(x: 0.53*width, y: 0.1*height, width: 0.35*width, height: 0.03*height);
        lblUnit.textAlignment = NSTextAlignment.right
        
        btnApply.frame = CGRect(x: 0.1*width, y: 0.6*height, width: 0.8*width, height: 0.06*height);
        
        AccView.addSubview(lblRestaurantName)
        //AccView.addSubview(lblConfirmationNumber)
        AccView.addSubview(lblReservDesc)
        AccView.addSubview(lblPeopleName)
        AccView.addSubview(lblUnit)
        
        txtCommentRequest.frame = CGRect(x: 0.02*width, y: 0.18*height, width: 0.9*width, height: 0.3*height);
        txtCommentRequest.font = UIFont(name:"Helvetica", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
        txtCommentRequest.layer.borderColor = UIColor.lightGray.cgColor
        txtCommentRequest.layer.cornerRadius = 5
        txtCommentRequest.layer.borderWidth = 0.5
        txtCommentRequest.isEditable = true
        txtCommentRequest.isSelectable = true
        txtCommentRequest.isUserInteractionEnabled = true
        txtCommentRequest.isMultipleTouchEnabled = true
        txtCommentRequest.text = NSLocalizedString("lblRestCommentRequest",comment:"");
        txtCommentRequest.textColor = colorWithHexString ("C7C7CD")
        AccView.addSubview(txtCommentRequest)
        
        txtCommentRequest.delegate = self
        
        self.view.addSubview(btnApply)
        self.view.addSubview(AccView)
        
        if ynReadOnly{
            
            btnApply.isEnabled = false
            txtCommentRequest.isEditable = false

            btnApply.isHidden = true
            
            ViewItem.title = NSLocalizedString("lblRestConfirmationNumber",comment:"") + " " + ConfirmationNumber
            
            if Comments == nil || Comments == "nil"{
                Comments = ""
            }
            
            txtCommentRequest.text = Comments
            
        }else{
            
            btnApply.isEnabled = true
            txtCommentRequest.isEditable = true

        }
        
        btnApply.setAttributedTitle(mas, for: UIControl.State())
        btnApply.titleLabel?.textAlignment = NSTextAlignment.center
        btnApply.titleLabel?.adjustsFontSizeToFitWidth = true
        btnApply.addTarget(self, action: #selector(vcReservRestAvail.RestReserv(_:)), for: UIControl.Event.touchUpInside)
        
        if appDelegate.ynIPad {
            switch appDelegate.Model {
            case "iPad 2":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.5*height);
            case "iPad Air":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.5*height);
            case "iPad Air 2":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.5*height);
            case "iPad Pro":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.5*height);
            case "iPad Retina":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.5*height);
            default:
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.5*height);
            }
        }else{
            switch appDelegate.Model {
            case "iPhone":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 4":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 4s":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 5":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 5c":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 5s":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 6":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 6 Plus":
                AccView.frame = CGRect(x: 0.05*width, y: 0.08*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 6s":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.5*height);
            case "iPhone 6s Plus":
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.5*height);
            default:
                AccView.frame = CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.5*height);
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
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtCommentRequest.text.isEmpty {
            txtCommentRequest.text = NSLocalizedString("lblRestCommentRequest",comment:"");
            txtCommentRequest.textColor = colorWithHexString ("C7C7CD")
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtCommentRequest.textColor == colorWithHexString ("C7C7CD") {
            txtCommentRequest.text = nil
            
            if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                
                txtCommentRequest.textColor = UIColor.black
                
            }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                
                txtCommentRequest.textColor = colorWithHexString("ba8748")
                
            }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                
                txtCommentRequest.textColor = colorWithHexString("00467f")
                
            }
        }
    }
    
    func ReservRest(){
        if ConfirmationNumber == ""{
            
            var tableItems = RRDataSet()
            var iRes: String = ""
            var tblRestResult: Dictionary<String, String>!
            var sRes: String = "Error"
            var iResult: String = ""
            var sResult: String = ""
            
            self.btnApply.isUserInteractionEnabled = false
            self.btnApply.isEnabled = false
            
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
            
            queue.addOperation() {//1
                //accion base de datos
                //print("A1")
                if Reachability.isConnectedToNetwork(){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    

                        let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                        tableItems = (service?.spAddRestReservationWeb("1", firstName: self.firstName, lastName: self.lastName, date: self.date, time: self.time, restaurantCode: self.restaurantCode, numAdult: self.numAdult, numChildren: self.numChildren, ynRRGuest: "1", propertyCode: self.propertyCode, hotelName: self.hotelName, roomNum: self.roomNum, ynRefine: "0", email: "", note: self.txtCommentRequest.text, sourceCode: "MOBILE", zoneCode: self.ZoneCode, prCode: "", dataBase: self.appDelegate.strDataBaseByStay))!

                    
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
                                sRes = rowResult.getColumnByName("sResult").content as! String
                            }else{
                                iRes = "-1"
                                sRes = rowResult.getColumnByName("sResult").content as! String
                            }
                            
                            if ( (iRes != "0") && (iRes != "-1")){
                                
                                
                                
                                var table = RRDataTable()
                                table = tableItems.tables.object(at: 1) as! RRDataTable
                                
                                var r = RRDataRow()
                                r = table.rows.object(at: 0) as! RRDataRow
                                
                                iResult = r.getColumnByName("iResult").content as! String
                                sResult = r.getColumnByName("sResult").content as! String
                                
                                if (Int(iResult) > 0){
                                    queueFM?.inTransaction() {
                                        db, rollback in
                                        
                                        
                                        if !(db.executeUpdate("INSERT INTO tblRestaurantReservation (StayInfoID, UnitCode, RestaurantName, ZoneDescripcion, Name, Adults, Childrens, DateReservation, TimeReservation, ConfirmacionNumber, Comments) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [self.appDelegate.RestStayInfoID.description, self.appDelegate.strRestAccCode, self.hotelName, self.ZoneDescripcion, self.firstName + " " + self.lastName, self.numAdult, self.numChildren, self.date, self.time, iResult, self.txtCommentRequest.text])) {
                                            
                                            
                                        }
                                    }
                                }
                                
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
                                
                                if (Int(iResult) > 0){
                                    self.btnApply.isUserInteractionEnabled = false
                                    self.btnApply.isEnabled = false
                                    SwiftLoader.hide()
                                    
                                    /*let NextViewController = self.navigationController?.viewControllers[0]
                                     self.navigationController?.popToViewController(NextViewController!, animated: false)*/
                                    /*self.ConfirmationNumber = iResult
                                     
                                     self.mas = NSMutableAttributedString(string: self.ConfirmationNumber, attributes: [
                                     NSFontAttributeName: UIFont(name:"Helvetica", size:self.appDelegate.gblFont7 + self.appDelegate.gblDeviceFont3)!
                                     ])
                                     self.btnApply.setAttributedTitle(self.mas, forState: UIControlState.Normal)*/
                                    
                                    GoogleWearAlert.showAlert(title: NSLocalizedString("lblRestConfirmationNumber",comment:"") + " " + iResult, type: .success, duration: 3, iAction: 1, form:"Restaurant Reservation")
                                    GoogleWearAlert.showAlert(title: NSLocalizedString("lblRestConcierge",comment:"") + " ", type: .success, duration: 3, iAction: 1, form:"Restaurant Concierge")
                                    
                                    self.appDelegate.gblGoRestReserv = true
                                    
                                    let NextViewController = self.navigationController?.viewControllers[0]
                                    self.navigationController?.popToViewController(NextViewController!, animated: false)
                                    
                                }else{
                                    self.btnApply.isUserInteractionEnabled = false
                                    self.btnApply.isEnabled = false
                                    SwiftLoader.hide()
                                    RKDropdownAlert.title(sResult, backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                                }
                                
                            }else{
                                self.btnApply.isUserInteractionEnabled = false
                                self.btnApply.isEnabled = false
                                SwiftLoader.hide()
                                RKDropdownAlert.title(sRes, backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                            }
                            
                        }
                    }//2
                }//1
            }
            
            
        }else{
            
            self.btnApply.isUserInteractionEnabled = false
            self.btnApply.isEnabled = false
            self.appDelegate.gblGoRestReserv = true
            
            let NextViewController = self.navigationController?.viewControllers[0]
            self.navigationController?.popToViewController(NextViewController!, animated: false)
            
        }
    }
    
    @objc func RestReserv(_ sender: AnyObject) {
        
        var resultStayID: Int32 = 0
        var strQuery: String = ""
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        strQuery = "SELECT COUNT(*) FROM tblRestaurantReservation rs INNER JOIN tblStay st ON st.StayInfoID = rs.StayInfoID WHERE st.StayInfoID = " + self.appDelegate.RestStayInfoID.description + " and DateReservation = '" + self.date + "'"
        
        queueFM?.inDatabase() {
                db in
                
                let resultCount = db.intForQuery(strQuery, "" as AnyObject)
                
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
        
        if resultStayID > 0{
            
            let alert = UIAlertController(title: NSLocalizedString("strRestExist",comment:""), message: NSLocalizedString("strSure",comment:""), preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("strContinue",comment:""), style: .default, handler: { action in
                self.ReservRest()
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("strViewReserv",comment:""), style: .default, handler: { action in
                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcRestReservList") as! vcRestReservList
                self.navigationController?.pushViewController(tercerViewController, animated: true)
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("strCancel",comment:""), style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
            
        }else{
            self.ReservRest()
        }

        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
