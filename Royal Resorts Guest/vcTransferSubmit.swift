//
//  vcTransferSubmit.swift
//  Royal Resorts Guest
//
//  Created by Soluciones on 12/12/19.
//  Copyright © 2019 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging
import DGRunkeeperSwitch

class vcTransferSubmit: UIViewController, UITextFieldDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var strFont: String = ""
    var urlHome: String = ""
    var titleCode:String = ""
    var lblUserName = UILabel()
    var lblMsgError = UILabel()
    var lblArrivalDate = UILabel()
    var btnChooseDate = UIButton()
    var lblUsaCan = UILabel()
    var lblMex = UILabel()
    var lblOther = UILabel()
    var lblOffice = UILabel()
    var lblMon = UILabel()
    var lblSat = UILabel()
    var lblEmail = UILabel()
    var lblUSTel = UILabel()
    var lblMexTel = UILabel()
    var lblOtherTel1 = UILabel()
    var lblOtherTel2 = UILabel()
    var tblTransferType: [Dictionary<String, String>]!
    var strPriceUSD: String = ""
    var strPriceMX: String = ""
    var strItemClassCode: String = ""
    var strItemTypeCode: String = ""
    var txtArrivalFlight = UITextField()
    var txtArrivalFlightCode = UITextField()
    var txtArrivalFlightHour = UITextField()
    var txtDepartureFlight = UITextField()
    var txtDepartureFlightCode = UITextField()
    var txtDepartureFlightHour = UITextField()
    var txtPersonFlightFName = UITextField()
    var txtPersonFlightLName = UITextField()
    var txtCommentFlight = UITextField()
    
    @IBOutlet var ViewItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        self.tabBarController?.navigationController?.navigationBar.isHidden = true;
        self.navigationController?.navigationBar.isHidden = false;
        self.navigationController?.isToolbarHidden = false;
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString(titleCode,comment:"");

        //Boton Add
        //ViewItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("btnEditInfo",comment:""), style: .plain, target: self, action: #selector(vcTransferDate.clickAdd(_:)))
        
        txtArrivalFlight.delegate = self
        txtDepartureFlight.delegate = self
        txtArrivalFlightHour.delegate = self
        txtDepartureFlightHour.delegate = self
        txtArrivalFlightCode.delegate = self
        txtDepartureFlightCode.delegate = self

        let TabTitleFont = UIFont(name: "HelveticaNeue", size: appDelegate.gblFont10 + appDelegate.gblDeviceFont2)!
        
            var strArrivalDate: String = ""
            let strdateFormatter = DateFormatter()
            strdateFormatter.dateFormat = "MMMM dd, yyyy";
            let ArrivalDate = moment(self.appDelegate.gstrArrivalTransfer)
            strArrivalDate = strdateFormatter.string(from: ArrivalDate!.date)

            var strDeparturedate: String = ""
            let Departuredate = moment(self.appDelegate.gstrDepartureTransfer)
            strDeparturedate = strdateFormatter.string(from: Departuredate!.date)
            
            lblUserName = UILabel(frame: CGRect(x: 0.05*width, y: 0.07*height, width: 0.9*width, height: 0.04*height));
            lblMsgError = UILabel(frame: CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.06*height));
            lblArrivalDate = UILabel(frame: CGRect(x: 0.05*width, y: 0.16*height, width: 0.9*width, height: 0.03*height));
            lblUsaCan = UILabel(frame: CGRect(x: 0.05*width, y: 0.2*height, width: 0.9*width, height: 0.03*height));
            txtArrivalFlight.frame = CGRect(x: 0.05*width!, y: 0.24*height!, width: 0.9*width!, height: 0.04*height!);
            txtArrivalFlightCode.frame = CGRect(x: 0.05*width!, y: 0.29*height!, width: 0.5*width!, height: 0.04*height!);
            txtArrivalFlightHour.frame = CGRect(x: 0.56*width!, y: 0.29*height!, width: 0.39*width!, height: 0.04*height!);
            lblMex = UILabel(frame: CGRect(x: 0.05*width, y: 0.34*height, width: 0.9*width, height: 0.03*height));
            txtDepartureFlight.frame = CGRect(x: 0.05*width!, y: 0.38*height!, width: 0.9*width!, height: 0.04*height!);
            txtDepartureFlightCode.frame = CGRect(x: 0.05*width!, y: 0.43*height!, width: 0.5*width!, height: 0.04*height!);
            txtDepartureFlightHour.frame = CGRect(x: 0.56*width!, y: 0.43*height!, width: 0.39*width!, height: 0.04*height!);
            lblOther = UILabel(frame: CGRect(x: 0.05*width, y: 0.48*height, width: 0.9*width, height: 0.06*height));
            txtPersonFlightFName.frame = CGRect(x: 0.05*width!, y: 0.55*height!, width: 0.43*width!, height: 0.04*height!);
            txtPersonFlightLName.frame = CGRect(x: 0.49*width!, y: 0.55*height!, width: 0.46*width!, height: 0.04*height!);
            txtCommentFlight.frame = CGRect(x: 0.05*width!, y: 0.6*height!, width: 0.9*width!, height: 0.08*height!);
            lblSat = UILabel(frame: CGRect(x: 0.05*width, y: 0.67*height, width: 0.9*width, height: 0.08*height));
            lblMon = UILabel(frame: CGRect(x: 0.05*width, y: 0.74*height, width: 0.9*width, height: 0.03*height));
            btnChooseDate.frame = CGRect(x: 0.1*width, y: 0.78*height, width: 0.8*width, height: 0.05*height);
            lblOtherTel2 = UILabel(frame: CGRect(x: 0.05*width, y: 0.84*height, width: 0.9*width, height: 0.03*height));
            lblEmail = UILabel(frame: CGRect(x: 0.05*width, y: 0.87*height, width: 0.9*width, height: 0.03*height));
        
            lblUserName.backgroundColor = UIColor.clear
            lblUserName.textAlignment = NSTextAlignment.left
            lblUserName.textColor = colorWithHexString("000000")
            lblUserName.numberOfLines = 0;
            lblUserName.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
            lblUserName.text = NSLocalizedString("lblUserNameTransfer",comment:"") + " " + self.appDelegate.gstrPeopleFNameTransfer
            
            lblMsgError.backgroundColor = UIColor.clear
            lblMsgError.textAlignment = NSTextAlignment.left
            lblMsgError.textColor = colorWithHexString("000000")
            lblMsgError.numberOfLines = 0;
            lblMsgError.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblMsgError.text = self.appDelegate.giPeopleNumTransfer.description + " " + NSLocalizedString("strPax",comment:"") + ", " + NSLocalizedString("strService",comment:"") + ": " + self.appDelegate.gItemClassCode.description +
                " " + self.appDelegate.gItemTypeCode.description + " $" + String(format: "%.2f", (String(format: "%.2f0", (self.appDelegate.gblTotalReserv.description as NSString).floatValue) as NSString).floatValue) + " USD"
            
            lblArrivalDate.backgroundColor = UIColor.clear
            lblArrivalDate.textAlignment = NSTextAlignment.left
            lblArrivalDate.textColor = colorWithHexString("000000")
            lblArrivalDate.numberOfLines = 0;
            lblArrivalDate.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblArrivalDate.text = NSLocalizedString("lblFlightInformation",comment:"")

            lblUsaCan.backgroundColor = UIColor.clear;
            lblUsaCan.textAlignment = NSTextAlignment.left;
            lblUsaCan.textColor = colorWithHexString("000000")
            lblUsaCan.numberOfLines = 0
            lblUsaCan.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblUsaCan.text = NSLocalizedString("lblArrivalInformation",comment:"")

            txtArrivalFlight.backgroundColor = UIColor.clear;
            txtArrivalFlight.textAlignment = NSTextAlignment.right;
            txtArrivalFlight.textColor = colorWithHexString("000000")
            txtArrivalFlight.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtArrivalFlight.layer.borderColor = UIColor.black.cgColor
            txtArrivalFlight.borderStyle = UITextField.BorderStyle.roundedRect
            txtArrivalFlight.keyboardType = UIKeyboardType.alphabet
            txtArrivalFlight.placeholder = NSLocalizedString("lblHolderAirline",comment:"")
            txtArrivalFlight.text = self.appDelegate.gstrOperatorNameArrival
            txtArrivalFlight.addTarget(self, action: #selector(vcTransferSubmit.clickArrivalFlight(_:)), for: UIControl.Event.touchDown)
            //txtArrivalFlight.isUserInteractionEnabled = false
        
            txtArrivalFlightCode.backgroundColor = UIColor.clear;
            txtArrivalFlightCode.textAlignment = NSTextAlignment.right;
            txtArrivalFlightCode.textColor = colorWithHexString("000000")
            txtArrivalFlightCode.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtArrivalFlightCode.layer.borderColor = UIColor.black.cgColor
            txtArrivalFlightCode.borderStyle = UITextField.BorderStyle.roundedRect
            txtArrivalFlightCode.keyboardType = UIKeyboardType.alphabet
            txtArrivalFlightCode.placeholder = NSLocalizedString("lblHolderFlight",comment:"")
            txtArrivalFlightCode.text = self.appDelegate.strArrivalFlightCode
            txtArrivalFlightCode.addTarget(self, action: #selector(vcTransferSubmit.clickArrivalFlightCode(_:)), for: UIControl.Event.touchDown)
            //txtArrivalFlightCode.isUserInteractionEnabled = false
        
            txtArrivalFlightHour.backgroundColor = UIColor.clear;
            txtArrivalFlightHour.textAlignment = NSTextAlignment.right;
            txtArrivalFlightHour.textColor = colorWithHexString("000000")
            txtArrivalFlightHour.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtArrivalFlightHour.layer.borderColor = UIColor.black.cgColor
            txtArrivalFlightHour.borderStyle = UITextField.BorderStyle.roundedRect
            txtArrivalFlightHour.keyboardType = UIKeyboardType.alphabet
            txtArrivalFlightHour.placeholder = NSLocalizedString("lblHolderHour",comment:"")
            txtArrivalFlightHour.text = self.appDelegate.strArrivalFlightHourAux
            txtArrivalFlightHour.addTarget(self, action: #selector(vcTransferSubmit.clickArrivalFlightHour(_:)), for: UIControl.Event.touchDown)
            //txtArrivalFlightHour.isUserInteractionEnabled = false
        
            lblMex.backgroundColor = UIColor.clear;
            lblMex.textAlignment = NSTextAlignment.left;
            lblMex.textColor = colorWithHexString("000000")
            lblMex.numberOfLines = 1;
            lblMex.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblMex.text = NSLocalizedString("lblDepartureInformation",comment:"")
        
            txtDepartureFlight.backgroundColor = UIColor.clear;
            txtDepartureFlight.textAlignment = NSTextAlignment.right;
            txtDepartureFlight.textColor = colorWithHexString("000000")
            txtDepartureFlight.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtDepartureFlight.layer.borderColor = UIColor.black.cgColor
            txtDepartureFlight.borderStyle = UITextField.BorderStyle.roundedRect
            txtDepartureFlight.keyboardType = UIKeyboardType.alphabet
            txtDepartureFlight.placeholder = NSLocalizedString("lblHolderAirline",comment:"")
            txtDepartureFlight.text = self.appDelegate.gstrOperatorNameDeparture
            txtDepartureFlight.addTarget(self, action: #selector(vcTransferSubmit.clickDepartureFlight(_:)), for: UIControl.Event.touchDown)
            //txtDepartureFlight.isUserInteractionEnabled = false
        
            txtDepartureFlightCode.backgroundColor = UIColor.clear;
            txtDepartureFlightCode.textAlignment = NSTextAlignment.right;
            txtDepartureFlightCode.textColor = colorWithHexString("000000")
            txtDepartureFlightCode.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtDepartureFlightCode.layer.borderColor = UIColor.black.cgColor
            txtDepartureFlightCode.borderStyle = UITextField.BorderStyle.roundedRect
            txtDepartureFlightCode.keyboardType = UIKeyboardType.alphabet
            txtDepartureFlightCode.placeholder = NSLocalizedString("lblHolderFlight",comment:"")
            txtDepartureFlightCode.text = self.appDelegate.strDepartureFlightCode
            txtDepartureFlightCode.addTarget(self, action: #selector(vcTransferSubmit.clickDepartureFlightCode(_:)), for: UIControl.Event.touchDown)
            //txtDepartureFlightCode.isUserInteractionEnabled = false
        
            txtDepartureFlightHour.backgroundColor = UIColor.clear;
            txtDepartureFlightHour.textAlignment = NSTextAlignment.right;
            txtDepartureFlightHour.textColor = colorWithHexString("000000")
            txtDepartureFlightHour.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtDepartureFlightHour.layer.borderColor = UIColor.black.cgColor
            txtDepartureFlightHour.borderStyle = UITextField.BorderStyle.roundedRect
            txtDepartureFlightHour.keyboardType = UIKeyboardType.alphabet
            txtDepartureFlightHour.placeholder = NSLocalizedString("lblHolderHour",comment:"")
            txtDepartureFlightHour.text = self.appDelegate.strDepartureFlightHourAux
            txtDepartureFlightHour.addTarget(self, action: #selector(vcTransferSubmit.clickDepartureFlightHour(_:)), for: UIControl.Event.touchDown)
            //txtDepartureFlightHour.isUserInteractionEnabled = false
        
            lblOther.backgroundColor = UIColor.clear;
            lblOther.textAlignment = NSTextAlignment.left;
            lblOther.textColor = colorWithHexString("000000")
            lblOther.numberOfLines = 2;
            lblOther.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
            lblOther.text = NSLocalizedString("lblTravellerName",comment:"")
        
            txtPersonFlightFName.backgroundColor = UIColor.clear;
            txtPersonFlightFName.textAlignment = NSTextAlignment.left;
            txtPersonFlightFName.textColor = colorWithHexString("000000")
            txtPersonFlightFName.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtPersonFlightFName.layer.borderColor = UIColor.black.cgColor
            txtPersonFlightFName.borderStyle = UITextField.BorderStyle.roundedRect
            txtPersonFlightFName.keyboardType = UIKeyboardType.alphabet
            txtPersonFlightFName.placeholder = self.appDelegate.gstrPeopleFNameTransfer
            txtPersonFlightFName.text = self.appDelegate.gstrPeopleFNameTransfer
        
            txtPersonFlightLName.backgroundColor = UIColor.clear;
            txtPersonFlightLName.textAlignment = NSTextAlignment.left;
            txtPersonFlightLName.textColor = colorWithHexString("000000")
            txtPersonFlightLName.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtPersonFlightLName.layer.borderColor = UIColor.black.cgColor
            txtPersonFlightLName.borderStyle = UITextField.BorderStyle.roundedRect
            txtPersonFlightLName.keyboardType = UIKeyboardType.alphabet
            txtPersonFlightLName.placeholder = self.appDelegate.gstrPeopleLNameTransfer
            txtPersonFlightLName.text = self.appDelegate.gstrPeopleLNameTransfer
        
            txtCommentFlight.backgroundColor = UIColor.clear;
            txtCommentFlight.textAlignment = NSTextAlignment.left;
            txtCommentFlight.textColor = colorWithHexString("000000")
            txtCommentFlight.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtCommentFlight.layer.borderColor = UIColor.black.cgColor
            txtCommentFlight.borderStyle = UITextField.BorderStyle.roundedRect
            txtCommentFlight.keyboardType = UIKeyboardType.alphabet
            txtCommentFlight.placeholder = NSLocalizedString("lblAddComment",comment:"")
            
            lblSat.backgroundColor = UIColor.clear;
            lblSat.textAlignment = NSTextAlignment.center;
            lblSat.textColor = colorWithHexString("000000")
            lblSat.numberOfLines = 3;
            lblSat.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblSat.text = NSLocalizedString("lblChargeService",comment:"")
            
            lblMon.backgroundColor = UIColor.clear;
            lblMon.textAlignment = NSTextAlignment.center;
            lblMon.textColor = colorWithHexString("000000")
            lblMon.numberOfLines = 1;
            lblMon.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblMon.text = NSLocalizedString("lblConditions",comment:"")

            btnChooseDate.setTitle(NSLocalizedString("btnSubmitRes",comment:""), for: UIControl.State())
            btnChooseDate.titleLabel?.font = UIFont(name: "Helvetica", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont4)
            btnChooseDate.backgroundColor = colorWithHexString("5C9FCC")
            btnChooseDate.layer.borderWidth = 0.8
            btnChooseDate.setTitleColor(UIColor.white, for: UIControl.State())
            btnChooseDate.titleLabel?.textAlignment = NSTextAlignment.center
        
            btnChooseDate.addTarget(self, action: #selector(vcTransferSubmit.clickSubmit(_:)), for: UIControl.Event.touchUpInside)
        
            lblOtherTel2.backgroundColor = UIColor.clear;
            lblOtherTel2.textAlignment = NSTextAlignment.center;
            lblOtherTel2.textColor = colorWithHexString("000000")
            lblOtherTel2.numberOfLines = 1;
            lblOtherTel2.font = UIFont(name: "Verdana", size: appDelegate.gblFont4 + appDelegate.gblDeviceFont2)
            lblOtherTel2.text = NSLocalizedString("lblHelpTransfer",comment:"");

            lblEmail.backgroundColor = UIColor.clear;
            lblEmail.textAlignment = NSTextAlignment.center;
            lblEmail.textColor = colorWithHexString("000000")
            lblEmail.numberOfLines = 1;
            lblEmail.font = UIFont(name: "Verdana", size: appDelegate.gblFont4 + appDelegate.gblDeviceFont2)
            lblEmail.text = NSLocalizedString("lblEmail",comment:"");
        
            self.view.addSubview(self.lblUserName)
            self.view.addSubview(self.lblMsgError)
            self.view.addSubview(self.lblArrivalDate)
            self.view.addSubview(self.lblUsaCan)
            self.view.addSubview(self.txtArrivalFlight)
            self.view.addSubview(self.txtArrivalFlightCode)
            self.view.addSubview(self.txtArrivalFlightHour)
            self.view.addSubview(self.lblMex)
            self.view.addSubview(self.txtDepartureFlight)
            self.view.addSubview(self.txtDepartureFlightCode)
            self.view.addSubview(self.txtDepartureFlightHour)
            self.view.addSubview(self.lblOther)
            self.view.addSubview(self.txtPersonFlightFName)
            self.view.addSubview(self.txtPersonFlightLName)
            self.view.addSubview(self.txtCommentFlight)
            self.view.addSubview(self.lblSat)
            self.view.addSubview(self.lblMon)
            self.view.addSubview(self.btnChooseDate)
            self.view.addSubview(self.lblOtherTel2)
            self.view.addSubview(self.lblEmail)
        
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
        
        CargaAerolineas()

    }
    
    func CargaAerolineas(){
        
        var tableItems = RRDataSet()
        var iRes: String = ""
        var sRes: String = ""
        
        var tblAerolinea: [Dictionary<String, String>]
        var tblAerolineaItem: Dictionary<String, String>
        
        tblAerolinea = []
        tblAerolineaItem = [:]
        
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 100
        config.backgroundColor = UIColor(white: 1, alpha: 0.5)
        config.spinnerColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.titleTextColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.spinnerLineWidth = 2.0
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        SwiftLoader.show(title: NSLocalizedString("lblLoading",comment:""), animated: true)
        
        appDelegate.gtblStay = nil
        appDelegate.gStaysStatus = nil

        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        var prepareOrderResult:NSString="";

            let queue = OperationQueue()
            
            queue.addOperation() {//1
                //accion webservice-db
                if Reachability.isConnectedToNetwork(){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true

                    let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                    tableItems = service!.wmGetFlightVtmTrans("3", iOperator: "0", sFlightTypeCode: "", strToken1: "", strToken2: "", strToken3: "", strToken4: "", strToken5: "POS")
                    
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
                            

                                queueFM?.inTransaction { db, rollback in
                                    do {
                                        
                                        for r in table.rows{
                                            
                                            tblAerolineaItem = [:]
                                            tblAerolineaItem["pkOperatorID"] = ((r as AnyObject).getColumnByName("pkOperatorID").content as? String)!
                                            tblAerolineaItem["OperatorName"] = ((r as AnyObject).getColumnByName("OperatorName").content as? String)!
                                            tblAerolineaItem["OperatorCode"] = ((r as AnyObject).getColumnByName("OperatorCode").content as? String)!
                                            tblAerolinea.append(tblAerolineaItem)
                                            
                                        }
                                        
                                        
                                    } catch {
                                        rollback.pointee = true
                                        print(error)
                                    }
                                }
                            
                            if (tblAerolinea.count>0){
                                self.appDelegate.gtblAerolinea = tblAerolinea
                            }
                            
                            SwiftLoader.hide()

                        }

                    }

                }
            }//1
  

    }
  
    func CargaFlights(iOperator: String){
          
          var tableItems = RRDataSet()
          var iRes: String = ""
          var sRes: String = ""
          var strOperator: String = ""
        
          var tblFlight: [Dictionary<String, String>]
          var tblFlightItem: Dictionary<String, String>
          
          tblFlight = []
          tblFlightItem = [:]
          
          var config : SwiftLoader.Config = SwiftLoader.Config()
          config.size = 100
          config.backgroundColor = UIColor(white: 1, alpha: 0.5)
          config.spinnerColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
          config.titleTextColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
          config.spinnerLineWidth = 2.0
          SwiftLoader.setConfig(config)
          SwiftLoader.show(animated: true)
          SwiftLoader.show(title: NSLocalizedString("lblLoading",comment:""), animated: true)
          
          self.appDelegate.gtblFlight = nil

        if iOperator == ""{
            strOperator = "0"
        }else{
            strOperator = iOperator
        }

          var queueFM: FMDatabaseQueue?
          
          queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
          
          var prepareOrderResult:NSString="";

              let queue = OperationQueue()
              
              queue.addOperation() {//1
                  //accion webservice-db
                  if Reachability.isConnectedToNetwork(){
                      UIApplication.shared.isNetworkActivityIndicatorVisible = true

                      let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                      tableItems = service!.wmGetFlightVtmTrans("2", iOperator: strOperator, sFlightTypeCode: "", strToken1: "", strToken2: "", strToken3: "", strToken4: "", strToken5: "POS")
                      
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
                              

                                  queueFM?.inTransaction { db, rollback in
                                      do {
                                        
                                          for r in table.rows{
                                              
                                              tblFlightItem = [:]
                                              tblFlightItem["pkFlightID"] = ((r as AnyObject).getColumnByName("pkFlightID").content as? String)!
                                              tblFlightItem["FlightCode"] = ((r as AnyObject).getColumnByName("FlightCode").content as? String)!
                                              tblFlight.append(tblFlightItem)
                                              
                                          }
                                        
                                        tblFlightItem = [:]
                                        tblFlightItem["pkFlightID"] = "0"
                                        tblFlightItem["FlightCode"] = NSLocalizedString("strOther",comment:"")
                                        tblFlight.append(tblFlightItem)
                                        
                                        self.appDelegate.gtblFlight = tblFlight

                                      } catch {
                                          rollback.pointee = true
                                          print(error)
                                      }
                                  }

                          }

                      }
                    
                    if (tblFlight.count==0){
                        
                        tblFlightItem = [:]
                        tblFlightItem["pkFlightID"] = "0"
                        tblFlightItem["FlightCode"] = NSLocalizedString("strOther",comment:"")
                        tblFlight.append(tblFlightItem)
                        
                        self.appDelegate.gtblFlight = tblFlight
                        
                    }
                    
                      SwiftLoader.hide()
                    
                    if self.appDelegate.ynCargaFlightArr{
                        self.appDelegate.ynCargaFlightArr = false
                        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectStay") as! vcSelectStay
                        tercerViewController.strMode = "ArrivalFlightCode"
                        self.navigationController?.pushViewController(tercerViewController, animated: true)
                    }
                    
                    if self.appDelegate.ynCargaFlightDep{
                        self.appDelegate.ynCargaFlightDep = false
                        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectStay") as! vcSelectStay
                        tercerViewController.strMode = "DepartureFlightCode"
                        self.navigationController?.pushViewController(tercerViewController, animated: true)
                    }
                      
                  }
              }//1
    

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
            AnalyticsParameterItemID: "id-TransferSubmit",
            AnalyticsParameterItemName: "TransferSubmit",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("TransferSubmit", screenClass: appDelegate.gstrAppName)
        
        txtArrivalFlight.text = self.appDelegate.gstrOperatorNameArrival
        txtDepartureFlight.text = self.appDelegate.gstrOperatorNameDeparture
        txtArrivalFlightHour.text = self.appDelegate.strArrivalFlightHourAux
        txtDepartureFlightHour.text = self.appDelegate.strDepartureFlightHourAux
        txtArrivalFlightCode.text = self.appDelegate.strArrivalFlightCode
        txtDepartureFlightCode.text = self.appDelegate.strDepartureFlightCode

        if self.appDelegate.gItemClassCode == "ONEWAY"{
            txtDepartureFlight.isEnabled = false
            txtDepartureFlightCode.isEnabled = false
            txtDepartureFlightHour.isEnabled = false
        }else{
            txtDepartureFlight.isEnabled = true
            txtDepartureFlightCode.isEnabled = true
            txtDepartureFlightHour.isEnabled = true
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        /*appDelegate.ynUpdTransfer = false
        appDelegate.ynCalcTransfer = false
        
        txtArrivalFlight.text = ""
        txtDepartureFlight.text = ""
        txtArrivalFlightHour.text = ""
        txtDepartureFlightHour.text = ""
        txtArrivalFlightCode.text = ""
        txtDepartureFlightCode.text = ""
        self.appDelegate.gstrOperatorNameArrival = ""
        self.appDelegate.gstrOperatorNameDeparture = ""
        self.appDelegate.strArrivalFlightHourAux = ""
        self.appDelegate.strDepartureFlightHourAux = ""
        self.appDelegate.strArrivalFlightCode = ""
        self.appDelegate.strDepartureFlightCode = ""*/
        
    }

    func addReserv() {
        
        var tableItems = RRDataSet()
        var iRes: String = ""
        var sRes: String = ""
        
        var strComment: String = ""
        
        strComment = self.txtCommentFlight.text!
        
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 100
        config.backgroundColor = UIColor(white: 1, alpha: 0.5)
        config.spinnerColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.titleTextColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.spinnerLineWidth = 2.0
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        SwiftLoader.show(title: NSLocalizedString("lblLoading",comment:""), animated: true)
        
        appDelegate.gtblStay = nil
        appDelegate.gStaysStatus = nil
        
        var prepareOrderResult:NSString="";
        
        let queue = OperationQueue()
        
        queue.addOperation() {//1
            //accion webservice-db
            if Reachability.isConnectedToNetwork(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
                let todaysDate:Date = Date()
                let dateFormatter:DateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
                let DateInFormat:String = dateFormatter.string(from: todaysDate)
                
                let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                
                tableItems = service!.wmAddReservation("GUESTAPP", sLanguageCode: self.appDelegate.strLenguaje, sSourceCode: "GUESTAPP", iPeopleFromCDRID: self.appDelegate.gstrLoginPeopleID, sFname: self.txtPersonFlightFName.text?.description, sLname1: self.txtPersonFlightLName.text?.description, sEmailAddress: self.appDelegate.gtblLogin["Email"]!, sTerminalCode: self.appDelegate.gsTerminalCode, sWorkStationCode: self.appDelegate.gsWorkStationCode, sUserLogin: "usrGuestApp", iApplicationClient: "2", iItemVariantID: self.appDelegate.gpkItemVariantID, iPax: self.appDelegate.giPeopleNumTransfer.description, sArrivalHotelCode: self.appDelegate.gstrHotelCode, sDepartureHotelCode: self.appDelegate.gstrDepHotelCode, sPaymentTypeCode: "CLUBCARD", sRoom: self.appDelegate.strUnitCodeTransfer, sConfirmationCode: self.appDelegate.gstrConfirmationCodeTransfer, dtArrivalDate: self.appDelegate.strArrivalFlightHourAux, sArrivalFlightCode: self.appDelegate.strArrivalFlightCode, sArrivalComment: self.txtCommentFlight.text?.description, dtDepartureDate: self.appDelegate.strDepartureFlightHourAux, sDepartureFlightCode: self.appDelegate.strDepartureFlightCode, ynArrival: true.description, iArrivalHotelID: self.appDelegate.strArrivalHotelID, iDepartureHotelID: self.appDelegate.strDepartureHotelID, ynIncludeDetail: true.description, sLimitDate: "23:59", dtDateIn: self.appDelegate.gstrArrivalTransfer, dtDateOut: self.appDelegate.gstrDepartureTransfer, sTransferTypeCode: self.appDelegate.gItemClassCode, sWebDocumentCode: "VTMCNFWEB_TRFR", sOrigin:"", sDestiny:"", strToken1: "", strToken2: "", strToken3: "", strToken4: "", strToken5: "POS")
                
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
                    
                    if (Int(iRes)! > 0){
                        self.appDelegate.gblPay = true
                        SwiftLoader.hide()
                        GoogleWearAlert.showAlert(title: "Reservation: " + (rowResult.getColumnByName("sResult").content as! String), type: .success, duration: 4, iAction: 1, form: "Account Payment")
                        let NextViewController = self.navigationController?.viewControllers[0]
                        self.appDelegate.gblAddFollow = true
                        
                        self.appDelegate.gstrOperatorNameArrival = ""
                        self.appDelegate.gstrOperatorNameDeparture = ""
                        self.appDelegate.strArrivalFlightHourAux = ""
                        self.appDelegate.strDepartureFlightHourAux = ""
                        self.appDelegate.gstrOperatorNameCodeArrival = ""
                        self.appDelegate.gstrOperatorNameCodeDeparture = ""
                        self.appDelegate.gstrHotelCode = ""
                        self.appDelegate.gstrHotelName = ""
                        self.appDelegate.gstrDepHotelCode = ""
                        self.appDelegate.gstrDepHotelName = ""
                        self.appDelegate.strArrivalHotelID = ""
                        self.appDelegate.strDepartureHotelID = ""
                        self.appDelegate.ynUpdTransfer = true
                        self.appDelegate.ynCalcTransfer = false
                        
                        self.navigationController?.popToViewController(NextViewController!, animated: false)
                    }else{
                        SwiftLoader.hide()
                        RKDropdownAlert.title("Reserv error", backgroundColor: UIColor.red, textColor: UIColor.black)
                        self.navigationController?.popViewController(animated: false)
                        
                    }
                    
                }

            }
        }//1
        
    }
    
    @objc func clickArrivalFlight(_ sender: AnyObject) {
        
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectStay") as! vcSelectStay
        tercerViewController.strMode = "ArrivalFlight"
        self.navigationController?.pushViewController(tercerViewController, animated: true)
        
    }
    
    @objc func clickDepartureFlight(_ sender: AnyObject) {
        
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectStay") as! vcSelectStay
        tercerViewController.strMode = "DepartureFlight"
        self.navigationController?.pushViewController(tercerViewController, animated: true)
        
    }
    
    @objc func clickArrivalFlightHour(_ sender: AnyObject) {
        
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectStay") as! vcSelectStay
        tercerViewController.strMode = "ArrivalFlightHour"
        self.navigationController?.pushViewController(tercerViewController, animated: true)
        
    }
    
    @objc func clickDepartureFlightHour(_ sender: AnyObject) {
        
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectStay") as! vcSelectStay
        tercerViewController.strMode = "DepartureFlightHour"
        self.navigationController?.pushViewController(tercerViewController, animated: true)
        
    }
    
    @objc func clickArrivalFlightCode(_ sender: AnyObject) {

        if self.appDelegate.gstrOperatorNameCodeArrival != ""{
            
            self.appDelegate.ynCargaFlightArr = true
            self.CargaFlights(iOperator: self.appDelegate.iArrOperator)

        }else{
            RKDropdownAlert.title(NSLocalizedString("lblNeedArrivalAirline",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
        }

    }
    
    @objc func clickDepartureFlightCode(_ sender: AnyObject) {

        if self.appDelegate.gstrOperatorNameCodeDeparture != ""{
            
            self.appDelegate.ynCargaFlightDep = true
            self.CargaFlights(iOperator: self.appDelegate.iDepOperator)

        }else{
            RKDropdownAlert.title(NSLocalizedString("lblNeedDepartureAirline",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
        }

    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if txtArrivalFlight == textField{
            return false
        }
        if txtArrivalFlightCode == textField{
            return false
        }
        if txtArrivalFlightHour == textField{
            return false
        }
        if txtDepartureFlight == textField{
            return false
        }
        if txtDepartureFlightCode == textField{
            return false
        }
        if txtDepartureFlightHour == textField{
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func clickSubmit(_ sender: AnyObject) {

        
        if self.txtPersonFlightFName.text?.description == ""{
            RKDropdownAlert.title(NSLocalizedString("lblNeedFirstName",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
            return
        }
        
        if self.txtPersonFlightLName.text?.description == ""{
            RKDropdownAlert.title(NSLocalizedString("lblNeedLastName",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
            return
        }

        if self.appDelegate.gItemClassCode == "ONEWAY"{
            
            if self.txtArrivalFlight.text?.description == ""{
                RKDropdownAlert.title(NSLocalizedString("lblNeedArrivalAirline",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
                return
            }
            
            if self.txtArrivalFlightCode.text?.description == ""{
                RKDropdownAlert.title(NSLocalizedString("lblNeedArrivalFlight",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
                return
            }
            
            if self.txtArrivalFlightHour.text?.description == ""{
                RKDropdownAlert.title(NSLocalizedString("lblNeedArrivalFlightHour",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
                return
            }

        }else{

            if self.txtArrivalFlight.text?.description == ""{
                RKDropdownAlert.title(NSLocalizedString("lblNeedArrivalAirline",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
                return
            }
            
            if self.txtArrivalFlightCode.text?.description == ""{
                RKDropdownAlert.title(NSLocalizedString("lblNeedArrivalFlight",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
                return
            }
            
            if self.txtArrivalFlightHour.text?.description == ""{
                RKDropdownAlert.title(NSLocalizedString("lblNeedArrivalFlightHour",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
                return
            }
            
            if self.txtDepartureFlight.text?.description == ""{
                RKDropdownAlert.title(NSLocalizedString("lblNeedDepartureAirline",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
                return
            }
            
            if self.txtDepartureFlightCode.text?.description == ""{
                RKDropdownAlert.title(NSLocalizedString("lblNeedDepartureFlight",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
                return
            }
            
            if self.txtDepartureFlightHour.text?.description == ""{
                RKDropdownAlert.title(NSLocalizedString("lblNeedDepartureFlightHour",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
                return
            }
            
        }
            
        addReserv()
        
    }
    
}
