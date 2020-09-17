//
//  vcConfLogin.swift
//  Royal Resorts Guest
//
//  Created by Soluciones on 7/8/20.
//  Copyright © 2020 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging

class vcConfLogin: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var ViewItem: UINavigationItem!
    
    var lblName = UILabel()
    var txtName = UITextField()
    var lblLastName = UILabel()
    var txtLastName = UITextField()
    var lbldtCheckin = UILabel()
    var txtdtCheckin = UITextField()
    /*var lblResort = UILabel()
    var txtResort = UITextField()
    var lblConfirmationCode = UILabel()
    var txtConfirmationCode = UITextField()*/
    var lblMsj = UILabel()
    var btnLogIn = UIButton()
    var tblLogin: Dictionary<String, String>!
    
    var tblPreRegAux: [Dictionary<String, String>]!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height

        ViewItem.title = NSLocalizedString("Iniciar",comment:"");

        lblName = UILabel(frame: CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.03*height));
        txtName.frame = CGRect(x: 0.05*width!, y: 0.15*height!, width: 0.9*width!, height: 0.04*height!);
        lblLastName = UILabel(frame: CGRect(x: 0.05*width, y: 0.22*height, width: 0.9*width, height: 0.03*height));
        txtLastName.frame = CGRect(x: 0.05*width!, y: 0.25*height!, width: 0.9*width!, height: 0.04*height!);
        lbldtCheckin = UILabel(frame: CGRect(x: 0.05*width, y: 0.32*height, width: 0.9*width, height: 0.03*height));
        txtdtCheckin.frame = CGRect(x: 0.05*width!, y: 0.35*height!, width: 0.9*width!, height: 0.04*height!);
        /*lblResort = UILabel(frame: CGRect(x: 0.05*width, y: 0.42*height, width: 0.9*width, height: 0.03*height));
        txtResort.frame = CGRect(x: 0.05*width!, y: 0.45*height!, width: 0.9*width!, height: 0.04*height!);
        lblConfirmationCode = UILabel(frame: CGRect(x: 0.05*width, y: 0.52*height, width: 0.9*width, height: 0.03*height));
        txtConfirmationCode.frame = CGRect(x: 0.05*width!, y: 0.55*height!, width: 0.9*width!, height: 0.04*height!);*/
        lblMsj = UILabel(frame: CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.07*height));
        btnLogIn.frame = CGRect(x: 0.05*width!, y: 0.6*height!, width: 0.9*width!, height: 0.04*height!);
        
       lblName.backgroundColor = UIColor.clear;
       lblName.textAlignment = NSTextAlignment.left;
       lblName.textColor = colorWithHexString("2e3634")
       lblName.numberOfLines = 1;
       lblName.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
       lblName.text = NSLocalizedString("lblFirstName",comment:"");
        
       txtName.backgroundColor = UIColor.clear;
       txtName.textAlignment = NSTextAlignment.left;
       txtName.textColor = colorWithHexString("2e3634")
       txtName.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
       txtName.layer.borderColor = UIColor.black.cgColor
       txtName.borderStyle = UITextField.BorderStyle.roundedRect
       txtName.keyboardType = UIKeyboardType.alphabet
       txtName.text = ""
       txtName.delegate = self
        
       lblLastName.backgroundColor = UIColor.clear;
       lblLastName.textAlignment = NSTextAlignment.left;
       lblLastName.textColor = colorWithHexString("2e3634")
       lblLastName.numberOfLines = 1;
       lblLastName.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
       lblLastName.text = NSLocalizedString("lblLastName",comment:"");
        
       txtLastName.backgroundColor = UIColor.clear;
       txtLastName.textAlignment = NSTextAlignment.left;
       txtLastName.textColor = colorWithHexString("2e3634")
       txtLastName.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
       txtLastName.layer.borderColor = UIColor.black.cgColor
       txtLastName.borderStyle = UITextField.BorderStyle.roundedRect
       txtLastName.keyboardType = UIKeyboardType.alphabet
       txtLastName.text = ""
       txtLastName.delegate = self
        
       lbldtCheckin.backgroundColor = UIColor.clear;
       lbldtCheckin.textAlignment = NSTextAlignment.left;
       lbldtCheckin.textColor = colorWithHexString("2e3634")
       lbldtCheckin.numberOfLines = 1;
       lbldtCheckin.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
       lbldtCheckin.text = NSLocalizedString("lblCheckin",comment:"");

       let todaysDate:Date = Date()
       let dtdateFormatter:DateFormatter = DateFormatter()
       dtdateFormatter.dateFormat = "MM/dd/yyyy"
       let DateInFormat:String = dtdateFormatter.string(from: todaysDate)
       
       self.appDelegate.gstrCheckin = DateInFormat
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy/MM/dd"
        let dateStr2 = dateFormatter2.string(from: todaysDate)

        self.appDelegate.gstrCheckinAux = dateStr2
        
       txtdtCheckin.backgroundColor = UIColor.clear;
       txtdtCheckin.textAlignment = NSTextAlignment.left;
       txtdtCheckin.textColor = colorWithHexString("2e3634")
       txtdtCheckin.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
       txtdtCheckin.layer.borderColor = UIColor.black.cgColor
       txtdtCheckin.borderStyle = UITextField.BorderStyle.roundedRect
       txtdtCheckin.text = self.appDelegate.gstrCheckin
       txtdtCheckin.addTarget(self, action: #selector(vcConfLogin.clickdtCheckin(_:)), for: UIControl.Event.touchDown)
       txtdtCheckin.delegate = self
        
       /*lblResort.backgroundColor = UIColor.clear;
       lblResort.textAlignment = NSTextAlignment.left;
       lblResort.textColor = colorWithHexString("00467f")
       lblResort.numberOfLines = 1;
       lblResort.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
       lblResort.text = "Resort"
        
       txtResort.backgroundColor = UIColor.clear;
       txtResort.textAlignment = NSTextAlignment.left;
       txtResort.textColor = colorWithHexString("00467f")
       txtResort.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
       txtResort.layer.borderColor = UIColor.black.cgColor
       txtResort.borderStyle = UITextField.BorderStyle.roundedRect
       txtResort.isEnabled = false
       txtResort.text = "Costa Linda"
       
       lblConfirmationCode.backgroundColor = UIColor.clear;
       lblConfirmationCode.textAlignment = NSTextAlignment.left;
       lblConfirmationCode.textColor = colorWithHexString("00467f")
       lblConfirmationCode.numberOfLines = 1;
       lblConfirmationCode.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
       lblConfirmationCode.text = "Comfirmation code"
        
       txtConfirmationCode.backgroundColor = UIColor.clear;
       txtConfirmationCode.textAlignment = NSTextAlignment.left;
       txtConfirmationCode.textColor = colorWithHexString("00467f")
       txtConfirmationCode.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
       txtConfirmationCode.layer.borderColor = UIColor.black.cgColor
       txtConfirmationCode.borderStyle = UITextField.BorderStyle.roundedRect
       txtConfirmationCode.keyboardType = UIKeyboardType.alphabet
       txtConfirmationCode.text = ""
       txtConfirmationCode.isEnabled = false*/
        
       lblMsj.backgroundColor = UIColor.clear;
       lblMsj.textAlignment = NSTextAlignment.left;
       lblMsj.textColor = colorWithHexString("2e3634")
       lblMsj.numberOfLines = 0;
       lblMsj.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
       lblMsj.text = NSLocalizedString("lblMsjConf",comment:"")
       
       btnLogIn.setTitle(NSLocalizedString("btnAply",comment:""), for: UIControl.State())
       btnLogIn.titleLabel?.font = UIFont(name: "Helvetica", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont4)
       btnLogIn.backgroundColor = colorWithHexString ("f7941e")
       btnLogIn.layer.borderWidth = 0.8
       btnLogIn.setTitleColor(colorWithHexString ("2e3634"), for: UIControl.State())
       btnLogIn.titleLabel?.textAlignment = NSTextAlignment.center
       btnLogIn.addTarget(self, action: #selector(vcConfLogin.clickLogInConf(_:)), for: UIControl.Event.touchUpInside)
        
       self.view.addSubview(lblName)
       self.view.addSubview(txtName)
       self.view.addSubview(lblLastName)
       self.view.addSubview(txtLastName)
       self.view.addSubview(lbldtCheckin)
       self.view.addSubview(txtdtCheckin)
       //self.view.addSubview(lblResort)
       //self.view.addSubview(txtResort)
       //self.view.addSubview(lblConfirmationCode)
       //self.view.addSubview(txtConfirmationCode)
       self.view.addSubview(lblMsj)
       self.view.addSubview(btnLogIn)
        
    }
    
    @IBAction func clickLogInConf(_ sender: AnyObject) {
        
     var iRes: String = ""
     var tblPreReg: Dictionary<String, String>!
     
     tblPreRegAux = []

        
     let strCheckinDt = self.appDelegate.gstrCheckinAux.replacingOccurrences(of: "/", with: "")
        
     var tableItems = RRDataSet()
     let service=RRRestaurantService(url: appDelegate.URLService as String, host: appDelegate.Host as String, userNameMobile : appDelegate.UserName, passwordMobile: appDelegate.Password);
        tableItems = (service?.spGetPreRegReservation("4", iPeopleID: self.appDelegate.gstrLoginPeopleID, confirmationCode: "", fname: txtName.text!, lName: txtLastName.text!, checkinDt: strCheckinDt, resortCode: appDelegate.gPropertyCode, dataBase: self.appDelegate.strDataBaseByStay))!
     
     if (tableItems.getTotalTables() > 0){
         
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
             
             iRes = r.getColumnByName("iResult").content as! String
            
             if (Int(iRes)! > 0){
                
                var tableConf = RRDataTable()
                tableConf = tableItems.tables.object(at: 2) as! RRDataTable
                
                 for r in tableConf.rows{

                    self.appDelegate.gstrLoginPeopleID = ((r as AnyObject).getColumnByName("PeopleFromCDRID").content as? String)!
                    self.appDelegate.ynLogInConf = true
       
                 }
                
                let NextViewController = self.navigationController?.viewControllers[1]
                self.navigationController?.popToViewController(NextViewController!, animated: false)

             }else{
                
                let NextViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcConfLoginError") as! vcConfLoginError
                self.navigationController?.pushViewController(NextViewController, animated: true)

             }
             
         }
     }
        
    }
    
    @objc func clickdtCheckin(_ sender: AnyObject) {
        
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectStay") as! vcSelectStay
        tercerViewController.strMode = "dtCheckinConf"
        self.navigationController?.pushViewController(tercerViewController, animated: true)
        
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
    
    override func viewWillAppear(_ animated: Bool) {

        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-ConfLogin",
            AnalyticsParameterItemName: "ConfLogin",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("ConfLogin", screenClass: appDelegate.gstrAppName)
        
        txtdtCheckin.text = self.appDelegate.gstrCheckin
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

