//
//  vcListReserv.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 23/03/17.
//  Copyright © 2017 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging
import DGRunkeeperSwitch

class vcRestReservList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var RestaurantReservations: [Dictionary<String, String>]!
    var strFont: String = ""
    var CountReserv: Int = 0
    var lastIndex = IndexPath()
    var imgCell = UIImage()
    var imgvwCell = UIImageView()
    var runkeeperSwitch: DGRunkeeperSwitch!
    var ynShowHistory: Bool = false
    
    @IBOutlet var ViewItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var AccView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        RestaurantReservations = nil
        
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        self.tabBarController?.navigationController?.navigationBar.isHidden = true;
        self.navigationController?.navigationBar.isHidden = false;
        self.navigationController?.isToolbarHidden = false;
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString("lblTitleRestReserv",comment:"");
        
        runkeeperSwitch = DGRunkeeperSwitch(titles: [NSLocalizedString("lblRecent",comment:""),NSLocalizedString("lblHistory",comment:"")])
        runkeeperSwitch.backgroundColor = colorWithHexString ("5C9FCC")
        runkeeperSwitch.selectedBackgroundColor = .white
        runkeeperSwitch.titleColor = .white
        runkeeperSwitch.selectedTitleColor = colorWithHexString ("5C9FCC")
        runkeeperSwitch.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
        runkeeperSwitch.frame = CGRect(x: 0.05*width, y: 0.01*height, width: 0.8*width, height: 0.05*height)
        runkeeperSwitch.addTarget(self, action: #selector(vcRestReservList.switchValueDidChange(_:)), for: .valueChanged)
        AccView.addSubview(runkeeperSwitch)
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            strFont = "Helvetica"
            self.navigationController?.navigationBar.tintColor = colorWithHexString("0D94FC")
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            
            
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
            
            runkeeperSwitch.backgroundColor = self.colorWithHexString ("ba8748")
            runkeeperSwitch.selectedTitleColor = self.colorWithHexString ("ba8748")
            
            
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
            
            runkeeperSwitch.backgroundColor = self.colorWithHexString ("a18015")
            runkeeperSwitch.selectedTitleColor = self.colorWithHexString ("a18015")
            
            
        }
        
        if appDelegate.ynIPad {
            switch appDelegate.Model {
            case "iPad 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.55*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            case "iPad Air":
                tableView.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.55*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            case "iPad Air 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.55*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            case "iPad Pro":
                tableView.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.55*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            case "iPad Retina":
                tableView.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.55*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            default:
                tableView.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.55*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            }
        }else{
            switch appDelegate.Model {
            case "iPhone":
                tableView.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.48*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            case "iPhone 4":
                tableView.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.48*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            case "iPhone 4s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.48*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            case "iPhone 5":
                tableView.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.5*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.08*height, width: 0.9*width, height: 0.07*height);
            case "iPhone 5c":
                tableView.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.5*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            case "iPhone 5s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.5*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            case "iPhone 6":
                tableView.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.52*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            case "iPhone 6 Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.52*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            case "iPhone 6s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.52*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            case "iPhone 6s Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.52*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            default:
                tableView.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.6*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            }
        }
        
        self.view.backgroundColor = UIColor.white
        AccView.backgroundColor = UIColor.white
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.separatorColor = UIColor.clear

        CargaReservList()
        
        let lblFooterMsg = UILabel(frame: CGRect(x: 0.05*width, y: 0.8*height, width: 0.9*width, height: 0.1*height));
        lblFooterMsg.backgroundColor = UIColor.clear;
        lblFooterMsg.textAlignment = NSTextAlignment.center;
        lblFooterMsg.textColor = colorWithHexString("a6a6a6")
        lblFooterMsg.numberOfLines = 0;
        lblFooterMsg.font = UIFont(name: "Verdana", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont3)
        lblFooterMsg.text = NSLocalizedString("strTextResCred",comment:"");
        lblFooterMsg.adjustsFontSizeToFitWidth = true
        
        self.view.addSubview(lblFooterMsg)
        
    }
    
    @objc func switchValueDidChange(_ sender: DGRunkeeperSwitch!) {
        
        if sender.selectedIndex == 1 {
            ynShowHistory = true
        } else {
            ynShowHistory = false
        }
        
        CargaReservList()
        
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
    
    func CargaReservList(){
        
        var DataRestaurantReservation = [String:String]()
        var RestaurantReservationsTemp: [Dictionary<String, String>]
        var Index: Int = 0
        var resultStayID: Int32 = 0
        var strQueryCount: String = ""
        var strQuery: String = ""
        
        RestaurantReservationsTemp = []
        
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))

        self.appDelegate.strRestStayInfoID = ""
        
        queueFM?.inDatabase() {
            db in
            
            if let rs = db.executeQuery("SELECT * FROM tblStay" as String,"" as AnyObject){
                while rs.next() {

                    self.appDelegate.strRestStayInfoID = self.appDelegate.strRestStayInfoID + rs.string(forColumn: "StayInfoID")! + ", "

                }
            }
            
        }
        
        let pre: AnyObject = self.appDelegate.strRestStayInfoID as AnyObject
        
        let strpre: String = pre.debugDescription
        
        let start = strpre.index(strpre.startIndex, offsetBy: 0)
        let end = strpre.index(strpre.endIndex, offsetBy: -2)
        let range = start..<end
        
        let mySubstring = strpre[range]
        
        self.appDelegate.strRestStayInfoID = String(mySubstring)
        
        if ynShowHistory{
            queueFM?.inDatabase() {
                db in
                
                let resultCount = db.intForQuery("SELECT COUNT(*) FROM tblRestaurantReservation rs INNER JOIN tblStay st ON st.StayInfoID = rs.StayInfoID WHERE st.StayInfoID = " + self.appDelegate.strRestStayInfoID + " and DateReservation < strftime('%Y-%m-%d', 'now') and DateReservation between date('now','start of month','-3 month','-1 day') and date('now','start of month','+3 month','-1 day')" as String, "" as AnyObject)
                
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
            
            self.CountReserv = Int(resultStayID)
            
            if resultStayID > 0{
                queueFM?.inDatabase() {
                    db in
                    
                    for _ in 0...resultStayID-1 {
                        RestaurantReservationsTemp.append([:])
                    }
                    
                    if let rs = db.executeQuery("SELECT rs.StayInfoID, rs.UnitCode, rs.RestaurantName, rs.ZoneDescripcion, rs.Name, rs.Adults, rs.Childrens, rs.DateReservation, rs.TimeReservation, rs.ConfirmacionNumber, rs.Comments FROM tblRestaurantReservation rs INNER JOIN tblStay st ON st.StayInfoID = rs.StayInfoID WHERE st.StayInfoID = " + self.appDelegate.strRestStayInfoID + " and DateReservation < strftime('%Y-%m-%d', 'now') and DateReserva@objc tion between date('now','start of month','-3 month','-1 day') and date('now','start of month','+3 month','-1 day')", withArgumentsIn: []){
                    while rs.next() {
                            DataRestaurantReservation["StayInfoID"] = String(describing: rs.string(forColumn: "StayInfoID")!)
                            DataRestaurantReservation["UnitCode"] = String(describing: rs.string(forColumn: "UnitCode")!)
                            DataRestaurantReservation["RestaurantName"] = String(describing: rs.string(forColumn: "RestaurantName")!)
                            DataRestaurantReservation["ZoneDescripcion"] = String(describing: rs.string(forColumn: "ZoneDescripcion")!)
                            DataRestaurantReservation["Name"] = String(describing: rs.string(forColumn: "Name")!)
                            DataRestaurantReservation["Adults"] = String(describing: rs.string(forColumn: "Adults")!)
                            DataRestaurantReservation["Childrens"] = String(describing: rs.string(forColumn: "Childrens")!)
                            DataRestaurantReservation["DateReservation"] = String(describing: rs.string(forColumn: "DateReservation")!)
                            DataRestaurantReservation["TimeReservation"] = String(describing: rs.string(forColumn: "TimeReservation")!)
                            DataRestaurantReservation["ConfirmacionNumber"] = String(describing: rs.string(forColumn: "ConfirmacionNumber")!)
                            DataRestaurantReservation["Comments"] = String(describing: rs.string(forColumn: "Comments")!)
                            RestaurantReservationsTemp[Index] = DataRestaurantReservation
                            
                            Index = Index + 1
                        }
                        
                        self.RestaurantReservations = RestaurantReservationsTemp
                        
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                    
                }
            }
            
        }else{
            
            queueFM?.inDatabase() {
                db in
                
                let resultCount = db.intForQuery("SELECT COUNT(*) FROM tblRestaurantReservation rs WHERE rs.StayInfoID = " + self.appDelegate.strRestStayInfoID as String, "" as AnyObject)
                
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

            self.CountReserv = Int(resultStayID)

            if resultStayID > 0{
                queueFM?.inDatabase() {
                    db in
                    
                    for _ in 0...resultStayID-1 {
                        RestaurantReservationsTemp.append([:])
                    }
                    
                    if let rs = db.executeQuery("SELECT rs.StayInfoID, rs.UnitCode, rs.RestaurantName, rs.ZoneDescripcion, rs.Name, rs.Adults, rs.Childrens, rs.DateReservation, rs.TimeReservation, rs.ConfirmacionNumber, rs.Comments FROM tblRestaurantReservation rs WHERE rs.StayInfoID = " + self.appDelegate.strRestStayInfoID, withArgumentsIn: []){
                        while rs.next() {
                            DataRestaurantReservation["StayInfoID"] = String(describing: rs.string(forColumn: "StayInfoID")!)
                            DataRestaurantReservation["UnitCode"] = String(describing: rs.string(forColumn: "UnitCode")!)
                            DataRestaurantReservation["RestaurantName"] = String(describing: rs.string(forColumn: "RestaurantName")!)
                            DataRestaurantReservation["ZoneDescripcion"] = String(describing: rs.string(forColumn: "ZoneDescripcion")!)
                            DataRestaurantReservation["Name"] = String(describing: rs.string(forColumn: "Name")!)
                            DataRestaurantReservation["Adults"] = String(describing: rs.string(forColumn: "Adults")!)
                            DataRestaurantReservation["Childrens"] = String(describing: rs.string(forColumn: "Childrens")!)
                            DataRestaurantReservation["DateReservation"] = String(describing: rs.string(forColumn: "DateReservation")!)
                            DataRestaurantReservation["TimeReservation"] = String(describing: rs.string(forColumn: "TimeReservation")!)
                            DataRestaurantReservation["ConfirmacionNumber"] = String(describing: rs.string(forColumn: "ConfirmacionNumber")!)
                            DataRestaurantReservation["Comments"] = String(describing: rs.string(forColumn: "Comments")!)
                            RestaurantReservationsTemp[Index] = DataRestaurantReservation
                            
                            Index = Index + 1
                        }
                        
                        self.RestaurantReservations = RestaurantReservationsTemp
                        
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                    
                }
            }
            
        }

        self.tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.toolbar.isHidden = true

        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Restaurant Reserv",
            AnalyticsParameterItemName: "Restaurant Reserv",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Restaurant Reserv", screenClass: appDelegate.gstrAppName)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.CountReserv;
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 0.07*height
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var DescReserv: String = ""
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellRestaurantReserv") as! tvcRestaurantReserv
        
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
            
            cell.textLabel?.textColor = colorWithHexString("00467f")
            cell.detailTextLabel?.textColor = colorWithHexString("00467f")
            
        }
        
        DescReserv = NSLocalizedString("lblTableIn",comment:"") + " " + RestaurantReservations[indexPath.row]["ZoneDescripcion"]! + " " + NSLocalizedString("lblZoneFor",comment:"") + " " + RestaurantReservations[indexPath.row]["Adults"]! + " " + NSLocalizedString("lblAdultsAnd",comment:"") + " " + RestaurantReservations[indexPath.row]["Childrens"]! + " " + NSLocalizedString("lblChildrenText",comment:"") + " "
        
        cell.SetValues(String(RestaurantReservations[indexPath.row]["RestaurantName"]!) + " - " + RestaurantReservations[indexPath.row]["DateReservation"]! + " " +  RestaurantReservations[indexPath.row]["TimeReservation"]!, ConfirmacionNumber: String(RestaurantReservations[indexPath.row]["ConfirmacionNumber"]!), DescReserv: DescReserv, width: width, height: height)

        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        lastIndex = IndexPath.init()
        
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
        
        var DescReserv: String = ""
        
        let pre: AnyObject = self.RestaurantReservations[indexPath.row]["TimeReservation"]! as AnyObject
        let len: Int = pre.description.characters.count - 5
        var strHour: String = ""
        
        let strpre: String = pre.debugDescription
        
        let start = strpre.index(strpre.startIndex, offsetBy: 0)
        let end = strpre.index(strpre.endIndex, offsetBy: -len)
        let range = start..<end
        
        let mySubstring = strpre[range]
        
        strHour = String(mySubstring)
        
        DescReserv = NSLocalizedString("lblTableIn",comment:"") + " " + RestaurantReservations[indexPath.row]["ZoneDescripcion"]! + " " + NSLocalizedString("lblZoneFor",comment:"") + " " + RestaurantReservations[indexPath.row]["Adults"]! + " " + NSLocalizedString("lblAdultsAnd",comment:"") + " " + RestaurantReservations[indexPath.row]["Childrens"]! + " " + NSLocalizedString("lblChildrenOn",comment:"") + " " + RestaurantReservations[indexPath.row]["DateReservation"]! + " " + NSLocalizedString("lblAt",comment:"") + " " + strHour
        
        tableView.cellForRow(at: indexPath)?.isUserInteractionEnabled = false
        
        print(RestaurantReservations[indexPath.row]["UnitCode"]!)
        
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcReservRest") as! vcReservRest
        tercerViewController.RestaurantName = RestaurantReservations[indexPath.row]["RestaurantName"]!
        tercerViewController.PeopleName = RestaurantReservations[indexPath.row]["Name"]!
        tercerViewController.Unit = RestaurantReservations[indexPath.row]["UnitCode"]!
        tercerViewController.ReservDesc = DescReserv
        tercerViewController.ynReadOnly = true
        tercerViewController.ConfirmationNumber = RestaurantReservations[indexPath.row]["ConfirmacionNumber"]!
        tercerViewController.Comments = RestaurantReservations[indexPath.row]["Comments"]!
        self.navigationController?.pushViewController(tercerViewController, animated: true)

        tableView.cellForRow(at: indexPath)?.isUserInteractionEnabled = true
        
    }
    
}
