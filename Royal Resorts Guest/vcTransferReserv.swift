//
//  vcTransferReserv.swift
//  Royal Resorts Guest
//
//  Created by Soluciones on 12/24/19.
//  Copyright © 2019 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging
import DGRunkeeperSwitch

class vcTransferReserv: UIViewController {
    
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
    var imgvwThomas = UIImageView()
    var imgvwTrip = UIImageView()
    var imgvwBar = UIImageView()
    var SwitchRound: DGRunkeeperSwitch!
    var SwitchShared: DGRunkeeperSwitch!
    var lblUSTel = UILabel()
    var lblMexTel = UILabel()
    var lblOtherTel1 = UILabel()
    var lblOtherTel2 = UILabel()
    var tblTransferType: [Dictionary<String, String>]!
    var strPriceUSD: String = ""
    var strPriceMX: String = ""
    var strItemClassCode: String = ""
    var strItemTypeCode: String = ""
    var btnContinue = UIButton()
    var btnQR = UIButton()
    var lblPressCode = UILabel()
    
    var strArrivaldate: String = ""
    var strresConfCode: String = ""
    var strConfirmationNo: String = ""
    var strDeparturePax: String = ""
    var strDepartureDate: String = ""
    var strItemDesc: String = ""
    var strHotelName: String = ""
    var strName: String = ""
    var barCodeImage = UIImage()
    var barCode = UIImageView()
    
    @IBOutlet var ViewItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        self.tabBarController?.navigationController?.navigationBar.isHidden = true;
        self.navigationController?.navigationBar.isHidden = false;
        self.navigationController?.isToolbarHidden = false;

        let strFullName = appDelegate.gtblLogin["FullName"]!
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString(titleCode,comment:"");

        //Boton Add
        //ViewItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("btnEditInfo",comment:""), style: .plain, target: self, action: #selector(vcTransferDate.clickAdd(_:)))
        
        let TabTitleFont = UIFont(name: "HelveticaNeue", size: appDelegate.gblFont10 + appDelegate.gblDeviceFont2)!
        //let barcode = UIImage(barcode: strConfirmationNo) // yields UIImage?
        
        //create barcode image
        barCode = UIImageView(image: barCodeImage)
        barCode.image = generateQRCode(from: "-" + strConfirmationNo + "-")
        
        btnQR.setBackgroundImage(barCode.image, for: UIControl.State())
        btnQR.addTarget(self, action: #selector(vcTransferReserv.clickQRView(_:)), for: UIControl.Event.touchUpInside)
        //add barcode to the scene
        //barCode.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        
            lblUserName = UILabel(frame: CGRect(x: 0.05*width, y: 0.07*height, width: 0.9*width, height: 0.04*height));
            lblMsgError = UILabel(frame: CGRect(x: 0.05*width, y: 0.1*height, width: 0.9*width, height: 0.04*height));
            lblArrivalDate = UILabel(frame: CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.04*height));
            lblUsaCan = UILabel(frame: CGRect(x: 0.05*width, y: 0.17*height, width: 0.9*width, height: 0.03*height));
            lblUSTel = UILabel(frame: CGRect(x: 0.05*width, y: 0.2*height, width: 0.9*width, height: 0.03*height));
            lblMex = UILabel(frame: CGRect(x: 0.05*width, y: 0.23*height, width: 0.9*width, height: 0.06*height));
            lblMexTel = UILabel(frame: CGRect(x: 0.05*width, y: 0.29*height, width: 0.9*width, height: 0.03*height));
            lblOther = UILabel(frame: CGRect(x: 0.05*width, y: 0.34*height, width: 0.9*width, height: 0.03*height));
            lblOtherTel1 = UILabel(frame: CGRect(x: 0.05*width, y: 0.37*height, width: 0.9*width, height: 0.06*height));
            lblPressCode = UILabel(frame: CGRect(x: 0.05*width, y: 0.41*height, width: 0.9*width, height: 0.06*height));
            btnQR.frame = CGRect(x: 0.4*width, y: 0.47*height, width: 0.2*width, height: 0.2*width)
            lblOtherTel2 = UILabel(frame: CGRect(x: 0.05*width, y: 0.63*height, width: 0.9*width, height: 0.03*height));
            imgvwThomas.frame = CGRect(x: 0.2*width, y: 0.66*height, width: 0.3*width, height: 0.13*height)
            imgvwTrip.frame = CGRect(x: 0.5*width, y: 0.66*height, width: 0.3*width, height: 0.13*height)
            lblSat = UILabel(frame: CGRect(x: 0.05*width, y: 0.8*height, width: 0.9*width, height: 0.03*height));
            lblEmail = UILabel(frame: CGRect(x: 0.05*width, y: 0.85*height, width: 0.9*width, height: 0.03*height));

            //imgvwBar.image = barcode

            lblUserName.backgroundColor = UIColor.clear;
            lblUserName.textAlignment = NSTextAlignment.left;
            lblUserName.textColor = colorWithHexString("000000")
            lblUserName.numberOfLines = 2;
            lblUserName.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblUserName.text = NSLocalizedString("strThank",comment:"") + " " + strFullName + "!"
            
            lblMsgError.backgroundColor = UIColor.clear;
            lblMsgError.textAlignment = NSTextAlignment.left;
            lblMsgError.textColor = colorWithHexString("000000")
            lblMsgError.numberOfLines = 4;
            lblMsgError.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblMsgError.text = NSLocalizedString("strConf",comment:"")
            
            lblArrivalDate.backgroundColor = UIColor.clear;
            lblArrivalDate.textAlignment = NSTextAlignment.left;
            lblArrivalDate.textColor = colorWithHexString("000000")
            lblArrivalDate.numberOfLines = 1;
            lblArrivalDate.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont4)
            lblArrivalDate.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont8 + appDelegate.gblDeviceFont4);
            lblArrivalDate.text = "#" + strConfirmationNo

            lblUsaCan.backgroundColor = UIColor.clear;
            lblUsaCan.textAlignment = NSTextAlignment.center;
            lblUsaCan.textColor = colorWithHexString("000000")
            lblUsaCan.numberOfLines = 1;
            lblUsaCan.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblUsaCan.text = strName + ", " + strDeparturePax + " " + NSLocalizedString("strPaxAux",comment:"")
            
            lblUSTel.backgroundColor = UIColor.clear;
            lblUSTel.textAlignment = NSTextAlignment.center;
            lblUSTel.textColor = colorWithHexString("000000")
            lblUSTel.numberOfLines = 1;
            lblUSTel.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            if strItemDesc.contains("ONE WAY") {
                lblUSTel.text = strArrivaldate
            }else{
                lblUSTel.text = strArrivaldate + " - " + strDepartureDate
            }

            lblMex.backgroundColor = UIColor.clear;
            lblMex.textAlignment = NSTextAlignment.center;
            lblMex.textColor = colorWithHexString("000000")
            lblMex.numberOfLines = 2;
            lblMex.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblMex.text = strItemDesc
            
            lblMexTel.backgroundColor = UIColor.clear;
            lblMexTel.textAlignment = NSTextAlignment.center;
            lblMexTel.textColor = colorWithHexString("000000")
            lblMexTel.numberOfLines = 1;
            lblMexTel.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblMexTel.text = NSLocalizedString("strAeroPuerto",comment:"") + strHotelName
            
            lblOther.backgroundColor = UIColor.clear;
            lblOther.textAlignment = NSTextAlignment.left;
            lblOther.textColor = colorWithHexString("000000")
            lblOther.numberOfLines = 1;
            lblOther.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblOther.text = NSLocalizedString("strYouSoon",comment:"")
            
            lblOtherTel1.backgroundColor = UIColor.clear;
            lblOtherTel1.textAlignment = NSTextAlignment.left;
            lblOtherTel1.textColor = colorWithHexString("000000")
            lblOtherTel1.numberOfLines = 2;
            lblOtherTel1.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblOtherTel1.text = NSLocalizedString("strScan",comment:"")
            //lblOtherTel1.adjustsFontSizeToFitWidth = true
        
            lblOtherTel2.backgroundColor = UIColor.clear;
            lblOtherTel2.textAlignment = NSTextAlignment.center;
            lblOtherTel2.textColor = colorWithHexString("000000")
            lblOtherTel2.numberOfLines = 1;
            lblOtherTel2.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblOtherTel2.text = NSLocalizedString("strItSafe",comment:"")

            lblSat.backgroundColor = UIColor.clear;
            lblSat.textAlignment = NSTextAlignment.center;
            lblSat.textColor = colorWithHexString("000000")
            lblSat.numberOfLines = 1;
            lblSat.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblSat.text = NSLocalizedString("lblHelpTransfer",comment:"");

            lblEmail.backgroundColor = UIColor.clear;
            lblEmail.textAlignment = NSTextAlignment.center;
            lblEmail.textColor = colorWithHexString("000000")
            lblEmail.numberOfLines = 1;
            lblEmail.font = UIFont(name: "HelveticaNeue-Bold", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblEmail.text = NSLocalizedString("lblEmail",comment:"");
        
            lblPressCode.backgroundColor = UIColor.clear;
            lblPressCode.textAlignment = NSTextAlignment.left;
            lblPressCode.textColor = colorWithHexString("FF8000")
            lblPressCode.numberOfLines = 2;
            lblPressCode.font = UIFont(name: "HelveticaNeue-Bold", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblPressCode.text = NSLocalizedString("lblPressCode",comment:"");
        
            self.imgvwThomas.downloadedFrom(url: URL.init(string: ("https://www.royalresorts.com/wp-content/uploads/2019/11/imagotipo-VTM.png"))!)
            if appDelegate.strLenguaje == "ENG"{
                self.imgvwTrip.downloadedFrom(url: URL.init(string: ("https://www.royalresorts.com/wp-content/uploads/2019/11/Trip-EN.png"))!)
            }else{
                self.imgvwTrip.downloadedFrom(url: URL.init(string: ("https://www.royalresorts.com/wp-content/uploads/2019/11/trip-ES.png"))!)
            }

            self.view.addSubview(self.lblUserName)
            self.view.addSubview(self.lblMsgError)
            self.view.addSubview(self.lblArrivalDate)
            self.view.addSubview(self.lblUsaCan)
            self.view.addSubview(self.lblUSTel)
            self.view.addSubview(self.lblMex)
            self.view.addSubview(self.lblMexTel)
            self.view.addSubview(self.lblOther)
            self.view.addSubview(self.lblOtherTel1)
            self.view.addSubview(self.lblOtherTel2)
            self.view.addSubview(self.lblSat)
            self.view.addSubview(self.lblEmail)
            self.view.addSubview(btnQR)
            self.view.addSubview(self.imgvwThomas)
            self.view.addSubview(self.imgvwTrip)
            self.view.addSubview(self.lblPressCode)

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
        
        
        //recargarHotelItems()
        

    }
    
    func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
         
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            if let output = filter.outputImage {
                return UIImage(ciImage: output)
            }
        }
         
        return nil
    }

    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 12, y: 12)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
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
            AnalyticsParameterItemID: "id-TransferReserv",
            AnalyticsParameterItemName: "TransferReserv",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("TransferReserv", screenClass: appDelegate.gstrAppName)
        
    }

    @objc func clickQRView(_ sender: AnyObject){
        
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcImgViewer") as! vcImgViewer
        tercerViewController.barCode = barCode
        self.navigationController?.pushViewController(tercerViewController, animated: true)
        
    }
    
    @objc func clickAdd(_ sender: AnyObject){
        
        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcTransferEdit") as! vcTransferEdit
        self.navigationController?.pushViewController(tercerViewController, animated: true)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*for touch: AnyObject in touches {
            let location = touch.location(in: self.view)
            if lblUSTel.frame.contains(location) {
                UIApplication.shared.openURL(NSURL(string: lblUSTel.text!.description) as! URL)
            }
        }*/
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcImgViewer") as! vcImgViewer
            tercerViewController.barCode = barCode
            self.navigationController?.pushViewController(tercerViewController, animated: true)
        }
    }
    
}

