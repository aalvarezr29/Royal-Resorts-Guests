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

class vcSelectStay: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
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
    var strMode: String = ""
    var txtTextField = UITextField()

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var ViewItem: UINavigationItem!
    @IBOutlet weak var AccView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        tableView.delegate = self
        tableView.dataSource = self
        txtTextField.delegate = self
        
        if self.strMode != "dtCheckinConf"{
            self.tabBarController?.navigationController?.navigationBar.isHidden = true;
            self.navigationController?.navigationBar.isHidden = false;
        }
        
        //Titulo de la vista
        //ViewItem.title = NSLocalizedString("lblSelectStay",comment:"");

        if self.strMode == ""{
            
            ViewItem.title = NSLocalizedString("lblSelectStay",comment:"");
            
        }else if self.strMode == "TransferReserv"{
            
            ViewItem.title = NSLocalizedString("strSelectConfirmation",comment:"");
            
        }else if self.strMode == "TransferArrivalHotel"{
            
            ViewItem.title = NSLocalizedString("strSelectArrivalHotel",comment:"");
            
        }else if self.strMode == "TransferArrivalDate"{
            
            ViewItem.title = NSLocalizedString("strSelectArrivalDate",comment:"");
            tableView.register(tvcDynamicCell.self, forCellReuseIdentifier: "tvcDynamicCell")
            
        }else if self.strMode == "TransferDepartureHotel"{
            
            ViewItem.title = NSLocalizedString("strSelectDepartureHotel",comment:"");
            
        }else if self.strMode == "TransferDepartureDate"{
            
            ViewItem.title = NSLocalizedString("strSelectDepartureDate",comment:"");
            tableView.register(tvcDynamicCell.self, forCellReuseIdentifier: "tvcDynamicCell")
            
        }else if self.strMode == "ArrivalFlight"{
            
            ViewItem.title = NSLocalizedString("strSelectArrivalAirline",comment:"");
            
        }else if self.strMode == "DepartureFlight"{
            
            ViewItem.title = NSLocalizedString("strSelectDepartureAirline",comment:"");
            
        }else if self.strMode == "ArrivalFlightHour"{
            
            ViewItem.title = NSLocalizedString("strSelectArrivalFlightHour",comment:"");
            tableView.register(tvcDynamicCell.self, forCellReuseIdentifier: "tvcDynamicCell")
            
            let timeFormatter: DateFormatter = DateFormatter()
            timeFormatter.dateFormat = "hh:mm a"
            timeFormatter.timeZone = TimeZone(identifier: "UTC")
            timeFormatter.locale = Locale(identifier: "en_US")
            timeFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            let timeStrAF = timeFormatter.string(from: appDelegate.gdtMOBAPP_TRAFROM)
            let timeStrAT = timeFormatter.string(from: appDelegate.gdtMOBAPP_TRATO)

            let lblFooter = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 0.1*height))
            lblFooter.backgroundColor = UIColor.clear;
            lblFooter.textAlignment = NSTextAlignment.left;
            lblFooter.textColor = UIColor.gray;
            lblFooter.font = UIFont(name:"HelveticaNeue-Light", size:appDelegate.gblFont10 + appDelegate.gblDeviceFont4)
            lblFooter.numberOfLines = 0;
            lblFooter.text = NSLocalizedString("strTransferHourMsj1",comment:"") + " " + timeStrAF + " " + NSLocalizedString("strTransferTo",comment:"") + " " + timeStrAT + ". " + NSLocalizedString("strTransferHourMsj2",comment:"")
            tableView.tableFooterView = lblFooter
            
        }else if self.strMode == "DepartureFlightHour"{
            
            ViewItem.title = NSLocalizedString("strSelectDepartureFlightHour",comment:"");
            tableView.register(tvcDynamicCell.self, forCellReuseIdentifier: "tvcDynamicCell")
            
            let timeFormatter: DateFormatter = DateFormatter()
            timeFormatter.dateFormat = "hh:mm a"
            timeFormatter.timeZone = TimeZone(identifier: "UTC")
            timeFormatter.locale = Locale(identifier: "en_US")
            timeFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            let timeStrDF = timeFormatter.string(from: appDelegate.gdtMOBAPP_TRDFROM)
            let timeStrDT = timeFormatter.string(from: appDelegate.gdtMOBAPP_TRDTO)
            
            let lblFooter = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 0.1*height))
            lblFooter.backgroundColor = UIColor.clear;
            lblFooter.textAlignment = NSTextAlignment.left;
            lblFooter.textColor = UIColor.gray;
            lblFooter.font = UIFont(name:"HelveticaNeue-Light", size:appDelegate.gblFont10 + appDelegate.gblDeviceFont4)
            lblFooter.numberOfLines = 0;
            lblFooter.text = NSLocalizedString("strTransferHourMsj1",comment:"") + " " + timeStrDF + " " + NSLocalizedString("strTransferTo",comment:"") + " " + timeStrDT + ". " + NSLocalizedString("strTransferHourMsj2",comment:"")
            tableView.tableFooterView = lblFooter
            
        }else if self.strMode == "ArrivalFlightCode"{
            
            ViewItem.title = NSLocalizedString("strSelectArrivalFlight",comment:"");
            
        }else if self.strMode == "DepartureFlightCode"{
            
            ViewItem.title = NSLocalizedString("strSelectDepartureFlight",comment:"");
            
        }else if self.strMode == "ArrivalFlightCodeOtro"{
            
            ViewItem.title = NSLocalizedString("strSelectArrivalFlight",comment:"");
            tableView.register(tvcDynamicCell.self, forCellReuseIdentifier: "tvcDynamicCell")
            
        }else if self.strMode == "DepartureFlightCodeOtro"{
            
            ViewItem.title = NSLocalizedString("strSelectDepartureFlight",comment:"");
            tableView.register(tvcDynamicCell.self, forCellReuseIdentifier: "tvcDynamicCell")
            
        }else if self.strMode == "dtCheckinConf"{
            
            ViewItem.title = NSLocalizedString("strSelectArrivalDate",comment:"");
            tableView.register(tvcDynamicCell.self, forCellReuseIdentifier: "tvcDynamicCell")
            
        }else if self.strMode == "Country"{
            
            ViewItem.title = "Select Country"
            
        }else{
            ViewItem.title = "";
        }
        if self.strMode != "dtCheckinConf"{
            self.navigationController?.isToolbarHidden = false;
        }
        
        if appDelegate.ynIPad {
            switch appDelegate.Model {
            case "iPad 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.8*height);
            case "iPad Air":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.8*height);
            case "iPad Air 2":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.8*height);
            case "iPad Pro":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.8*height);
            case "iPad Retina":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.8*height);
            default:

                tableView.frame = CGRect(x: 0.05*width, y: 0.05*height, width: 0.9*width, height: 0.9*height);

            }
        }else{
            switch appDelegate.Model {
            case "iPhone":
                tableView.frame = CGRect(x: 0.05*width, y: 0.143*height, width: 0.9*width, height: 0.8*height);
            case "iPhone 4":
                tableView.frame = CGRect(x: 0.05*width, y: 0.143*height, width: 0.9*width, height: 0.8*height);
            case "iPhone 4s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.143*height, width: 0.9*width, height: 0.8*height);
            case "iPhone 5":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.8*height);
            case "iPhone 5c":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.8*height);
            case "iPhone 5s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.8*height);
            case "iPhone 6":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.8*height);
            case "iPhone 6 Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.8*height);
            case "iPhone 6s":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.8*height);
            case "iPhone 6s Plus":
                tableView.frame = CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.8*height);
            default:

                tableView.frame = CGRect(x: 0.05*width, y: 0.05*height, width: 0.9*width, height: 0.9*height);

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
                    
                    var resultCount: Int32 = 0
                    
                    if self.strMode == ""{
                        resultCount = db.intForQuery("SELECT COUNT(*) FROM tblStay WHERE OrderNo IN(1,2)" as String,"" as AnyObject)
                    } else if self.strMode == "TransferReserv"{
                        resultCount = db.intForQuery("SELECT COUNT(ConfirmationCode) FROM tblStay GROUP BY ConfirmationCode" as String,"" as AnyObject)
                    }

                    if (resultCount == nil){
                        resultStayID = 0
                    }else{
                        if (String(describing: resultCount) == ""){
                            resultStayID = 0
                        }else{
                            resultStayID = resultCount
                        }
                        
                    }
                    
                }
                
                self.CountStay = resultStayID
                if self.strMode == "TransferArrivalHotel"{
                     
                    self.CountStay = Int32(self.appDelegate.gtblhotel.count)

                } else if self.strMode == "TransferDepartureHotel"{

                    self.CountStay = Int32(self.appDelegate.gtblhotel.count)

                } else if self.strMode == "ArrivalFlight"{

                    self.CountStay = Int32(self.appDelegate.gtblAerolinea.count)

                } else if self.strMode == "DepartureFlight"{

                    self.CountStay = Int32(self.appDelegate.gtblAerolinea.count)

                } else if self.strMode == "ArrivalFlightCode"{

                    self.CountStay = Int32(self.appDelegate.gtblFlight.count)

                } else if self.strMode == "DepartureFlightCode"{

                    self.CountStay = Int32(self.appDelegate.gtblFlight.count)

                }else if self.strMode == "Country"{
                    
                   self.CountStay = Int32(self.appDelegate.gtblCountry.count)
                    
                }
            }
            
            OperationQueue.main.addOperation() {
                queue.addOperation() {//2
                    //accion base de datos
                    //print(2)
                    
                    if (self.CountStay>0){
                        
                        queueFM?.inDatabase() {
                            db in
                            

                            if self.strMode == ""{
                                
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
                                        DataStays["PlaceCode"] = String(describing: rs.string(forColumn: "PlaceCode")!)
                                        DataStays["fkPropertyID"] = String(describing: rs.string(forColumn: "fkPropertyID")!)
                                        Stays[Index] = DataStays
                                        
                                        Index = Index + 1
                                    }
                            } else {
                                print("select failure: \(db.lastErrorMessage())")
                            }
                            
                        } else if self.strMode == "TransferReserv"{
                                Index = 0
                                
                                Stays = []
                                
                                if let rs = db.executeQuery("SELECT ConfirmationCode FROM tblStay GROUP BY ConfirmationCode", withArgumentsIn: []){
                                while rs.next() {
                                    DataStays["ConfirmationCode"] = String(describing: rs.string(forColumn: "ConfirmationCode")!)
                                    Stays.append(DataStays)
                                    
                                    Index = Index + 1
                                }
                            }
                        }
                            
                        self.appDelegate.gtblStay = Stays
                        
                        self.tblStay = self.appDelegate.gtblStay
                        
                    }
                    
                    OperationQueue.main.addOperation() {
                            //accion base de datos
                            print(3)
                        if self.strMode == ""{
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
                        } else if self.strMode == "TransferReserv"{
                            if (self.CountStay>0){
                                self.iseccion = self.tblStay.count
                            }else{
                                self.iseccion = 0
                            }
                            
                        } else if self.strMode == "TransferArrivalHotel"{

                            self.iseccion = self.appDelegate.gtblhotel.count

                        } else if self.strMode == "TransferDepartureHotel"{

                            self.iseccion = self.appDelegate.gtblhotel.count

                        } else if self.strMode == "ArrivalFlight"{

                            self.iseccion = self.appDelegate.gtblAerolinea.count

                       } else if self.strMode == "DepartureFlight"{

                            self.iseccion = self.appDelegate.gtblAerolinea.count

                       } else if self.strMode == "ArrivalFlightCode"{

                            self.iseccion = self.appDelegate.gtblFlight.count

                       } else if self.strMode == "DepartureFlightCode"{

                            self.iseccion = self.appDelegate.gtblFlight.count

                       }else if self.strMode == "Country"{

                           self.iseccion = self.appDelegate.gtblCountry.count
                            
                       }

                        self.tableView.reloadData()
                    }
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
        if self.strMode == ""{
            
            return iseccion;
            
        }else if self.strMode == "TransferReserv"{
            
            return 1;
            
        }else if self.strMode == "TransferArrivalHotel"{
            
            return 1;
            
        }else if self.strMode == "TransferArrivalDate"{
            
            return 1;
            
        }else if self.strMode == "TransferDepartureHotel"{
            
            return 1;
            
        }else if self.strMode == "TransferDepartureDate"{
            
            return 1;
            
        }else if self.strMode == "ArrivalFlight"{
            
            return 1;
            
        }else if self.strMode == "DepartureFlight"{
            
            return 1;
            
        }else if self.strMode == "ArrivalFlightHour"{
            
            return 1;
            
        }else if self.strMode == "DepartureFlightHour"{
            
            return 1;
            
        }else if self.strMode == "ArrivalFlightCode"{
            
            return 1;
            
        }else if self.strMode == "DepartureFlightCode"{
            
            return 1;
            
        }else if self.strMode == "ArrivalFlightCodeOtro"{
            
            return 1;
            
        }else if self.strMode == "DepartureFlightCodeOtro"{
            
            return 1;
            
        }else if self.strMode == "dtCheckinConf"{
            
            return 1;
            
        }else if self.strMode == "Country"{

            return 1;
             
        }else{
            return 0;
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.strMode == ""{
            
            return StaysStatus[section].count
            
        }else if self.strMode == "TransferReserv"{
            
            return iseccion;
            
        }else if self.strMode == "TransferArrivalHotel"{
                   
            return iseccion;
                   
        }else if self.strMode == "TransferArrivalDate"{
            
            return 1;
            
        }else if self.strMode == "TransferDepartureHotel"{
            
            return iseccion;
            
        }else if self.strMode == "TransferDepartureDate"{
            
            return 1;
            
        }else if self.strMode == "ArrivalFlight"{
            
            return iseccion;
            
        }else if self.strMode == "DepartureFlight"{
            
            return iseccion;
            
        }else if self.strMode == "ArrivalFlightHour"{
            
            return 1;
            
        }else if self.strMode == "DepartureFlightHour"{
            
            return 1;
            
        }else if self.strMode == "ArrivalFlightCode"{
            
            return iseccion;
            
        }else if self.strMode == "DepartureFlightCode"{
            
            return iseccion;
            
        }else if self.strMode == "ArrivalFlightCodeOtro"{
            
            return 1;
            
        }else if self.strMode == "DepartureFlightCodeOtro"{
            
            return 1;
            
        }else if self.strMode == "dtCheckinConf"{
            
            return 1;
            
        }else if self.strMode == "Country"{

            return iseccion;
             
        }else{
            return 0;
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.strMode == ""{
            
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
            
        }else if self.strMode == "TransferReserv"{
            
            return ""
            
        }else if self.strMode == "TransferArrivalHotel"{
                   
            return ""
                   
        }else if self.strMode == "TransferArrivalDate"{
            
            return ""
            
        }else if self.strMode == "TransferDepartureHotel"{
            
            return ""
            
        }else if self.strMode == "TransferDepartureDate"{
            
            return ""
            
        }else if self.strMode == "ArrivalFlight"{
            
            return ""
            
        }else if self.strMode == "DepartureFlight"{
            
            return ""
            
        }else if self.strMode == "ArrivalFlightHour"{
            
            return ""
            
        }else if self.strMode == "DepartureFlightHour"{
            
            return ""
            
        }else if self.strMode == "ArrivalFlightCode"{
            
            return ""
            
        }else if self.strMode == "DepartureFlightCode"{
            
            return ""
            
        }else if self.strMode == "ArrivalFlightCodeOtro"{
            
            return ""
            
        }else if self.strMode == "DepartureFlightCodeOtro"{
            
            return ""
            
        }else if self.strMode == "dtCheckinConf"{
            
            return ""
            
        }else if self.strMode == "Country"{

            return ""
             
        }else{
            return ""
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.strMode == ""{
            
            return 0.08*height
            
        }else if self.strMode == "TransferReserv"{
            
            return 0.08*height
            
        }else if self.strMode == "TransferArrivalHotel"{
                   
            return 0.08*height
                   
        }else if self.strMode == "TransferArrivalDate"{
            
            return 0.12*height
            
        }else if self.strMode == "TransferDepartureHotel"{
            
            return 0.08*height
            
        }else if self.strMode == "TransferDepartureDate"{
            
            return 0.12*height
            
        }else if self.strMode == "ArrivalFlight"{
            
            return 0.08*height
            
        }else if self.strMode == "DepartureFlight"{
            
            return 0.08*height
            
        }else if self.strMode == "ArrivalFlightHour"{
            
            return 0.12*height
            
        }else if self.strMode == "DepartureFlightHour"{
            
            return 0.12*height
            
        }else if self.strMode == "ArrivalFlightCode"{
            
            return 0.08*height
            
        }else if self.strMode == "DepartureFlightCode"{
            
            return 0.08*height
            
        }else if self.strMode == "ArrivalFlightCodeOtro"{
            
            return 0.08*height
            
        }else if self.strMode == "DepartureFlightCodeOtro"{
            
            return 0.08*height
            
        }else if self.strMode == "dtCheckinConf"{
            
            return 0.12*height
            
        }else if self.strMode == "Country"{

            return 0.08*height
             
        }else{
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.03*height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.03*height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var title: UILabel = UILabel()
        
        if self.strMode == ""{

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
            
        }else if self.strMode == "TransferReserv"{
            
            return title
            
        }else if self.strMode == "TransferArrivalHotel"{
                   
            return title
                   
        }else if self.strMode == "TransferArrivalDate"{
            
            return title
            
        }else if self.strMode == "TransferDepartureHotel"{
            
            return title
            
        }else if self.strMode == "TransferDepartureDate"{
            
            return title
            
        }else if self.strMode == "ArrivalFlight"{
            
            return title
            
        }else if self.strMode == "DepartureFlight"{
            
            return title
            
        }else if self.strMode == "ArrivalFlightHour"{
            
            return title
            
        }else if self.strMode == "DepartureFlightHour"{
            
            return title
            
        }else if self.strMode == "ArrivalFlightCode"{
            
            return title
            
        }else if self.strMode == "DepartureFlightCode"{
            
            return title
            
        }else if self.strMode == "ArrivalFlightCodeOtro"{
            
            return title
            
        }else if self.strMode == "DepartureFlightCodeOtro"{
            
            return title
            
        }else if self.strMode == "dtCheckinConf"{
            
            return title
            
        }else if self.strMode == "Country"{

            return title
             
        }else{
            return title
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        var strArrivalDate: String = ""
        var strDepartureDate: String = ""
        
        if self.strMode == ""{
            
            let ArrivalDate = moment(StaysStatus[indexPath.section][indexPath.row]["ArrivalDate"]!)
            let DepartureDate = moment(StaysStatus[indexPath.section][indexPath.row]["DepartureDate"]!)
            
            let strdateFormatter = DateFormatter()
            strdateFormatter.dateFormat = "yyyy-MM-dd";
            strArrivalDate = strdateFormatter.string(from: ArrivalDate!.date)
            strDepartureDate = strdateFormatter.string(from: DepartureDate!.date)
            
        }else if self.strMode == "TransferReserv"{
            
            
            
        }else if self.strMode == "TransferArrivalHotel"{
            
            
            
        }else if self.strMode == "TransferDepartureHotel"{
            
            
            
        }else if self.strMode == "TransferDepartureDate"{
            
            
            
        }else if self.strMode == "ArrivalFlight"{
            
            
            
        }else if self.strMode == "DepartureFlight"{
            
            
            
        }else if self.strMode == "ArrivalFlightHour"{
            
            
            
        }else if self.strMode == "DepartureFlightHour"{
            
            
            
        }else if self.strMode == "ArrivalFlightCode"{
            
            
            
        }else if self.strMode == "DepartureFlightCode"{
            
            
            
        }else if self.strMode == "ArrivalFlightCodeOtro"{
            
            
            
        }else if self.strMode == "DepartureFlightCodeOtro"{
            
            
            
        }else if self.strMode == "Country"{

             
        }else{
           
        }

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
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{

            cell.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("004c50"))
            
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.layer.borderWidth = 1
            cell.layer.shadowOffset = CGSize(width: -1, height: 1)
            cell.layer.borderColor = UIColor.black.cgColor
            
            lastIndex = IndexPath.init()
            cell.textLabel?.textColor = colorWithHexString("2e3634")
            cell.detailTextLabel?.textColor = colorWithHexString("2e3634")
            
        }
        
        cell.textLabel?.font = UIFont(name:"Helvetica", size:appDelegate.gblFont7 + appDelegate.gblDeviceFont2)
        cell.textLabel?.adjustsFontSizeToFitWidth = true;
        
        if self.strMode == ""{
            
            if (String(StaysStatus[indexPath.section][indexPath.row]["OrderNo"]!) == "1"){
                cell.textLabel?.text = String(StaysStatus[indexPath.section][indexPath.row]["PropertyName"]!) + " - " + String(StaysStatus[indexPath.section][indexPath.row]["ConfirmationCode"]!)
            }else{
                cell.textLabel?.text = String(StaysStatus[indexPath.section][indexPath.row]["PropertyName"]!) + " - " + String(StaysStatus[indexPath.section][indexPath.row]["UnitCode"]!)
            }
            cell.detailTextLabel?.text = strArrivalDate + " - " + strDepartureDate
            cell.detailTextLabel?.font = UIFont(name:"Helvetica", size:appDelegate.gblFont4 + appDelegate.gblDeviceFont2)
        }else if self.strMode == "TransferReserv"{
            
            cell.textLabel?.text = String(tblStay[indexPath.row]["ConfirmationCode"]!)
            cell.detailTextLabel?.text = ""
            
        }else if self.strMode == "TransferArrivalHotel"{
            
            cell.textLabel?.text = String(self.appDelegate.gtblhotel[indexPath.row]["sHotelName"]!)
            cell.detailTextLabel?.text = ""
            
        }else if self.strMode == "TransferArrivalDate"{
            
            if self.appDelegate.gstrArrivalTransferAux == ""{
                self.appDelegate.gstrArrivalTransferAux = self.appDelegate.gstrArrivalTransfer
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tvcDynamicCell", for: indexPath) as! tvcDynamicCell
            cell.SetValues("TransferArrivalDate", dtDate: self.appDelegate.gstrArrivalTransferAux, txtTextField: txtTextField, width: width, height: height)
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        }else if self.strMode == "TransferDepartureHotel"{
            
            cell.textLabel?.text = String(self.appDelegate.gtblhotel[indexPath.row]["sHotelName"]!)
            cell.detailTextLabel?.text = ""

        }else if self.strMode == "TransferDepartureDate"{
            
            if self.appDelegate.gstrDepartureTransferAux == ""{
                self.appDelegate.gstrDepartureTransferAux = self.appDelegate.gstrDepartureTransfer
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tvcDynamicCell", for: indexPath) as! tvcDynamicCell
            cell.SetValues("TransferDepartureDate", dtDate: self.appDelegate.gstrDepartureTransferAux, txtTextField: txtTextField, width: width, height: height)
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        }else if self.strMode == "ArrivalFlight"{
            
            cell.textLabel?.text = String(self.appDelegate.gtblAerolinea[indexPath.row]["OperatorName"]!)
            cell.detailTextLabel?.text = ""
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            
        }else if self.strMode == "DepartureFlight"{
            
            cell.textLabel?.text = String(self.appDelegate.gtblAerolinea[indexPath.row]["OperatorName"]!)
            cell.detailTextLabel?.text = ""
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            
        }else if self.strMode == "ArrivalFlightHour"{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tvcDynamicCell", for: indexPath) as! tvcDynamicCell
            cell.SetValues("ArrivalFlightHour", dtDate: self.appDelegate.gstrArrivalTransfer, txtTextField: txtTextField, width: width, height: height)
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        }else if self.strMode == "DepartureFlightHour"{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tvcDynamicCell", for: indexPath) as! tvcDynamicCell
            cell.SetValues("DepartureFlightHour", dtDate: self.appDelegate.gstrDepartureTransfer, txtTextField: txtTextField, width: width, height: height)
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        }else if self.strMode == "ArrivalFlightCode"{
            
            cell.textLabel?.text = String(self.appDelegate.gtblFlight[indexPath.row]["FlightCode"]!)
            cell.detailTextLabel?.text = ""
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            
        }else if self.strMode == "DepartureFlightCode"{
            
            cell.textLabel?.text = String(self.appDelegate.gtblFlight[indexPath.row]["FlightCode"]!)
            cell.detailTextLabel?.text = ""
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            
        }else if self.strMode == "ArrivalFlightCodeOtro"{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tvcDynamicCell", for: indexPath) as! tvcDynamicCell
            cell.SetValues("ArrivalFlightCodeOtro", dtDate: "", txtTextField: txtTextField, width: width, height: height)
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        }else if self.strMode == "DepartureFlightCodeOtro"{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tvcDynamicCell", for: indexPath) as! tvcDynamicCell
            cell.SetValues("DepartureFlightCodeOtro", dtDate: "", txtTextField: txtTextField, width: width, height: height)
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        }else if self.strMode == "dtCheckinConf"{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tvcDynamicCell", for: indexPath) as! tvcDynamicCell
            cell.SetValues("dtCheckinConf", dtDate: self.appDelegate.gstrCheckin, txtTextField: txtTextField, width: width, height: height)
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            
        }else if self.strMode == "Country"{

            cell.textLabel?.text = String(self.appDelegate.gtblCountry[indexPath.row]["Description"]!)
            cell.detailTextLabel?.text = ""
             
        }else{
           
        }

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
        if self.strMode == ""{
        appDelegate.strUnitStay = String(StaysStatus[indexPath.section][indexPath.row]["PropertyCode"]!) + "/" + String(StaysStatus[indexPath.section][indexPath.row]["UnitCode"]!)
        appDelegate.strUnitStayInfoID = String(StaysStatus[indexPath.section][indexPath.row]["StayInfoID"]!)
        appDelegate.strUnitCode = String(StaysStatus[indexPath.section][indexPath.row]["UnitCode"]!)
        appDelegate.strStayInfoStatus = String(StaysStatus[indexPath.section][indexPath.row]["StatusCode"]!)
        appDelegate.strUnitArrivalDate = String(StaysStatus[indexPath.section][indexPath.row]["ArrivalDate"]!)
        appDelegate.strUnitPropertyID = String(StaysStatus[indexPath.section][indexPath.row]["fkPropertyID"]!)
        self.navigationController?.popViewController(animated: true)
        }else if self.strMode == "TransferReserv"{
            
            self.appDelegate.gstrConfirmationCodeTransferAux = String(tblStay[indexPath.row]["ConfirmationCode"]!)
            self.navigationController?.popViewController(animated: true)
            
        }else if self.strMode == "TransferArrivalHotel"{
            
            self.appDelegate.gstrHotelCodeAux = String(self.appDelegate.gtblhotel[indexPath.row]["sHotelCode"]!)
            self.appDelegate.gstrHotelNameAux = String(self.appDelegate.gtblhotel[indexPath.row]["sHotelName"]!)
            self.appDelegate.strArrivalHotelIDAux = String(self.appDelegate.gtblhotel[indexPath.row]["pkHotelID"]!)
            
            if self.appDelegate.gItemClassCode == "ONEWAY"{
                self.appDelegate.gstrDepHotelCodeAux = String(self.appDelegate.gtblhotel[indexPath.row]["sHotelCode"]!)
                self.appDelegate.gstrDepHotelNameAux = String(self.appDelegate.gtblhotel[indexPath.row]["sHotelName"]!)
                self.appDelegate.strDepartureHotelIDAux = String(self.appDelegate.gtblhotel[indexPath.row]["pkHotelID"]!)
            }
            
            self.navigationController?.popViewController(animated: true)

        }else if self.strMode == "TransferArrivalDate"{
            
            self.navigationController?.popViewController(animated: true)
            
        }else if self.strMode == "TransferDepartureHotel"{
            
            self.appDelegate.gstrDepHotelCodeAux = String(self.appDelegate.gtblhotel[indexPath.row]["sHotelCode"]!)
            self.appDelegate.gstrDepHotelNameAux = String(self.appDelegate.gtblhotel[indexPath.row]["sHotelName"]!)
            self.appDelegate.strDepartureHotelIDAux = String(self.appDelegate.gtblhotel[indexPath.row]["pkHotelID"]!)
            self.navigationController?.popViewController(animated: true)
            
        }else if self.strMode == "TransferDepartureDate"{
            
            self.navigationController?.popViewController(animated: true)
            
        }else if self.strMode == "ArrivalFlight"{
            
            self.appDelegate.ynCargaFlightArr = true
            self.appDelegate.gstrOperatorNameArrival = String(self.appDelegate.gtblAerolinea[indexPath.row]["OperatorName"]!)
            self.appDelegate.gstrOperatorNameCodeArrival = String(self.appDelegate.gtblAerolinea[indexPath.row]["OperatorCode"]!)
            self.appDelegate.iArrOperator = String(self.appDelegate.gtblAerolinea[indexPath.row]["pkOperatorID"]!)
            self.navigationController?.popViewController(animated: true)
            
        }else if self.strMode == "DepartureFlight"{
            
            self.appDelegate.ynCargaFlightDep = true
            self.appDelegate.gstrOperatorNameDeparture = String(self.appDelegate.gtblAerolinea[indexPath.row]["OperatorName"]!)
            self.appDelegate.gstrOperatorNameCodeDeparture = String(self.appDelegate.gtblAerolinea[indexPath.row]["OperatorCode"]!)
            self.appDelegate.iDepOperator = String(self.appDelegate.gtblAerolinea[indexPath.row]["pkOperatorID"]!)
            self.navigationController?.popViewController(animated: true)
            
        }else if self.strMode == "ArrivalFlightHour"{
            
            self.navigationController?.popViewController(animated: true)
            
        }else if self.strMode == "DepartureFlightHour"{
            
            self.navigationController?.popViewController(animated: true)
            
        }else if self.strMode == "ArrivalFlightCode"{
            
            if String(self.appDelegate.gtblFlight[indexPath.row]["FlightCode"]!) == NSLocalizedString("strOther",comment:""){
                
                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectStay") as! vcSelectStay
                tercerViewController.strMode = "ArrivalFlightCodeOtro"
                self.navigationController?.pushViewController(tercerViewController, animated: true)
                
            }else{
                self.appDelegate.strArrivalFlightCode = String(self.appDelegate.gtblFlight[indexPath.row]["FlightCode"]!)
                self.navigationController?.popViewController(animated: true)
            }
            
        }else if self.strMode == "DepartureFlightCode"{
            
            if String(self.appDelegate.gtblFlight[indexPath.row]["FlightCode"]!) == NSLocalizedString("strOther",comment:""){
                
                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectStay") as! vcSelectStay
                tercerViewController.strMode = "DepartureFlightCodeOtro"
                self.navigationController?.pushViewController(tercerViewController, animated: true)
                
            }else{
                self.appDelegate.strDepartureFlightCode = String(self.appDelegate.gtblFlight[indexPath.row]["FlightCode"]!)
                self.navigationController?.popViewController(animated: true)
            }
 
        }else if self.strMode == "ArrivalFlightCodeOtro"{
            
            self.appDelegate.strArrivalFlightCode = self.appDelegate.gstrOperatorNameCodeArrival + " " + txtTextField.text!
            let NextViewController = self.navigationController?.viewControllers[3]
            self.navigationController?.popToViewController(NextViewController!, animated: false)
            //self.navigationController?.popViewController(animated: true)
            
        }else if self.strMode == "DepartureFlightCodeOtro"{
            
            self.appDelegate.strDepartureFlightCode = self.appDelegate.gstrOperatorNameCodeDeparture + " " + txtTextField.text!
            let NextViewController = self.navigationController?.viewControllers[3]
            self.navigationController?.popToViewController(NextViewController!, animated: false)
            //self.navigationController?.popViewController(animated: true)
            
        }else if self.strMode == "dtCheckinConf"{
            
            let NextViewController = self.navigationController?.viewControllers[2]
            self.navigationController?.popToViewController(NextViewController!, animated: false)
            
        }else if self.strMode == "Country"{
            
            self.appDelegate.gstrCountry = String(self.appDelegate.gtblCountry[indexPath.row]["Description"]!)
            self.appDelegate.gstrISOCountryCode = String(self.appDelegate.gtblCountry[indexPath.row]["ISOCode"]!)
            self.navigationController?.popViewController(animated: true)
            
        }else{
           
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if self.strMode != "dtCheckinConf"{
            self.navigationController?.toolbar.isHidden = true
        }

        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Select Stays",
            AnalyticsParameterItemName: "Select Stays",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Select Stays", screenClass: appDelegate.gstrAppName)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var result = true
        var ireturn: Int = 11
        
        if textField == txtTextField {

            let newLength = textField.text!.utf16.count + string.utf16.count - range.length
            result = (newLength <= ireturn)
            
            if string.characters.count > 0 && (result == true) {
                let disallowedCharacterSet = CharacterSet(charactersIn: "0123456789").inverted
                let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }
            
        }

        return result
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
