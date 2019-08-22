//
//  vcNotification.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 18/09/15.
//  Copyright (c) 2015 Marco Cocom. All rights reserved.
//

import UIKit

class vcNotification: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var width: CGFloat!
    var height: CGFloat!
    var btnBack = UIButton()
    var PushMessage: [[Dictionary<String, String>]]!
    var PushMessageID: [Dictionary<String, String>]!
    var imgCell = UIImage()
    var imgvwCell = UIImageView()
    var lastIndex = IndexPath()
    
    @IBOutlet var ViewItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        self.tabBarController?.navigationController?.navigationBar.isHidden = true;
        self.navigationController?.navigationBar.isHidden = false;
        self.navigationController?.isToolbarHidden = false;
        
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 44));
        label.backgroundColor = UIColor.clear;
        label.textAlignment = NSTextAlignment.center;
        label.textColor = UIColor.black;
        label.numberOfLines = 1;
        
        //fSizeFont = 15.0 + appDelegate.gblDeviceFont
        
        /*label.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont9 + appDelegate.gblDeviceFont3);
        label.text = NSLocalizedString("lblNotification",comment:"");*/
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString("lblNotification",comment:"");
        
        //Boton Add
        ViewItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.organize, target: self, action: #selector(vcNotification.clickConf))
        
        //Boton Home
        ViewItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("btnHome",comment:""), style: .plain, target: self, action: #selector(vcNotification.clickHome(_:)))
        
        
        let TabTitleFont = UIFont(name: "HelveticaNeue", size: appDelegate.gblFont10 + appDelegate.gblDeviceFont2)!
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            self.navigationController?.navigationBar.tintColor = colorWithHexString("0D94FC")
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            
            ViewItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: colorWithHexString("0D94FC")], for: UIControl.State())
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()

            var img = UIImage(named:appDelegate.gstrNavImg)
            var resizable = img!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
            self.navigationController?.navigationBar.setBackgroundImage(resizable, for: .default)
            let navigationTitleFont = UIFont(name: "HelveticaNeue", size: appDelegate.gblFont10 + appDelegate.gblDeviceFont3)!
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
            

        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()

            var img = UIImage(named:appDelegate.gstrNavImg)
            var resizable = img!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
            self.navigationController?.navigationBar.setBackgroundImage(resizable, for: .default)
            let navigationTitleFont = UIFont(name: "HelveticaNeue", size: appDelegate.gblFont10 + appDelegate.gblDeviceFont3)!
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
        
        tableView.frame = CGRect(x: 0.05*width, y: 0.08*height, width: 0.9*width, height: 0.9*height)
        
        PushMessage = getPushMessage(PeopleFDeskID: appDelegate.gstrLoginPeopleID)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.reloadData()
    }
    
    @objc func clickHome(_ sender: AnyObject) {
        
        self.tabBarController?.navigationController?.navigationBar.isHidden = false;
        appDelegate.gblGoHome = true
        appDelegate.gblGoOut = false
        self.tabBarController?.navigationController?.popViewController(animated: false)
        
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
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func clickConf() {
        
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "vcConfNotification") as! vcConfNotification
        vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(vc, animated: true, completion: nil)*/
        
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcNotificationConf") as! vcConfNotification
        appDelegate.gblNotification = true
        self.navigationController?.pushViewController(tercerViewController, animated: true)
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return PushMessage.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PushMessage[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0.08*height
    }
    
    /*func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return PushMessage[section][0]["Date"]!

    }*/
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let title: UILabel = UILabel()
        title.backgroundColor = UIColor.clear;
        title.textAlignment = NSTextAlignment.left;
        title.textColor = UIColor.gray;
        title.font = UIFont(name:"HelveticaNeue-Light", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont4)
        title.numberOfLines = 0;

        title.text = PushMessage[section][0]["Date"]!

        return title
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.03*height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.03*height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "CellNotification")!
        
        /*cell.textLabel?.text = String(PushMessage[indexPath.section][indexPath.row]["Message"]!)
        
        cell.textLabel?.font = UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont2)
        cell.textLabel?.adjustsFontSizeToFitWidth = true;
        
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        if(String(PushMessage[indexPath.section][indexPath.row]["ynViewed"]!)=="0"){
            cell.detailTextLabel?.text = NSLocalizedString("lblNotificationNew",comment:"");
        }
        else{
            cell.detailTextLabel?.text = ""
        }
        
        cell.detailTextLabel?.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont2)
        cell.detailTextLabel?.textColor = UIColor.green*/
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellNotification") as! tvcNotifications
        
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
            }else if (PushMessage[indexPath.section].count-1) == indexPath.row{
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
            
            if (PushMessage[indexPath.section].count) == 1
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
            }else if (PushMessage[indexPath.section].count-1) == indexPath.row{
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
            
            if (PushMessage[indexPath.section].count) == 1
            {
                imgCell = UIImage(named:"tblaccrowsingle.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblaccrowsingleSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
                
            }
        }
        
        cell.SetValues(String(PushMessage[indexPath.section][indexPath.row]["CategoryDesc"]!), Message: String(PushMessage[indexPath.section][indexPath.row]["Message"]!), Hour: String(PushMessage[indexPath.section][indexPath.row]["Hour"]!), Viewed: String(PushMessage[indexPath.section][indexPath.row]["ynViewed"]!), width: width, height: height)

        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        lastIndex = IndexPath.init()
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcMessage") as! vcMessage
        tercerViewController.strCategoryDesc = String(PushMessage[indexPath.section][indexPath.row]["CategoryDesc"]!)
        tercerViewController.strDate = String(PushMessage[indexPath.section][indexPath.row]["Date"]!)
        tercerViewController.strHour = String(PushMessage[indexPath.section][indexPath.row]["Hour"]!)
        tercerViewController.strMessage = String(PushMessage[indexPath.section][indexPath.row]["Message"]!)
        tercerViewController.strHTMLMessage = String(PushMessage[indexPath.section][indexPath.row]["HTMLMessage"]!)
        tercerViewController.strImageURL = String(PushMessage[indexPath.section][indexPath.row]["ImageURL"]!)
        tercerViewController.strViewed = String(PushMessage[indexPath.section][indexPath.row]["ynViewed"]!)
        tercerViewController.strID = String(PushMessage[indexPath.section][indexPath.row]["id"]!)
        self.navigationController?.pushViewController(tercerViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.toolbar.isHidden = true
        
        PushMessage = getPushMessage(PeopleFDeskID: appDelegate.gstrLoginPeopleID)
        self.tableView.reloadData()
    }
    
    func getPushMessage(PeopleFDeskID: String) -> [[Dictionary<String, String>]] {
        var PushMessage: [[Dictionary<String, String>]]
        var queueFM: FMDatabaseQueue?
        var strDateAux: String = ""
        var GrpIndex: Int = 0
        
        var strCategoryDesc: String = ""
        var strDate: String = ""
        var strHour: String = ""
        var strMessage: String = ""
        var strHTMLMessage: String = ""
        var strImageURL: String = ""
        var strViewed: String = ""
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        var Index: Int = 0

        PushMessage = []
        
        queueFM?.inDatabase() {
            db in
            
            if let rs = db.executeQuery("SELECT * FROM tblPushMessage ORDER BY Date DESC", withArgumentsIn:[]) {
                while rs.next() {
                    
                    if strDateAux == ""
                    {

                        if !(rs.object(forColumnName: "Date") is NSNull) {
                            //Whatever you want to do with myField when not null
                            strDateAux = rs.object(forColumnName: "Date") as! String//rs.string(forColumn: "Date")!
                            PushMessage.append([])
                        } else {
                            //Whatever you want to do when myField is null
                            strDateAux = ""
                        }

                    }else{
                        
                        if strDateAux != rs.string(forColumn: "Date")!
                        {
                            strDateAux = rs.string(forColumn: "Date")!
                            PushMessage.append([])
                            Index = 0
                            GrpIndex = GrpIndex + 1
                        }
                    }
                    
                    if strDateAux != ""{
                    
                        PushMessage[GrpIndex].append([:])
                        
                        if (rs.string(forColumn: "CategoryDesc") == nil) {
                            strCategoryDesc = ""
                        }else{
                            strCategoryDesc = rs.string(forColumn: "CategoryDesc")!
                        }
                        if (rs.string(forColumn: "Date") == nil) {
                            strDate = ""
                        }else{
                            strDate = rs.string(forColumn: "Date")!
                        }
                        if (rs.string(forColumn: "Hour") == nil) {
                            strHour = ""
                        }else{
                            strHour = rs.string(forColumn: "Hour")!
                        }
                        if (rs.string(forColumn: "Message") == nil) {
                            strMessage = ""
                        }else{
                            strMessage = rs.string(forColumn: "Message")!
                        }
                        if (rs.string(forColumn: "HTMLMessage") == nil) {
                            strHTMLMessage = ""
                        }else{
                            strHTMLMessage = rs.string(forColumn: "HTMLMessage")!
                        }
                        if (rs.string(forColumn: "ImageURL") == nil) {
                            strImageURL = ""
                        }else{
                            strImageURL = rs.string(forColumn: "ImageURL")!
                        }
                        if (rs.string(forColumn: "ynViewed") == nil) {
                            strViewed = ""
                        }else{
                            strViewed = rs.string(forColumn: "ynViewed")!
                        }
                        PushMessage[GrpIndex][Index]["id"] = rs.string(forColumn: "_id")
                        PushMessage[GrpIndex][Index]["CategoryDesc"] = strCategoryDesc
                        PushMessage[GrpIndex][Index]["Date"] = strDate
                        PushMessage[GrpIndex][Index]["Hour"] = strHour
                        PushMessage[GrpIndex][Index]["Message"] = strMessage
                        PushMessage[GrpIndex][Index]["HTMLMessage"] = strHTMLMessage
                        PushMessage[GrpIndex][Index]["ImageURL"] = strImageURL
                        PushMessage[GrpIndex][Index]["ynViewed"] = strViewed
                    }
                    
                    Index = Index + 1
                }
            } else {
                print("select failure: \(db.lastErrorMessage())")
            }
        }
        
        return PushMessage
        
    }
    func getPushMessageID(MessageID: String) -> [Dictionary<String, String>] {
        var PushMessage: [Dictionary<String, String>]
        var queueFM: FMDatabaseQueue?
        var strDateAux: String = ""
        var GrpIndex: Int = 0
        
        var strCategoryDesc: String = ""
        var strDate: String = ""
        var strHour: String = ""
        var strMessage: String = ""
        var strHTMLMessage: String = ""
        var strImageURL: String = ""
        var strViewed: String = ""
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        var Index: Int = 0
        
        PushMessage = []
        
        queueFM?.inDatabase() {
            db in
            
            if let rs = db.executeQuery("SELECT * FROM tblPushMessage WHERE MessageID = ? ORDER BY Date DESC", withArgumentsIn:[MessageID]) {
                while rs.next() {
                    
                    PushMessage.append([:])
                    
                    if (rs.string(forColumn: "CategoryDesc") == nil) {
                        strCategoryDesc = ""
                    }else{
                        strCategoryDesc = rs.string(forColumn: "CategoryDesc")!
                    }
                    if (rs.string(forColumn: "Date") == nil) {
                        strDate = ""
                    }else{
                        strDate = rs.string(forColumn: "Date")!
                    }
                    if (rs.string(forColumn: "Hour") == nil) {
                        strHour = ""
                    }else{
                        strHour = rs.string(forColumn: "Hour")!
                    }
                    if (rs.string(forColumn: "Message") == nil) {
                        strMessage = ""
                    }else{
                        strMessage = rs.string(forColumn: "Message")!
                    }
                    if (rs.string(forColumn: "HTMLMessage") == nil) {
                        strHTMLMessage = ""
                    }else{
                        strHTMLMessage = rs.string(forColumn: "HTMLMessage")!
                    }
                    if (rs.string(forColumn: "ImageURL") == nil) {
                        strImageURL = ""
                    }else{
                        strImageURL = rs.string(forColumn: "ImageURL")!
                    }
                    if (rs.string(forColumn: "ynViewed") == nil) {
                        strViewed = ""
                    }else{
                        strViewed = rs.string(forColumn: "ynViewed")!
                    }
                    
                    PushMessage[Index]["id"] = rs.string(forColumn: "_id")
                    PushMessage[Index]["CategoryDesc"] = strCategoryDesc
                    PushMessage[Index]["Date"] = strDate
                    PushMessage[Index]["Hour"] = strHour
                    PushMessage[Index]["Message"] = strMessage
                    PushMessage[Index]["HTMLMessage"] = strHTMLMessage
                    PushMessage[Index]["ImageURL"] = strImageURL
                    PushMessage[Index]["ynViewed"] = strViewed
                    
                    Index = Index + 1
                }
            } else {
                print("select failure: \(db.lastErrorMessage())")
            }
        }
        
        return PushMessage
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.appDelegate.gblGoMessage == true{
            
            self.appDelegate.gblGoMessage = false
            
            PushMessageID = getPushMessageID(MessageID: self.appDelegate.gstrMessageID)
            let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcMessage") as! vcMessage
            tercerViewController.strCategoryDesc = String(PushMessageID[0]["CategoryDesc"]!)
            tercerViewController.strDate = String(PushMessageID[0]["Date"]!)
            tercerViewController.strHour = String(PushMessageID[0]["Hour"]!)
            tercerViewController.strMessage = String(PushMessageID[0]["Message"]!)
            tercerViewController.strHTMLMessage = String(PushMessageID[0]["HTMLMessage"]!)
            tercerViewController.strImageURL = String(PushMessageID[0]["ImageURL"]!)
            tercerViewController.strViewed = String(PushMessageID[0]["ynViewed"]!)
            tercerViewController.strID = String(PushMessageID[0]["id"]!)
            self.navigationController?.pushViewController(tercerViewController, animated: true)
            
        }
        
    }
}

