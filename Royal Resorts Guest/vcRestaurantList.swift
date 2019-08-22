//
//  vcRestaurantList.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 8/03/17.
//  Copyright © 2017 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging

class vcRestaurantList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var strFont: String = ""
    var imgCell = UIImage()
    var imgvwCell = UIImageView()
    var imgCellSel = UIImage()
    var imgvwCellSel = UIImageView()
    var lastIndex = IndexPath()
    var tblRestaurantListPropGroup: [[Dictionary<String, String>]]!
    var iseccion: Int = 0
    var indexImg: Int = 0
    var totalRest: Int = 0
    var hImg: CGFloat = 0
    var hTable: CGFloat = 0
    
    @IBOutlet var ViewItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var AccView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tblRestaurantListPropGroup = nil
        
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        self.tabBarController?.navigationController?.navigationBar.isHidden = true;
        self.navigationController?.navigationBar.isHidden = false;
        self.navigationController?.isToolbarHidden = false;

        //Titulo de la vista
        ViewItem.title = NSLocalizedString("lblTitleRestaurant",comment:"");
        
        //Boton Reserve
        ViewItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("btnReservations",comment:""), style: .plain, target: self, action: #selector(vcRestaurantList.clickReservations(_:)))
        
        //Boton Home
        ViewItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("btnHome",comment:""), style: .plain, target: self, action: #selector(vcRestaurantList.clickHome(_:)))
        
        let TabTitleFont = UIFont(name: "HelveticaNeue", size: appDelegate.gblFont10 + appDelegate.gblDeviceFont2)!

        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            strFont = "Helvetica"
            self.navigationController?.navigationBar.tintColor = colorWithHexString("0D94FC")
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            
            ViewItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: colorWithHexString("0D94FC")], for: UIControl.State())
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
            strFont = "HelveticaNeue"
            var img = UIImage(named:appDelegate.gstrNavImg)
            var resizable = img!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
            self.navigationController?.navigationBar.setBackgroundImage(resizable, for: .default)
            let navigationTitleFont = UIFont(name: strFont, size: appDelegate.gblFont10 + appDelegate.gblDeviceFont3)!
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.alpha = 0.99
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
            for parent in self.navigationController!.navigationBar.subviews {
                for childView in parent.subviews {
                    if(childView is UIImageView) {
                        childView.removeFromSuperview()
                    }
                }
            }
            
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            
            ViewItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State())

            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
            strFont = "HelveticaNeue"
            var img = UIImage(named:appDelegate.gstrNavImg)
            var resizable = img!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
            self.navigationController?.navigationBar.setBackgroundImage(resizable, for: .default)
            let navigationTitleFont = UIFont(name: strFont, size: appDelegate.gblFont10 + appDelegate.gblDeviceFont3)!
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.alpha = 0.99
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
            for parent in self.navigationController!.navigationBar.subviews {
                for childView in parent.subviews {
                    if(childView is UIImageView) {
                        childView.removeFromSuperview()
                    }
                }
            }
            
            ViewItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State())
            
        }
        
        appDelegate.strPeopleName = appDelegate.gtblLogin["FirstName"]!
        appDelegate.strPeopleLastName = appDelegate.gtblLogin["LastName"]!

        var tableItems = RRDataSet()

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
            //print("A1")
            if Reachability.isConnectedToNetwork(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
                let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                tableItems = (service?.spGetGuestAccount("1", appCode: self.appDelegate.gstrAppName, personalID: self.appDelegate.gstrLoginPeopleID, stayInfoID: self.appDelegate.RestStayInfoID.description, lastAccTrxID: "", dataBase: self.appDelegate.strDataBaseByStay))!
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            OperationQueue.main.addOperation() {
                queue.addOperation() {//2
                    //accion base de datos
                    //print("A2")
                    
                    if (tableItems.getTotalTables() > 0 ){
                        
                        var tableResult = RRDataTable()
                        tableResult = tableItems.tables.object(at: 2) as! RRDataTable
                        
                        self.appDelegate.RestCountPeople = Int(tableResult.getTotalRows())

                    }
                    
                    OperationQueue.main.addOperation() {
                        //accion
                        if !Reachability.isConnectedToNetwork(){
                            RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                        }
                        
                        SwiftLoader.hide()
                    }
                }//2
            }//1
        }
        
        
        if appDelegate.ynIPad {
            switch appDelegate.Model {
            case "iPad 2":
                tableView.frame = CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.89*height);
                hTable = 0.86
            case "iPad Air":
                tableView.frame = CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.89*height);
                hTable = 0.86
            case "iPad Air 2":
                tableView.frame = CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.89*height);
                hTable = 0.86
            case "iPad Pro":
                tableView.frame = CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.89*height);
                hTable = 0.86
            case "iPad Retina":
                tableView.frame = CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.89*height);
                hTable = 0.86
            default:
                tableView.frame = CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.89*height);
                hTable = 0.86
            }
        }else{
            switch appDelegate.Model {
            case "iPhone":
                tableView.frame = CGRect(x: 0.0, y: 0.09*height, width: width, height: 0.8*height);
                hTable = 0.76
            case "iPhone 4":
                tableView.frame = CGRect(x: 0.0, y: 0.09*height, width: width, height: 0.8*height);
                hTable = 0.76
            case "iPhone 4s":
                tableView.frame = CGRect(x: 0.0, y: 0.09*height, width: width, height: 0.8*height);
                hTable = 0.76
            case "iPhone 5":
                tableView.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.8*height);
                hTable = 0.76
            case "iPhone 5c":
                tableView.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.8*height);
                hTable = 0.76
            case "iPhone 5s":
                tableView.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.8*height);
                hTable = 0.76
            case "iPhone 6":
                tableView.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.8*height);
                hTable = 0.76
            case "iPhone 6 Plus":
                tableView.frame = CGRect(x: 0.0, y: 0.06*height, width: width, height: 0.847*height);
                hTable = 0.79
            case "iPhone 6s":
                tableView.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.8*height);
                hTable = 0.76
            case "iPhone 6s Plus":
                tableView.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.8*height);
                hTable = 0.76
            default:
                tableView.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.8*height);
                hTable = 0.76
            }
        }

        self.view.backgroundColor = UIColor.white
        AccView.backgroundColor = UIColor.white
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.separatorColor = UIColor.clear

        CargaRestaurantList()
        
    }
    
    @objc func clickHome(_ sender: AnyObject) {
        
        self.tabBarController?.navigationController?.navigationBar.isHidden = false;
        appDelegate.gblGoHome = true
        appDelegate.gblGoOut = false
        self.tabBarController?.navigationController?.popViewController(animated: false)
        
    }
    
    @objc func clickReservations(_ sender: AnyObject){
        
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcRestReservList") as! vcRestReservList
        self.navigationController?.pushViewController(tercerViewController, animated: true)
        
    }

    func CargaRestaurantList(){


        var tableItems = RRDataSet()
        var iRes: String = ""
        var tblRestaurantListTemp: Dictionary<String, String>!
        var iSection: Int = 0
        var iSectionGroup: Int = 0
        var sPropertyName: String = ""
        var tblRestaurantListPropGroupAux: [[Dictionary<String, String>]]
        
        tblRestaurantListPropGroupAux = []
        
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
                //print("A1")
                if Reachability.isConnectedToNetwork(){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    
                    let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                    tableItems = (service?.spGetRestaurantDefault("3", propertyID: "0", typeCode: self.appDelegate.gstrAppName, stayInfoID: self.appDelegate.RestStayInfoID.description, dataBase: self.appDelegate.strDataBaseByStay))!
                    
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
                                
                                
                                var table = RRDataTable()
                                table = tableItems.tables.object(at: 1) as! RRDataTable
                                
                                if table.rows != nil{
                                    var r = RRDataRow()
                                    r = table.rows.object(at: 0) as! RRDataRow
                                    
                                    self.totalRest = table.rows.count
                                    
                                    for r in table.rows{
                                        
                                        if sPropertyName == ""{
                                            iSection = 0
                                            iSectionGroup = 0
                                            tblRestaurantListPropGroupAux.append([[:]])
                                        }else if sPropertyName != ((r as AnyObject).getColumnByName("PropertyName").content as? String)!{
                                            iSection = 0
                                            iSectionGroup = iSectionGroup + 1
                                            tblRestaurantListPropGroupAux.append([[:]])
                                        }else{
                                            iSection = iSection + 1
                                            tblRestaurantListPropGroupAux[iSectionGroup].append([:])
                                        }
                                        
                                        tblRestaurantListTemp = [:]
                                        
                                        sPropertyName = ((r as AnyObject).getColumnByName("PropertyName").content as? String)!

                                        tblRestaurantListTemp["RestaurantName"] = (r as AnyObject).getColumnByName("RestaurantName").content as? String
                                        tblRestaurantListTemp["RestaurantCode"] = (r as AnyObject).getColumnByName("RestaurantCode").content as? String
                                        tblRestaurantListTemp["ServerCode"] = (r as AnyObject).getColumnByName("ServerCode").content as? String
                                        tblRestaurantListTemp["RestaurantDatabaseConn"] = (r as AnyObject).getColumnByName("RestaurantDatabaseConn").content as? String
                                        tblRestaurantListTemp["PlaceForDeps"] = (r as AnyObject).getColumnByName("PlaceForDeps").content as? String
                                        tblRestaurantListTemp["WebServiceCode"] = (r as AnyObject).getColumnByName("WebServiceCode").content as? String
                                        tblRestaurantListTemp["WebServiceConn"] = (r as AnyObject).getColumnByName("WebServiceConn").content as? String
                                        tblRestaurantListTemp["pkCRMRestaurantID"] = (r as AnyObject).getColumnByName("pkCRMRestaurantID").content as? String
                                        tblRestaurantListTemp["CRMDescription"] = (r as AnyObject).getColumnByName("CRMDescription").content as? String
                                        tblRestaurantListTemp["WebsiteURL"] = (r as AnyObject).getColumnByName("WebsiteURL").content as? String
                                        tblRestaurantListTemp["PropertyName"] = (r as AnyObject).getColumnByName("PropertyName").content as? String
                                        tblRestaurantListTemp["Opentime"] = (r as AnyObject).getColumnByName("Opentime").content as? String
                                        tblRestaurantListTemp["PropertyCode"] = (r as AnyObject).getColumnByName("PropertyCode").content as? String
                                        tblRestaurantListTemp["RestCodeCRM"] = (r as AnyObject).getColumnByName("RestCodeCRM").content as? String
                                        tblRestaurantListTemp["URLBanner"] = (r as AnyObject).getColumnByName("URLBanner").content as? String
                                        tblRestaurantListTemp["DayOff"] = (r as AnyObject).getColumnByName("DayOff").content as? String
                                        tblRestaurantListPropGroupAux[iSectionGroup][iSection] = tblRestaurantListTemp

                                    }

                                    self.tblRestaurantListPropGroup = tblRestaurantListPropGroupAux
                                    self.iseccion = self.tblRestaurantListPropGroup.count
                                    self.ViewItem.rightBarButtonItem?.isEnabled = true
                                }
                                
                            }else{
                            
                                self.ViewItem.rightBarButtonItem?.isEnabled = false
                                
                            }
                            
                        }
                        
                        OperationQueue.main.addOperation() {
                            //accion
                            if !Reachability.isConnectedToNetwork(){
                                RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                            }
                            
                            self.indexImg = 1
                            
                            self.tableView.reloadData()
                            
                            SwiftLoader.hide()
                        }
                    }//2
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.toolbar.isHidden = true
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Restaurant List",
            AnalyticsParameterItemName: "Restaurant List",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Restaurant List", screenClass: appDelegate.gstrAppName)
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return iseccion;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tblRestaurantListPropGroup[section].count;
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        hImg = (hTable*height)/CGFloat(totalRest)
        
        return ((hTable*height)/CGFloat(totalRest))
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.06*height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title: UILabel = UILabel()
        title.backgroundColor = UIColor.clear;
        title.textAlignment = NSTextAlignment.left;
        title.textColor = UIColor.gray;
        title.font = UIFont(name:"HelveticaNeue-Light", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont4)
        title.numberOfLines = 0;
        title.text = String(tblRestaurantListPropGroup[section][0]["PropertyName"]!)
        
        return title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellRestaurantList") as! tvcRestaurantList
        
        cell.backgroundColor = UIColor.clear
        cell.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("e4c29c"))

        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{

            cell.backgroundColor = UIColor.clear
            
            if indexImg > totalRest{
                indexImg = 1
            }
            
            imgvwCell = UIImageView(image: imgCell)
            if let url = URL.init(string: String(tblRestaurantListPropGroup[indexPath.section][indexPath.row]["URLBanner"]!)) {
                imgvwCell.downloadedFrom(url: url)
            }
            
            imgvwCell.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            imgvwCell.translatesAutoresizingMaskIntoConstraints = true
            imgvwCell.contentMode = .scaleToFill
            
            cell.backgroundView = imgvwCell
            
            imgvwCell = UIImageView(image: imgCell)
            if let url = URL.init(string: String(tblRestaurantListPropGroup[indexPath.section][indexPath.row]["URLBanner"]!)) {
                imgvwCell.downloadedFrom(url: url)
            }
            
            imgvwCell.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            imgvwCell.translatesAutoresizingMaskIntoConstraints = true
            imgvwCell.contentMode = .scaleToFill
            
            cell.selectedBackgroundView = imgvwCell
            
            indexImg = indexImg + 1

            lastIndex = IndexPath.init()

            cell.textLabel?.textColor = colorWithHexString("C7C7CD")
            cell.detailTextLabel?.textColor = colorWithHexString("C7C7CD")
            cell.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("C7C7CD"))

        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            cell.backgroundColor = UIColor.clear

            if indexImg > totalRest{
                indexImg = 1
            }

            imgvwCell = UIImageView(image: imgCell)
            if let url = URL.init(string: String(tblRestaurantListPropGroup[indexPath.section][indexPath.row]["URLBanner"]!)) {
                imgvwCell.downloadedFrom(url: url)
            }
            
            imgvwCell.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            imgvwCell.translatesAutoresizingMaskIntoConstraints = true
            imgvwCell.contentMode = .scaleToFill
            
            cell.backgroundView = imgvwCell
            
            imgvwCell = UIImageView(image: imgCell)
            if let url = URL.init(string: String(tblRestaurantListPropGroup[indexPath.section][indexPath.row]["URLBanner"]!)) {
                imgvwCell.downloadedFrom(url: url)
            }
            
            imgvwCell.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            imgvwCell.translatesAutoresizingMaskIntoConstraints = true
            imgvwCell.contentMode = .scaleToFill
            
            cell.selectedBackgroundView = imgvwCell
            
            indexImg = indexImg + 1
            
            lastIndex = IndexPath.init()
            
            cell.textLabel?.textColor = colorWithHexString("CB983E")
            cell.detailTextLabel?.textColor = colorWithHexString("CB983E")
            cell.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("e4c29c"))
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            cell.backgroundColor = UIColor.clear
            cell.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("94cce5"))
            
            if indexPath.row == 0{
                imgCell = UIImage(named:"tblhdr.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblhdrSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }else if (tblRestaurantListPropGroup[indexPath.section].count-1) == indexPath.row{
                imgCell = UIImage(named:"tblfooter.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblfooterSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            } else {
                imgCell = UIImage(named:"tblrow.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblrowSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }
            
            if (tblRestaurantListPropGroup[indexPath.section].count) == 1
            {
                imgCell = UIImage(named:"tblrowsingle.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblrowsingleSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
                
            }
            
            lastIndex = IndexPath.init()
            cell.textLabel?.textColor = colorWithHexString("00467f")
            cell.detailTextLabel?.textColor = colorWithHexString("00467f")
        }
        
        cell.SetValues(String(tblRestaurantListPropGroup[indexPath.section][indexPath.row]["RestaurantName"]!), width: width, height: height, cellh: hImg)

        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        lastIndex = IndexPath.init()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            if lastIndex != indexPath && lastIndex.count > 0{

                
            }else{
                if lastIndex != indexPath {
                    
                    
                }
                
            }
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
            
        }
        
        lastIndex = indexPath
        
        self.appDelegate.pkRestaurantID = Int(tblRestaurantListPropGroup[indexPath.section][indexPath.row]["pkCRMRestaurantID"]!)!
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcRestaurant") as! vcRestaurant
        tercerViewController.RestaurantName = String(tblRestaurantListPropGroup[indexPath.section][indexPath.row]["RestaurantName"]!)
        tercerViewController.Opentime = String(tblRestaurantListPropGroup[indexPath.section][indexPath.row]["Opentime"]!)
        tercerViewController.RestaurantCode = String(tblRestaurantListPropGroup[indexPath.section][indexPath.row]["RestCodeCRM"]!)
        tercerViewController.PropertyCode = String(tblRestaurantListPropGroup[indexPath.section][indexPath.row]["PropertyCode"]!)
        tercerViewController.urlHome = String(tblRestaurantListPropGroup[indexPath.section][indexPath.row]["WebsiteURL"]!)
        tercerViewController.strDayName = String(tblRestaurantListPropGroup[indexPath.section][indexPath.row]["DayOff"]!)
        self.navigationController?.pushViewController(tercerViewController, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appDelegate.gblGoHome = false
        
        if self.appDelegate.gblGoRestReserv == true{
            
            self.appDelegate.gblGoRestReserv = false

            let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcRestReservList") as! vcRestReservList
            self.navigationController?.pushViewController(tercerViewController, animated: true)
        }
        
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return false
    }
    
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

