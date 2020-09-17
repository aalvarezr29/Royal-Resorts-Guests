//
//  DateCellTableViewController.swift
//  DateCell
//
//  Created by Kohei Hayakawa on 2/6/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging
import DGRunkeeperSwitch

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

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


class DateCellTableViewController: UITableViewController, UITextFieldDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var CheckOuttargetedCellIndexPath: IndexPath?
    var DatetargetedCellIndexPath: IndexPath?
    var BellBoytargetedCellIndexPath: IndexPath?
    var DateBelltargetedCellIndexPath: IndexPath?
    var IndexRow: Int!
    
    var width: CGFloat!
    var height: CGFloat!
    let kPickerAnimationDuration = 0.40 // duration for the animation to slide the date picker into view
    let kDatePickerTag           = 99   // view tag identifiying the date picker view
    
    let kTitleKey = "title" // key for obtaining the data source item's title
    let kDateKey  = "date"  // key for obtaining the data source item's date value
    
    // keep track of which rows have date cells
    let kDateStartRow = 1
    let kDateEndRow   = 2
    
    let kDateCellID       = "dateCell";       // the cells with the start or end date
    let kDatePickerCellID = "datePickerCell"; // the cell containing the date picker
    let kOtherCellID      = "otherCell";      // the remaining cells at the end
    
    var dataArray: [[String: AnyObject]] = []
    var dateFormatter = DateFormatter()
    
    // keep track which indexPath points to the cell with UIDatePicker
    var datePickerIndexPath: IndexPath?
    
    var pickerCellRowHeight: CGFloat = 150
    var btnBack = UIButton()
    var btnSave = UIButton()
    var strCheckOutDate: String = ""
    var strBellBoyDate: String = ""
    
    var strStayInfoID: String = ""
    var strAccCode: String = ""
    var strArrivalDate: String = ""
    var strDepartureDate: String = ""
    var strDataBase: String = ""
    var dtDepartureDate: Date = Date()
    var dtArrivalDate: Date = Date()
    var ynConn:Bool=false
    var lastIndex = IndexPath()
    var ynBandp: Bool = false
    var dtDepartureDatebb: Date = Date()
    var strDepartureDatebb: String = ""
    var ynBellBoyDate: Bool = false
    var txtBag = AKMaskField()
    var cgHeader: CGFloat = 0.0
    var lblFooter = UILabel()
    var imgCell = UIImage()
    var imgvwCell = UIImageView()
    
    @IBOutlet weak var pickerView: UIDatePicker!
    @IBOutlet weak var swBellBoy: UISwitch!
    @IBOutlet weak var Statictable: UITableView!
    @IBOutlet var ViewItem: UINavigationItem!
    @IBOutlet var indicators: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        let hdrlabel = UIView()
        hdrlabel.frame = CGRect(x: 0.0, y: 0.0, width: 0.9*width, height: 0.07*height)
        self.tableView.tableHeaderView = hdrlabel
        
        strStayInfoID = appDelegate.strStayInfoIDCheckOut
        strAccCode = appDelegate.strAccCodeCheckOut
        
        let ArrivalDate = moment(appDelegate.strArrivalDateCheckOut)
        dtArrivalDate = ArrivalDate!.date

        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let dateStr = dateFormatter.string(from: dtArrivalDate)
        
        strArrivalDate = dateStr + " 12:00 PM"
        
        dateFormatter.dateFormat = "yyyy/MM/dd h:mm a"
        
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dtArrivalDate = dateFormatter.date(from: strArrivalDate)!
        
        let dateFormatterdp: DateFormatter = DateFormatter()
        dateFormatterdp.dateFormat = "MM/dd/yyyy h:mm:ss a"
        dateFormatterdp.timeZone = TimeZone(identifier: "UTC")
        dateFormatterdp.locale = Locale(identifier: "en_US")
        dateFormatterdp.timeZone = TimeZone(secondsFromGMT: 0)
        dtDepartureDate = dateFormatterdp.date(from: appDelegate.strDepartureDateCheckOut)!
        dtDepartureDatebb = dateFormatterdp.date(from: appDelegate.strDepartureDateCheckOut)!
        
        let strFormatter: DateFormatter = DateFormatter()
        strFormatter.dateFormat = "yyyy-MM-dd h:mm a"
        strFormatter.timeZone = TimeZone(identifier: "UTC")
        strFormatter.locale = Locale(identifier: "en_US")
        strFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        strDepartureDate = strFormatter.string(from: dtDepartureDate)
        strDepartureDatebb = strFormatter.string(from: dtDepartureDate)
        
        //strDataBase = "FDESK_CANCUN"
        
        self.tabBarController?.navigationController?.navigationBar.isHidden = true;
        
        self.navigationController?.navigationBar.isHidden = false;
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString("TitleCheckout",comment:"")
        
        self.navigationController?.isToolbarHidden = false;

        // setup our data source
        let itemOne = [kTitleKey : NSLocalizedString("HdrCheckout",comment:"")]
        let itemTwo = [kTitleKey : "Start Date", kDateKey : dtDepartureDate] as [String : Any]
        let itemThree = [kTitleKey : "(other item1)"]
        let itemFour = [kTitleKey : "End Date", kDateKey : dtDepartureDate] as [String : Any]
        let itemFive = [kTitleKey : "(other item3)"]
        //let itemSix = [kTitleKey : "(other item2)"]
        dataArray = [itemOne as Dictionary<String, AnyObject>, itemTwo as Dictionary<String, AnyObject>, itemThree as Dictionary<String, AnyObject>, itemFour as Dictionary<String, AnyObject>, itemFive as Dictionary<String, AnyObject>]
        
        dateFormatter.dateStyle = .short // show short-style date format
        dateFormatter.timeStyle = .short
        
        // if the local changes while in the background, we need to be notified so we can update the date
        // format in the table view cells
        //
        NotificationCenter.default.addObserver(self, selector: #selector(DateCellTableViewController.localeChanged(_:)), name: NSLocale.currentLocaleDidChangeNotification, object: nil)
        
        if self.appDelegate.gblynPreAuth == true
        {
            let vwfooter: UIView = UIView(frame: CGRect(x: 0.05*width, y: 0.0, width: 0.9*width, height: 0.15*height))
            lblFooter = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 0.9*width, height: 0.15*height))
            lblFooter.backgroundColor = UIColor.clear;
            lblFooter.textAlignment = NSTextAlignment.left;
            lblFooter.textColor = UIColor.gray;
            lblFooter.text = NSLocalizedString("msgSPreAct",comment:"") + "\r\n" + NSLocalizedString("msgInvoiceReq",comment:"")
            lblFooter.font = UIFont(name:"HelveticaNeue-Light", size:appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
            lblFooter.numberOfLines = 0;
            lblFooter.adjustsFontSizeToFitWidth = true
            lblFooter.sizeToFit()
            vwfooter.addSubview(lblFooter)
            tableView.tableFooterView = vwfooter
        }else{
            
            let vwfooter: UIView = UIView(frame: CGRect(x: 0.05*width, y: 0.0, width: 0.9*width, height: 0.15*height))
            lblFooter = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 0.9*width, height: 0.15*height))
            lblFooter.backgroundColor = UIColor.clear;
            lblFooter.textAlignment = NSTextAlignment.left;
            lblFooter.textColor = UIColor.gray;
            lblFooter.text = NSLocalizedString("msgInvoiceReq",comment:"")
            lblFooter.font = UIFont(name:"HelveticaNeue-Light", size:appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
            lblFooter.numberOfLines = 0;
            lblFooter.adjustsFontSizeToFitWidth = true
            lblFooter.sizeToFit()
            vwfooter.addSubview(lblFooter)
            tableView.tableFooterView = vwfooter
            
        }
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DateCellTableViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tapGesture)
        
        for indicator in indicators {
            indicator.layer.cornerRadius = 10
            indicator.frame  = CGRect(x: 0.7*width, y: 0.34*height, width: 0.05*width, height: 0.05*height);
        }

        if appDelegate.ynIPad {
            switch appDelegate.Model {
            case "iPad 2":
                cgHeader = 0.07*height
            case "iPad Air":
                cgHeader = 0.07*height
            case "iPad Air 2":
                cgHeader = 0.07*height
            case "iPad Pro":
                cgHeader = 0.07*height
            case "iPad Retina":
                cgHeader = 0.07*height
            default:
                cgHeader = 0.07*height
            }
        }else{
            switch appDelegate.Model {
            case "iPhone":
                cgHeader = 0.07*height
            case "iPhone 4":
                cgHeader = 0.07*height
            case "iPhone 4s":
                cgHeader = 0.07*height
            case "iPhone 5":
                cgHeader = 0.05*height
            case "iPhone 5c":
                cgHeader = 0.05*height
            case "iPhone 5s":
                cgHeader = 0.05*height
            case "iPhone 6":
                cgHeader = 0.07*height
            case "iPhone 6 Plus":
                cgHeader = 0.07*height
            case "iPhone 6s":
                cgHeader = 0.07*height
            case "iPhone 6s Plus":
                cgHeader = 0.07*height
            default:
                cgHeader = 0.07*height
            }
        }
        
        ViewItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(DateCellTableViewController.SaveAction(_:)))
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            self.view.backgroundColor = UIColor.clear
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
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
            
            self.view.backgroundColor = UIColor.clear
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
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
            
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            self.view.backgroundColor = UIColor.clear
            //self.view.backgroundColor = colorWithHexString ("DDF4FF")
            self.view.backgroundColor = UIColor.white
            
            imgBack = UIImage(named:"bg.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: -0.05*height, width: width, height: height+(0.05*height));
            imgvwBack.alpha = 0.3
            imgvwBack.contentMode = UIView.ContentMode.scaleAspectFill
            //self.view.addSubview(imgvwBack)
            
            lblFooter.textColor = colorWithHexString("2e3634")
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            tableView.separatorColor = UIColor.clear
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.registerForKeyboardNotifications()
        self.navigationController?.toolbar.isHidden = true
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Check_Out",
            AnalyticsParameterItemName: "Check Out",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Check Out", screenClass: appDelegate.gstrAppName)
        
    }

    func registerForKeyboardNotifications() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(DateCellTableViewController.keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notification: Notification) {

        if self.hasInlineDatePicker() {
            self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0.85*height, width: 1, height: 1), animated: true)
        }else{
            self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0.1*height, width: 1, height: 1), animated: true)
        }
        
        
    }
    
    @objc func hideKeyboard() {
        txtBag.resignFirstResponder()
        //self.tableView.scrollRectToVisible(CGRect(x: 0, y: 500, width: 1, height: 1), animated: true)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Locale
    
    /*! Responds to region format or locale changes.
    */
    @objc func localeChanged(_ notif: Notification) {
        // the user changed the locale (region format) in Settings, so we are notified here to
        // update the date format in the table view cells
        //
        tableView.reloadData()
    }
    
    
    /*! Determines if the given indexPath has a cell below it with a UIDatePicker.
    
    @param indexPath The indexPath to check if its cell has a UIDatePicker below it.
    */
    func hasPickerForIndexPath(_ indexPath: IndexPath) -> Bool {
        var hasDatePicker = false
        
        let targetedRow = indexPath.row + 1
        
        let checkDatePickerCell = tableView.cellForRow(at: IndexPath(row: targetedRow, section: 0))
        let checkDatePicker = checkDatePickerCell?.viewWithTag(kDatePickerTag)
        
        hasDatePicker = checkDatePicker != nil
        return hasDatePicker
    }
    
    /*! Updates the UIDatePicker's value to match with the date of the cell above it.
    */
    func updateDatePicker() {
        
        var strCheckOutDate2: Date = Date()
    
        
        if let indexPath = datePickerIndexPath {
            let associatedDatePickerCell = tableView.cellForRow(at: indexPath)
            if let targetedDatePicker = associatedDatePickerCell?.viewWithTag(kDatePickerTag) as! UIDatePicker? {
                
                //targetedDatePicker.frame = CGRectMake(0.2*width!, 0.0001*height!, 0.6*width!, 0.2*height!);
                
                targetedDatePicker.minimumDate = dtArrivalDate

                targetedDatePicker.maximumDate  = dtDepartureDatebb
                
                targetedDatePicker.timeZone = TimeZone(secondsFromGMT: 0)
                if strCheckOutDate == ""{
                    targetedDatePicker.setDate(dtDepartureDatebb, animated: false)
                }else{
                    
                    var dateFormatterck: DateFormatter = DateFormatter()

                    if ynBandp{
                        dateFormatterck.dateFormat = "yyyy-MM-dd hh:mm a"
                        dateFormatterck.timeZone = TimeZone(secondsFromGMT: 0)
                        dateFormatterck.timeZone = TimeZone(identifier: "UTC")
                        dateFormatterck.locale = Locale(identifier: "en_US")
                        
                        strCheckOutDate2 = dateFormatterck.date(from: strCheckOutDate)!
                        
                        var strBellBoyDate2: String = ""
                        
                        strBellBoyDate = strCheckOutDate
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        dateFormatter.dateStyle = DateFormatter.Style.full
                        dateFormatter.timeStyle = DateFormatter.Style.none
                        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                        let dateStr = dateFormatter.string(from: strCheckOutDate2)
                        
                        let timeFormatter: DateFormatter = DateFormatter()
                        timeFormatter.dateFormat = "hh:mm a"
                        timeFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                        let timeStr = timeFormatter.string(from: strCheckOutDate2)
                        
                        strBellBoyDate2 = dateStr + " " + timeStr
                        
                        var targetedCellIndexPath: IndexPath?
                        
                        if self.hasInlineDatePicker() {
                            targetedCellIndexPath = IndexPath(row: datePickerIndexPath!.row - 1, section: 0)
                        } else {
                            targetedCellIndexPath = tableView.indexPathForSelectedRow!
                        }
                        
                        let cell = tableView.cellForRow(at: targetedCellIndexPath!)
                        
                        cell?.detailTextLabel?.backgroundColor = UIColor.clear;
                        cell?.detailTextLabel?.textAlignment = NSTextAlignment.left;
                        cell?.detailTextLabel?.textColor = UIColor.black;
                        cell?.detailTextLabel?.numberOfLines = 1;
                        cell?.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont6 + appDelegate.gblDeviceFont3);
                        cell?.detailTextLabel?.text = strBellBoyDate2
                        cell?.detailTextLabel?.adjustsFontSizeToFitWidth = true
                        
                    }else{
                        
                        dateFormatterck.dateFormat = "yyyy-MM-dd hh:mm a"
                        dateFormatterck.timeZone = TimeZone(secondsFromGMT: 0)
                        dateFormatterck.timeZone = TimeZone(identifier: "UTC")
                        dateFormatterck.locale = Locale(identifier: "en_US")
                        
                        if strBellBoyDate == ""{
                            strCheckOutDate2 = dateFormatterck.date(from: strDepartureDatebb)!
                        }else{
                            strCheckOutDate2 = dateFormatterck.date(from: strBellBoyDate)!
                        }

                    }
                    
                    targetedDatePicker.setDate(strCheckOutDate2, animated: false)
                    
                }
                
            }
        }
    }
    
    /*! Determines if the UITableViewController has a UIDatePicker in any of its cells.
    */
    func hasInlineDatePicker() -> Bool {
        return datePickerIndexPath != nil
    }
    
    /*! Determines if the given indexPath points to a cell that contains the UIDatePicker.
    
    @param indexPath The indexPath to check if it represents a cell with the UIDatePicker.
    */
    func indexPathHasPicker(_ indexPath: IndexPath) -> Bool {
        return hasInlineDatePicker() && datePickerIndexPath?.row == indexPath.row
    }
    
    /*! Determines if the given indexPath points to a cell that contains the start/end dates.
    
    @param indexPath The indexPath to check if it represents start/end date cell.
    */
    func indexPathHasDate(_ indexPath: IndexPath) -> Bool {
        var hasDate = false
        
        if (indexPath.row == kDateStartRow) || (indexPath.row == kDateEndRow || (hasInlineDatePicker() && (indexPath.row == kDateEndRow + 1))) {
            hasDate = true
        }
        return hasDate
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return (indexPathHasPicker(indexPath) ? pickerCellRowHeight : 0.1*height)
        }else{
            return (indexPathHasPicker(indexPath) ? pickerCellRowHeight : 0.08*height)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numRows = dataArray.count
        
        if hasInlineDatePicker() {
            // we have a date picker, so allow for it in the number of rows in this section
            numRows = numRows + 1
        }
        
        return numRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        var cellID = kOtherCellID
        
        if indexPathHasPicker(indexPath) {
            // the indexPath is the one containing the inline date picker
            cellID = kDatePickerCellID     // the current/opened date picker cell
        } else if indexPathHasDate(indexPath) {
            // the indexPath is one that contains the date information
            cellID = kDateCellID       // the start/end date cells
        }

        if cellID != kDatePickerCellID {
            switch String(indexPath.row){
            case "0":
                cellID = kOtherCellID
            case "1":
                cellID = kDateCellID
            case "2":
                cellID = "otherSwitch"
            case "3":
                cellID = kDateCellID
            case "4":
                cellID = "bagCell"
            case "5":
                cellID = "buttonCell"
            default:
                cellID = kOtherCellID
            };
        }else{
            
            if indexPath.row == 2 {
                DatetargetedCellIndexPath = indexPath
            }
            if indexPath.row == 4 {
                DateBelltargetedCellIndexPath = indexPath
            }
            
            IndexRow = indexPath.row
            
        }
        
        cell = tableView.dequeueReusableCell(withIdentifier: cellID)!
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            cell!.backgroundColor = UIColor.clear
            //cell!.backgroundColor = colorWithHexString ("DDF4FF")
            cell!.backgroundColor = UIColor.white
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{

            cell!.backgroundColor = UIColor.clear
            //cell!.backgroundColor = colorWithHexString ("DDF4FF")
            cell!.backgroundColor = UIColor.white
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{

            cell!.backgroundColor = UIColor.clear
            //cell!.backgroundColor = colorWithHexString ("DDF4FF")
            cell!.backgroundColor = UIColor.white
            
        }
    
        if indexPath.row == 0 {
            // we decide here that first cell in the table is not selectable (it's just an indicator)
            cell?.selectionStyle = .none;
        }
        
        // if we have a date picker open whose cell is above the cell we want to update,
        // then we have one more cell than the model allows
        //
        var modelRow = indexPath.row
        if (datePickerIndexPath != nil && datePickerIndexPath?.row <= indexPath.row) {
            modelRow -= 1
        }
        
        //let itemData = dataArray[modelRow]
        
        var dtDepartureDateCell: Date = Date()
        var dtBellBoyDateCell: Date = Date()

        if cellID == "dateCell" {
            if indexPath.row == 1 {

                cell?.textLabel?.backgroundColor = UIColor.clear;
                cell?.textLabel?.textAlignment = NSTextAlignment.right;
                cell?.textLabel?.textColor = UIColor.black;
                cell?.textLabel?.numberOfLines = 0;
                cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont8 + appDelegate.gblDeviceFont3);
                cell?.textLabel?.text = NSLocalizedString("lblCheckout",comment:"");
                
                if strCheckOutDate == ""{
                    dtDepartureDateCell = dtDepartureDatebb
                }else{
                    
                    let dateFormatterck: DateFormatter = DateFormatter()
                    dateFormatterck.dateFormat = "yyyy-MM-dd hh:mm a"
                    dateFormatterck.timeZone = TimeZone(secondsFromGMT: 0)
                    dtDepartureDateCell = dateFormatterck.date(from: strCheckOutDate)!
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.dateStyle = DateFormatter.Style.full
                dateFormatter.timeStyle = DateFormatter.Style.none
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                let dateStr = dateFormatter.string(from: dtDepartureDateCell)
                
                let timeFormatter: DateFormatter = DateFormatter()
                timeFormatter.dateFormat = "hh:mm a"
                timeFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                let timeStr = timeFormatter.string(from: dtDepartureDateCell)
                
                let strDateTime = dateStr + " " + timeStr
                
                cell?.detailTextLabel?.backgroundColor = UIColor.clear;
                cell?.detailTextLabel?.textAlignment = NSTextAlignment.left;
                cell?.detailTextLabel?.textColor = UIColor.black;
                cell?.detailTextLabel?.numberOfLines = 1;
                cell?.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont6 + appDelegate.gblDeviceFont3);
                cell?.detailTextLabel?.text = strDateTime
                cell?.detailTextLabel?.adjustsFontSizeToFitWidth = true
                
                CheckOuttargetedCellIndexPath = indexPath
                
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
                
                gradientView.bottomBorderColor = colorWithHexString ("5C9FCC")
                
                cell!.backgroundView = gradientView
                
                lastIndex = IndexPath.init()
                
                cell!.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                
                if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                    
                    
                }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                    
                    cell!.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("e4c29c"))
                    
                }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{

                    cell!.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("e4c29c"))
                    
                }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{

                    cell!.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("2e3634"))
                    
                }

            }
            if indexPath.row == 3 {

                cell?.textLabel?.backgroundColor = UIColor.clear;
                cell?.textLabel?.textAlignment = NSTextAlignment.left;
                cell?.textLabel?.textColor = UIColor.black;
                cell?.textLabel?.numberOfLines = 0;
                cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont8 + appDelegate.gblDeviceFont3);
                cell?.textLabel?.text = NSLocalizedString("lblBellBoyAt",comment:"");
                
                if strBellBoyDate == ""{
                    dtBellBoyDateCell = dtDepartureDatebb
                }else{
                    
                    let dateFormatterck: DateFormatter = DateFormatter()
                    dateFormatterck.dateFormat = "yyyy-MM-dd hh:mm a"
                    dateFormatterck.timeZone = TimeZone(secondsFromGMT: 0)
                    dtBellBoyDateCell = dateFormatterck.date(from: strBellBoyDate)!
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.dateStyle = DateFormatter.Style.full
                dateFormatter.timeStyle = DateFormatter.Style.none
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                let dateStr = dateFormatter.string(from: dtBellBoyDateCell)
                
                let timeFormatter: DateFormatter = DateFormatter()
                timeFormatter.dateFormat = "hh:mm a"
                timeFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                let timeStr = timeFormatter.string(from: dtBellBoyDateCell)
                
                let strDateTime = dateStr + " " + timeStr
                
                cell?.detailTextLabel?.backgroundColor = UIColor.clear;
                cell?.detailTextLabel?.textAlignment = NSTextAlignment.left;
                cell?.detailTextLabel?.textColor = UIColor.black;
                cell?.detailTextLabel?.numberOfLines = 1;
                cell?.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont6 + appDelegate.gblDeviceFont3);
                cell?.detailTextLabel?.text = strDateTime
                cell?.detailTextLabel?.adjustsFontSizeToFitWidth = true

                cell?.isUserInteractionEnabled = false
                
                BellBoytargetedCellIndexPath = indexPath
                
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
                
                gradientView.bottomBorderColor = colorWithHexString ("5C9FCC")
                
                cell!.backgroundView = gradientView
                
                lastIndex = IndexPath.init()

                cell!.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                
                if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                    
                    
                }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                    
                    cell!.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("e4c29c"))
                    
                }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{

                    cell!.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("e4c29c"))
                    
                }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
                    
                    cell!.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("2e3634"))
                    
                }

            }

        } else if cellID == "otherCell" {

            if indexPath.row == 0 {

                cell?.textLabel?.text = ""
                cell?.textLabel?.backgroundColor = UIColor.clear;
                cell?.textLabel?.textAlignment = NSTextAlignment.center;
                cell?.textLabel?.textColor = UIColor.black;
                cell?.textLabel?.numberOfLines = 0;
                cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont4 + appDelegate.gblDeviceFont3);
                cell?.textLabel?.text = NSLocalizedString("HdrCheckout",comment:"");
                
                if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                    
                    
                }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                    
                    cell?.textLabel?.textColor = colorWithHexString("ba8748")
                    
                }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{

                    cell?.textLabel?.textColor = colorWithHexString("00467f")
                    
                }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
                    
                    cell?.textLabel?.textColor = colorWithHexString("2e3634")
                    
                }
                
            }else{
                if indexPath.row == 2 {
                    //cell?.textLabel?.text = "Bell boy service"
                    
                }
                if indexPath.row == 4 {
                    //cell?.textLabel?.text = "Save"
                }

            }

        } else if cellID == "buttonCell" {
            
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
            
            gradientView.bottomBorderColor = colorWithHexString ("5C9FCC")
            
            cell!.backgroundView = gradientView
            
            
            btnSave.frame = CGRect(x: 0.4*width, y: 0.02*height, width: 0.2*width, height: 0.04*height)
            btnSave.layer.cornerRadius = 5
            btnSave.setTitle(NSLocalizedString("btnSave",comment:""), for:UIControl.State())
            btnSave.titleLabel?.font = UIFont(name: "Helvetica", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
            btnSave.titleLabel?.textAlignment = NSTextAlignment.left
            btnSave.addTarget(self, action: #selector(DateCellTableViewController.SaveAction(_:)), for: UIControl.Event.touchUpInside)

            if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{

                btnSave.titleLabel?.numberOfLines = 5
                btnSave.layer.borderColor = UIColor.clear.cgColor
                btnSave.backgroundColor = colorWithHexString("FFCC66")
                btnSave.setTitleColor(colorWithHexString ("007AFF"), for: UIControl.State())
                
            }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{

                btnSave.titleLabel?.numberOfLines = 5
                btnSave.layer.borderColor = UIColor.clear.cgColor
                btnSave.backgroundColor = colorWithHexString("FFCC66")
                btnSave.setTitleColor(colorWithHexString ("007AFF"), for: UIControl.State())
                
            }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{

                btnSave.titleLabel?.numberOfLines = 5
                btnSave.layer.borderColor = UIColor.clear.cgColor
                btnSave.backgroundColor = colorWithHexString("FFCC66")
                btnSave.setTitleColor(colorWithHexString ("007AFF"), for: UIControl.State())
                
            }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{

                btnSave.backgroundColor = colorWithHexString("f7941e")
                btnSave.setTitleColor(colorWithHexString ("2e3634"), for: UIControl.State())
                
            }
            
            cell?.addSubview(btnSave)
            
        } else if cellID == "otherSwitch" {

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
            
            gradientView.bottomBorderColor = colorWithHexString ("5C9FCC")
            
            cell!.backgroundView = gradientView
            
            cell?.textLabel?.backgroundColor = UIColor.clear;
            cell?.textLabel?.textAlignment = NSTextAlignment.left;
            cell?.textLabel?.textColor = UIColor.black;
            cell?.textLabel?.numberOfLines = 1;
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont5 + appDelegate.gblDeviceFont2);
            cell?.textLabel?.text = NSLocalizedString("lblBellBoyService",comment:"");
            cell?.textLabel?.adjustsFontSizeToFitWidth = true
            
            let runkeeperSwitch = DGRunkeeperSwitch(titles: [NSLocalizedString("lblNoService",comment:""),NSLocalizedString("lblService",comment:"")])
            
            if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                runkeeperSwitch.backgroundColor = colorWithHexString ("5C9FCC")
                runkeeperSwitch.selectedTitleColor = colorWithHexString ("5C9FCC")
                
                
            }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                
                runkeeperSwitch.backgroundColor = self.colorWithHexString ("ba8748")
                runkeeperSwitch.selectedTitleColor = self.colorWithHexString ("ba8748")
                
            }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                
                runkeeperSwitch.backgroundColor = self.colorWithHexString ("a18015")
                runkeeperSwitch.selectedTitleColor = self.colorWithHexString ("a18015")
                
            }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
                
                runkeeperSwitch.backgroundColor = self.colorWithHexString ("004c50")
                runkeeperSwitch.selectedTitleColor = self.colorWithHexString ("004c50")
                
            }
 
            runkeeperSwitch.selectedBackgroundColor = .white
            runkeeperSwitch.titleColor = .white
            runkeeperSwitch.titleFont = UIFont(name: "HelveticaNeue-Medium", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont2)
            runkeeperSwitch.frame = CGRect(x: 0.58*width, y: 0.02*height, width: 0.4*width, height: 0.04*height)
            runkeeperSwitch.addTarget(self, action: #selector(DateCellTableViewController.SwitchAction(_:)), for: .valueChanged)
            cell?.addSubview(runkeeperSwitch)
            
            cell!.accessoryType = UITableViewCell.AccessoryType.none
            
            
        }else if cellID == "bagCell" {
            
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
            
            gradientView.bottomBorderColor = colorWithHexString ("5C9FCC")
            
            cell!.backgroundView = gradientView
            
            let lblBag = UILabel(frame: CGRect(x: 0.05*width, y: 0.02*height, width: 0.4*width, height: 0.04*height));
            lblBag.backgroundColor = UIColor.clear;
            lblBag.textAlignment = NSTextAlignment.left;
            lblBag.textColor = UIColor.black;
            lblBag.numberOfLines = 0;
            lblBag.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont8 + appDelegate.gblDeviceFont3);
            lblBag.text = NSLocalizedString("lblBag",comment:"");
            lblBag.adjustsFontSizeToFitWidth = true;
            cell?.addSubview(lblBag)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(DateCellTableViewController.txtClickBag))
            tap.numberOfTapsRequired = 1
            txtBag.addGestureRecognizer(tap)
            
            txtBag.maskExpression = "{dd}"
            txtBag.maskTemplate = ""
            txtBag.maskDelegate = self
            txtBag.layer.borderColor = UIColor.black.cgColor
            txtBag.borderStyle = UITextField.BorderStyle.roundedRect
            txtBag.frame = CGRect(x: 0.75*width, y: 0.02*height, width: 0.2*width, height: 0.04*height);
            txtBag.font = UIFont(name:"HelveticaNeue-Bold", size:appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtBag.keyboardType = UIKeyboardType.numberPad
            txtBag.isEnabled = false
            
            cell?.addSubview(txtBag)
            
        }
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            if cellID != "otherCell" {
                
                if indexPath.row != 0 {
                    
                    imgCell = UIImage(named:"tblrowsingle.png")!
                    imgvwCell = UIImageView(image: imgCell)
                    cell!.backgroundView = imgvwCell
                    
                    imgCell = UIImage(named:"tblrowsingleSel.png")!
                    imgvwCell = UIImageView(image: imgCell)
                    cell!.selectedBackgroundView = imgvwCell
                    
                }
            }
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            if cellID != "otherCell" {
                
                if indexPath.row != 0 {
                    
                    imgCell = UIImage(named:"tblrowsingle.png")!
                    imgvwCell = UIImageView(image: imgCell)
                    cell!.backgroundView = imgvwCell
                    
                    imgCell = UIImage(named:"tblrowsingleSel.png")!
                    imgvwCell = UIImageView(image: imgCell)
                    cell!.selectedBackgroundView = imgvwCell
                    
                }
            }

        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
            
        }
        
        lastIndex = IndexPath.init()
        
        return cell!
    }
    
    @objc func txtClickBag() {
        
        let ccNumber = txtBag.text!.trimmingCharacters(in: .whitespaces)
        if ccNumber == ""{
            let newPosition = txtBag.beginningOfDocument
            txtBag.selectedTextRange = txtBag.textRange(from: newPosition, to: newPosition)
        }

        txtBag.becomeFirstResponder()

    }
    /*! Adds or removes a UIDatePicker cell below the given indexPath.
    
    @param indexPath The indexPath to reveal the UIDatePicker.
    */
    func toggleDatePickerForSelectedIndexPath(_ indexPath: IndexPath) {
        
        tableView.beginUpdates()
        
        let indexPaths = [IndexPath(row: indexPath.row + 1, section: 0)]
        // check if 'indexPath' has an attached date picker below it
        if hasPickerForIndexPath(indexPath) {
            // found a picker below it, so remove it
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            // didn't find a picker below it, so we should insert it
            tableView.insertRows(at: indexPaths, with: .fade)
        }

        tableView.endUpdates()
    }
    
    /*! Reveals the date picker inline for the given indexPath, called by "didSelectRowAtIndexPath".
    
    @param indexPath The indexPath to reveal the UIDatePicker.
    */
    func displayInlineDatePickerForRowAtIndexPath(_ indexPath: IndexPath, cellClick: Bool) {
        
        // display the date picker inline with the table content
        tableView.beginUpdates()
        
        var before = false // indicates if the date picker is below "indexPath", help us determine which row to reveal
        if hasInlineDatePicker() {
            before = datePickerIndexPath?.row < indexPath.row
        }
        
        var sameCellClicked = (datePickerIndexPath?.row == indexPath.row + 1)
        
        if cellClick == true{
            sameCellClicked = true
        }

        // remove any date picker cell if it exists
        if self.hasInlineDatePicker() {
            tableView.deleteRows(at: [IndexPath(row: datePickerIndexPath!.row, section: 0)], with: .fade)
            datePickerIndexPath = nil
        }
        
        if !sameCellClicked {
            // hide the old date picker and display the new one
            let rowToReveal = (before ? indexPath.row - 1 : indexPath.row)
            let indexPathToReveal = IndexPath(row: rowToReveal, section: 0)
            
            toggleDatePickerForSelectedIndexPath(indexPathToReveal)
            datePickerIndexPath = IndexPath(row: indexPathToReveal.row + 1, section: 0)

        }
        
        // always deselect the row containing the start or end date
        tableView.deselectRow(at: indexPath, animated:true)
        
        tableView.endUpdates()
        
        // inform our date picker of the current date to match the current cell
        updateDatePicker()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cgHeader
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)

        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            if indexPath.row == 1 || indexPath.row == 3{
                if lastIndex != indexPath && lastIndex.count > 0{
                    // Initialize a gradient view
                    let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 0.9*width, height: 0.12*height))
                    
                    // Set the gradient colors 8DE3F5 5C9F00
                    gradientView.colors = [UIColor.white, colorWithHexString ("C6F4FE")]
                    
                    // Optionally set some locations
                    gradientView.locations = [0.4, 1.0]
                    
                    // Optionally change the direction. The default is vertical.
                    gradientView.direction = .vertical
                    
                    // Add some borders too if you want
                    gradientView.topBorderColor = UIColor.lightGray
                    
                    gradientView.bottomBorderColor = colorWithHexString ("5C9FCC")
                    
                    cell!.backgroundView = gradientView
                    
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
                    
                    gradientView2.bottomBorderColor = colorWithHexString ("5C9FCC")
                    
                    tableView.cellForRow(at: lastIndex)?.backgroundView = gradientView2
                    
                }else{
                    if lastIndex != indexPath {
                        
                        // Initialize a gradient view
                        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 0.9*width, height: 0.12*height))
                        
                        // Set the gradient colors 8DE3F5 5C9F00
                        gradientView.colors = [UIColor.white, colorWithHexString ("C6F4FE")]
                        
                        // Optionally set some locations
                        gradientView.locations = [0.4, 1.0]
                        
                        // Optionally change the direction. The default is vertical.
                        gradientView.direction = .vertical
                        
                        // Add some borders too if you want
                        gradientView.topBorderColor = UIColor.lightGray
                        
                        gradientView.bottomBorderColor = colorWithHexString ("5C9FCC")
                        
                        cell!.backgroundView = gradientView
                        
                    }
                    
                }
                
                lastIndex = indexPath
            }
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            var sameCellClicked = (datePickerIndexPath?.row == indexPath.row + 1)

            if indexPath.row == 1 || indexPath.row == 3{
                
                if indexPath.row == 1{
                    
                    if !sameCellClicked {
                        tableView.cellForRow(at: IndexPath(row: 3, section: 0))?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("e4c29c"))
                    }
                    /*else{
                        tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0))?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("e4c29c"))
                    }*/
                    
                }else{
                    
                    if !sameCellClicked {
                        tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("e4c29c"))
                    }
                    
                }
                
                tableView.cellForRow(at: indexPath)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("ba8748"))
                
            }
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            if indexPath.row == 1 || indexPath.row == 3{
                
                if indexPath.row == 1{
                
                    tableView.cellForRow(at: IndexPath(row: 3, section: 0))?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("94cce5"))
                    
                }else{
                
                    tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("94cce5"))
                
                }
                
                tableView.cellForRow(at: indexPath)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("00467f"))
                
            }

        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
            
            if indexPath.row == 1 || indexPath.row == 3{
                
                if indexPath.row == 1{
                
                    tableView.cellForRow(at: IndexPath(row: 3, section: 0))?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("004c50"))
                    
                }else{
                
                    tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("004c50"))
                
                }
                
                tableView.cellForRow(at: indexPath)?.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("004c50"))
                
            }

        }
        
        if indexPath.row == 1 {
            
            ynBandp = true
            
        }
        
        if indexPath.row == 3 || indexPath.row == 4 {
            
            ynBandp = false
            
        }
        
        if cell?.reuseIdentifier == kDateCellID {
            displayInlineDatePickerForRowAtIndexPath(indexPath,cellClick: false)
            cell!.accessoryType = UITableViewCell.AccessoryType.none
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        lastIndex = indexPath

    }
    @IBAction func SaveAction(_ sender: AnyObject) {
        
        var bags: String = "0"
        
        let trimmedString = txtBag.text!.trimmingCharacters(
            in: CharacterSet.whitespacesAndNewlines
        )
        if (trimmedString.isEmpty==true){
            bags = "0"
        }else{
            bags = txtBag.text!
        }

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
        
        var prepareOrderResult:NSString="";
        let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile:self.appDelegate.UserName, passwordMobile:self.appDelegate.Password);
        
        queue.addOperation() {

            
            if Reachability.isConnectedToNetwork(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                prepareOrderResult = service!.wmPosCheckOut("1", strStayInfoID: self.strStayInfoID, strAccID: self.strAccCode, strArrivalDate: self.strArrivalDate, strDepartureDate: self.strDepartureDate, strBellBoydate: self.strBellBoyDate, strDataBase: self.appDelegate.strDataBaseByStay, strBellBoyBag1: bags) as! NSString
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }else{
                RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                SwiftLoader.hide()
            }
            
            OperationQueue.main.addOperation() {
                
                let separators = CharacterSet(charactersIn: ",")
                var aRes = prepareOrderResult.components(separatedBy: separators)
                
                if(aRes[0]=="1"){
                    
                    if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
                        GoogleWearAlert.showAlert(title: NSLocalizedString("msgCheckOutCLB",comment:""), type: .success, duration: 4, iAction: 1, form:"Check Out")
                    }else
                    {
                        GoogleWearAlert.showAlert(title: NSLocalizedString("msgCheckOut",comment:""), type: .success, duration: 4, iAction: 1, form:"Check Out")
                    }

                    self.appDelegate.gblCheckOutVw = true
                    self.appDelegate.gblCheckOUT = true
                    self.navigationController?.popViewController(animated: false)
                }else{
                    if prepareOrderResult == ""{
                        RKDropdownAlert.title("", backgroundColor: UIColor.red, textColor: UIColor.black)
                        //self.dismissViewControllerAnimated(true, completion: nil)
                    }else{
                        RKDropdownAlert.title(aRes[1], backgroundColor: UIColor.red, textColor: UIColor.black)
                        self.navigationController?.popViewController(animated: false)
                    }
                }
                SwiftLoader.hide()
                
                
            }
        }
        
    }

    @IBAction func SwitchAction(_ sender: DGRunkeeperSwitch!) {
        
        if DatetargetedCellIndexPath != nil
        {
            displayInlineDatePickerForRowAtIndexPath(DatetargetedCellIndexPath!,cellClick: true)
        }
        
        let cell = tableView.cellForRow(at: BellBoytargetedCellIndexPath!)
        
        if sender.selectedIndex == 1 {

            let dateFormatterWST: DateFormatter = DateFormatter()
            dateFormatterWST.dateFormat = "yyyy-MM-dd"
            dateFormatterWST.timeZone = TimeZone(identifier: "UTC")
            dateFormatterWST.locale = Locale(identifier: "en_US")
            dateFormatterWST.timeZone = TimeZone(secondsFromGMT: 0)
            let dateStrWST = dateFormatterWST.string(from: dtDepartureDatebb)
            
            let timeFormatterWS1: DateFormatter = DateFormatter()
            timeFormatterWS1.dateFormat = "hh:mm a"
            timeFormatterWS1.timeZone = TimeZone(identifier: "UTC")
            timeFormatterWS1.locale = Locale(identifier: "en_US")
            timeFormatterWS1.timeZone = TimeZone(secondsFromGMT: 0)
            let timeStrWS1 = timeFormatterWS1.string(from: dtDepartureDatebb)
            
            strBellBoyDate = dateStrWST + " " + timeStrWS1
            
            cell?.isUserInteractionEnabled = true
            displayInlineDatePickerForRowAtIndexPath(BellBoytargetedCellIndexPath!,cellClick: false)
            txtBag.isEnabled = true
        } else {
            cell?.isUserInteractionEnabled = false
            strBellBoyDate = ""
            if DateBelltargetedCellIndexPath != nil
            {
                displayInlineDatePickerForRowAtIndexPath(DateBelltargetedCellIndexPath!,cellClick: true)
            }
            txtBag.text = ""
            txtBag.isEnabled = false
        }
        
    }
    
    @IBAction func dateAction(_ sender: UIDatePicker) {
        
        var targetedCellIndexPath: IndexPath?
        
        if self.hasInlineDatePicker() {
            targetedCellIndexPath = IndexPath(row: datePickerIndexPath!.row - 1, section: 0)
        } else {

            if let IndexPath = tableView.indexPathForSelectedRow {
                targetedCellIndexPath = tableView.indexPathForSelectedRow!
            }else{
                if IndexRow == 2 {
                    targetedCellIndexPath = IndexPath(row: 0, section: 1)
                }
                if IndexRow == 4 {
                    targetedCellIndexPath = IndexPath(row: 0, section: 3)
                }
            }
            
        }
        
        let cell = tableView.cellForRow(at: targetedCellIndexPath!)
        let targetedDatePicker = sender

        var itemData = dataArray[targetedCellIndexPath!.row]
        itemData[kDateKey] = targetedDatePicker.date as AnyObject
        dataArray[targetedCellIndexPath!.row] = itemData
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let dateStr = dateFormatter.string(from: targetedDatePicker.date)
        
        let timeFormatter: DateFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        timeFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let timeStr = timeFormatter.string(from: targetedDatePicker.date)
        
        let strDateTime = dateStr + " " + timeStr
        
        cell?.detailTextLabel?.backgroundColor = UIColor.clear;
        cell?.detailTextLabel?.textAlignment = NSTextAlignment.left;
        cell?.detailTextLabel?.textColor = UIColor.black;
        cell?.detailTextLabel?.numberOfLines = 1;
        cell?.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont6 + appDelegate.gblDeviceFont3);
        cell?.detailTextLabel?.text = strDateTime
        cell?.detailTextLabel?.adjustsFontSizeToFitWidth = true
        
        if IndexRow == 2 {
            
            let dateFormatterWST: DateFormatter = DateFormatter()
            dateFormatterWST.dateFormat = "yyyy-MM-dd"
            dateFormatterWST.timeZone = TimeZone(identifier: "UTC")
            dateFormatterWST.locale = Locale(identifier: "en_US")
            dateFormatterWST.timeZone = TimeZone(secondsFromGMT: 0)
            let dateStrWST = dateFormatterWST.string(from: targetedDatePicker.date)
            
            let timeFormatterWS1: DateFormatter = DateFormatter()
            timeFormatterWS1.dateFormat = "hh:mm a"
            timeFormatterWS1.timeZone = TimeZone(identifier: "UTC")
            timeFormatterWS1.locale = Locale(identifier: "en_US")
            timeFormatterWS1.timeZone = TimeZone(secondsFromGMT: 0)
            let timeStrWS1 = timeFormatterWS1.string(from: targetedDatePicker.date)
            
            strDepartureDate = dateStrWST + " " + timeStrWS1
            strCheckOutDate = dateStrWST + " " + timeStrWS1

            appDelegate.strCheckOutTimeAux = timeStrWS1
            appDelegate.strCheckOutDateAux = dateStrWST
            
        }
        if IndexRow == 4 {
            
            let dateFormatterWS2: DateFormatter = DateFormatter()
            dateFormatterWS2.dateFormat = "yyyy-MM-dd"
            dateFormatterWS2.timeZone = TimeZone(identifier: "UTC")
            dateFormatterWS2.locale = Locale(identifier: "en_US")
            dateFormatterWS2.timeZone = TimeZone(secondsFromGMT: 0)
            let dateStrWS2 = dateFormatterWS2.string(from: targetedDatePicker.date)
            
            let timeFormatterWS2: DateFormatter = DateFormatter()
            timeFormatterWS2.dateFormat = "hh:mm a"
            timeFormatterWS2.timeZone = TimeZone(identifier: "UTC")
            timeFormatterWS2.locale = Locale(identifier: "en_US")
            timeFormatterWS2.timeZone = TimeZone(secondsFromGMT: 0)
            let timeStrWS2 = timeFormatterWS2.string(from: targetedDatePicker.date)

            strBellBoyDate = dateStrWS2 + " " + timeStrWS2
            
        }
        
        //cell?.detailTextLabel?.text = dateFormatter.stringFromDate(targetedDatePicker.date)
        
        
    }
    
    @IBAction func clickBack(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}


// MARK: - AKMaskFieldDelegate
//         _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

extension DateCellTableViewController: AKMaskFieldDelegate {
    
    func maskField(_ maskField: AKMaskField, shouldChangeCharacters oldString: String, inRange range: NSRange, replacementString withString: String) {
        
        // Status animation
        var statusColor =  UIColor.clear
        
        switch maskField.maskStatus {
        case .clear:
            statusColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0)
        case .incomplete:
            statusColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
        case .complete:
            statusColor = UIColor(red: 0/255, green: 219/255, blue: 86/255, alpha: 1.0)
            
        }
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseIn,
            animations: { () -> Void in
                
                self.indicators[maskField.tag].backgroundColor = statusColor
                
            },
            completion: nil
        )
        
        // Event animation
        var eventColor =  UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 0.5)
        /*switch maskField.event {
        case .insert:
            eventColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0)
        case .replace:
            eventColor = UIColor(red: 140/255, green: 190/255, blue: 178/255, alpha: 0.5)
        case .delete:
            eventColor = UIColor(red: 243/255, green: 181/255, blue: 98/255, alpha: 0.5)
        default: ()
        }*/
        
        UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseIn,
            animations: { () -> Void in
                
                maskField.backgroundColor = eventColor
                
            }
            ) { (Bool) -> Void in
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut,
                    animations: { () -> Void in
                        
                        maskField.backgroundColor = UIColor.clear
                        
                        if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                            
                        }else if self.appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                            
                            maskField.backgroundColor = UIColor.white
                            
                        }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
                            
                            maskField.backgroundColor = UIColor.white
                            
                        }else if self.appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
                            
                            maskField.backgroundColor = UIColor.white
                            
                        }
                        
                    },
                    completion: nil
                )
        }
    }
}
