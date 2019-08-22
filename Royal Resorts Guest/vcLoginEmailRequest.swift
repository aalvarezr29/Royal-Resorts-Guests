//
//  vcLoginEmailRequest.swift
//  Royal Resorts Guest
//
//  Created by Marco Cocom on 11/18/14.
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


class vcLoginEmailRequest: UIViewController, UITextFieldDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var sMsj = ""
    var strEmailReq: String = ""
    var fSizeFont: CGFloat = 0
    var mas: NSMutableAttributedString = NSMutableAttributedString()
    var btnBack = UIButton()
    
    //Estilos
    var img = UIImage()
    var imgvw = UIImageView()
    var imgMail = UIImage()
    var imgvwMail = UIImageView()
    var linevw1: UIView = UIView()
    var imgBack = UIImage()
    var imgvwBack = UIImageView()
    var strDocumentCode: String = ""
    var DataBaseMail: String = ""
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblMsj: UILabel!
    
    @IBOutlet weak var lblHdr1: UILabel!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var btnRequest: UIButton!
    
    @IBOutlet weak var lblfoo1: UILabel!
    @IBOutlet weak var lblfoo2: UILabel!
    @IBOutlet weak var lblfoo3: UILabel!
    @IBOutlet weak var lblfoo4: UILabel!
    @IBOutlet weak var btnBarBack: UIBarButtonItem!
    @IBOutlet var ViewItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = appDelegate.width
        let height = appDelegate.height
        
        lblHdr1.frame = CGRect(x: 0.1*width, y: 0.11*height, width: 0.8*width, height: 0.15*height);
        bodyView.frame = CGRect(x: 0.05*width, y: 0.3*height, width: 0.9*width, height: 0.19*height);
        txtEmail.frame = CGRect(x: 0.09*width, y: 0.03*height, width: 0.7*width, height: 0.05*height);
        btnRequest.frame = CGRect(x: 0.3*width, y: 0.11*height, width: 0.3*width, height: 0.05*height);
        btnRequest.layer.cornerRadius = 5
        lblMsj.frame = CGRect(x: 0.05*width, y: 0.5*height, width: 0.8*width, height: 0.07*height);
        lblfoo1.frame = CGRect(x: 0.1*width, y: 0.77*height, width: 0.8*width, height: 0.08*height);
        lblfoo2.frame = CGRect(x: 0.1*width, y: 0.85*height, width: 0.8*width, height: 0.03*height);
        lblfoo3.frame = CGRect(x: 0.1*width, y: 0.89*height, width: 0.8*width, height: 0.03*height);
        lblfoo4.frame = CGRect(x: 0.1*width, y: 0.93*height, width: 0.8*width, height: 0.03*height);
        
        txtEmail.delegate = self

        lblHdr1.numberOfLines = 0
        lblHdr1.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont5)
        lblfoo1.numberOfLines = 0
        lblfoo1.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont5)
        lblfoo2.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont5)
        lblfoo3.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont5)
        lblfoo4.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont5)
        
        lblHdr1.text = NSLocalizedString("lblHdr1",comment:"");
        lblfoo1.text = NSLocalizedString("lblfoo1",comment:"");
        lblfoo4.text = NSLocalizedString("lblfoo4",comment:"");
        lblfoo2.text = NSLocalizedString("lblfoo2",comment:"");
        lblfoo3.text = NSLocalizedString("lblfoo3",comment:"");
        
        txtEmail.font = UIFont(name:"Helvetica", size:appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
        txtEmail.placeholder = "Email"
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString("TitleRequest",comment:"");
        
        mas = NSMutableAttributedString(string: NSLocalizedString("btnRequestPIN",comment:""), attributes: [
            NSAttributedString.Key.font: UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont5)!,
            NSAttributedString.Key.foregroundColor: colorWithHexString ("007AFF")
            ])
        btnRequest.setAttributedTitle(mas, for: UIControl.State())
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            strDocumentCode = "APP_RECOVERYPIN"
            DataBaseMail = "CDRPRD"
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            strDocumentCode = "APP_RECOVERYPINGRM"
            DataBaseMail = "CDRPRD"
            //appDelegate.strLenguaje = "ENG"
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            self.view.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"BackAqua.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height);
            imgvwBack.alpha = 0.2
            //self.view.addSubview(imgvwBack)
            
            bodyView.isHidden = true
            lblMsj.isHidden = true
            
            img = UIImage(named:"Logo.png")!
            imgvw = UIImageView(image: img)
            if appDelegate.ynIPad == true{
                imgvw.frame = CGRect(x: 0.33*width, y: 0.12*height, width: 0.34*width, height: 0.22*height);
            }else{
                imgvw.frame = CGRect(x: 0.3*width, y: 0.15*height, width: 0.4*width, height: 0.2*height);
            }
            //imgvw.alpha = 0.5
            self.view.addSubview(imgvw)
            
            lblHdr1.frame = CGRect(x: 0.05*width, y: 0.345*height, width: 0.9*width, height: 0.1*height);
            lblHdr1.textColor = colorWithHexString ("ba8748")
            lblHdr1.numberOfLines = 0
            lblHdr1.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont5)
            lblHdr1.text = NSLocalizedString("lblHdr1",comment:"")
            lblHdr1.textAlignment = NSTextAlignment.center
            lblHdr1.alpha = 0.9
            
            imgMail = UIImage(named:"mail.png")!
            imgvwMail = UIImageView(image: imgMail)
            if appDelegate.ynIPad == true{
                imgvwMail.frame = CGRect(x: 0.05*width, y: 0.454*height, width: 0.08*width, height: 0.06*height);
            }else{
                imgvwMail.frame = CGRect(x: 0.05*width, y: 0.454*height, width: 0.09*width, height: 0.06*height);
            }
            imgvwMail.tintColor = UIColor.white
            imgvwMail.alpha = 0.5
            self.view.addSubview(imgvwMail)
            
            txtEmail.frame = CGRect(x: 0.15*width, y: 0.471*height, width: 0.7*width, height: 0.04*height);
            txtEmail.font = UIFont(name:"Helvetica", size:appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
            txtEmail.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("txtEmail",comment:""),
                                                                attributes:[NSAttributedString.Key.foregroundColor: colorWithHexString ("e4c29c")])
            txtEmail.tintColor = colorWithHexString ("ba8748")
            txtEmail.textColor = colorWithHexString ("ba8748")
            txtEmail.backgroundColor = UIColor.clear
            txtEmail.layer.borderColor = UIColor.clear.cgColor
            txtEmail.layer.borderWidth = 0
            txtEmail.borderStyle = UITextField.BorderStyle.none
            txtEmail.delegate = self
            self.view.addSubview(txtEmail)
            
            linevw1.frame = CGRect(x: 0.05*width, y: 0.51*height, width: 0.9*width, height: 1);
            linevw1.backgroundColor = colorWithHexString ("e4c29c")
            linevw1.alpha = 0.9
            self.view.addSubview(linevw1)
            
            btnRequest.frame = CGRect(x: 0.05*width, y: 0.525*height, width: 0.9*width, height: 0.04*height);
            mas = NSMutableAttributedString(string: NSLocalizedString("btnRequestPIN",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont4)!,
                NSAttributedString.Key.foregroundColor: colorWithHexString ("ba8748")
                ])
            btnRequest.setAttributedTitle(mas, for: UIControl.State())
            btnRequest.layer.borderColor = colorWithHexString ("e4c29c").cgColor
            btnRequest.layer.borderWidth = 1
            btnRequest.alpha = 0.9
            btnRequest.addTarget(self, action: #selector(vcLoginEmailRequest.clickRequest(_:)), for: UIControl.Event.touchUpInside)
            btnRequest.backgroundColor = UIColor.clear
            btnRequest.layer.cornerRadius = 0
            self.view.addSubview(btnRequest)
            
            lblfoo1.frame = CGRect(x: 0.1*width, y: 0.77*height, width: 0.8*width, height: 0.08*height);
            lblfoo1.textColor = colorWithHexString ("ba8748")
            lblfoo1.numberOfLines = 0
            lblfoo1.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont5)
            lblfoo1.text = NSLocalizedString("lblfoo1",comment:"")
            lblfoo1.textAlignment = NSTextAlignment.center
            lblfoo1.alpha = 0.9
            
            lblfoo2.frame = CGRect(x: 0.1*width, y: 0.85*height, width: 0.8*width, height: 0.03*height);
            lblfoo2.textColor = colorWithHexString ("ba8748")
            lblfoo2.numberOfLines = 0
            lblfoo2.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont5)
            lblfoo2.text = NSLocalizedString("lblfoo2",comment:"")
            lblfoo2.textAlignment = NSTextAlignment.center
            lblfoo2.alpha = 0.9
            
            lblfoo3.frame = CGRect(x: 0.1*width, y: 0.89*height, width: 0.8*width, height: 0.03*height);
            lblfoo3.textColor = colorWithHexString ("ba8748")
            lblfoo3.numberOfLines = 0
            lblfoo3.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont5)
            lblfoo3.text = NSLocalizedString("lblfoo3",comment:"")
            lblfoo3.textAlignment = NSTextAlignment.center
            lblfoo3.alpha = 0.9
            
            lblfoo4.frame = CGRect(x: 0.1*width, y: 0.93*height, width: 0.8*width, height: 0.03*height);
            lblfoo4.textColor = colorWithHexString ("ba8748")
            lblfoo4.numberOfLines = 0
            lblfoo4.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont5)
            lblfoo4.text = NSLocalizedString("lblfoo4",comment:"")
            lblfoo4.textAlignment = NSTextAlignment.center
            lblfoo4.alpha = 0.9
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            strDocumentCode = "APP_RECOVERYPINRRC"
            DataBaseMail = "FDESK_PELICAN"
            //appDelegate.strLenguaje = "ENG"
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            self.view.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"BackAqua.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height);
            imgvwBack.alpha = 0.2
            //self.view.addSubview(imgvwBack)
            
            bodyView.isHidden = true
            lblMsj.isHidden = true
            
            img = UIImage(named:"Logo.png")!
            imgvw = UIImageView(image: img)
            if appDelegate.ynIPad == true{
                imgvw.frame = CGRect(x: 0.3*width, y: 0.2*height, width: 0.4*width, height: 0.12*height);
            }else{
                imgvw.frame = CGRect(x: 0.3*width, y: 0.2*height, width: 0.4*width, height: 0.1*height);
            }
            //imgvw.alpha = 0.5
            self.view.addSubview(imgvw)
            
            lblHdr1.frame = CGRect(x: 0.05*width, y: 0.345*height, width: 0.9*width, height: 0.1*height);
            lblHdr1.textColor = colorWithHexString ("00467f")
            lblHdr1.numberOfLines = 0
            lblHdr1.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont5)
            lblHdr1.text = NSLocalizedString("lblHdr1",comment:"")
            lblHdr1.textAlignment = NSTextAlignment.center
            lblHdr1.alpha = 0.6
            
            imgMail = UIImage(named:"mail.png")!
            imgvwMail = UIImageView(image: imgMail)
            if appDelegate.ynIPad == true{
                imgvwMail.frame = CGRect(x: 0.05*width, y: 0.454*height, width: 0.08*width, height: 0.06*height);
            }else{
                imgvwMail.frame = CGRect(x: 0.05*width, y: 0.454*height, width: 0.09*width, height: 0.06*height);
            }
            imgvwMail.tintColor = UIColor.white
            imgvwMail.alpha = 0.3
            self.view.addSubview(imgvwMail)
            
            txtEmail.frame = CGRect(x: 0.15*width, y: 0.471*height, width: 0.7*width, height: 0.04*height);
            txtEmail.font = UIFont(name:"Helvetica", size:appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
            txtEmail.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("txtEmail",comment:""),
                                                                attributes:[NSAttributedString.Key.foregroundColor: colorWithHexString ("9abfd8")])
            txtEmail.tintColor = colorWithHexString ("00467f")
            txtEmail.textColor = colorWithHexString ("00467f")
            txtEmail.backgroundColor = UIColor.clear
            txtEmail.layer.borderColor = UIColor.clear.cgColor
            txtEmail.layer.borderWidth = 0
            txtEmail.borderStyle = UITextField.BorderStyle.none
            txtEmail.delegate = self
            self.view.addSubview(txtEmail)
            
            linevw1.frame = CGRect(x: 0.05*width, y: 0.51*height, width: 0.9*width, height: 1);
            linevw1.backgroundColor = colorWithHexString ("00467f")
            linevw1.alpha = 0.6
            self.view.addSubview(linevw1)
            
            btnRequest.frame = CGRect(x: 0.05*width, y: 0.525*height, width: 0.9*width, height: 0.04*height);
            mas = NSMutableAttributedString(string: NSLocalizedString("btnRequestPIN",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont4)!,
                NSAttributedString.Key.foregroundColor: colorWithHexString ("00467f")
                ])
            btnRequest.setAttributedTitle(mas, for: UIControl.State())
            btnRequest.layer.borderColor = colorWithHexString ("00467f").cgColor
            btnRequest.layer.borderWidth = 1
            btnRequest.alpha = 0.5
            btnRequest.addTarget(self, action: #selector(vcLoginEmailRequest.clickRequest(_:)), for: UIControl.Event.touchUpInside)
            btnRequest.backgroundColor = UIColor.clear
            btnRequest.layer.cornerRadius = 0
            self.view.addSubview(btnRequest)
            
            lblfoo1.frame = CGRect(x: 0.1*width, y: 0.77*height, width: 0.8*width, height: 0.08*height);
            lblfoo1.textColor = colorWithHexString ("00467f")
            lblfoo1.numberOfLines = 0
            lblfoo1.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont5)
            lblfoo1.text = NSLocalizedString("lblfoo1",comment:"")
            lblfoo1.textAlignment = NSTextAlignment.center
            lblfoo1.alpha = 0.6
            
            lblfoo2.frame = CGRect(x: 0.1*width, y: 0.85*height, width: 0.8*width, height: 0.03*height);
            lblfoo2.textColor = colorWithHexString ("00467f")
            lblfoo2.numberOfLines = 0
            lblfoo2.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont5)
            lblfoo2.text = NSLocalizedString("lblfoo2",comment:"")
            lblfoo2.textAlignment = NSTextAlignment.center
            lblfoo2.alpha = 0.6
            
            lblfoo3.frame = CGRect(x: 0.1*width, y: 0.89*height, width: 0.8*width, height: 0.03*height);
            lblfoo3.textColor = colorWithHexString ("00467f")
            lblfoo3.numberOfLines = 0
            lblfoo3.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont5)
            lblfoo3.text = NSLocalizedString("lblfoo3",comment:"")
            lblfoo3.textAlignment = NSTextAlignment.center
            lblfoo3.alpha = 0.6
            
            lblfoo4.frame = CGRect(x: 0.1*width, y: 0.93*height, width: 0.8*width, height: 0.03*height);
            lblfoo4.textColor = colorWithHexString ("00467f")
            lblfoo4.numberOfLines = 0
            lblfoo4.font = UIFont(name:"Helvetica", size:appDelegate.gblFont5 + appDelegate.gblDeviceFont5)
            lblfoo4.text = NSLocalizedString("lblfoo4",comment:"")
            lblfoo4.textAlignment = NSTextAlignment.center
            lblfoo4.alpha = 0.6
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBAction func clickRequest(_ sender: AnyObject) {
        var email: String = ""
        var config : SwiftLoader.Config = SwiftLoader.Config()
        var iRes: String = ""
        var tableItems = RRDataSet()
        let queue = OperationQueue()
        var ynValidEmail: Bool = false
        var ynValidSend: Bool = false
        
        config.size = 100
        config.backgroundColor = UIColor(white: 1, alpha: 0.5)
        config.spinnerColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.titleTextColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.spinnerLineWidth = 2.0
        self.btnRequest.isEnabled = false
        
        if ValidaEmail(){
            
            SwiftLoader.setConfig(config)
            SwiftLoader.show(animated: true)
            SwiftLoader.show(title: NSLocalizedString("lblLoading",comment:""), animated: true)
            
            email = txtEmail.text!
            
            queue.addOperation() {
                
                if Reachability.isConnectedToNetwork(){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    
                    let service=RRRestaurantService(url: self.appDelegate.URLServiceLogin as String, host: self.appDelegate.HostLogin as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
                    tableItems = (service?.spGetPinRecovery("1", param1: self.appDelegate.gstrAppName, param2: email))!
                    
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
                            
                            if (Int(iRes) < 0){
                                self.sMsj = NSLocalizedString("MsgError5",comment:"")
                                ynValidEmail = false
                            }else{
                                ynValidEmail = true
                            }
                        }else{
                            self.sMsj = NSLocalizedString("MsgError5",comment:"")
                            ynValidEmail = false
                        }
                    }else{
                        self.sMsj = NSLocalizedString("MsgError5",comment:"")
                        ynValidEmail = false
                    }
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
                OperationQueue.main.addOperation() {
                    
                    queue.addOperation() {
                        if ynValidEmail{
                            
                            if Reachability.isConnectedToNetwork(){
                                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                                
                                    var prepareOrderResult:NSString="";
                                    let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
                                
                                    prepareOrderResult = service!.wmSendEmailWebDocument(email, strLenguageCode: self.appDelegate.strLenguaje, database: self.DataBaseMail, webDocumentCode: self.strDocumentCode, webDocumentValue1: email, webDocumentValue2: "") as! NSString
                                    let separators = CharacterSet(charactersIn: ",")
                                    var aRes = prepareOrderResult.components(separatedBy: separators)
                                
                                    if(aRes[0]=="1"){
                                        ynValidSend = true
                                    
                                    }else{
                                        self.sMsj = NSLocalizedString("MsgError5",comment:"")
                                        ynValidSend = false
                                    }
                                
                                    UIApplication.shared.isNetworkActivityIndicatorVisible = false

                                }
                            
                        }else{
                            ynValidSend = false
                        }
                        
                        OperationQueue.main.addOperation() {
                            
                            SwiftLoader.hide()
                            self.btnRequest.isEnabled = true
                            
                            if ynValidSend{
                                self.strEmailReq = email
                                self.lblMsj.textColor = UIColor.black
                                GoogleWearAlert.showAlert(title: NSLocalizedString("Msg1",comment:""), type: .success, iAction: 1, form:"Email Request")
                                self.appDelegate.gstrRequestEmail = self.strEmailReq
                                self.navigationController?.popViewController(animated: true)
                            }else{
                                RKDropdownAlert.title(self.sMsj, backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                            }
                        
                        }
                    
                    }
                
                }
            }
            
        }else{
            
            self.btnRequest.isEnabled = true
            RKDropdownAlert.title(self.sMsj, backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
            
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
    
    func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func ValidaEmail()-> Bool{
        
        var validEmail = false
        
        if txtEmail.text == ""{
            sMsj = NSLocalizedString("MsgError1",comment:"")
            return false;
        }else{
            for character in (txtEmail.text?.characters)! {
                if character == "@"{
                    validEmail = true
                }
                
            }
            
            if validEmail == true{
                if isValidEmail(txtEmail.text!) == false{
                    sMsj = NSLocalizedString("MsgError2",comment:"")
                    return false;
                }else{
                    return true;
                }
                
            }else{
                let a:Int? = Int(txtEmail.text!)
                if a == nil {
                    sMsj = NSLocalizedString("MsgError3",comment:"")
                    return false;
                } else {
                    return true;
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Email_Request",
            AnalyticsParameterItemName: "Email Request",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Email Request", screenClass: appDelegate.gstrAppName)
        
    }
    
    @IBAction func clickBack(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
