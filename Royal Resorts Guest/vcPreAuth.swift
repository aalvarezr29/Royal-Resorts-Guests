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

class vcPreAuth: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    var imgCell = UIImage()
    var imgvwCell = UIImageView()
    var lastIndex = IndexPath()
    
    @IBOutlet weak var barNavigate: UINavigationBar!
    @IBOutlet weak var btnStays: UIBarButtonItem!
    @IBOutlet weak var btnCreditCard: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var ViewItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString("lblPreAuthorizations",comment:"")
        
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        self.tabBarController?.navigationController?.navigationBar.isHidden = true;
        self.navigationController?.navigationBar.isHidden = false;
        self.navigationController?.isToolbarHidden = false;
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString("lblPreAuthorizations",comment:"");
        
        //Boton Refresh
        ViewItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("lblCreditCard",comment:""), style: UIBarButtonItem.Style.plain, target: self, action: #selector(vcPreAuth.clickCreditCard(_:)))
        
        tblPreAuth = appDelegate.gtblAccPreAuth
        
        if appDelegate.ynIPad {
            switch appDelegate.Model {
            case "iPad 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.64*height);
            case "iPad Air":
                tableView.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.64*height);
            case "iPad Air 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.64*height);
            case "iPad Pro":
                tableView.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.64*height);
            case "iPad Retina":
                tableView.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.64*height);
            default:
                tableView.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.64*height);
            }
        }else{
            switch appDelegate.Model {
            case "iPhone":
                tableView.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 4":
                tableView.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 4s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 5":
                tableView.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 5c":
                tableView.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 5s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 6":
                tableView.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 6 Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 6s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.64*height);
            case "iPhone 6s Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.64*height);
            default:
                tableView.frame = CGRect(x: 0.05*width, y: 0.12*height, width: 0.9*width, height: 0.64*height);
            }
        }
        
        let lblFooter = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 0.15*height))
        lblFooter.backgroundColor = UIColor.clear;
        lblFooter.textAlignment = NSTextAlignment.left;
        lblFooter.textColor = UIColor.gray;
        lblFooter.font = UIFont(name:"HelveticaNeue-Light", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont4)
        lblFooter.numberOfLines = 0;
        lblFooter.text = NSLocalizedString("msgPreauth",comment:"")
        tableView.tableFooterView = lblFooter
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            tableView.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"bg.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: -0.05*height, width: width, height: height+(0.05*height));
            imgvwBack.alpha = 0.3
            imgvwBack.contentMode = UIView.ContentMode.scaleAspectFill
            //self.view.addSubview(imgvwBack)
            
            lblFooter.textColor = colorWithHexString("ba8748")
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            tableView.separatorColor = UIColor.clear
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{

            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            tableView.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"bg.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: -0.05*height, width: width, height: height+(0.05*height));
            imgvwBack.alpha = 0.3
            imgvwBack.contentMode = UIView.ContentMode.scaleAspectFill
            //self.view.addSubview(imgvwBack)
            
            lblFooter.textColor = colorWithHexString("00467f")
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            tableView.separatorColor = UIColor.clear
            
        }
        
        self.tableView.reloadData()
        
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
        return tblPreAuth.count
        //        return self.items.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0.04*height
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var fAmount: Double = 0
        var str: String = ""
        
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        fAmount = Double(String(format: "%.2f", (tblPreAuth[indexPath.row]["Amount"]! as NSString).floatValue))!
        
        str = fAmount.description

        let cell = tableView.dequeueReusableCell(withIdentifier: "CellPreAuth") as! tvcPreDetail
        
        cell.frame = CGRect(x: 0, y: 0, width: 0.9*width, height: 0.05*height)
        
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
            
            imgCell = UIImage(named:"tblaccrowsingle.png")!
            imgvwCell = UIImageView(image: imgCell)
            cell.backgroundView = imgvwCell
            
            imgCell = UIImage(named:"tblaccrowsingleSel.png")!
            imgvwCell = UIImageView(image: imgCell)
            cell.selectedBackgroundView = imgvwCell
            
            lastIndex = IndexPath.init()
            cell.textLabel?.textColor = colorWithHexString("ba8748")
            cell.detailTextLabel?.textColor = colorWithHexString("ba8748")
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            
            cell.backgroundColor = UIColor.clear
            cell.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("94cce5"))

            imgCell = UIImage(named:"tblaccrowsingle.png")!
            imgvwCell = UIImageView(image: imgCell)
            cell.backgroundView = imgvwCell
                
            imgCell = UIImage(named:"tblaccrowsingleSel.png")!
            imgvwCell = UIImageView(image: imgCell)
            cell.selectedBackgroundView = imgvwCell

            lastIndex = IndexPath.init()
            cell.textLabel?.textColor = colorWithHexString("00467f")
            cell.detailTextLabel?.textColor = colorWithHexString("00467f")
            
        }
        
        let strpre: String = String(tblPreAuth[indexPath.row]["CcNumber"]!)
        
        let start = strpre.index(strpre.startIndex, offsetBy: 12)
        let end = strpre.index(strpre.endIndex, offsetBy: 0)
        let range = start..<end
        
        let mySubstring = String(strpre[range])
        
        cell.SetValues(ccNumber: mySubstring, ccType: String(tblPreAuth[indexPath.row]["CcType"]!), TrxDate: String(tblPreAuth[indexPath.row]["TrxDate"]!), Amount: str, width: width, height: height)
        
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
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
        
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcGuestAccountPayment") as! vcGuestAccountPayment
        tercerViewController.StayInfoID = StayInfoID
        tercerViewController.PeopleID = PeopleID
        tercerViewController.PeopleFDeskID = PeopleFDeskID
        tercerViewController.ynPreAuth = true
        tercerViewController.ynPreAuthCreditCard = false
        tercerViewController.AccTrxID = String(tblPreAuth[indexPath.row]["AccTrxID"]!)
        tercerViewController.CcNumber = String(tblPreAuth[indexPath.row]["CcNumber"]!)
        tercerViewController.ExpDate = String(tblPreAuth[indexPath.row]["ExpDate"]!)
        tercerViewController.PreAmount = String(tblPreAuth[indexPath.row]["Amount"]!)
        self.navigationController?.pushViewController(tercerViewController, animated: true)

    }
    func clickAccount(_ sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @objc func clickCreditCard(_ sender: AnyObject) {
        
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcGuestAccountPayment") as! vcGuestAccountPayment
        tercerViewController.StayInfoID = StayInfoID
        tercerViewController.PeopleID = PeopleID
        tercerViewController.PeopleFDeskID = PeopleFDeskID
        tercerViewController.ynPreAuth = false
        tercerViewController.ynPreAuthCreditCard = true
        tercerViewController.PreAmount = "0"
        self.navigationController?.pushViewController(tercerViewController, animated: true)
        
    }
    
    func CargaPreAuthData(){
        
        var iRes: String = ""
        var tblPre: Dictionary<String, String>!
        
        tblPreAuth = []
        
        var tableItems = RRDataSet()
        let service=RRRestaurantService(url: appDelegate.URLService as String, host: appDelegate.Host as String, userNameMobile : appDelegate.UserName, passwordMobile: appDelegate.Password);
        tableItems = (service?.spGetGuestAccPreAuthTrx("1", appCode: self.appDelegate.gstrAppName, personalID: self.appDelegate.gstrLoginPeopleID, stayInfoID: StayInfoID, dataBase: self.appDelegate.strDataBaseByStay))!
        
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
                
                if (Int(iRes)! > 0){
                    appDelegate.gblynPreAuth = true
                    for r in table.rows{
                        tblPre = [:]
                        tblPre["StayInfoID"] = (r as AnyObject).getColumnByName("StayInfoID").content as? String
                        tblPre["DatabaseName"] = (r as AnyObject).getColumnByName("DatabaseName").content as? String
                        tblPre["Voucher"] = (r as AnyObject).getColumnByName("Voucher").content as? String
                        tblPre["PlaceDesc"] = (r as AnyObject).getColumnByName("PlaceDesc").content as? String
                        tblPre["Amount"] = (r as AnyObject).getColumnByName("Amount").content as? String
                        tblPre["TrxDate"] = (r as AnyObject).getColumnByName("TrxDate").content as? String
                        tblPre["TrxTime"] = (r as AnyObject).getColumnByName("TrxTime").content as? String
                        tblPre["PeopleID"] = (r as AnyObject).getColumnByName("PeopleID").content as? String
                        tblPre["KeyCardID"] = (r as AnyObject).getColumnByName("KeyCardID").content as? String
                        tblPre["CcNumber"] = (r as AnyObject).getColumnByName("CcNumber").content as? String
                        tblPre["AccTrxID"] = (r as AnyObject).getColumnByName("AccTrxID").content as? String
                        tblPre["ExpDate"] = (r as AnyObject).getColumnByName("ExpDate").content as? String
                        tblPre["CcType"] = (r as AnyObject).getColumnByName("CcType").content as? String
                        tblPreAuth.append(tblPre)
                    }
                    
                    appDelegate.gtblAccPreAuth = tblPreAuth
                    
                }else{
                    appDelegate.gblynPreAuth = false
                    appDelegate.gtblAccPreAuth = nil
                }
                
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.navigationController?.toolbar.isHidden = true
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Pre Auth",
            AnalyticsParameterItemName: "Pre Auth",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Pre Auth", screenClass: appDelegate.gstrAppName)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (self.appDelegate.gblExitPreAuth == true){

            self.navigationController?.popViewController(animated: false)
        }
        
    }

}
