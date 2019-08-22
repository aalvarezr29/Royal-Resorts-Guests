//
//  vcSelectStay.swift
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

class vcSelectStay: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var width: CGFloat!
    var height: CGFloat!
    var btnBack = UIButton()
    var btnNext = UIButton()
    var StaysStatus: [[Dictionary<String, String>]]!
    var iseccion: Int = 0
    var tblStay: [Dictionary<String, String>]!
    var CountStay: Int32 = 0
    
    var StayInfoID: String = ""
    var PeopleID: String = ""
    var PeopleFDeskID: String = ""
    var formatter = NumberFormatter()
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
        ViewItem.title = NSLocalizedString("lblSelectStay",comment:"");

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
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            tableView.backgroundColor = UIColor.clear
            
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
            
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            var imgBack = UIImage()
            var imgvwBack = UIImageView()
            
            tableView.backgroundColor = UIColor.clear
            
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

            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            
        }
        
        cargarDatos()
        
    }
    
    func cargarDatos(){
        
        self.StaysStatus = nil
        self.tblStay = nil
        self.appDelegate.gtblStay = nil
        self.appDelegate.gStaysStatus = nil
        
        var resultStayID: Int32 = 0
        var resultStatusID: Int32 = 0
        var Stays: [Dictionary<String, String>]
        var DataStays = [String:String]()
        var Index: Int = 0
        var Status: [String]
        var StaysStatus: [[Dictionary<String, String>]]
        var contStatus: Int = 0
        var CountStatusTot: Int32 = 0
        
        StaysStatus = []
        Status = [""]
        Stays = []
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        let queue = OperationQueue()
        
        queue.addOperation() {//1
            //accion base de datos
            //print(1)
            
            if self.appDelegate.gstrLoginPeopleID != ""
            {
                queueFM?.inDatabase() {
                    db in
                    
                    let resultCount = db.intForQuery("SELECT COUNT(*) FROM tblStay WHERE OrderNo IN(1,2)" as String,"" as AnyObject)
                    
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
                
                self.CountStay = resultStayID
            }
            
            OperationQueue.main.addOperation() {
                queue.addOperation() {//2
                    //accion base de datos
                    //print(2)
                    
                    if (self.CountStay>0){
                        
                        queueFM?.inDatabase() {
                            db in
                            
                            for _ in 0...resultStayID-1 {
                                Stays.append([:])
                            }
                            
                            if let rs = db.executeQuery("SELECT * FROM tblStay WHERE OrderNo IN(1,2)", withArgumentsIn: []){
                                while rs.next() {
                                    DataStays["StayInfoID"] = String(describing: rs.string(forColumn: "StayInfoID")!)
                                    DataStays["DatabaseName"] = String(describing: rs.string(forColumn: "DatabaseName")!)
                                    DataStays["PropertyCode"] = String(describing: rs.string(forColumn: "PropertyCode")!)
                                    DataStays["PropertyName"] = String(describing: rs.string(forColumn: "PropertyName")!)
                                    DataStays["UnitCode"] = String(describing: rs.string(forColumn: "UnitCode")!)
                                    DataStays["StatusCode"] = String(describing: rs.string(forColumn: "StatusCode")!)
                                    DataStays["StatusDesc"] = String(describing: rs.string(forColumn: "StatusDesc")!)
                                    DataStays["ArrivalDate"] = String(describing: rs.string(forColumn: "ArrivalDate")!)
                                    DataStays["DepartureDate"] = String(describing: rs.string(forColumn: "DepartureDate")!)
                                    DataStays["PrimaryPeopleID"] = String(describing: rs.string(forColumn: "PrimaryPeopleID")!)
                                    DataStays["OrderNo"] = String(describing: rs.string(forColumn: "OrderNo")!)
                                    DataStays["PrimAgeCFG"] = String(describing: rs.string(forColumn: "PrimAgeCFG")!)
                                    DataStays["fkPlaceID"] = String(describing: rs.string(forColumn: "fkPlaceID")!)
                                    DataStays["DepartureDateCheckOut"] = String(describing: rs.string(forColumn: "DepartureDateCheckOut")!)
                                    DataStays["ConfirmationCode"] = String(describing: rs.string(forColumn: "ConfirmationCode")!)
                                    DataStays["fkCurrencyID"] = String(describing: rs.string(forColumn: "fkCurrencyID")!)
                                    Stays[Index] = DataStays
                                    
                                    Index = Index + 1
                                }
                            } else {
                                print("select failure: \(db.lastErrorMessage())")
                            }
                            
                        }
                        
                        self.appDelegate.gtblStay = Stays
                        
                        self.tblStay = self.appDelegate.gtblStay
                        
                    }
                    
                    OperationQueue.main.addOperation() {
                            //accion base de datos
                            print(3)
                        
                            if (self.CountStay>0){

                                queueFM?.inDatabase() {
                                    db in
                                    
                                    let CountStatusTot = db.intForQuery("SELECT COUNT(*) FROM (SELECT OrderNo FROM tblStay WHERE OrderNo IN(1,2) GROUP BY OrderNo)" as String,"" as AnyObject)
                                    
                                    if (CountStatusTot == nil){
                                        resultStatusID = 0
                                    }else{
                                        if (String(describing: CountStatusTot) == ""){
                                            resultStatusID = 0
                                        }else{
                                            resultStatusID = Int32(CountStatusTot!)
                                        }
                                        
                                    }
                                    
                                }
                                
                                Index = 0
                                
                                queueFM?.inDatabase() {
                                    db in
                                    
                                    for _ in 0...resultStayID-1 {
                                        Stays.append([:])
                                    }
                                    
                                    if let rs = db.executeQuery("SELECT count(*) as CountStatus,OrderNo FROM tblStay WHERE OrderNo IN(1,2) GROUP BY OrderNo ORDER BY OrderNo DESC", withArgumentsIn: []){
                                        while rs.next() {
                                            if (Index==0){
                                                Status[0] = rs.string(forColumn: "OrderNo")!
                                                contStatus = Int(rs.int(forColumn: "CountStatus"))
                                                StaysStatus.append([])
                                                for _ in 0...contStatus-1 {
                                                    StaysStatus[0].append([:])
                                                }
                                                
                                            }else{
                                                Status.append(rs.string(forColumn: "OrderNo")!)
                                                contStatus = Int(rs.int(forColumn: "CountStatus"))
                                                StaysStatus.append([])
                                                for _ in 0...contStatus-1 {
                                                    StaysStatus[Index].append([:])
                                                }
                                                
                                            }
                                            Index = Index + 1
                                        }
                                    } else {
                                        print("select failure: \(db.lastErrorMessage())")
                                    }
                                    
                                }
                                
                                let xCountStatus = Int(resultStatusID)
                                let xCountStays = Int(resultStayID)
                                var sCount: Int = 0
                                
                                for xIndex in 0...xCountStatus-1 {
                                    sCount = 0
                                    for yIndex in 0...xCountStays-1 {
                                        if (Status[xIndex]==self.tblStay[yIndex]["OrderNo"]){
                                            StaysStatus[xIndex][sCount] = self.tblStay[yIndex]
                                            sCount = sCount + 1
                                        }
                                        
                                    }
                                    
                                }
                                
                                self.appDelegate.gStaysStatus = StaysStatus
                                self.StaysStatus = StaysStatus

                                self.iseccion = self.StaysStatus.count
                                
                            }else{
                            
                                self.iseccion = 0
                            
                            }
                        
                            self.tableView.reloadData()
                    }
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return iseccion;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StaysStatus[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch StaysStatus[section][0]["OrderNo"]!{
        case "3":
            return NSLocalizedString("OUT",comment:"")
        case "2":
            return NSLocalizedString("INHOUSE",comment:"")
        case "1":
            return NSLocalizedString("ASSIGNED",comment:"")
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0.08*height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.03*height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.03*height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title: UILabel = UILabel()
        title.backgroundColor = UIColor.clear;
        title.textAlignment = NSTextAlignment.left;
        title.textColor = UIColor.gray;
        title.font = UIFont(name:"HelveticaNeue-Light", size:appDelegate.gblFont8 + appDelegate.gblDeviceFont4)
        title.numberOfLines = 0;
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            title.textColor = colorWithHexString("ba8748")
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{

            title.textColor = colorWithHexString("00467f")
            
        }
        
        switch StaysStatus[section][0]["OrderNo"]!{
        case "3":
            title.text = NSLocalizedString("OUT",comment:"");
        case "2":
            title.text = NSLocalizedString("INHOUSE",comment:"");
        case "1":
            title.text = NSLocalizedString("ASSIGNED",comment:"");
        default:
            title.text = NSLocalizedString("ASSIGNED",comment:"");
        }
        
        return title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var strArrivalDate: String = ""
        var strDepartureDate: String = ""
        
        let ArrivalDate = moment(StaysStatus[indexPath.section][indexPath.row]["ArrivalDate"]!)
        let DepartureDate = moment(StaysStatus[indexPath.section][indexPath.row]["DepartureDate"]!)
        
        let strdateFormatter = DateFormatter()
        strdateFormatter.dateFormat = "yyyy-MM-dd";
        strArrivalDate = strdateFormatter.string(from: ArrivalDate!.date)
        strDepartureDate = strdateFormatter.string(from: DepartureDate!.date)
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "CellSelectStays")!
       
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
                imgCell = UIImage(named:"tblhdr.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblhdrSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }else if (StaysStatus[indexPath.section].count-1) == indexPath.row{
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
            
            if (StaysStatus[indexPath.section].count) == 1
            {
                imgCell = UIImage(named:"tblrowsingle.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblrowsingleSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
                
            }
            
            lastIndex = IndexPath.init()
            cell.textLabel?.textColor = colorWithHexString("ba8748")
            cell.detailTextLabel?.textColor = colorWithHexString("ba8748")
            
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
            }else if (StaysStatus[indexPath.section].count-1) == indexPath.row{
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
            
            if (StaysStatus[indexPath.section].count) == 1
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
        
        if (String(StaysStatus[indexPath.section][indexPath.row]["OrderNo"]!) == "1"){
            cell.textLabel?.text = String(StaysStatus[indexPath.section][indexPath.row]["PropertyName"]!) + " - " + String(StaysStatus[indexPath.section][indexPath.row]["ConfirmationCode"]!)
        }else{
            cell.textLabel?.text = String(StaysStatus[indexPath.section][indexPath.row]["PropertyName"]!) + " - " + String(StaysStatus[indexPath.section][indexPath.row]["UnitCode"]!)
        }
        
        cell.textLabel?.font = UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont2)
        cell.textLabel?.adjustsFontSizeToFitWidth = true;

        cell.detailTextLabel?.text = strArrivalDate + " - " + strDepartureDate
        cell.detailTextLabel?.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont2)
        
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
        
        appDelegate.strUnitStay = String(StaysStatus[indexPath.section][indexPath.row]["PropertyCode"]!) + "/" + String(StaysStatus[indexPath.section][indexPath.row]["UnitCode"]!)
        appDelegate.strUnitStayInfoID = String(StaysStatus[indexPath.section][indexPath.row]["StayInfoID"]!)
        appDelegate.strUnitCode = String(StaysStatus[indexPath.section][indexPath.row]["UnitCode"]!)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.toolbar.isHidden = true

        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Select Stays",
            AnalyticsParameterItemName: "Select Stays",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Select Stays", screenClass: appDelegate.gstrAppName)
        
    }

}
