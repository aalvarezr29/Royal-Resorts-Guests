//
//  vcAddFolloUp.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 22/01/16.
//  Copyright © 2016 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging

class vcAddFolloUp: UIViewController, UITableViewDelegate, UITextViewDelegate, UITextFieldDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var width: CGFloat!
    var height: CGFloat!
    var btnBack = UIButton()
    var strDate: String = ""
    var strMessage: String = ""
    var strViewed: String = ""
    var strID: String = ""
    var btnStay = UIButton()
    var btnType = UIButton()
    let txtShortDesc = UITextField()
    let txtCommentRequest = UITextView()
    var strValidError: String = ""
    let btnSend = UIButton()
    var imgBack = UIImage()
    var imgvwBack = UIImageView()
    var strFont: String = ""
    var imgCell = UIImage()
    var imgvwCell = UIImageView()
    var lastIndex = IndexPath()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var BodyView: UIView!
    @IBOutlet var ViewItem: UINavigationItem!
    @IBOutlet weak var AccView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.frame = CGRect(x: 0.0, y: 44, width: width, height: height);
        
        self.tabBarController?.navigationController?.navigationBar.isHidden = true;
        
        self.navigationController?.navigationBar.isHidden = false;
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString("lblNewRequest",comment:"") + strDate;

        self.navigationController?.isToolbarHidden = false;
        
        AccView.frame = CGRect(x: 0.05*width, y: 0.255*height, width: 0.9*width, height: 0.4*height);
        
        //Boton Refresh
        ViewItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(vcAddFolloUp.Send(_:)))

        txtShortDesc.layer.borderColor = UIColor.black.cgColor
        txtShortDesc.borderStyle = UITextField.BorderStyle.roundedRect
        txtShortDesc.frame = CGRect(x: 0, y: 0.04*height, width: 0.9*width, height: 0.05*height);
        txtShortDesc.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
        txtShortDesc.placeholder = NSLocalizedString("lblFollowDesc",comment:"");
        AccView.addSubview(txtShortDesc)

        txtCommentRequest.frame = CGRect(x: 0, y: 0.11*height, width: 0.9*width, height: 0.3*height);
        txtCommentRequest.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
        txtCommentRequest.layer.borderColor = UIColor.lightGray.cgColor
        txtCommentRequest.layer.cornerRadius = 5
        txtCommentRequest.layer.borderWidth = 0.5
        txtCommentRequest.isEditable = true
        txtCommentRequest.isSelectable = true
        txtCommentRequest.isUserInteractionEnabled = true
        txtCommentRequest.isMultipleTouchEnabled = true
        txtCommentRequest.text = NSLocalizedString("lblCommentRequest",comment:"");
        txtCommentRequest.textColor = colorWithHexString ("C7C7CD")
        AccView.addSubview(txtCommentRequest)
        
        txtShortDesc.delegate = self
        txtCommentRequest.delegate = self
        
        if appDelegate.ynIPad {
            switch appDelegate.Model {
            case "iPad 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.135*height, width: 0.9*width, height: 0.15*height);
            case "iPad Air":
                tableView.frame = CGRect(x: 0.05*width, y: 0.135*height, width: 0.9*width, height: 0.15*height);
            case "iPad Air 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.135*height, width: 0.9*width, height: 0.15*height);
            case "iPad Pro":
                tableView.frame = CGRect(x: 0.05*width, y: 0.135*height, width: 0.9*width, height: 0.15*height);
            case "iPad Retina":
                tableView.frame = CGRect(x: 0.05*width, y: 0.135*height, width: 0.9*width, height: 0.15*height);
            default:
                tableView.frame = CGRect(x: 0.05*width, y: 0.135*height, width: 0.9*width, height: 0.15*height);
            }
        }else{
            switch appDelegate.Model {
            case "iPhone":
                tableView.frame = CGRect(x: 0.05*width, y: 0.143*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 4":
                tableView.frame = CGRect(x: 0.05*width, y: 0.143*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 4s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.143*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 5":
                tableView.frame = CGRect(x: 0.05*width, y: 0.135*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 5c":
                tableView.frame = CGRect(x: 0.05*width, y: 0.135*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 5s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.135*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 6":
                tableView.frame = CGRect(x: 0.05*width, y: 0.135*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 6 Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.135*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 6s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.135*height, width: 0.9*width, height: 0.15*height);
            case "iPhone 6s Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.135*height, width: 0.9*width, height: 0.15*height);
            default:
                tableView.frame = CGRect(x: 0.05*width, y: 0.135*height, width: 0.9*width, height: 0.15*height);
            }
        }
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{

            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            strFont = "HelveticaNeue"
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            AccView.backgroundColor = UIColor.clear
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            //tableView.backgroundColor = colorWithHexString ("DDF4FF")
            //AccView.backgroundColor = colorWithHexString ("DDF4FF")
            
            AccView.backgroundColor = UIColor.white
            tableView.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"bg.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: -0.05*height, width: width, height: height+(0.05*height));
            imgvwBack.alpha = 0.3
            imgvwBack.contentMode = UIView.ContentMode.scaleAspectFill
            //self.view.addSubview(imgvwBack)
            
            AccView.addSubview(txtShortDesc)
            AccView.addSubview(txtCommentRequest)
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            tableView.separatorColor = UIColor.clear
            
            txtShortDesc.textColor = colorWithHexString("ba8748")
            //txtCommentRequest.textColor = colorWithHexString ("ba8748")
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            strFont = "HelveticaNeue"
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            AccView.backgroundColor = UIColor.clear
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            //tableView.backgroundColor = colorWithHexString ("DDF4FF")
            //AccView.backgroundColor = colorWithHexString ("DDF4FF")
            
            AccView.backgroundColor = UIColor.white
            tableView.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"bg.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: -0.05*height, width: width, height: height+(0.05*height));
            imgvwBack.alpha = 0.3
            imgvwBack.contentMode = UIView.ContentMode.scaleAspectFill
            //self.view.addSubview(imgvwBack)
            
            AccView.addSubview(txtShortDesc)
            AccView.addSubview(txtCommentRequest)
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            tableView.separatorColor = UIColor.clear
            
            txtShortDesc.textColor = colorWithHexString("00467f")
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
            strFont = "HelveticaNeue"
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            AccView.backgroundColor = UIColor.clear
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            //tableView.backgroundColor = colorWithHexString ("DDF4FF")
            //AccView.backgroundColor = colorWithHexString ("DDF4FF")
            
            AccView.backgroundColor = UIColor.white
            tableView.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"bg.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: -0.05*height, width: width, height: height+(0.05*height));
            imgvwBack.alpha = 0.3
            imgvwBack.contentMode = UIView.ContentMode.scaleAspectFill
            //self.view.addSubview(imgvwBack)
            
            AccView.addSubview(txtShortDesc)
            AccView.addSubview(txtCommentRequest)
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            tableView.separatorColor = UIColor.clear
            
            tableView.backgroundColor = UIColor.clear
            
            txtShortDesc.textColor = colorWithHexString("2e3634")
            //txtCommentRequest.textColor = colorWithHexString ("2e3634")
            
        }
        
        tableView.reloadData()
        
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
                
            }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
                
                txtCommentRequest.textColor = colorWithHexString("2e3634")
                
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtCommentRequest.text.isEmpty {
            txtCommentRequest.text = NSLocalizedString("lblCommentRequest",comment:"");
            txtCommentRequest.textColor = colorWithHexString ("C7C7CD")
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 0.07*height
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?

        cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        if indexPath.row == 0{
            
            cell?.textLabel?.backgroundColor = UIColor.clear;
            cell?.textLabel?.textAlignment = NSTextAlignment.left;
            cell?.textLabel?.textColor = UIColor.black;
            cell?.textLabel?.numberOfLines = 0;
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont8 + appDelegate.gblDeviceFont3);
            cell?.textLabel?.text = NSLocalizedString("lblStay",comment:"");
            
            if(appDelegate.strUnitStay != ""){
                
                cell?.detailTextLabel?.backgroundColor = UIColor.clear;
                cell?.detailTextLabel?.textAlignment = NSTextAlignment.left;
                cell?.detailTextLabel?.textColor = UIColor.black;
                cell?.detailTextLabel?.numberOfLines = 0;
                cell?.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont6 + appDelegate.gblDeviceFont3);
                cell?.detailTextLabel?.text = appDelegate.strUnitStay
                
            }else{
                cell!.detailTextLabel?.text = ""
            }
            
        }else{
            
            cell?.textLabel?.backgroundColor = UIColor.clear;
            cell?.textLabel?.textAlignment = NSTextAlignment.left;
            cell?.textLabel?.textColor = UIColor.black;
            cell?.textLabel?.numberOfLines = 0;
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont8 + appDelegate.gblDeviceFont3);
            cell?.textLabel?.text = NSLocalizedString("lblType",comment:"");
            
            if(appDelegate.strDescriptionForExternal != ""){
                cell?.detailTextLabel?.backgroundColor = UIColor.clear;
                cell?.detailTextLabel?.textAlignment = NSTextAlignment.left;
                cell?.detailTextLabel?.textColor = UIColor.black;
                cell?.detailTextLabel?.numberOfLines = 0;
                cell?.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont6 + appDelegate.gblDeviceFont3);
                cell?.detailTextLabel?.text = appDelegate.strDescriptionForExternal
            }else{
                cell!.detailTextLabel?.text = ""
            }
        }
        
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
            //5C9FCC
            
            cell!.backgroundView = gradientView
            
            
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            cell!.backgroundColor = UIColor.clear
            
            cell!.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("e4c29c"))
            
            imgCell = UIImage(named:"tblrowsingle.png")!
            imgvwCell = UIImageView(image: imgCell)
            cell!.backgroundView = imgvwCell
            
            imgCell = UIImage(named:"tblrowsingleSel.png")!
            imgvwCell = UIImageView(image: imgCell)
            cell!.selectedBackgroundView = imgvwCell
            
            cell?.textLabel?.textColor = colorWithHexString("ba8748")
            cell?.detailTextLabel?.textColor = colorWithHexString("ba8748")
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            
            cell!.backgroundColor = UIColor.clear
            
            cell!.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("94cce5"))
            
            imgCell = UIImage(named:"tblrowsingle.png")!
            imgvwCell = UIImageView(image: imgCell)
            cell!.backgroundView = imgvwCell
            
            imgCell = UIImage(named:"tblrowsingleSel.png")!
            imgvwCell = UIImageView(image: imgCell)
            cell!.selectedBackgroundView = imgvwCell
            
            cell?.textLabel?.textColor = colorWithHexString("00467f")
            cell?.detailTextLabel?.textColor = colorWithHexString("00467f")
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
            
            
            cell!.backgroundColor = UIColor.clear
            
            cell!.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("004c50"))
            
            cell!.layer.masksToBounds = true
            cell!.layer.cornerRadius = 5
            cell!.layer.borderWidth = 1
            cell!.layer.shadowOffset = CGSize(width: -1, height: 1)
            cell!.layer.borderColor = UIColor.black.cgColor
            
            /*imgCell = UIImage(named:"tblrowsingle.png")!
            imgvwCell = UIImageView(image: imgCell)
            cell!.backgroundView = imgvwCell
            
            imgCell = UIImage(named:"tblrowsingleSel.png")!
            imgvwCell = UIImageView(image: imgCell)
            cell!.selectedBackgroundView = imgvwCell*/
            
            cell?.textLabel?.textColor = colorWithHexString("2e3634")
            cell?.detailTextLabel?.textColor = colorWithHexString("2e3634")
            
        }

        cell!.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            tableView.cellForRow(at: indexPath)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("ba8748"))
            
            if lastIndex != indexPath && lastIndex.count > 0{
                
                tableView.cellForRow(at: lastIndex)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("e4c29c"))
                
            }
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            tableView.cellForRow(at: indexPath)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("00467f"))
            
            if lastIndex != indexPath && lastIndex.count > 0{

                tableView.cellForRow(at: lastIndex)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("94cce5"))

            }
 
        }
        
        if indexPath.row == 0{
            if self.appDelegate.iCountStayF > 1{
                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectStay") as! vcSelectStay
                self.navigationController?.pushViewController(tercerViewController, animated: true)
            }
        }else{
            let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectRequestType") as! vcSelectRequestType
            self.navigationController?.pushViewController(tercerViewController, animated: true)
        }
        
        lastIndex = indexPath
        
    }
    
    func GetStay(_ sender: AnyObject){
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectStay") as! vcSelectStay
        self.navigationController?.pushViewController(tercerViewController, animated: true)
    }
    
    func GetType(_ sender: AnyObject){
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectRequestType") as! vcSelectRequestType
        self.navigationController?.pushViewController(tercerViewController, animated: true)
    }
    
    @objc func Send(_ sender: AnyObject){
        
        btnSend.isEnabled = false

        var prepareOrderResult:NSString="";
        
        if (SendValidate() == true){
        
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
        
        queue.addOperation() {
            
            if Reachability.isConnectedToNetwork(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                prepareOrderResult = self.WSReserv()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            OperationQueue.main.addOperation() {
                let separators = CharacterSet(charactersIn: ",")
                var aRes = prepareOrderResult.components(separatedBy: separators)
                if(aRes[0]=="1"){
                    GoogleWearAlert.showAlert(title: NSLocalizedString("SaveRequest",comment:""), type: .success, duration: 4, iAction: 2, form:"Request Edit New")
                    self.appDelegate.gblAddFollow = true
                    //self.navigationController?.popViewController(animated: false)
                    
                    let NextViewController = self.navigationController?.viewControllers[0]
                    self.navigationController?.popToViewController(NextViewController!, animated: false)
                    
                }else{
                    
                    RKDropdownAlert.title(NSLocalizedString("NoSaveRequest",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)

                }
                self.btnSend.isEnabled = true
                SwiftLoader.hide()
            }
            }
        }else{
            btnSend.isEnabled = true
            RKDropdownAlert.title(strValidError, backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
        }
        
        
    }
    
    func WSReserv() -> NSString{
        
        var prepareOrderResult:NSString="";
        
        var strDocumentCode: String = ""
        
        strDocumentCode = "GFollowUp"
        
        if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
            strDocumentCode = "APP_GUESTREQMAILCL"
        }

        appDelegate.strEmailList = ""
        
        var countEmails: Int = 0
        
        countEmails = appDelegate.gtblFollowUpTypeEmail.count
        
        if countEmails > 0{
            for yIndex in 0...countEmails-1 {

                if (appDelegate.gtblFollowUpTypeEmail[yIndex]["fkPropertyID"] == appDelegate.strUnitPropertyID && appDelegate.gtblFollowUpTypeEmail[yIndex]["pkFollowUpTypeID"] == appDelegate.strFollowUpTypeID){
                    
                    appDelegate.strEmailList = appDelegate.gtblFollowUpTypeEmail[yIndex]["emailList"]!

                }
                
            }
        }

        print(appDelegate.strEmailList)
        
        if Reachability.isConnectedToNetwork() && appDelegate.strEmailList != ""{

            if (self.appDelegate.strStayInfoStatus == "RESERVED" || self.appDelegate.strStayInfoStatus == "ASSIGNED"){
                
                let strdateFormatter = DateFormatter()
                strdateFormatter.dateFormat = "yyyy-MM-dd";
                let ArrivalDate = moment(self.appDelegate.strUnitArrivalDate)
                let strArrivalDate = strdateFormatter.string(from: ArrivalDate!.date)
                
                let service=RRRestaurantService(url: appDelegate.URLService as String, host: appDelegate.Host as String, userNameMobile:appDelegate.UserName, passwordMobile:appDelegate.Password);
                prepareOrderResult = service!.wmCallAddFollowUp(self.appDelegate.strDataBaseByStay, unitcode: appDelegate.strUnitCode, stayinfoID: appDelegate.strUnitStayInfoID, iPeopleID: appDelegate.gstrLoginPeopleID, fTypeID: appDelegate.strFollowUpTypeID, reqShort: txtShortDesc.text, reqlong: txtCommentRequest.text, solution: "", expect: strArrivalDate, finish: strArrivalDate, statusID: "3", strLenguageCode: self.appDelegate.strLenguaje, strDocumentCode: strDocumentCode, strPeopleEmail: appDelegate.strEmailList)! as NSString
                
            }else{
                
                let todaysDate:Date = Date()
                let dtdateFormatter:DateFormatter = DateFormatter()
                dtdateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
                let DateInFormat:String = dtdateFormatter.string(from: todaysDate)
                
                let service=RRRestaurantService(url: appDelegate.URLService as String, host: appDelegate.Host as String, userNameMobile:appDelegate.UserName, passwordMobile:appDelegate.Password);
                prepareOrderResult = service!.wmCallAddFollowUp(self.appDelegate.strDataBaseByStay, unitcode: appDelegate.strUnitCode, stayinfoID: appDelegate.strUnitStayInfoID, iPeopleID: appDelegate.gstrLoginPeopleID, fTypeID: appDelegate.strFollowUpTypeID, reqShort: txtShortDesc.text, reqlong: txtCommentRequest.text, solution: "", expect: DateInFormat, finish: DateInFormat, statusID: "3", strLenguageCode: self.appDelegate.strLenguaje, strDocumentCode: strDocumentCode, strPeopleEmail: appDelegate.strEmailList)! as NSString
                
            }

        }
        
        return prepareOrderResult
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var ynActualiza: Bool = false
        
        if(appDelegate.strUnitStay != ""){
            
            ynActualiza = true

        }
        
        if(appDelegate.strDescriptionForExternal != ""){
            
            ynActualiza = true
            
        }
        
        if ynActualiza == true {
            
            tableView.reloadData()

        }
        
    }
    
    func SendValidate()->Bool{
        
        if (txtShortDesc.text==""){
            strValidError = NSLocalizedString("msgProvDesc",comment:"")
            return false;
        }
        
        if (txtCommentRequest.text==""){
            strValidError = NSLocalizedString("msgProvReq",comment:"")
            return false;
        }
        
        if (appDelegate.strUnitCode==""){
            strValidError = NSLocalizedString("lblSelectStay",comment:"")
            return false;
        }
        
        if (appDelegate.strFollowUpTypeID==""){
            strValidError = NSLocalizedString("lblSelectRequestType",comment:"")
            return false;
        }
        
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.toolbar.isHidden = true
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Request Edit New",
            AnalyticsParameterItemName: "Request Edit New",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Request Edit New", screenClass: appDelegate.gstrAppName)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
