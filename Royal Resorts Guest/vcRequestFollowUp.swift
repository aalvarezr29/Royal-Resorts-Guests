//
//  vcPreAuth.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 19/11/15.
//  Copyright © 2015 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging
import DGRunkeeperSwitch

class vcRequestFollowUp: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var width: CGFloat!
    var height: CGFloat!
    var btnBack = UIButton()
    var btnNext = UIButton()
    var tblFollowUp: [Dictionary<String, String>]!
    var tblFollowUpType: [Dictionary<String, String>]!
    var tblTransfer: [Dictionary<String, String>]!
    var tblTransHourConf: [Dictionary<String, String>]!
    var tblFollowUpTypeE: [Dictionary<String, String>]!
    
    var StayInfoID: String = ""
    var PeopleID: String = ""
    var PeopleFDeskID: String = ""
    var formatter = NumberFormatter()
    var btnAddRequest = UIButton()
    var tblLogin: Dictionary<String, String>!
    var LastName: String = ""
    var ynShowHistory: Bool = false
    var swTypePay = UISwitch()
    var tableViewContentOffset = CGPoint()
    
    var Voucher: String!
    var fSizeFont: CGFloat = 0
    var ynConn:Bool=false
    var lastIndex = IndexPath()
    var ynActualiza: Bool = false
    var refreshControl: UIRefreshControl!
    var refreshControlTransfer: UIRefreshControl!
    var runkeeperSwitch: DGRunkeeperSwitch!
    var imgBack = UIImage()
    var imgvwBack = UIImageView()
    var strFont: String = ""
    var imgCell = UIImage()
    var imgvwCell = UIImageView()
    var tableRequest = UITableView()
    var tableTransfer = UITableView()

    @IBOutlet var ViewItem: UINavigationItem!
    @IBOutlet weak var BodyView: UIView!
    @IBOutlet weak var AccView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        self.tabBarController?.navigationController?.navigationBar.isHidden = true;
        self.navigationController?.navigationBar.isHidden = false;
        self.navigationController?.isToolbarHidden = false;
        
        BodyView.frame = CGRect(x: 0.0, y: 0.05*height, width: width, height: height);
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString("lblRequestFollowUp",comment:"");
        
        LastName = appDelegate.gtblLogin["LastName"]!
        
        self.ynActualiza = true

        runkeeperSwitch = DGRunkeeperSwitch(titles: [NSLocalizedString("lblRecent",comment:""),NSLocalizedString("lblHistory",comment:"")])
        runkeeperSwitch.backgroundColor = colorWithHexString ("5C9FCC")
        runkeeperSwitch.selectedBackgroundColor = .white
        runkeeperSwitch.titleColor = .white
        runkeeperSwitch.selectedTitleColor = colorWithHexString ("5C9FCC")
        runkeeperSwitch.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
        runkeeperSwitch.frame = CGRect(x: 0.05*width, y: 0.01*height, width: 0.8*width, height: 0.05*height)
        runkeeperSwitch.addTarget(self, action: #selector(vcRequestFollowUp.switchValueDidChange(_:)), for: .valueChanged)
        AccView.addSubview(runkeeperSwitch)
        
        tableRequest.tag = 1
        tableTransfer.tag = 2
        
        tableTransfer.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.38*height);

        if appDelegate.ynIPad {
            switch appDelegate.Model {
            case "iPad 2":
                //tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.75*height);
                tableRequest.frame = CGRect(x: 0.05*width, y: 0.6*height, width: 0.9*width, height: 0.35*height);
            case "iPad Air":
                //tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.75*height);
                tableRequest.frame = CGRect(x: 0.05*width, y: 0.6*height, width: 0.9*width, height: 0.35*height);
            case "iPad Air 2":
                //tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.75*height);
                tableRequest.frame = CGRect(x: 0.05*width, y: 0.6*height, width: 0.9*width, height: 0.35*height);
            case "iPad Pro":
                //tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.75*height);
                tableRequest.frame = CGRect(x: 0.05*width, y: 0.6*height, width: 0.9*width, height: 0.35*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            case "iPad Retina":
                //tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.75*height);
                tableRequest.frame = CGRect(x: 0.05*width, y: 0.6*height, width: 0.9*width, height: 0.35*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            default:
                //tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.75*height);
                tableRequest.frame = CGRect(x: 0.05*width, y: 0.6*height, width: 0.9*width, height: 0.35*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            }
        }else{
            switch appDelegate.Model {
            case "iPhone":
                //tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.68*height);
                tableRequest.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 4":
                //tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.68*height);
                tableRequest.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 4s":
                //tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.68*height);
                tableRequest.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 5":
                //tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.68*height);
                tableRequest.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 5c":
                //tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.68*height);
                tableRequest.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 5s":
                //tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.68*height);
                tableRequest.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 6":
                //tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.68*height);
                tableRequest.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 6 Plus":
                //tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.68*height);
                tableRequest.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 6s":
                //tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.68*height);
                tableRequest.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.4*height);
            case "iPhone 6s Plus":
                //tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.68*height);
                tableRequest.frame = CGRect(x: 0.05*width, y: 0.45*height, width: 0.9*width, height: 0.4*height);
            default:
                //tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.68*height);
                tableRequest.frame = CGRect(x: 0.05*width, y: 0.55*height, width: 0.9*width, height: 0.35*height);
                AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.07*height);
            }
        }
        
        //Boton Add
        ViewItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(vcRequestFollowUp.clickAdd(_:)))
        
        //Boton Home
        ViewItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("btnHome",comment:""), style: .plain, target: self, action: #selector(vcRequestFollowUp.clickHome(_:)))
        
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
            let img = UIImage(named:appDelegate.gstrNavImg)
            let resizable = img!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
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
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            AccView.backgroundColor = UIColor.clear
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            //tableRequest.backgroundColor = colorWithHexString ("DDF4FF")
            
            tableRequest.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"bg.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: -0.05*height, width: width, height: height+(0.05*height));
            imgvwBack.alpha = 0.3
            imgvwBack.contentMode = UIView.ContentMode.scaleAspectFill
            //self.view.addSubview(imgvwBack)
            
            runkeeperSwitch.backgroundColor = self.colorWithHexString ("ba8748")
            runkeeperSwitch.selectedTitleColor = self.colorWithHexString ("ba8748")
            
            ViewItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State())
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
            strFont = "HelveticaNeue"
            let img = UIImage(named:appDelegate.gstrNavImg)
            let resizable = img!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
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
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            AccView.backgroundColor = UIColor.clear
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            //tableRequest.backgroundColor = colorWithHexString ("DDF4FF")
            
            tableRequest.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"bg.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: -0.05*height, width: width, height: height+(0.05*height));
            imgvwBack.alpha = 0.3
            imgvwBack.contentMode = UIView.ContentMode.scaleAspectFill
            //self.view.addSubview(imgvwBack)
            
            runkeeperSwitch.backgroundColor = self.colorWithHexString ("a18015")
            runkeeperSwitch.selectedTitleColor = self.colorWithHexString ("a18015")
            
            ViewItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State())
            
            //if self.appDelegate.gstrArrivalTransfer == ""{
                //ViewItem.leftBarButtonItem?.isEnabled = false
            //}
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
            
            tableRequest.frame = CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.68*height);
            tableTransfer.isHidden = true
            
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
            strFont = "HelveticaNeue"
            let img = UIImage(named:appDelegate.gstrNavImg)
            let resizable = img!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
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
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            AccView.backgroundColor = UIColor.clear
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            //tableRequest.backgroundColor = colorWithHexString ("DDF4FF")
            
            tableRequest.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"bg.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: -0.05*height, width: width, height: height+(0.05*height));
            imgvwBack.alpha = 0.3
            imgvwBack.contentMode = UIView.ContentMode.scaleAspectFill
            //self.view.addSubview(imgvwBack)
            
            runkeeperSwitch.backgroundColor = self.colorWithHexString ("004c50")
            runkeeperSwitch.selectedTitleColor = self.colorWithHexString ("004c50")
            
            ViewItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State())
            
            strFont = "Helvetica"
            self.navigationController?.navigationBar.tintColor = colorWithHexString("ffffff")
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
        }

        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableRequest.tableFooterView = UIView()
        
        tableRequest.delegate = self
        tableRequest.dataSource = self
        
        tableTransfer.delegate = self
        tableTransfer.dataSource = self
        
        tableRequest.separatorStyle = .none
        tableRequest.backgroundColor = UIColor.clear
        
        tableTransfer.separatorStyle = .none
        tableTransfer.backgroundColor = UIColor.clear
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(vcRequestFollowUp.refresh(_:)), for: UIControl.Event.valueChanged)
        tableRequest.addSubview(refreshControl) // not
        
        refreshControlTransfer = UIRefreshControl()
        refreshControlTransfer.attributedTitle = NSAttributedString(string: "")
        refreshControlTransfer.addTarget(self, action: #selector(vcRequestFollowUp.refreshTransfer(_:)), for: UIControl.Event.valueChanged)
        tableTransfer.addSubview(refreshControlTransfer) // not
        
        self.tableRequest.register(tvcFollowUp.self, forCellReuseIdentifier: "tvcFollowUp")
        self.tableTransfer.register(tvcTransfer.self, forCellReuseIdentifier: "tvcTransfer")
        
        self.view.addSubview(tableRequest)
        self.view.addSubview(tableTransfer)
        
        if self.appDelegate.gtblStay != nil{
            if self.appDelegate.gtblStay.count > 0{
                recargarTablas()
            }
        }

    }
    
    @objc func clickHome(_ sender: AnyObject) {
        
        self.tabBarController?.navigationController?.navigationBar.isHidden = false;
        appDelegate.gblGoHome = true
        appDelegate.gblGoOut = false
        self.tabBarController?.navigationController?.popViewController(animated: false)
        
    }
    
    @objc func refresh(_ sender:AnyObject) {
        // Code to refresh table view
        
        if runkeeperSwitch.selectedIndex == 1 {
            ynShowHistory = true
        } else {
            ynShowHistory = false
        }
        
        self.ynActualiza = true
        
        recargarTablas()
        
        self.tableRequest.reloadData()
        
        refreshControl.endRefreshing()
    }
    
    @objc func refreshTransfer(_ sender:AnyObject) {
        // Code to refresh table view
        
        if runkeeperSwitch.selectedIndex == 1 {
            ynShowHistory = true
        } else {
            ynShowHistory = false
        }
        
        self.ynActualiza = true
        
        recargarTablas()
        
        if self.appDelegate.gstrAppName == "APPSTAY" || self.appDelegate.gstrAppName == "APPSTAYGRM" {
            self.tableTransfer.reloadData()
            
        }
        
        refreshControlTransfer.endRefreshing()
    }
    
    @objc func switchValueDidChange(_ sender: DGRunkeeperSwitch!) {
        
        if sender.selectedIndex == 1 {
            ynShowHistory = true
        } else {
            ynShowHistory = false
        }
        
        self.ynActualiza = true
        
        recargarTablas()
        
    }
    
    func recargarTablas(){
        
        var tableItems = RRDataSet()
        var val: String = "0"
        var iRes: String = ""
        var tblFollow: Dictionary<String, String>!
        var tblFollowType: Dictionary<String, String>!
        var tblTrans: Dictionary<String, String>!
        var tblTransHour: Dictionary<String, String>!
        var tblFollowTypeE1: Dictionary<String, String>!
        
        if ynShowHistory {
            val = "1"
        }else{
            val = "0"
        }
        
        tblFollowUp = []
        tblFollowUpType = []
        tblTransfer = []
        tblTransHourConf = []
        tblFollowUpTypeE = []
        
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
                    tableItems = (service?.spGetMobileFollowUpVw(val, appCode: self.appDelegate.gstrAppName, peopleID: self.appDelegate.gstrLoginPeopleID, followUpId: "0", dataBase: self.appDelegate.strDataBaseByStay, sLanguage: ""))!
                    
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
                                    tblFollowType["emailList"] = (rType as AnyObject).getColumnByName("emailList").content as? String
                                    self.tblFollowUpType.append(tblFollowType)
                                }
                                
                                self.appDelegate.gtblFollowUpType = self.tblFollowUpType
                                
                                var table = RRDataTable()
                                table = tableItems.tables.object(at: 2) as! RRDataTable
                                
                                if table.rows != nil && table.getTotalRows() > 0 {
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
                                
                                if (tableItems.getTotalTables() > 4 ){
                                    var tableTransfer = RRDataTable()
                                    tableTransfer = tableItems.tables.object(at: 4) as! RRDataTable
                                    
                                    if tableTransfer.rows != nil{
                                        var r = RRDataRow()
                                        r = tableTransfer.rows.object(at: 0) as! RRDataRow
                                        
                                        
                                        for r in tableTransfer.rows{
                                            tblTrans = [:]
                                            tblTrans["Arrivaldate"] = (r as AnyObject).getColumnByName("Arrivaldate").content as? String
                                            tblTrans["resConfCode"] = (r as AnyObject).getColumnByName("resConfCode").content as? String
                                            tblTrans["ConfirmationNo"] = (r as AnyObject).getColumnByName("ConfirmationNo").content as? String
                                            tblTrans["DeparturePax"] = (r as AnyObject).getColumnByName("DeparturePax").content as? String
                                            tblTrans["DepartureDate"] = (r as AnyObject).getColumnByName("DepartureDate").content as? String
                                            tblTrans["ItemDesc"] = (r as AnyObject).getColumnByName("ItemDesc").content as? String
                                            tblTrans["HotelName"] = (r as AnyObject).getColumnByName("HotelName").content as? String
                                            tblTrans["Name"] = (r as AnyObject).getColumnByName("Name").content as? String
                                            self.tblTransfer.append(tblTrans)
                                        }
                                        
                                    }

                                }
                                
                                if (tableItems.getTotalTables() > 5 ){

                                    var tableTransferHour = RRDataTable()
                                    tableTransferHour = tableItems.tables.object(at: 5) as! RRDataTable
                                    
                                    if tableTransferHour.rows != nil{
                                        var r = RRDataRow()
                                        r = tableTransferHour.rows.object(at: 0) as! RRDataRow
                                        
                                        for r in tableTransferHour.rows{
                                            tblTransHour = [:]
                                            tblTransHour["fkPropertyID"] = (r as AnyObject).getColumnByName("fkPropertyID").content as? String
                                            tblTransHour["Concept"] = (r as AnyObject).getColumnByName("Concept").content as? String
                                            tblTransHour["ValDate"] = (r as AnyObject).getColumnByName("ValDate").content as? String
                                            self.tblTransHourConf.append(tblTransHour)
                                            
                                            if (((r as AnyObject).getColumnByName("fkPropertyID").content as? String)! == self.appDelegate.gifkPropertyID.description){

                                                if (((r as AnyObject).getColumnByName("Concept").content as? String)! == "MOBAPP_TRAFROM"){
                                                    self.appDelegate.gMOBAPP_TRAFROM = ((r as AnyObject).getColumnByName("ValDate").content as? String)!
                                                }
                                                if (((r as AnyObject).getColumnByName("Concept").content as? String)! == "MOBAPP_TRATO"){
                                                    self.appDelegate.gMOBAPP_TRATO = ((r as AnyObject).getColumnByName("ValDate").content as? String)!
                                                }
                                                if (((r as AnyObject).getColumnByName("Concept").content as? String)! == "MOBAPP_TRDFROM"){
                                                    self.appDelegate.gMOBAPP_TRDFROM = ((r as AnyObject).getColumnByName("ValDate").content as? String)!
                                                }
                                                if (((r as AnyObject).getColumnByName("Concept").content as? String)! == "MOBAPP_TRDTO"){
                                                    self.appDelegate.gMOBAPP_TRDTO = ((r as AnyObject).getColumnByName("ValDate").content as? String)!
                                                }

                                                
                                            }

                                        }
                                        
                                        if !(self.appDelegate.gMOBAPP_TRAFROM != "" && self.appDelegate.gMOBAPP_TRATO != "" && self.appDelegate.gMOBAPP_TRDFROM != "" && self.appDelegate.gMOBAPP_TRDTO != ""){
                                            self.appDelegate.gMOBAPP_TRAFROM = "5:00:00"
                                            self.appDelegate.gMOBAPP_TRATO = "23:30:00"
                                            self.appDelegate.gMOBAPP_TRDFROM = "5:00:00"
                                            self.appDelegate.gMOBAPP_TRDTO = "23:30:00"
                                        }
                                        
                                        if self.tblTransHourConf.count > 0 && self.appDelegate.gifkPropertyID > 0{
                                            self.appDelegate.gtblTransferHourConf = self.tblTransHourConf
                                            
                                            let todaysDate:Date = Date()
                                            let dateFormatter:DateFormatter = DateFormatter()
                                            dateFormatter.dateFormat = "yyyy-MM-dd"
                                            let DateInFormat:String = dateFormatter.string(from: todaysDate)
                                            
                                            let dateFormatterMOBAPP_TRAFROM:DateFormatter = DateFormatter()
                                            dateFormatterMOBAPP_TRAFROM.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                            dateFormatterMOBAPP_TRAFROM.timeZone = TimeZone(identifier: "UTC")
                                            dateFormatterMOBAPP_TRAFROM.locale = Locale(identifier: "en_US")
                                            dateFormatterMOBAPP_TRAFROM.timeZone = TimeZone(secondsFromGMT: 0)
                                            let DateInFormatMOBAPP_TRAFROM:Date = dateFormatterMOBAPP_TRAFROM.date(from: (DateInFormat + " " + self.appDelegate.gMOBAPP_TRAFROM))!
                                            
                                            self.appDelegate.gdtMOBAPP_TRAFROM = DateInFormatMOBAPP_TRAFROM
                                            
                                            let dateFormatterMOBAPP_TRATO:DateFormatter = DateFormatter()
                                            dateFormatterMOBAPP_TRATO.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                            dateFormatterMOBAPP_TRATO.timeZone = TimeZone(identifier: "UTC")
                                            dateFormatterMOBAPP_TRATO.locale = Locale(identifier: "en_US")
                                            dateFormatterMOBAPP_TRATO.timeZone = TimeZone(secondsFromGMT: 0)
                                            let DateInFormatMOBAPP_TRATO:Date = dateFormatterMOBAPP_TRATO.date(from: (DateInFormat + " " + self.appDelegate.gMOBAPP_TRATO))!
                                            
                                            self.appDelegate.gdtMOBAPP_TRATO = DateInFormatMOBAPP_TRATO
                                             
                                            let dateFormatterMOBAPP_TRDFROM:DateFormatter = DateFormatter()
                                            dateFormatterMOBAPP_TRDFROM.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                            dateFormatterMOBAPP_TRDFROM.timeZone = TimeZone(identifier: "UTC")
                                            dateFormatterMOBAPP_TRDFROM.locale = Locale(identifier: "en_US")
                                            dateFormatterMOBAPP_TRDFROM.timeZone = TimeZone(secondsFromGMT: 0)
                                            let DateInFormatMOBAPP_TRDFROM:Date = dateFormatterMOBAPP_TRDFROM.date(from: (DateInFormat + " " + self.appDelegate.gMOBAPP_TRDFROM))!
                                            
                                            self.appDelegate.gdtMOBAPP_TRDFROM = DateInFormatMOBAPP_TRDFROM
                                            
                                            let dateFormatterMOBAPP_TRDTO:DateFormatter = DateFormatter()
                                            dateFormatterMOBAPP_TRDTO.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                            dateFormatterMOBAPP_TRDTO.timeZone = TimeZone(identifier: "UTC")
                                            dateFormatterMOBAPP_TRDTO.locale = Locale(identifier: "en_US")
                                            dateFormatterMOBAPP_TRDTO.timeZone = TimeZone(secondsFromGMT: 0)
                                            let DateInFormatMOBAPP_TRDTO:Date = dateFormatterMOBAPP_TRDTO.date(from: (DateInFormat + " " + self.appDelegate.gMOBAPP_TRDTO))!
                                            
                                            self.appDelegate.gdtMOBAPP_TRDTO = DateInFormatMOBAPP_TRDTO
                                            
                                        }
                                        
                                    }
                                    
                                    
                                }
                                
                                if (tableItems.getTotalTables() > 6 ){

                                    var tblFollowUpTypeEmail = RRDataTable()
                                    tblFollowUpTypeEmail = tableItems.tables.object(at: 6) as! RRDataTable
                                    
                                    for rType in tblFollowUpTypeEmail.rows{
                                        tblFollowTypeE1 = [:]
                                        tblFollowTypeE1["pkFollowUpTypeID"] = (rType as AnyObject).getColumnByName("pkFollowUpTypeID").content as? String
                                        tblFollowTypeE1["DescriptionForExternal"] = (rType as AnyObject).getColumnByName("DescriptionForExternal").content as? String
                                        tblFollowTypeE1["emailList"] = (rType as AnyObject).getColumnByName("emailList").content as? String
                                        tblFollowTypeE1["fkPropertyID"] = (rType as AnyObject).getColumnByName("fkPropertyID").content as? String
                                        self.tblFollowUpTypeE.append(tblFollowTypeE1)
                                    }
                                    
                                    self.appDelegate.gtblFollowUpTypeEmail = self.tblFollowUpTypeE
                                    
                                }
                                
                                

                            }
                            
                        }
                        
                        OperationQueue.main.addOperation() {
                            //accion
                            if !Reachability.isConnectedToNetwork(){
                                RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                            }
                            
                            self.tableRequest.reloadData()
                            if self.appDelegate.gstrAppName == "APPSTAY" || self.appDelegate.gstrAppName == "APPSTAYGRM" {
                                self.tableTransfer.reloadData()
                            }
                            
                            
                            SwiftLoader.hide()
                        }
                    }//2
                }
            }//1
        }
    }
    
    func CargaFollowUp(){
        var val: String = "0"
        var iRes: String = ""
        var tblFollow: Dictionary<String, String>!
        var tblFollowType: Dictionary<String, String>!
        var tblFollowTypeE1: Dictionary<String, String>!
        
        if ynShowHistory {
            val = "1"
        }else{
            val = "0"
        }
        
        tblFollowUp = []
        tblFollowUpType = []
        tblFollowUpTypeE = []
        
        var tableItems = RRDataSet()
        let service=RRRestaurantService(url: appDelegate.URLService as String, host: appDelegate.Host as String, userNameMobile : appDelegate.UserName, passwordMobile: appDelegate.Password);
        tableItems = (service?.spGetMobileFollowUpVw(val, appCode: self.appDelegate.gstrAppName, peopleID: appDelegate.gstrLoginPeopleID, followUpId: "0", dataBase: self.appDelegate.strDataBaseByStay, sLanguage: appDelegate.strLenguaje))!
        
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
                    tblFollowType["emailList"] = (rType as AnyObject).getColumnByName("emailList").content as? String
                    tblFollowUpType.append(tblFollowType)
                }
                
                appDelegate.gtblFollowUpType = tblFollowUpType
                
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
                        tblFollowUp.append(tblFollow)
                    }
                    
                    appDelegate.gtblFollowUp = tblFollowUp
                }
                
                print(tableItems.getTotalTables())
                
                if (tableItems.getTotalTables() > 6 ){

                    var tblFollowUpTypeEmail = RRDataTable()
                    tblFollowUpTypeEmail = tableItems.tables.object(at: 6) as! RRDataTable
                    
                    for rType in tblFollowUpTypeEmail.rows{
                        tblFollowTypeE1 = [:]
                        tblFollowTypeE1["pkFollowUpTypeID"] = (rType as AnyObject).getColumnByName("pkFollowUpTypeID").content as? String
                        tblFollowTypeE1["DescriptionForExternal"] = (rType as AnyObject).getColumnByName("DescriptionForExternal").content as? String
                        tblFollowTypeE1["emailList"] = (rType as AnyObject).getColumnByName("emailList").content as? String
                        tblFollowUpTypeE.append(tblFollowTypeE1)
                    }
                    
                    appDelegate.gtblFollowUpTypeEmail = tblFollowUpTypeE
                    
                }
                
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let title: UILabel = UILabel()
        title.backgroundColor = UIColor.clear;
        title.textAlignment = NSTextAlignment.left;
        title.font = UIFont(name:"HelveticaNeue-Light", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont4)
        title.numberOfLines = 0;
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            title.textColor = UIColor.gray;
        }
        else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            title.textColor = colorWithHexString("ba8748")
        }
        else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
            title.textColor = colorWithHexString("2e3634")
        }
        
        if tableView.tag == 1{
                title.text = NSLocalizedString("lbltblRequest",comment:"");
            }else{
                title.text = NSLocalizedString("lbltblTransfer",comment:"");
        }

        return title
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 1{
        if tblFollowUp != nil{
            return tblFollowUp.count;
        }else{
            return 0;
        }

        }else{
            if tblTransfer != nil{
                return tblTransfer.count;
            }else{
                return 0;
            }
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        

      return 0.07*height

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView.tag == 1{
            let cell = tableRequest.dequeueReusableCell(withIdentifier: "tvcFollowUp", for: indexPath) as! tvcFollowUp
            
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
                
                if indexPath.row == 0{
                    imgCell = UIImage(named:"tblacchdr.png")!
                    imgvwCell = UIImageView(image: imgCell)
                    cell.backgroundView = imgvwCell
                    
                    imgCell = UIImage(named:"tblacchdrSel.png")!
                    imgvwCell = UIImageView(image: imgCell)
                    cell.selectedBackgroundView = imgvwCell
                }else if (tblFollowUp.count-1) == indexPath.row{
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
                
                if (tblFollowUp.count) == 1
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
                cell.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("94cce5"))
                
                if indexPath.row == 0{
                    imgCell = UIImage(named:"tblacchdr.png")!
                    imgvwCell = UIImageView(image: imgCell)
                    cell.backgroundView = imgvwCell
                    
                    imgCell = UIImage(named:"tblacchdrSel.png")!
                    imgvwCell = UIImageView(image: imgCell)
                    cell.selectedBackgroundView = imgvwCell
                }else if (tblFollowUp.count-1) == indexPath.row{
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
                
                if (tblFollowUp.count) == 1
                {
                    imgCell = UIImage(named:"tblaccrowsingle.png")!
                    imgvwCell = UIImageView(image: imgCell)
                    cell.backgroundView = imgvwCell
                    
                    imgCell = UIImage(named:"tblaccrowsingleSel.png")!
                    imgvwCell = UIImageView(image: imgCell)
                    cell.selectedBackgroundView = imgvwCell
                    
                }
            }
            
            cell.SetValues(String(tblFollowUp[indexPath.row]["Reqshort"]!), Status: String(tblFollowUp[indexPath.row]["Status"]!), AccCode: String(tblFollowUp[indexPath.row]["AccCode"]!), Date: String(tblFollowUp[indexPath.row]["CrDt"]!), width: width, height: height)
            
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            
            lastIndex = IndexPath.init()
            
            return cell
            
        }else{
            
            let cell = tableTransfer.dequeueReusableCell(withIdentifier: "tvcTransfer", for: indexPath) as! tvcTransfer
            
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
                
                if indexPath.row == 0{
                    imgCell = UIImage(named:"tblacchdr.png")!
                    imgvwCell = UIImageView(image: imgCell)
                    cell.backgroundView = imgvwCell
                    
                    imgCell = UIImage(named:"tblacchdrSel.png")!
                    imgvwCell = UIImageView(image: imgCell)
                    cell.selectedBackgroundView = imgvwCell
                }else if (tblTransfer.count-1) == indexPath.row{
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
                
                if (tblTransfer.count) == 1
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
                cell.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("94cce5"))
                
                if indexPath.row == 0{
                    imgCell = UIImage(named:"tblacchdr.png")!
                    imgvwCell = UIImageView(image: imgCell)
                    cell.backgroundView = imgvwCell
                    
                    imgCell = UIImage(named:"tblacchdrSel.png")!
                    imgvwCell = UIImageView(image: imgCell)
                    cell.selectedBackgroundView = imgvwCell
                }else if (tblTransfer.count-1) == indexPath.row{
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
                
                if (tblTransfer.count) == 1
                {
                    imgCell = UIImage(named:"tblaccrowsingle.png")!
                    imgvwCell = UIImageView(image: imgCell)
                    cell.backgroundView = imgvwCell
                    
                    imgCell = UIImage(named:"tblaccrowsingleSel.png")!
                    imgvwCell = UIImageView(image: imgCell)
                    cell.selectedBackgroundView = imgvwCell
                    
                }
            }
            
            var strArrivalDate: String = ""
            let strdateFormatter = DateFormatter()
            strdateFormatter.dateFormat = "MM/dd/yyyy";
            let ArrivalDate = moment(String(tblTransfer[indexPath.row]["Arrivaldate"]!))
            strArrivalDate = strdateFormatter.string(from: ArrivalDate!.date)
            
            cell.SetValues(String(tblTransfer[indexPath.row]["ConfirmationNo"]!), ArrivalDate: strArrivalDate, width: width, height: height)
            
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            
            lastIndex = IndexPath.init()
            
            return cell
            
        }


    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            if lastIndex != indexPath && lastIndex.count > 0{
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
                
                tableRequest.cellForRow(at: indexPath)?.backgroundView = gradientView
                
                // Initialize a gradient view
                let gradientView2 = GradientView(frame: CGRect(x: 0, y: 0, width: 0.9*width, height: 0.12*height))
                
                // Set the gradient colors 8DE3F5 5C9F00
                gradientView2.colors = [UIColor.white, colorWithHexString ("F2F2F2")]
                
                // Optionally set some locations
                gradientView2.locations = [0.4, 1.0]
                
                // Optionally change the direction. The default is vertical.
                gradientView2.direction = .vertical
                
                // Add some borders too if you want
                gradientView2.topBorderColor = UIColor.lightGray
                
                gradientView2.bottomBorderColor = colorWithHexString ("C7C7CD")
                
                tableRequest.cellForRow(at: lastIndex)?.backgroundView = gradientView2
                
            }else{
                if lastIndex != indexPath {
                    
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
                    
                    tableRequest.cellForRow(at: indexPath)?.backgroundView = gradientView
                    
                }
                
            }
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            if lastIndex != indexPath && lastIndex.count > 0{
                tableRequest.cellForRow(at: lastIndex)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("e4c29c"))
            }
            
            tableRequest.cellForRow(at: indexPath)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("ba8748"))
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            if lastIndex != indexPath && lastIndex.count > 0{
                tableRequest.cellForRow(at: lastIndex)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("94cce5"))
            }
            
            tableRequest.cellForRow(at: indexPath)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("00467f"))
            
        }
        
        lastIndex = indexPath
        
        appDelegate.gblAddFollow = false
        
        if tableView.tag == 1{
            let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcRequestDetail") as! vcRequestDetail
            tercerViewController.FollowUpId = String(tblFollowUp[indexPath.row]["ID"]!)
            tercerViewController.Reqshort = String(tblFollowUp[indexPath.row]["Reqshort"]!)
            tercerViewController.AccCode = String(tblFollowUp[indexPath.row]["AccCode"]!)
            tercerViewController.FType = String(tblFollowUp[indexPath.row]["FType"]!)
            tercerViewController.Status = String(tblFollowUp[indexPath.row]["Status"]!)
            self.navigationController?.pushViewController(tercerViewController, animated: true)
        }else{
            let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcTransferReserv") as! vcTransferReserv
            tercerViewController.strArrivaldate = String(tblTransfer[indexPath.row]["Arrivaldate"]!)
            tercerViewController.strresConfCode = String(tblTransfer[indexPath.row]["resConfCode"]!)
            tercerViewController.strConfirmationNo = String(tblTransfer[indexPath.row]["ConfirmationNo"]!)
            tercerViewController.strDeparturePax = String(tblTransfer[indexPath.row]["DeparturePax"]!)
            tercerViewController.strDepartureDate = String(tblTransfer[indexPath.row]["DepartureDate"]!)
            tercerViewController.strItemDesc = String(tblTransfer[indexPath.row]["ItemDesc"]!)
            tercerViewController.strHotelName = String(tblTransfer[indexPath.row]["HotelName"]!)
            tercerViewController.strName = String(tblTransfer[indexPath.row]["Name"]!)
            self.navigationController?.pushViewController(tercerViewController, animated: true)
        }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.toolbar.isHidden = true
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Request",
            AnalyticsParameterItemName: "Request",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Request", screenClass: appDelegate.gstrAppName)
        
    }
    
    @objc func clickAdd(_ sender: AnyObject){
        
        //let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcAddFolloUp") as! vcAddFolloUp
        //self.navigationController?.pushViewController(tercerViewController, animated: true)

        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcServices") as! vcServices
        self.navigationController?.pushViewController(tercerViewController, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /*if self.appDelegate.iCountStayF > 1{
            appDelegate.strUnitStay = ""
            appDelegate.strUnitStayInfoID = ""
            appDelegate.strUnitCode = ""
            appDelegate.strFollowUpTypeID = ""
            appDelegate.strDescriptionForExternal = ""
        }*/
        
        if appDelegate.gblAddFollow == true{
            self.ynActualiza = true
            recargarTablas()
            self.tableRequest.reloadData()
            if self.appDelegate.gstrAppName == "APPSTAY" || self.appDelegate.gstrAppName == "APPSTAYGRM" {
            self.tableTransfer.reloadData()
            }
            appDelegate.gblAddFollow = false
        }
        
    }
    
}
