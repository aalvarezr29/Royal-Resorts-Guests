//
//  vcConfNotification.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 23/09/15.
//  Copyright (c) 2015 Marco Cocom. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

class vcConfNotification: UIViewController, UITableViewDataSource, UITableViewDelegate, SettingCellDelegate{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var settings: [SettingItem]!
    var width: CGFloat!
    var height: CGFloat!
    var btnBack = UIButton()
    //let currentInstallation: PFInstallation = PFInstallation.currentInstallation()
    var Channels: [Dictionary<String, String>]!
    var keys: [String]!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var ViewItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Channels = []
        width = appDelegate.width
        height = appDelegate.height

        //Titulo de la vista
        ViewItem.title = NSLocalizedString("lblNotificationtype",comment:"");
        
        tableView.frame = CGRect(x: 0.05*width, y: 0.08*height, width: 0.9*width, height: 0.9*height)
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        /*var iRes: String = ""
        var sRes: String = ""
        var tableItems = RRDataSet()
        let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
        //tableItems = (service?.wmGetFirebaseThemes())!
        
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
                
                let tblNSDic = (r as AnyObject).getColumnByName("rel").content as! NSDictionary
                let tblDic = tblNSDic["topics"] as! NSDictionary

                keys = tblDic.allKeys as! [String]
                
            }
            
        }*/
        
        setChannel(ifkChannelID: "0", iType: "1")

    }
    
    func setChannel(ifkChannelID: String, iType: String){
        var iRes: String = ""
        var sRes: String = ""
        var ynActive: Int = 0
        let queue = OperationQueue()
        var tableItems = RRDataSet()
        let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        queue.addOperation() {
            
            if Reachability.isConnectedToNetwork(){
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                tableItems = (service?.spGetAppPeopleChannelVw(iType, appCode: self.appDelegate.gstrAppName, peopleID: self.appDelegate.gstrLoginPeopleID, dataBase: "CDRPRD"))!
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
            }
            
            OperationQueue.main.addOperation() {

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
                        
                        var tableChannelPeople = RRDataTable()
                        tableChannelPeople = tableItems.tables.object(at: 1) as! RRDataTable
                        
                        var rChannelPeople = RRDataRow()
                        rChannelPeople = table.rows.object(at: 0) as! RRDataRow
                        
                        /*queueFM?.inTransaction { db, rollback in
                            do {
                                
                                try db.executeUpdate("DELETE FROM tblChannelCfg WHERE AppCode = ?", withArgumentsIn: [self.appDelegate.gstrAppName])
                                
                            } catch {
                                rollback.pointee = true
                            }
                        }*/
                        
                        queueFM?.inTransaction { db, rollback in
                            do {
                                
                                for r in table.rows{

                                        let resultCount = db.intForQuery("SELECT COUNT(*) FROM tblChannelCfg WHERE pkChannelID = " + ((r as AnyObject).getColumnByName("pkChannelID").content as? String)! + " AND AppCode = '" + self.appDelegate.gstrAppName as String + "'","" as AnyObject)
                                        
                                        if (resultCount == 0){
                                            try db.executeUpdate("INSERT INTO tblChannelCfg (pkChannelID, AppCode, ChannelName, ChannelDesc, ynActive) VALUES (?, ?, ?, ?, ?)", withArgumentsIn: [((r as AnyObject).getColumnByName("pkChannelID").content as? String)!, self.appDelegate.gstrAppName, ((r as AnyObject).getColumnByName("ChannelDesc").content as? String)!, ((r as AnyObject).getColumnByName("ChannelDesc").content as? String)!, ((r as AnyObject).getColumnByName("ynChannelSelected").content as? String)!])
                                        }else{
                                            if (String(describing: resultCount) == ""){
                                                try db.executeUpdate("INSERT INTO tblChannelCfg (pkChannelID, AppCode, ChannelName, ChannelDesc, ynActive) VALUES (?, ?, ?, ?, ?)", withArgumentsIn: [((r as AnyObject).getColumnByName("pkChannelID").content as? String)!, self.appDelegate.gstrAppName, ((r as AnyObject).getColumnByName("ChannelDesc").content as? String)!, ((r as AnyObject).getColumnByName("ChannelDesc").content as? String)!, ((r as AnyObject).getColumnByName("ynChannelSelected").content as? String)!])
                                            }
                                            
                                        }

                                }

                            } catch {
                                rollback.pointee = true
                                print(error)
                            }

                        }
                        
                        var ChannelsAux: [Dictionary<String, String>]
                        var index: Int = 0
                        ChannelsAux = []
                        
                        queueFM?.inDatabase() {
                            db in
                            
                            if let rs = db.executeQuery("SELECT pkChannelID, AppCode, ChannelName, ChannelDesc, ynActive FROM tblChannelCfg WHERE AppCode = ?", withArgumentsIn: [self.appDelegate.gstrAppName]){
                                while rs.next() {
                                    ChannelsAux.append([:])
                                    ChannelsAux[index]["pkChannelID"] = rs.string(forColumn: "pkChannelID")!
                                    ChannelsAux[index]["AppCode"] = rs.string(forColumn: "AppCode")!
                                    ChannelsAux[index]["ChannelName"] = rs.string(forColumn: "ChannelName")!
                                    ChannelsAux[index]["ChannelDesc"] = rs.string(forColumn: "ChannelDesc")!
                                    ChannelsAux[index]["ynActive"] = rs.string(forColumn: "ynActive")!
                                    index = index + 1
                                }
                            } else {
                                print("select failure: \(db.lastErrorMessage())")
                            }
                        }
                        
                        self.Channels = ChannelsAux
                        self.tableView.reloadData()
                        
                    }
                    
                }
            }
        }
    }
    
    /*func setChannel(ifkChannelID: String, iType: String){
        var iRes: String = ""
        var sRes: String = ""
        var ynActive: Int = 0
        let queue = OperationQueue()
        var tableItems = RRDataSet()
        let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        queue.addOperation() {

            if Reachability.isConnectedToNetwork(){
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                tableItems = (service?.spGetAppPeopleChannelVw(iType, appCode: self.appDelegate.gstrAppName, peopleID: self.appDelegate.gstrLoginPeopleID, dataBase: "CDRPRD"))!
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
            }
            
            OperationQueue.main.addOperation() {
                
                var ChannelsAux: [String]
                var index: Int = 0
                ChannelsAux = []
                var Channels: [Dictionary<String, String>]
                Channels = []
                
                queueFM?.inDatabase() {
                    db in
                    
                    if let rs = db.executeQuery("SELECT pkChannelID, AppCode, ChannelName, ChannelDesc FROM tblChannelCfg WHERE AppCode = ?", withArgumentsIn: [self.appDelegate.gstrAppName]){
                        while rs.next() {
                            ChannelsAux.append(rs.string(forColumn: "ChannelName")!)
                        }
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                    
                }
                
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
                        
                        var tableChannelPeople = RRDataTable()
                        tableChannelPeople = tableItems.tables.object(at: 2) as! RRDataTable
                        
                        var rChannelPeople = RRDataRow()
                        rChannelPeople = table.rows.object(at: 0) as! RRDataRow
                        
                        queueFM?.inTransaction { db, rollback in
                            do {
                                
                                for r in table.rows{
                                    
                                    let Code = ((r as AnyObject).getColumnByName("ChannelName").content as? String)!
                                    
                                    if !ChannelsAux.contains(Code){
                                        try db.executeUpdate("INSERT INTO tblChannelCfg (pkChannelID, AppCode, ChannelName, ChannelDesc, ynActive) VALUES (?, ?, ?, ?, ?)", withArgumentsIn: [((r as AnyObject).getColumnByName("pkChannelID").content as? String)!, ((r as AnyObject).getColumnByName("AppCode").content as? String)!, ((r as AnyObject).getColumnByName("ChannelName").content as? String)!, ((r as AnyObject).getColumnByName("ChannelDesc").content as? String)!, "0"])
                                    }
                                    
                                    if self.keys.contains(Code){
                                        
                                        Channels.append([:])
                                        Channels[index]["pkChannelID"] = ((r as AnyObject).getColumnByName("pkChannelID").content as? String)!
                                        Channels[index]["AppCode"] = ((r as AnyObject).getColumnByName("AppCode").content as? String)!
                                        Channels[index]["ChannelName"] = ((r as AnyObject).getColumnByName("ChannelName").content as? String)!
                                        Channels[index]["ChannelDesc"] = ((r as AnyObject).getColumnByName("ChannelDesc").content as? String)!
                                        Channels[index]["ynActive"] = "0"
                                        
                                        if tableChannelPeople.getTotalRows() > 0
                                        {
                                            for rChannelPeople in tableChannelPeople.rows{
                                                
                                                if ((rChannelPeople as AnyObject).getColumnByName("ChannelName").content as? String)! == ((r as AnyObject).getColumnByName("ChannelName").content as? String)!
                                                {
                                                    
                                                    Channels[index]["ynActive"] = "1"
                                                    
                                                }
                                                
                                            }
                                        }

                                        index = index + 1
                                        
                                    }

                                }
                                
                                
                            } catch {
                                rollback.pointee = true
                                print(error)
                            }
                            
                            self.Channels = Channels
                            
                            self.tableView.reloadData()
                            
                        }

                    }
                    
                }
                
                /*var ChannelsAux: [Dictionary<String, String>]
                var index: Int = 0
                ChannelsAux = []
                
                queueFM?.inDatabase() {
                    db in
                    
                    if let rs = db.executeQuery("SELECT pkChannelID, AppCode, ChannelName, ChannelDesc, ynActive FROM tblChannelCfg WHERE AppCode = ?", withArgumentsIn: [self.appDelegate.gstrAppName]){
                        while rs.next() {
                            ChannelsAux.append([:])
                            ChannelsAux[index]["pkChannelID"] = rs.string(forColumn: "pkChannelID")!
                            ChannelsAux[index]["AppCode"] = rs.string(forColumn: "AppCode")!
                            ChannelsAux[index]["ChannelName"] = rs.string(forColumn: "ChannelName")!
                            ChannelsAux[index]["ChannelDesc"] = rs.string(forColumn: "ChannelDesc")!
                            
                            index = index + 1
                        }
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                    
                    self.Channels = ChannelsAux
                    
                    self.tableView.reloadData()

                }*/
            }
        }
    }*/
    
    class SettingItem: NSObject {
        
        var settingName : String?
        var settingCode : String?
        var switchState : Bool?
        
        init (settingName: String?, settingCode: String?, switchState : Bool?) {
            super.init()
            self.settingName = settingName
            self.settingCode = settingCode
            self.switchState = switchState
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
    
    @IBAction func clickAccount(sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Channels.count
        //        return self.items.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0.08*height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
     let cell = tableView.dequeueReusableCell(withIdentifier: "CellNotificationType") as! SettingCell
     //let cell = tableView.dequeueReusableCell(withIdentifier: "CellNotificationType", for:indexPath)
        
     //let settingItem = settings[indexPath.row]
     
     /*cell.settingsLabel.text = settingItem.settingName
     cell.settingsSwitch.enabled = settingItem.switchState!*/
     
     tableView.rowHeight = 0.04*height
     tableView.sectionHeaderHeight = 0.04*height
     tableView.sectionFooterHeight = 0.04*height
     
     cell.frame = CGRect(x: 0.0, y: 0.0, width: 0.9*width, height: 0.05*height)
     var val: String = ""
        
     if String(Channels[indexPath.row]["ynActive"]!) == "1"
     {
        val = "true"
     }else{
        val = "false"
        }

        cell.SetValues(Channel: String(Channels[indexPath.row]["ChannelName"]!), ChannelCode: String(Channels[indexPath.row]["ChannelDesc"]!), Value: val, ID: Int(Channels[indexPath.row]["pkChannelID"]!)!, width: width, height: height)
     
     cell.cellDelegate = self
     
     return cell
     }
    
    func didChangeSwitchState(sender: SettingCell, isOn: Bool) {
        
        var ynEnabled: String = ""
        var iType: String = ""
        /*var ChannelCode: String = ""
        var xIndex: Int = 0
        
        for xIndex in 0...Channels.count-1 {

            if String(sender.settingsSwitch.tag) == String(Channels[xIndex]["pkChannelID"]!)! {
                
                ChannelCode = String(Channels[xIndex]["pkChannelID"]!)!
                
            }
            
        }*/
        
        if isOn == false{
            ynEnabled = "0"
            iType = "0"
            //Messaging.messaging().unsubscribe(fromTopic: ChannelCode)
        }else{
            ynEnabled = "1"
            iType = "1"
            //Messaging.messaging().subscribe(toTopic: ChannelCode)
        }

        //setChannel(ifkChannelID: String(sender.settingsSwitch.tag), iType: iType)
        
        var iRes: String = ""
        var sRes: String = ""
        var ynActive: Int = 0
        let queue = OperationQueue()
        var tableItems = RRDataSet()
        let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        queue.addOperation() {
            
            if Reachability.isConnectedToNetwork(){
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                tableItems = (service?.spSetAppPeopleChannel(iType, appCode: self.appDelegate.gstrAppName, peopleID: self.appDelegate.gstrLoginPeopleID, pkChannelID: String(sender.settingsSwitch.tag), dataBase: "CDRPRD"))!
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
            }
            
            OperationQueue.main.addOperation() {
                
                self.setChannel(ifkChannelID: "0", iType: "1")
                
            }
            
        }
        
        queueFM?.inTransaction { db, rollback in
            do {
                
                try db.executeUpdate("UPDATE tblChannelCfg SET ynActive = ? WHERE AppCode=? AND pkChannelID = ?", withArgumentsIn: [ynEnabled, self.appDelegate.gstrAppName, String(sender.settingsSwitch.tag)])
                
            } catch {
                rollback.pointee = true
                return
                    print(error)
            }
        }
        
    }
    
}
 protocol SettingCellDelegate : class {
    
 func didChangeSwitchState(sender: SettingCell, isOn: Bool)
    
 }
