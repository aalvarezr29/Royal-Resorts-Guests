//
//  vcSelectRequestType.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 26/01/16.
//  Copyright © 2016 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging

class vcSelectRequestType: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var width: CGFloat!
    var height: CGFloat!
    var btnBack = UIButton()
    var btnNext = UIButton()
    var tblPreAuth: [Dictionary<String, String>]!
    
    var StayInfoID: String = ""
    var PeopleID: String = ""
    var PeopleFDeskID: String = ""
    var formatter = NumberFormatter()
    var tblFollowUp: [Dictionary<String, String>]!
    var tblFollowUpType: [Dictionary<String, String>]!
    var iseccion: Int = 0
    var ynActualiza: Bool = false
    var imgCell = UIImage()
    var imgvwCell = UIImageView()
    var lastIndex = IndexPath()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var ViewItem: UINavigationItem!
    @IBOutlet weak var AccView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tabBarController?.navigationController?.navigationBar.isHidden = true;
        
        self.navigationController?.navigationBar.isHidden = false;
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString("lblSelectRequestType",comment:"");
        
        self.navigationController?.isToolbarHidden = false;
        
        if appDelegate.ynIPad {
            switch appDelegate.Model {
            case "iPad 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.64*height);
            case "iPad Air":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.64*height);
            case "iPad Air 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.64*height);
            case "iPad Pro":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.64*height);
            case "iPad Retina":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.64*height);
            default:
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.64*height);
            }
        }else{
            switch appDelegate.Model {
            case "iPhone":
                tableView.frame = CGRect(x: 0.05*width, y: 0.143*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 4":
                tableView.frame = CGRect(x: 0.05*width, y: 0.143*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 4s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.143*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 5":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 5c":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 5s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 6":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 6 Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 6s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 6s Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.64*height);
            default:
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.64*height);
            }
        }
        
        if appDelegate.gtblFollowUpType == nil{
            ynActualiza = true
        }else{
            ynActualiza = false
        }
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
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
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            tableView.separatorColor = UIColor.clear
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
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
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            tableView.separatorColor = UIColor.clear
            
        }
        
        cargarDatos()
        
    }
    
    func cargarDatos(){
        
        var tableItems = RRDataSet()
        var val: String = "0"
        var iRes: String = ""
        var tblFollow: Dictionary<String, String>!
        var tblFollowType: Dictionary<String, String>!
        
        val = "0"
        
        tblFollowUp = []
        tblFollowUpType = []
        
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
                
                let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                tableItems = (service?.spGetMobileFollowUpVw(val, appCode: self.appDelegate.gstrAppName, peopleID: self.appDelegate.gstrLoginPeopleID, followUpId: "0", dataBase: self.appDelegate.strDataBaseByStay, sLanguage: self.appDelegate.strLenguaje))!
                
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
                        
                        if ( (iRes != "0") && (iRes != "-1")){
                            
                            var tableType = RRDataTable()
                            tableType = tableItems.tables.object(at: 1) as! RRDataTable
                            
                            var rType = RRDataRow()
                            rType = tableType.rows.object(at: 0) as! RRDataRow
                            
                            for rType in tableType.rows{
                                (rType as AnyObject).getColumnByName("pkFollowUpTypeID").content as? String
                                tblFollowType = [:]
                                tblFollowType["pkFollowUpTypeID"] = (rType as AnyObject).getColumnByName("pkFollowUpTypeID").content as? String
                                tblFollowType["DescriptionForExternal"] = (rType as AnyObject).getColumnByName("DescriptionForExternal").content as? String
                                self.tblFollowUpType.append(tblFollowType)
                            }
                            
                            self.appDelegate.gtblFollowUpType = self.tblFollowUpType
                            
                            var table = RRDataTable()
                            table = tableItems.tables.object(at: 2) as! RRDataTable
                            
                            if table.rows != nil{
                                var r = RRDataRow()
                                r = table.rows.object(at: 0) as! RRDataRow
                                
                                for r in table.rows{
                                    tblFollow = [:]
                                    tblFollow["ID"] = (r as AnyObject).getColumnByName("ID").content as? String
                                    tblFollow["ExpectedDt"] = (r as AnyObject).getColumnByName("ExpectedDt").content as? String
                                    tblFollow["FinishDt"] = (r as AnyObject).getColumnByName("FinishDt").content as? String
                                    tblFollow["Reqshort"] = (r as AnyObject).getColumnByName("Reqshort").content as? String
                                    tblFollow["Requiere"] = (r as AnyObject).getColumnByName("Requiere").content as? String
                                    tblFollow["FType"] = (r as AnyObject).getColumnByName("FType").content as? String
                                    tblFollow["ConfirmationCode"] = (r as AnyObject).getColumnByName("ConfirmationCode").content as? String
                                    tblFollow["pkStayInfoID"] = (r as AnyObject).getColumnByName("pkStayInfoID").content as? String
                                    tblFollow["Status"] = (r as AnyObject).getColumnByName("Status").content as? String
                                    tblFollow["intv"] = (r as AnyObject).getColumnByName("intv").content as? String
                                    tblFollow["IntvYear"] = (r as AnyObject).getColumnByName("IntvYear").content as? String
                                    tblFollow["peopleID"] = (r as AnyObject).getColumnByName("peopleID").content as? String
                                    tblFollow["Solution"] = (r as AnyObject).getColumnByName("Solution").content as? String
                                    tblFollow["AccCode"] = (r as AnyObject).getColumnByName("AccCode").content as? String
                                    tblFollow["CrDt"] = (r as AnyObject).getColumnByName("CrDt").content as? String
                                    self.tblFollowUp.append(tblFollow)
                                }
                                
                                self.appDelegate.gtblFollowUp = self.tblFollowUp
                            }
                            
                        }
                        
                    }
                    
                    OperationQueue.main.addOperation() {
                        //accion
                        if !Reachability.isConnectedToNetwork(){
                            RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                        }
                        
                        if self.appDelegate.gtblFollowUpType == nil{
                            self.iseccion = 0
                        }else{
                            self.iseccion = self.appDelegate.gtblFollowUpType.count
                        }
                        
                        self.tableView.reloadData()
                        
                        SwiftLoader.hide()
                    }
                }
            }
        }
    }
    
    func recargarTablas(){
        
        var tableItems = RRDataSet()
        var val: String = "0"
        var iRes: String = ""
        var tblFollow: Dictionary<String, String>!
        var tblFollowType: Dictionary<String, String>!
        
        val = "0"
        
        tblFollowUp = []
        tblFollowUpType = []
        
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
            if self.ynActualiza {
                //print("A1")
                if Reachability.isConnectedToNetwork(){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    
                    let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                    tableItems = (service?.spGetMobileFollowUpVw(val, appCode: self.appDelegate.gstrAppName, peopleID: self.appDelegate.gstrLoginPeopleID, followUpId: "0", dataBase: self.appDelegate.strDataBaseByStay, sLanguage: self.appDelegate.strLenguaje))!
                    
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
                            }else{
                                iRes = "-1"
                            }
                            
                            if ( (iRes != "0") && (iRes != "-1")){
                                
                                var tableType = RRDataTable()
                                tableType = tableItems.tables.object(at: 1) as! RRDataTable
                                
                                var rType = RRDataRow()
                                rType = tableType.rows.object(at: 0) as! RRDataRow
                                
                                for rType in tableType.rows{
                                    tblFollowType = [:]
                                    tblFollowType["pkFollowUpTypeID"] = (rType as AnyObject).getColumnByName("pkFollowUpTypeID").content as? String
                                    tblFollowType["DescriptionForExternal"] = (rType as AnyObject).getColumnByName("DescriptionForExternal").content as? String
                                    self.tblFollowUpType.append(tblFollowType)
                                }
                                
                                self.appDelegate.gtblFollowUpType = self.tblFollowUpType
                                
                                var table = RRDataTable()
                                table = tableItems.tables.object(at: 2) as! RRDataTable
                                
                                if table.rows != nil{
                                    var r = RRDataRow()
                                    r = table.rows.object(at: 0) as! RRDataRow
                                    
                                    for r in table.rows{
                                        tblFollow = [:]
                                        tblFollow["ID"] = (r as AnyObject).getColumnByName("ID").content as? String
                                        tblFollow["ExpectedDt"] = (r as AnyObject).getColumnByName("ExpectedDt").content as? String
                                        tblFollow["FinishDt"] = (r as AnyObject).getColumnByName("FinishDt").content as? String
                                        tblFollow["Reqshort"] = (r as AnyObject).getColumnByName("Reqshort").content as? String
                                        tblFollow["Requiere"] = (r as AnyObject).getColumnByName("Requiere").content as? String
                                        tblFollow["FType"] = (r as AnyObject).getColumnByName("FType").content as? String
                                        tblFollow["ConfirmationCode"] = (r as AnyObject).getColumnByName("ConfirmationCode").content as? String
                                        tblFollow["pkStayInfoID"] = (r as AnyObject).getColumnByName("pkStayInfoID").content as? String
                                        tblFollow["Status"] = (r as AnyObject).getColumnByName("Status").content as? String
                                        tblFollow["intv"] = (r as AnyObject).getColumnByName("intv").content as? String
                                        tblFollow["IntvYear"] = (r as AnyObject).getColumnByName("IntvYear").content as? String
                                        tblFollow["peopleID"] = (r as AnyObject).getColumnByName("peopleID").content as? String
                                        tblFollow["Solution"] = (r as AnyObject).getColumnByName("Solution").content as? String
                                        tblFollow["AccCode"] = (r as AnyObject).getColumnByName("AccCode").content as? String
                                        tblFollow["CrDt"] = (r as AnyObject).getColumnByName("CrDt").content as? String
                                        self.tblFollowUp.append(tblFollow)
                                    }
                                    
                                    self.appDelegate.gtblFollowUp = self.tblFollowUp
                                }
                                
                            }
                            
                        }
                        
                        OperationQueue.main.addOperation() {
                            //accion
                            if !Reachability.isConnectedToNetwork(){
                                RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                            }
                            
                            if self.appDelegate.gtblFollowUpType == nil{
                                self.iseccion = 0
                            }else{
                                self.iseccion = self.appDelegate.gtblFollowUpType.count
                            }
                            
                            self.tableView.reloadData()
                            
                            SwiftLoader.hide()
                        }
                    }//2
                }
            }//1
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return iseccion
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0.06*height
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "CellSelectRequestType")!
        
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
            
            imgCell = UIImage(named:"tblrowsingle.png")!
            imgvwCell = UIImageView(image: imgCell)
            cell.backgroundView = imgvwCell
            
            imgCell = UIImage(named:"tblrowsingleSel.png")!
            imgvwCell = UIImageView(image: imgCell)
            cell.selectedBackgroundView = imgvwCell
            
            lastIndex = IndexPath.init()
            cell.textLabel?.textColor = colorWithHexString("ba8748")
            cell.detailTextLabel?.textColor = colorWithHexString("ba8748")
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            
            cell.backgroundColor = UIColor.clear
            cell.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("94cce5"))
            
            imgCell = UIImage(named:"tblrowsingle.png")!
            imgvwCell = UIImageView(image: imgCell)
            cell.backgroundView = imgvwCell
                
            imgCell = UIImage(named:"tblrowsingleSel.png")!
            imgvwCell = UIImageView(image: imgCell)
            cell.selectedBackgroundView = imgvwCell

            lastIndex = IndexPath.init()
            cell.textLabel?.textColor = colorWithHexString("00467f")
            cell.detailTextLabel?.textColor = colorWithHexString("00467f")
            
        }

        cell.textLabel?.text = String(appDelegate.gtblFollowUpType[indexPath.row]["DescriptionForExternal"]!)

        cell.textLabel?.font = UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont2)
        cell.textLabel?.adjustsFontSizeToFitWidth = true;
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        
        appDelegate.strFollowUpTypeID = String(appDelegate.gtblFollowUpType[indexPath.row]["pkFollowUpTypeID"]!)
        appDelegate.strDescriptionForExternal = String(appDelegate.gtblFollowUpType[indexPath.row]["DescriptionForExternal"]!)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.toolbar.isHidden = true
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Select Request",
            AnalyticsParameterItemName: "Select Request",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Select Request", screenClass: appDelegate.gstrAppName)
        
    }
    
}
