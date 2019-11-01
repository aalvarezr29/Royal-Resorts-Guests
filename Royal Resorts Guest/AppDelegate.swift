//

//  AppDelegate.swift

//  Royal Resorts Guest

//

//  Created by Marco Cocom on 11/18/14.

//  Copyright (c) 2014 Marco Cocom. All rights reserved.

//



import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate{
    /*------------------*/
    
    /*VARIABLES GLOBALES*/
    
    /*------------------*/
    
    let gcmMessageIDKey = "gcm.message_id"
    
    //Variables para controlar las dimensiones de la pantalla.
    var window: UIWindow? //panel principal del dispositivo
    var width: CGFloat = 0.0 //ancho maximo del dispositivo
    var height: CGFloat = 0.0 //altura maxima del dispositivo
    var Device: String = ""
    var Model: String = ""

    //Variables para uso en transiciones de pantalla
    var gstrRequestEmail: String = ""
    var gstrLoginPeopleID: String = ""
    var gblGoHome: Bool = false
    var gblGoOut: Bool = false
    var gblPay: Bool = false
    var gblCheckOUT: Bool = false
    var ynHome: Bool = false
    var NewPeople: Bool = false
    var gblGoNotification: Bool = false
    var gblGoMessage: Bool = false
    var strStayInfoIDCheckOut: String = ""
    var strAccCodeCheckOut: String = ""
    var strArrivalDateCheckOut: String = ""
    var strDepartureDateCheckOut: String = ""
    var strLoginMail: String = ""
    var strLenguaje: String = ""
    var gblCheckOutVw: Bool = false
    var glbPreCheck: Bool = false
    var glbPreCheckSave: Bool = false
    var glbTokenDevice: Data!
    var ParseAppKey: String = ""
    var ParseClientKey: String = ""
    var ParseRestKey: String = ""
    var ParseMasterKey: String = ""
    var tblPushMessage: [String]!
    var CountParseBadge: Int = 0;
    var gblNotification: Bool = false;
    var gblynPreAuth: Bool = false;
    var gblExitPreAuth: Bool = false;
    var gblynResortCredit: Bool = false
    var gstrPrimaryPeopleID: String = ""
    var ynLoadParse: Bool = false
    var gstrLoginFDESKPeopleID: String = ""
    var gblGoStays: Bool = false
    var ynTabsEnabled: Bool = true
    var strUnitStay: String = ""
    var strUnitStayInfoID: String = ""
    var strStayInfoStatus: String = ""
    var strUnitCode: String = ""
    var strUnitArrivalDate: String = ""
    var strFollowUpTypeID: String = ""
    var strDescriptionForExternal: String = ""
    var gblAddFollow: Bool = false
    var strPeopleType: String = ""
    var iCountStayF: Int = 0
    var ynIPad: Bool = true
    var gstrPrimaryPeopleFdeskID: String = ""
    var strBundleIdentifier: String = ""
    var iVersion: Double = 0
    var RestStayInfoID: Int = 0
    var pkRestaurantID: Int = 0
    var strRestUnit: String = ""
    var strPeopleName: String = ""
    var RestCountPeople: Int = 0
    var strRestUnitReserv: String = ""
    var strRestAccCode: String = ""
    var strPeopleLastName: String = ""
    var gblGoRestReserv: Bool = false
    //Configuracion de estilos
    var strDataBaseByStay: String = ""
    var urlHome: String = ""
    var gstrNavImg: String = ""
    var gstrBorderColorImg: String = ""
    var urlActiv: String = ""
    var strRestStayInfoID: String = ""
    var strCheckOutTime: String = ""
    var strCheckOutDate: String = ""
    var strCheckOutTimeAux: String = ""
    var strCheckOutDateAux: String = ""
    
    //Variables de configuracion
    var URLService: NSString = ""
    var URLServiceLogin: NSString = ""
    var Host: NSString = ""
    var HostLogin: NSString = ""
    
    var gstrAppName: String = ""
    
    var gblDeviceFont: CGFloat = 0.0
    var gblDeviceFont1: CGFloat = 0.0
    var gblDeviceFont2: CGFloat = 0.0
    var gblDeviceFont3: CGFloat = 0.0
    var gblDeviceFont4: CGFloat = 0.0
    var gblDeviceFont5: CGFloat = 0.0
    var gblDeviceFont6: CGFloat = 0.0
    var gblDeviceFont7: CGFloat = 0.0
    var gblDeviceFont8: CGFloat = 0.0
    var gblDeviceFont9: CGFloat = 0.0
    var gblDeviceFont10: CGFloat = 0.0
    
    var gblFont0: CGFloat = 0.0
    var gblFont: CGFloat = 0.0
    var gblFont1: CGFloat = 0.0
    var gblFont2: CGFloat = 0.0
    var gblFont3: CGFloat = 0.0
    var gblFont4: CGFloat = 0.0
    var gblFont5: CGFloat = 0.0
    var gblFont6: CGFloat = 0.0
    var gblFont7: CGFloat = 0.0
    var gblFont8: CGFloat = 0.0
    var gblFont9: CGFloat = 0.0
    var gblFont10: CGFloat = 0.0
    var gblFont11: CGFloat = 0.0
    
    var UserName: String = "cqsCMUTp8V8wld6dDBoBTw=="
    var Password: String = "Rhw267Y5Pfkk1SOtnGpwZA=="
    var AppAmb: Int = 1
    
    //Arreglos
    var gtblLogin: Dictionary<String, String>! //tabla de Login
    var gtblStay: [Dictionary<String, String>]! //tabla de Stays
    var gStaysStatus: [[Dictionary<String, String>]]! //tabla de agrupado de stays
    var gArrPeopleChannels: NSArray!
    var gtblAccPreAuth: [Dictionary<String, String>]! //tabla de PreAuth
    var gtblFollowUp: [Dictionary<String, String>]! //tabla de FollowUp
    var gtblFollowUpType: [Dictionary<String, String>]!
    var gtblPeople: Dictionary<String, String>! //tabla de People
    
    var gstrToken: String = ""
    var gstrMessageID: String = ""
    var gblPromoAI: Bool = false
    var gblynResortCredits: Bool = false
    var gblResCredMax: Double = 0.0
    var gblResCredAmount: Double = 0.0
    var gblynResCredApply: String = ""
    var gblStayInfoCatProductID: String = ""
    var gblChargesApplied: Double = 0.0
    var gblRRRewards: Double = 0.0
    var RewardPerDollar: Double = 0
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.width = CGFloat(self.window!.bounds.size.width) //Se obtiene el ancho del dispositivo
        self.height = CGFloat(self.window!.bounds.size.height) //Se obtiene el alto del dispositivo
        
        let bundleID = Bundle.main.bundleIdentifier
        
        if let text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            iVersion = Double(text)!
        }
        
        strBundleIdentifier = bundleID!
        
        //strBundleIdentifier = "com.royalresortscaribbean.guestservices"
        //strBundleIdentifier = "com.royalresorts.guestservices"
        //strBundleIdentifier = "com.royalresorts.guestservicesgrm"
        
        if strBundleIdentifier == "com.royalresorts.guestservices"{
            
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            gstrAppName = "APPSTAY"
            strDataBaseByStay = "FDESK_CANCUN"
            //urlHome = "http://royalresorts.mobi/guest-services/"
            //urlActiv = "http://royalresorts.mobi/guest-services/activities.html"
            urlHome = "https://www.royalresorts.com/guest-services-app/"
            urlActiv = "https://www.royalresorts.com/guest-services-app/activities.html"
            //gstrNavImg = "NavigationBar.png"
            
            switch AppAmb {
            case 1:
                URLService = "http://wdev.rrgapps.com/MobileService/MobileService.asmx"
                URLServiceLogin = "http://wdev.rrgapps.com/MobileService/MobileService.asmx"
                Host = "wdev.rrgapps.com"
                HostLogin = "wdev.rrgapps.com"
            case 2:
                URLService = "http://wqas.royalresorts.com/mobileservice/mobileservice.asmx"
                URLServiceLogin = "http://wqas.royalresorts.com/mobileservice/mobileservice.asmx"
                Host = "wqas.royalresorts.com"
                HostLogin = "wqas.royalresorts.com"
            case 3:
                URLService = "http://wqasweb.royalresorts.com/mobileservice/mobileservice.asmx"
                URLServiceLogin = "http://wqasweb.royalresorts.com/mobileservice/mobileservice.asmx"
                Host = "wqasweb.royalresorts.com"
                HostLogin = "wqasweb.royalresorts.com"
            case 4:
                URLService = "https://wprdinternet.servicesrr.com:444/mobileservice/MobileService.asmx"
                URLServiceLogin = "https://wprdinternet.servicesrr.com:444/mobileservice/MobileService.asmx"
                Host = "wprdinternet.servicesrr.com"
                HostLogin = "wprdinternet.servicesrr.com"
            default:
                URLService = "https://wdev.rrgapps.com/MobileService/MobileService.asmx"
                URLServiceLogin = "https://wdev.rrgapps.com/MobileService/MobileService.asmx"
                Host = "wdev.rrgapps.com"
                HostLogin = "wdev.rrgapps.com"
            }

            
        }else if strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            UIApplication.shared.statusBarStyle = .lightContent
            gstrAppName = "APPSTAYGRM"
            strDataBaseByStay = "FDESK_CANCUN"
            urlHome = "http://grandresidencesbyroyalresorts.com/guest-services/intro.html"
            urlActiv = "http://grandresidencesbyroyalresorts.com/guest-services/activities.html"
            gstrNavImg = "navBar.png"
            
            switch AppAmb {
            case 1:
                URLService = "https://wdev.rrgapps.com/MobileService/MobileService.asmx"
                URLServiceLogin = "https://wdev.rrgapps.com/MobileService/MobileService.asmx"
                Host = "wdev.rrgapps.com"
                HostLogin = "wdev.rrgapps.com"
            case 2:
                URLService = "http://wqas.royalresorts.com/mobileservice/mobileservice.asmx"
                URLServiceLogin = "http://wqas.royalresorts.com/mobileservice/mobileservice.asmx"
                Host = "wqas.royalresorts.com"
                HostLogin = "wqas.royalresorts.com"
            case 3:
                URLService = "http://wqasweb.royalresorts.com/mobileservice/mobileservice.asmx"
                URLServiceLogin = "http://wqasweb.royalresorts.com/mobileservice/mobileservice.asmx"
                Host = "wqasweb.royalresorts.com"
                HostLogin = "wqasweb.royalresorts.com"
            case 4:
                URLService = "https://wprdinternet.servicesrr.com:444/mobileservice/MobileService.asmx"
                URLServiceLogin = "https://wprdinternet.servicesrr.com:444/mobileservice/MobileService.asmx"
                Host = "wprdinternet.servicesrr.com"
                HostLogin = "wprdinternet.servicesrr.com"
            default:
                URLService = "https://wdev.rrgapps.com/MobileService/MobileService.asmx"
                URLServiceLogin = "https://wdev.rrgapps.com/MobileService/MobileService.asmx"
                Host = "wdev.rrgapps.com"
                HostLogin = "wdev.rrgapps.com"
            }
            
        }else if strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            UIApplication.shared.statusBarStyle = .lightContent
            gstrAppName = "APPSTAYSBR"
            strDataBaseByStay = "FDESK_PELICAN"
            urlHome = "http://www.simpsonbayresort.com/webapptest/"
            urlActiv = "http://grandresidencesbyroyalresorts.com/guest-services/activities.html"
            gstrNavImg = "navBar.png"
            
            switch AppAmb {
            case 1:
                URLService = "http://wdev.rrgapps.com/MobileService/MobileService.asmx"
                URLServiceLogin = "http://wdev.rrgapps.com/MobileService/MobileService.asmx"
                Host = "wdev.rrgapps.com"
                HostLogin = "wdev.rrgapps.com"
            case 2:
                URLService = "http://wqas.royalresorts.com/mobileservice/mobileservice.asmx"
                URLServiceLogin = "http://wqas.royalresorts.com/mobileservice/mobileservice.asmx"
                Host = "wqas.royalresorts.com"
                HostLogin = "wqas.royalresorts.com"
            case 3:
                URLService = "http://wqasweb.royalresorts.com/mobileservice/mobileservice.asmx"
                URLServiceLogin = "http://wqasweb.royalresorts.com/mobileservice/mobileservice.asmx"
                Host = "wqasweb.royalresorts.com"
                HostLogin = "wqasweb.royalresorts.com"
            case 4:
                URLService = "https://wprdinternet.servicesrr.com:444/mobileservice/MobileService.asmx"
                URLServiceLogin = "https://wprdinternet.servicesrr.com:444/mobileservice/MobileService.asmx"
                Host = "wprdinternet.simpsonbayresort.com"
                HostLogin = "wprdinternet.servicesrr.com"
            default:
                URLService = "https://wdev.rrgapps.com/MobileService/MobileService.asmx"
                URLServiceLogin = "https://wdev.rrgapps.com/MobileService/MobileService.asmx"
                Host = "wdev.rrgapps.com"
                HostLogin = "wdev.rrgapps.com"
            }
            
        }
        
        //strDataBaseByStay = "FDESK_CANCUN"
        
        Util.copyFile("GuestStay.sqlite") //Se copia la base de datos al dispositivo
        
        var path = Util.getPath("GuestStay.sqlite")
        
        self.Device = UIDevice.current.modelDevice
        self.Model = UIDevice.current.modelName

        switch self.Device {

        case "iPad":
            ynIPad = true
            switch self.Model {
 
            default:
                
                self.gblDeviceFont = 2.0
                self.gblDeviceFont1 = 4.0
                self.gblDeviceFont2 = 6.0
                self.gblDeviceFont3 = 8.0
                self.gblDeviceFont4 = 10.0
                self.gblDeviceFont5 = 12.0
                self.gblDeviceFont6 = 14.0
                self.gblDeviceFont7 = 16.0
                self.gblDeviceFont8 = 18.0
                self.gblDeviceFont9 = 20.0
                self.gblDeviceFont10 = 22.0
                
                self.gblFont0 = 5.5
                self.gblFont = 6.0
                self.gblFont1 = 7.0
                self.gblFont2 = 8.0
                self.gblFont3 = 9.0
                self.gblFont4 = 10.0
                self.gblFont5 = 11.0
                self.gblFont6 = 12.0
                self.gblFont7 = 13.0
                self.gblFont8 = 14.0
                self.gblFont9 = 15.0
                self.gblFont10 = 18.0
                self.gblFont11 = 21.0
            }
            
            
            
        case "iPhone":
            ynIPad = false
            switch self.Model {

            default:
                self.gblDeviceFont = 0.0
                self.gblDeviceFont1 = 0.0
                self.gblDeviceFont2 = 0.0
                self.gblDeviceFont3 = 0.0
                self.gblDeviceFont4 = 0.0
                self.gblDeviceFont5 = 0.0
                self.gblDeviceFont6 = 0.0
                self.gblDeviceFont7 = 0.0
                self.gblDeviceFont8 = 0.0
                self.gblDeviceFont9 = 0.0
                self.gblDeviceFont10 = 0.0
                
                self.gblFont0 = 5.5
                self.gblFont = 6.0
                self.gblFont1 = 7.0
                self.gblFont2 = 8.0
                self.gblFont3 = 9.0
                self.gblFont4 = 10.0
                self.gblFont5 = 11.0
                self.gblFont6 = 12.0
                self.gblFont7 = 13.0
                self.gblFont8 = 14.0
                self.gblFont9 = 15.0
                self.gblFont10 = 18.0
                self.gblFont11 = 40.0
                
                
            }

        default:

            ynIPad = false
            self.Model = "iPhone X"

            switch self.Model {
 
            case "iPhone X":
                self.gblDeviceFont = 0.0
                self.gblDeviceFont1 = 0.0
                self.gblDeviceFont2 = 0.0
                self.gblDeviceFont3 = 0.0
                self.gblDeviceFont4 = 0.0
                self.gblDeviceFont5 = 0.0
                self.gblDeviceFont6 = 0.0
                self.gblDeviceFont7 = 0.0
                self.gblDeviceFont8 = 0.0
                self.gblDeviceFont9 = 0.0
                self.gblDeviceFont10 = 0.0
                
                self.gblFont0 = 5.5
                self.gblFont = 6.0
                self.gblFont1 = 7.0
                self.gblFont2 = 8.0
                self.gblFont3 = 9.0
                self.gblFont4 = 10.0
                self.gblFont5 = 11.0
                self.gblFont6 = 12.0
                self.gblFont7 = 13.0
                self.gblFont8 = 14.0
                self.gblFont9 = 15.0
                self.gblFont10 = 18.0
                self.gblFont11 = 40.0
                
            default:
                
                self.gblDeviceFont = 2.0
                self.gblDeviceFont1 = 4.0
                self.gblDeviceFont2 = 6.0
                self.gblDeviceFont3 = 8.0
                self.gblDeviceFont4 = 10.0
                self.gblDeviceFont5 = 12.0
                self.gblDeviceFont6 = 18.0
                self.gblDeviceFont7 = 26.0
                self.gblDeviceFont8 = 38.0
                self.gblDeviceFont9 = 50.0
                self.gblDeviceFont10 = 70.0
                
                self.gblFont0 = 5.5
                self.gblFont = 6.0
                self.gblFont1 = 7.0
                self.gblFont2 = 8.0
                self.gblFont3 = 9.0
                self.gblFont4 = 10.0
                self.gblFont5 = 11.0
                self.gblFont6 = 12.0
                self.gblFont7 = 13.0
                self.gblFont8 = 14.0
                self.gblFont9 = 15.0
                self.gblFont10 = 18.0
                self.gblFont11 = 40.0
            }
 
        }

        FirebaseApp.configure()

        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Inicia App",
            AnalyticsParameterItemName: "Inicia App",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Inicia App", screenClass: gstrAppName)
        
        ChangeDatabase()
        
        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
        // [END set_messaging_delegate]
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        // [START register_for_notifications]
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        Fabric.with([Crashlytics.self])
        Fabric.sharedSDK().debug = true
        
        return true
    }
 
    func ChangeDatabase() {
        
        var db: FMDatabase?
        var queueFM: FMDatabaseQueue?
        
        db = FMDatabase(path: Util.getPath("GuestStay.sqlite"))
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        db?.open()
            
            if !(db!.columnExists("UserImg", inTableWithName: "tblLogin")){
                
                queueFM?.inTransaction { db, rollback in
                    do {
                        
                        try db.executeUpdate("ALTER TABLE tblLogin ADD COLUMN UserImg BLOB", withArgumentsIn: [])
                        
                    } catch {
                        
                        rollback.pointee = true
                        
                    }
                }
                
                /*queueFM?.inTransaction() {
                    db, rollback in
                
                    if !(db.executeUpdate("ALTER TABLE tblLogin ADD COLUMN UserImg BLOB", withArgumentsIn: [])){
                    
                    }
                
                }*/
        
            }
        
            if !(db!.tableExists("tblRestaurantReservation")){
                
                queueFM?.inTransaction { db, rollback in
                    do {
                        
                        try db.executeUpdate("CREATE TABLE `tblRestaurantReservation` (`StayInfoID` INTEGER, `UnitCode` varchar(20), `RestaurantName` varchar(60), `ZoneDescripcion` varchar(60), `Name` varchar(120), `Adults` INTEGER, `Childrens` INTEGER, `DateReservation` varchar(20) DEFAULT (null), `TimeReservation` varchar(10) DEFAULT (null), `ConfirmacionNumber` INTEGER, `Comments` varchar(500))", withArgumentsIn: [])
                        
                    } catch {
                        rollback.pointee = true
                    }
                }
                
            }
        
        if !(db!.tableExists("tblChannelCfg")){
            
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("CREATE TABLE `tblChannelCfg` (`pkChannelID` INTEGER, `AppCode` varchar(20), `ChannelName` varchar(100), `ChannelDesc` varchar(100), `pkPeopleID` INTEGER, `ynActive` INTEGER)", withArgumentsIn: [])
                    
                } catch {
                    rollback.pointee = true
                }
            }
            
            //setChannel()
            
        }

        if (db!.tableExists("tblChannelType")){
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("DROP TABLE `tblChannelType`", withArgumentsIn: [])
                    
                } catch {
                    rollback.pointee = true
                }
            }
        }
        
        if (db!.tableExists("tblChannel")){
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("DROP TABLE `tblChannel`", withArgumentsIn: [])
                    
                } catch {
                    rollback.pointee = true
                }
            }
        }

        if !(db!.columnExists("MessageID", inTableWithName: "tblPushMessage")){
            
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("DROP TABLE `tblPushMessage`", withArgumentsIn: [])
                    
                } catch {
                    rollback.pointee = true
                }
            }
            
        }
        
        if ((db!.columnExists("RRRBalance", inTableWithName: "tblPerson")) == false){
            
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("ALTER TABLE tblPerson ADD COLUMN RRRBalance REAL", withArgumentsIn: [])
                    
                } catch {
                    rollback.pointee = true
                }
            }
            
        }
        
        if !(db!.tableExists("tblPushMessage")){
            
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("CREATE TABLE `tblPushMessage` (`_id` INTEGER PRIMARY KEY AUTOINCREMENT, `MessageID` varchar(200), `CategoryDesc` varchar(200), `Date` varchar(20), `Hour` varchar(10), `Message` varchar(200), `HTMLMessage` BLOB, `ImageURL` varchar(200), `ynViewed` INTEGER DEFAULT 0)", withArgumentsIn: [])
                    
                } catch {
                    rollback.pointee = true
                }
            }
            
        }
        
        if ((db!.columnExists("URLTicket", inTableWithName: "tblAccount")) == false){
            
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("ALTER TABLE tblAccount ADD COLUMN URLTicket varchar(500)", withArgumentsIn: [])
                    
                } catch {
                    rollback.pointee = true
                }
            }
            
        }
        
        if ((db!.columnExists("PhoneNo", inTableWithName: "tblPerson")) == false){
            
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("ALTER TABLE tblPerson ADD COLUMN PhoneNo varchar(20)", withArgumentsIn: [])
                    
                } catch {
                    rollback.pointee = true
                }
            }
            
        }
        
        if ((db!.columnExists("dtExpectedArrival", inTableWithName: "tblPerson")) == false){
            
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("ALTER TABLE tblPerson ADD COLUMN dtExpectedArrival varchar(20)", withArgumentsIn: [])
                    
                } catch {
                    rollback.pointee = true
                }
            }
            
        }
        
        if ((db!.columnExists("iKeycardid", inTableWithName: "tblPerson")) == false){
            
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("ALTER TABLE tblPerson ADD COLUMN iKeycardid INTEGER", withArgumentsIn: [])
                    
                } catch {
                    rollback.pointee = true
                }
            }
            
        }
        
        if !(db!.tableExists("tblPersonAI")){
            
            queueFM?.inTransaction { db, rollback in
                do {
                    try db.executeUpdate("CREATE TABLE `tblPersonAI` (`StayInfoID` INTEGER,`GuestSequence` INTEGER, `Age` INTEGER, `pkGuestAgeID` INTEGER, `pkPeopleID` INTEGER, `fkPromoID` INTEGER, AdultChildTeen varchar(1), `fkPeopleID` INTEGER)", withArgumentsIn: [])
                    
                } catch {
                    rollback.pointee = true
                }
            }
            
        }
        
        if ((db!.columnExists("PlaceCode", inTableWithName: "tblStay")) == false){
            
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("ALTER TABLE tblStay ADD COLUMN PlaceCode VARCHAR(10)", withArgumentsIn: [])
                    
                } catch {
                    rollback.pointee = true
                }
            }
            
        }
        
        db?.close()
        
    }
    

    
    // [START receive_message]
    /*func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        let todaysDate:Date = Date()
        let dtdateFormatter:DateFormatter = DateFormatter()
        dtdateFormatter.dateFormat = "yyyy-MM-dd"
        let DateInFormat:String = dtdateFormatter.string(from: todaysDate)
        
        let todaysDate2:Date = Date()
        let dtdateFormatter2:DateFormatter = DateFormatter()
        dtdateFormatter2.dateFormat = "hh:mm"
        let DateInFormat2:String = dtdateFormatter2.string(from: todaysDate2)
        
        var MessageAux: Any = userInfo["aps"]!
        
        var strArray: [String:Any] = MessageAux as! [String : Any]
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        queueFM?.inTransaction { db, rollback in
            do {
                
                try db.executeUpdate("INSERT INTO tblPushMessage (CategoryDesc, Date, Hour, Message, HTMLMessage, ImageURL, ynViewed) VALUES (?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [userInfo["google.c.a.c_l"], DateInFormat, DateInFormat2, strArray["alert"] as! String,"","",0])
                
                
            } catch {
                rollback.pointee = true
                print(error)
            }
        }
        
    }*/
    
    /*func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let aps = userInfo["aps"] as! [String: AnyObject]
        
        // 1
        if aps["content-available"] as? Int == 1 {
            let podcastStore = PodcastStore.sharedStore
            // Refresh Podcast
            // 2
            podcastStore.refreshItems { didLoadNewItems in
                // 3
                completionHandler(didLoadNewItems ? .newData : .noData)
            }
        } else  {
            // News
            // 4
            _ = NewsItem.makeNewsItem(aps)
            completionHandler(.newData)
        }
    }*/
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        let todaysDate:Date = Date()
        let dtdateFormatter:DateFormatter = DateFormatter()
        dtdateFormatter.dateFormat = "yyyy-MM-dd"
        let DateInFormat:String = dtdateFormatter.string(from: todaysDate)
        
        let todaysDate2:Date = Date()
        let dtdateFormatter2:DateFormatter = DateFormatter()
        dtdateFormatter2.dateFormat = "hh:mm a"
        let DateInFormat2:String = dtdateFormatter2.string(from: todaysDate2)

        var MessageAux: Any = userInfo["aps"]!
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        if userInfo["gcm.notification.Date"] != nil{
            
            var strArray: [String:[String : String]] = MessageAux as! [String : [String : String]]
            var strArrayData: Dictionary<String, String>!
            
            for (key, value) in strArray {
                if key == "alert" {
                    strArrayData = value
                    
                }
            }
            
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("INSERT INTO tblPushMessage (MessageID, CategoryDesc, Date, Hour, Message, HTMLMessage, ImageURL, ynViewed) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [userInfo["gcm.message_id"], strArrayData["title"] as! String, userInfo["gcm.notification.Date"], userInfo["gcm.notification.Hour"], strArrayData["body"] as! String, userInfo["gcm.notification.HTMLMessage"],userInfo["gcm.notification.ImageURL"],0])
                    
                } catch {
                    rollback.pointee = true
                    print(error)
                }
            }
            
        }
        else
        {
            
            var strArray: [String:Any] = MessageAux as! [String : Any]
            
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("INSERT INTO tblPushMessage (MessageID, CategoryDesc, Date, Hour, Message, HTMLMessage, ImageURL, ynViewed) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [userInfo["gcm.message_id"], strArray["alert"] as! String, DateInFormat, DateInFormat2, userInfo["google.c.a.c_l"], "","",0])
                    
                } catch {
                    rollback.pointee = true
                    print(error)
                }
            }
        }
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        gstrToken = fcmToken
        print("Firebase registration token: \(fcmToken)")
        
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        Messaging.messaging().apnsToken = deviceToken as Data
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    /*func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        var tokenq = ""
        for i in 0..<deviceToken.count {
            tokenq = tokenq + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        
        InstanceID.instanceID().setAPNSToken(deviceToken as Data, type: InstanceIDAPNSTokenType.sandbox )
        InstanceID.instanceID().setAPNSToken(deviceToken as Data, type: InstanceIDAPNSTokenType.prod )
        
        if InstanceID.instanceID().token() != nil{
            gstrToken = InstanceID.instanceID().token()!.description
            print("***Token***")
            print(gstrToken)
            //Messaging.messaging().subscribe(toTopic: "news")
        }else{
            gstrToken = ""
        }
        
        
    }*/
    
    /*func tokenRefreshNotification(_ notification: Notification) {
        if let refreshedToken = InstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
        }
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
    }*/
    
    /*func connectToFcm() {
        Messaging.messaging().connect { (error) in
            if error != nil {
                print("Unable to connect with FCM. \(error)")
            } else {
                print("Connected to FCM.")
            }
        }
    }*/
    
    func setChannel(){
        var iRes: String = ""
        var sRes: String = ""
        let queue = OperationQueue()
        var tableItems = RRDataSet()
        let service=RRRestaurantService(url: self.URLService as String, host: self.Host as String, userNameMobile:self.UserName, passwordMobile:self.Password);
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        queue.addOperation() {
            
            if Reachability.isConnectedToNetwork(){
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                //tableItems = (service?.spUpdPeopleChannel("1", appCode: self.gstrAppName, ifkPeopleID: "", ifkChannelID: "", dataBase: "CDRPRD"))!
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
                        sRes = rowResult.getColumnByName("sResult").content as! String
                    }else{
                        iRes = "-1"
                        sRes = NSLocalizedString("MsgError6",comment:"")
                    }
                    
                    if ( (iRes != "0") && (iRes != "-1")){
                        
                        var table = RRDataTable()
                        table = tableItems.tables.object(at: 1) as! RRDataTable
                        
                        var r = RRDataRow()
                        r = table.rows.object(at: 0) as! RRDataRow
                        
                        queueFM?.inTransaction { db, rollback in
                            do {
                                
                                try db.executeUpdate("DELETE FROM tblChannelCfg WHERE AppCode = ?", withArgumentsIn: [self.gstrAppName])
                                
                            } catch {
                                rollback.pointee = true
                            }
                        }
                        
                        queueFM?.inTransaction { db, rollback in
                            do {
                                
                                for r in table.rows{
                                    
                                    try db.executeUpdate("INSERT INTO tblChannelCfg (pkChannelID, AppCode, ChannelName, ChannelDesc,  ynActive) VALUES (?, ?, ?, ?, ?)", withArgumentsIn: [((r as AnyObject).getColumnByName("pkChannelID").content as? String)!, ((r as AnyObject).getColumnByName("AppCode").content as? String)!, ((r as AnyObject).getColumnByName("ChannelName").content as? String)!, ((r as AnyObject).getColumnByName("ChannelDesc").content as? String)!, ""])
                                    
                                }
                                
                                
                            } catch {
                                rollback.pointee = true
                                print(error)
                            }
                        }
                        
                        
                    }
                }
            }
        }
    }

}



// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        let todaysDate:Date = Date()
        let dtdateFormatter:DateFormatter = DateFormatter()
        dtdateFormatter.dateFormat = "yyyy-MM-dd"
        let DateInFormat:String = dtdateFormatter.string(from: todaysDate)
        
        let todaysDate2:Date = Date()
        let dtdateFormatter2:DateFormatter = DateFormatter()
        dtdateFormatter2.dateFormat = "hh:mm a"
        let DateInFormat2:String = dtdateFormatter2.string(from: todaysDate2)
        
        var MessageAux: Any = userInfo["aps"]!
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        if userInfo["gcm.notification.Date"] != nil{
            
            var strArray: [String:[String : String]] = MessageAux as! [String : [String : String]]
            var strArrayData: Dictionary<String, String>!
            
            for (key, value) in strArray {
                if key == "alert" {
                    strArrayData = value
                    
                }
            }
            
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("INSERT INTO tblPushMessage (MessageID, CategoryDesc, Date, Hour, Message, HTMLMessage, ImageURL, ynViewed) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [userInfo["gcm.message_id"], strArrayData["title"] as! String, userInfo["gcm.notification.Date"], userInfo["gcm.notification.Hour"], strArrayData["body"] as! String, userInfo["gcm.notification.HTMLMessage"],userInfo["gcm.notification.ImageURL"],0])
                    
                } catch {
                    rollback.pointee = true
                    print(error)
                }
            }
            
        }
        else
        {
            
            var strArray: [String:Any] = MessageAux as! [String : Any]
            
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("INSERT INTO tblPushMessage (MessageID, CategoryDesc, Date, Hour, Message, HTMLMessage, ImageURL, ynViewed) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [userInfo["gcm.message_id"], strArray["alert"] as! String, DateInFormat, DateInFormat2, userInfo["google.c.a.c_l"], "","",0])
                    
                } catch {
                    rollback.pointee = true
                    print(error)
                }
            }
        }
        
        // Change this to your preferred presentation option
        completionHandler([])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        
        print(userInfo)
        
        let todaysDate:Date = Date()
        let dtdateFormatter:DateFormatter = DateFormatter()
        dtdateFormatter.dateFormat = "yyyy-MM-dd"
        let DateInFormat:String = dtdateFormatter.string(from: todaysDate)
        
        let todaysDate2:Date = Date()
        let dtdateFormatter2:DateFormatter = DateFormatter()
        dtdateFormatter2.dateFormat = "hh:mm a"
        let DateInFormat2:String = dtdateFormatter2.string(from: todaysDate2)
        
        var MessageAux: Any = userInfo["aps"]!
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        if userInfo["gcm.notification.Date"] != nil{
            
            var strArray: [String:[String : String]] = MessageAux as! [String : [String : String]]
            var strArrayData: Dictionary<String, String>!
            
            for (key, value) in strArray {
                if key == "alert" {
                    strArrayData = value
                    
                }
            }
            
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("INSERT INTO tblPushMessage (MessageID, CategoryDesc, Date, Hour, Message, HTMLMessage, ImageURL, ynViewed) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [userInfo["gcm.message_id"], strArrayData["title"] as! String, userInfo["gcm.notification.Date"], userInfo["gcm.notification.Hour"], strArrayData["body"] as! String, userInfo["gcm.notification.HTMLMessage"],userInfo["gcm.notification.ImageURL"],0])
                    
                } catch {
                    rollback.pointee = true
                    print(error)
                }
            }
            
        }
        else
        {
            
            var strArray: [String:Any] = MessageAux as! [String : Any]
            
            queueFM?.inTransaction { db, rollback in
                do {
                    
                    try db.executeUpdate("INSERT INTO tblPushMessage (MessageID, CategoryDesc, Date, Hour, Message, HTMLMessage, ImageURL, ynViewed) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [userInfo["gcm.message_id"], strArray["alert"] as! String, DateInFormat, DateInFormat2, userInfo["google.c.a.c_l"], "","",0])
                    
                } catch {
                    rollback.pointee = true
                    print(error)
                }
            }
        }
        
        gblGoNotification = true
        gstrMessageID = userInfo[gcmMessageIDKey] as! String
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let NextViewController = mainStoryboard.instantiateViewController(withIdentifier: "tcGuestServicesMain") as! UITabBarController
        let rootViewController = self.window!.rootViewController as! UINavigationController
        rootViewController.pushViewController(NextViewController, animated: true)
        
        completionHandler()
    }
}
// [END ios_10_message_handling]

extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        gstrToken = fcmToken
        print("Firebase registration token: \(fcmToken)")
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
    // [END ios_10_data_message]
}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
    var modelDevice: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod "
        case "iPod7,1":                                 return "iPod"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone"
        case "iPhone4,1":                               return "iPhone"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone"
        case "iPhone7,2":                               return "iPhone"
        case "iPhone7,1":                               return "iPhone"
        case "iPhone8,1":                               return "iPhone"
        case "iPhone8,2":                               return "iPhone"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone"
        case "iPhone8,4":                               return "iPhone"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad"
        case "iPad5,3", "iPad5,4":                      return "iPad"
        case "iPad6,11", "iPad6,12":                    return "iPad"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad"
        case "iPad5,1", "iPad5,2":                      return "iPad"
        case "iPad6,3", "iPad6,4":                      return "iPad"
        case "iPad6,7", "iPad6,8":                      return "iPad"
        case "iPad7,1", "iPad7,2":                      return "iPad"
        case "iPad7,3", "iPad7,4":                      return "iPad"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}


