//
//  ViewController.swift
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
import Crashlytics

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var PinNo: String = "-1"
    var tblLogin: Dictionary<String, String>!
    var Email: String = ""
    var FullName: String = ""
    var FirstName: String = ""
    var width: CGFloat!
    var height: CGFloat!
    var ynMustLogin: Bool = false
    var mas: NSMutableAttributedString = NSMutableAttributedString()
    var PeopleIDLogged: Int32 = 0
    var CountLogin: Int32? = 0
    var urlHome: String = ""
    var btnRegister = UIButton()
    var myWebView = UIWebView()
    var imgBack = UIImage()
    var imgvwBack = UIImageView()
    var strFont: String = ""
    var btnPageBack = UIButton()
    var btnMenu = UIButton()
    var viewBar: UIView = UIView()
    var imgvw: UIImageView = UIImageView()
    var searchImage  = UIImage()
    var editButton   = UIBarButtonItem()
    var searchButton = UIBarButtonItem()
    
    @IBOutlet var ViewItem: UINavigationItem!
    @IBOutlet var btnNext: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let pre: AnyObject = Locale.preferredLanguages[0] as AnyObject
        let len: Int = pre.description.characters.count - 2
        var resultStayID: Int32 = 0
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        let strpre: String = pre.debugDescription
        
        let start = strpre.index(strpre.startIndex, offsetBy: 0)
        let end = strpre.index(strpre.endIndex, offsetBy: -len)
        let range = start..<end
        
        let mySubstring = strpre[range].description
        
        if mySubstring == "es"
        {
            appDelegate.strLenguaje = "ESP"
        }else{
            appDelegate.strLenguaje = "ENG"
        }

        width = appDelegate.width
        height = appDelegate.height

        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            //Titulo de la vista
            ViewItem.title = NSLocalizedString("Titulo",comment:"Royal Resorts")
            
            strFont = "Helvetica"
            self.navigationController?.navigationBar.tintColor = colorWithHexString("0D94FC")
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            
            btnNext.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            btnNext.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            
            //UIWebView
            urlHome = appDelegate.urlHome
            myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: height))
            myWebView.loadRequest(URLRequest(url: URL(string: urlHome)!))
            myWebView.scalesPageToFit = true
            self.view.addSubview(myWebView)
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            //Titulo de la vista
            ViewItem.title = NSLocalizedString("TituloGRM",comment:"Royal Resorts")
            strFont = "HelveticaNeue"
            
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
            var img = UIImage(named:appDelegate.gstrNavImg)
            var resizable = img!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
            self.navigationController?.navigationBar.setBackgroundImage(resizable, for: .default)
            let navigationTitleFont = UIFont(name: strFont, size: appDelegate.gblFont10 + appDelegate.gblDeviceFont3)!
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.isTranslucent = true
            //self.navigationController?.navigationBar.alpha = 0.99
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
            
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            
            btnNext.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            btnNext.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            
            var image3 = UIImage()
            image3 = UIImage(named:"Logo.png")!
            
            imgvw = UIImageView(image: image3)
            
            //UIWebView
            urlHome = appDelegate.urlHome
            /*if appDelegate.ynIPad == true{
                myWebView = UIWebView(frame: CGRectMake(0.0, 0.12*height, width, 0.88*height))
                viewBar.frame = CGRectMake(0.0, 0.05*height, width, 0.1*height);
                btnPageBack.frame = CGRectMake(0.0, 0.02*height, 0.07*width, 0.04*height);
                btnMenu.frame = CGRectMake(0.9*width, 0.02*height, 0.07*width, 0.04*height);
                imgvw.frame = CGRectMake(0.47*width, 0.015*height, 0.07*width, 0.05*height);
            }else{
                myWebView = UIWebView(frame: CGRectMake(0.0, 0.18*height, width, 0.82*height))
                viewBar.frame = CGRectMake(0.0, 0.08*height, width, 0.1*height);
                btnPageBack.frame = CGRectMake(0.0, 0.04*height, 0.07*width, 0.04*height);
                btnMenu.frame = CGRectMake(0.9*width, 0.04*height, 0.07*width, 0.04*height);
                imgvw.frame = CGRectMake(0.45*width, 0.04*height, 0.1*width, 0.05*height);
            }*/
            
            if appDelegate.ynIPad {
                switch appDelegate.Model {
                case "iPad 2":
                    myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.12*height, width: width, height: 0.88*height))
                    viewBar.frame = CGRect(x: 0.0, y: 0.05*height, width: width, height: 0.1*height);
                    btnPageBack.frame = CGRect(x: 0.0, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                    btnMenu.frame = CGRect(x: 0.9*width, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                    imgvw.frame = CGRect(x: 0.47*width, y: 0.015*height, width: 0.07*width, height: 0.05*height);
                case "iPad Air":
                    myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.12*height, width: width, height: 0.88*height))
                    viewBar.frame = CGRect(x: 0.0, y: 0.05*height, width: width, height: 0.1*height);
                    btnPageBack.frame = CGRect(x: 0.0, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                    btnMenu.frame = CGRect(x: 0.9*width, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                    imgvw.frame = CGRect(x: 0.47*width, y: 0.015*height, width: 0.07*width, height: 0.05*height);
                case "iPad Air 2":
                    myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.12*height, width: width, height: 0.88*height))
                    viewBar.frame = CGRect(x: 0.0, y: 0.05*height, width: width, height: 0.1*height);
                    btnPageBack.frame = CGRect(x: 0.0, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                    btnMenu.frame = CGRect(x: 0.9*width, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                    imgvw.frame = CGRect(x: 0.47*width, y: 0.015*height, width: 0.07*width, height: 0.05*height);
                case "iPad Pro":
                    myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.12*height, width: width, height: 0.88*height))
                    viewBar.frame = CGRect(x: 0.0, y: 0.05*height, width: width, height: 0.1*height);
                    btnPageBack.frame = CGRect(x: 0.0, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                    btnMenu.frame = CGRect(x: 0.9*width, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                    imgvw.frame = CGRect(x: 0.47*width, y: 0.015*height, width: 0.07*width, height: 0.05*height);
                case "iPad Retina":
                    myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.12*height, width: width, height: 0.88*height))
                    viewBar.frame = CGRect(x: 0.0, y: 0.05*height, width: width, height: 0.1*height);
                    btnPageBack.frame = CGRect(x: 0.0, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                    btnMenu.frame = CGRect(x: 0.9*width, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                    imgvw.frame = CGRect(x: 0.47*width, y: 0.015*height, width: 0.07*width, height: 0.05*height);
                default:
                    myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.12*height, width: width, height: 0.88*height))
                    viewBar.frame = CGRect(x: 0.0, y: 0.05*height, width: width, height: 0.1*height);
                    btnPageBack.frame = CGRect(x: 0.0, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                    btnMenu.frame = CGRect(x: 0.9*width, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                    imgvw.frame = CGRect(x: 0.47*width, y: 0.015*height, width: 0.07*width, height: 0.05*height);
                }
            }else{
                switch appDelegate.Model {
                case "iPhone":
                    myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.18*height, width: width, height: 0.82*height))
                    viewBar.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.1*height);
                    btnPageBack.frame = CGRect(x: 0.0, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    btnMenu.frame = CGRect(x: 0.9*width, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
                case "iPhone 4":
                    myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.18*height, width: width, height: 0.82*height))
                    viewBar.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.1*height);
                    btnPageBack.frame = CGRect(x: 0.0, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    btnMenu.frame = CGRect(x: 0.9*width, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
                case "iPhone 4s":
                    myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.18*height, width: width, height: 0.82*height))
                    viewBar.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.1*height);
                    btnPageBack.frame = CGRect(x: 0.0, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    btnMenu.frame = CGRect(x: 0.9*width, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
                case "iPhone 5":
                    myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.18*height, width: width, height: 0.82*height))
                    viewBar.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.1*height);
                    btnPageBack.frame = CGRect(x: 0.0, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    btnMenu.frame = CGRect(x: 0.9*width, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
                case "iPhone 5c":
                    myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.18*height, width: width, height: 0.82*height))
                    viewBar.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.1*height);
                    btnPageBack.frame = CGRect(x: 0.0, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    btnMenu.frame = CGRect(x: 0.9*width, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
                case "iPhone 5s":
                    myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.18*height, width: width, height: 0.82*height))
                    viewBar.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.1*height);
                    btnPageBack.frame = CGRect(x: 0.0, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    btnMenu.frame = CGRect(x: 0.9*width, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
                case "iPhone 6":
                    myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.18*height, width: width, height: 0.82*height))
                    viewBar.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.1*height);
                    btnPageBack.frame = CGRect(x: 0.0, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    btnMenu.frame = CGRect(x: 0.9*width, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
                case "iPhone 6 Plus":
                    myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.16*height, width: width, height: 0.84*height))
                    viewBar.frame = CGRect(x: 0.0, y: 0.06*height, width: width, height: 0.1*height);
                    btnPageBack.frame = CGRect(x: 0.0, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    btnMenu.frame = CGRect(x: 0.9*width, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
                case "iPhone 6s":
                    myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.18*height, width: width, height: 0.82*height))
                    viewBar.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.1*height);
                    btnPageBack.frame = CGRect(x: 0.0, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    btnMenu.frame = CGRect(x: 0.9*width, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
                case "iPhone 6s Plus":
                    myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.18*height, width: width, height: 0.82*height))
                    viewBar.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.1*height);
                    btnPageBack.frame = CGRect(x: 0.0, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    btnMenu.frame = CGRect(x: 0.9*width, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
                default:
                    myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.18*height, width: width, height: 0.82*height))
                    viewBar.frame = CGRect(x: 0.0, y: 0.08*height, width: width, height: 0.1*height);
                    btnPageBack.frame = CGRect(x: 0.0, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    btnMenu.frame = CGRect(x: 0.9*width, y: 0.04*height, width: 0.07*width, height: 0.04*height);
                    imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
                }
            }
            
            myWebView.loadRequest(URLRequest(url: URL(string: urlHome)!))
            myWebView.scalesPageToFit = true
            
            var image = UIImage()
            image = UIImage(named:"ic_navigate_before")!
            
            let stencil = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate) // use your UIImage here
            btnPageBack.setImage(stencil, for: UIControl.State()) // assign it to your UIButton
            btnPageBack.tintColor = UIColor.gray // set a color
            btnPageBack.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            btnPageBack.addTarget(self, action: #selector(ViewController.GoBack(_:)), for: UIControl.Event.touchUpInside)
            
            var image2 = UIImage()
            image2 = UIImage(named:"ic_dehaze")!
            
            let stencil2 = image2.withRenderingMode(UIImage.RenderingMode.alwaysTemplate) // use your UIImage here
            btnMenu.setImage(stencil2, for: UIControl.State())
            btnMenu.tintColor = UIColor.gray // set a color
            btnMenu.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
            btnMenu.addTarget(self, action: #selector(ViewController.GoPagMenu(_:)), for: UIControl.Event.touchUpInside)
            
            viewBar.backgroundColor = UIColor.white
            
            viewBar.addSubview(btnPageBack)
            viewBar.addSubview(btnMenu)
            viewBar.addSubview(imgvw)
            
            self.view.addSubview(viewBar)
            self.view.addSubview(myWebView)
            self.view.backgroundColor = UIColor.black
            
            //appDelegate.strLenguaje = "ENG"
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            //Titulo de la vista
            ViewItem.title = NSLocalizedString("TituloSBR",comment:"Royal Resorts")
            
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

            imgBack = UIImage(named:"BackAqua.png")!
            imgvwBack = UIImageView(image: imgBack)
            imgvwBack.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height);
            imgvwBack.alpha = 0.2
            self.view.addSubview(imgvwBack)
            
            btnNext.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            btnNext.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            
            //UIWebView
            urlHome = appDelegate.urlHome
            if appDelegate.ynIPad == true{
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.05*height, width: width, height: height))
            }else{
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.08*height, width: width, height: height))
            }
            myWebView.loadRequest(URLRequest(url: URL(string: urlHome)!))
            myWebView.scalesPageToFit = true
            self.view.addSubview(myWebView)
            
            //appDelegate.strLenguaje = "ENG"
            
        }

        //Boton Refresh
        ViewItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(ViewController.barButtonItemRefreshClicked))

        //Validar si la tabla de Login estan vacia #0D79FE
        queueFM?.inDatabase() {
            db in
            
            let resultCount = db.intForQuery("SELECT PersonalID FROM tblLogin WHERE PIN = 0" as String,"" as AnyObject)
            
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
        
        self.CountLogin = resultStayID
        
        if (CountLogin != nil){ //si no existe la tabla
            if (CountLogin == 0){
                ynMustLogin = true
            }else{
                ynMustLogin = false
            }
        }

        btnRegister.frame = CGRect(x: 0.0, y: 44, width: 0.1*width, height: 0.04*height);

        //debe loguearse por que no hubo un Usuario Activo
        if (ynMustLogin == true){
            //print("viewDidLoadSignIn")
            /*btnNext.setTitle(NSLocalizedString("Iniciar",comment:""), forState: UIControlState.Normal)
            btnNext.titleLabel?.textAlignment = NSTextAlignment.Right
            btnNext.titleLabel?.text = NSLocalizedString("Iniciar",comment:"")
            btnNext.sizeToFit()*/
            mas = NSMutableAttributedString(string: NSLocalizedString("Iniciar",comment:""), attributes: [
                NSAttributedString.Key.font: UIFont(name:strFont, size:appDelegate.gblFont9 + appDelegate.gblDeviceFont3)!
                ])
            btnNext.setAttributedTitle(mas, for: UIControl.State())
            btnNext.titleLabel?.textAlignment = NSTextAlignment.right
            btnNext.titleLabel?.text = NSLocalizedString("Iniciar",comment:"")
            btnNext.sizeToFit()
            
            btnNext.titleLabel?.text = ""

            searchImage  = UIImage(named: "ic_redo")!
            
            editButton   = UIBarButtonItem(title: NSLocalizedString("Iniciar",comment:""),  style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.Clicknext(_:)))
            searchButton = UIBarButtonItem(image: searchImage,  style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.Clicknext(_:)))
            
            navigationItem.rightBarButtonItems = [searchButton, editButton]
            
        }else{
            //se obtiene PersonalID del Usuario Activo
            queueFM?.inDatabase() {
                db in
                
                let resultCount = db.intForQuery("SELECT PersonalID FROM tblLogin WHERE PIN = 0" as String,"" as AnyObject)
                
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
            
            PeopleIDLogged = resultStayID
            
            appDelegate.gstrLoginPeopleID = PeopleIDLogged.description
            
            if (PeopleIDLogged > 0){
                //print("viewDidLoadUser")
                //se llena la tabla con la informacion del Usuario Activo
                var tblLoginAux: Dictionary<String, String>!
                var strQuery: String = ""
                
                if (String(PeopleIDLogged)==""){
                    strQuery = "SELECT * FROM tblLogin WHERE PIN > 0"
                }else{
                    strQuery = "SELECT * FROM tblLogin WHERE PersonalID = ?"
                }
                
                tblLoginAux = [:]
                
                queueFM?.inDatabase() {
                    db in
                    
                    if let rs = db.executeQuery(strQuery, withArgumentsIn: [String(self.PeopleIDLogged)]){
                        while rs.next() {
                            tblLoginAux["Email"] = rs.string(forColumn: "Email")!
                            tblLoginAux["PIN"] = rs.string(forColumn: "PIN")!
                            tblLoginAux["PersonalID"] = rs.string(forColumn: "PersonalID")!
                            tblLoginAux["Gender"] = rs.string(forColumn: "Gender")!
                            tblLoginAux["Lenguage"] = rs.string(forColumn: "Lenguage")!
                            tblLoginAux["FullName"] = rs.string(forColumn: "FullName")!
                            tblLoginAux["FirstName"] = rs.string(forColumn: "FirstName")!
                            tblLoginAux["LastName"] = rs.string(forColumn: "LastName")!
                            tblLoginAux["Field1"] = rs.string(forColumn: "Field1")!
                            tblLoginAux["Field2"] = rs.string(forColumn: "Field2")!
                            tblLoginAux["Field3"] = rs.string(forColumn: "Field3")!
                            tblLoginAux["Field4"] = rs.string(forColumn: "Field4")!
                            tblLoginAux["Field5"] = rs.string(forColumn: "Field5")!
                            tblLoginAux["LastStayUpdate"] = rs.string(forColumn: "LastStayUpdate")!
                            tblLoginAux["PeopleType"] = rs.string(forColumn: "PeopleType")!
                        }
                    } else {
                        print("select failure: \(db.lastErrorMessage())")
                    }
                    
                }
                
                tblLogin = tblLoginAux
                appDelegate.gtblLogin = tblLogin
                
                let NextViewController = self.storyboard?.instantiateViewController(withIdentifier: "tcGuestServicesMain") as! UITabBarController
                appDelegate.ynHome = true
                self.navigationController?.pushViewController(NextViewController, animated: true)

            }

        }
        
        Analytics.setScreenName("Home", screenClass: appDelegate.gstrAppName)

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
        super.viewWillAppear(true)
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Home",
            AnalyticsParameterItemName: "Home",
            AnalyticsParameterContentType: "Pantalla"
            ])

        Analytics.setScreenName("Home", screenClass: appDelegate.gstrAppName)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func Clicknext(_ sender: UIButton) {
        
        //valida si tiene PIN
        if (PinNo != "-1")
        {   //Si tiene se muestra la vista de stays
            let NextViewController = self.storyboard?.instantiateViewController(withIdentifier: "tcGuestServicesMain") as! UITabBarController
            appDelegate.ynHome = true
            self.navigationController?.pushViewController(NextViewController, animated: true)
            
        } else
        {
            //si no tiene se muestra la vista de logueo
            let NextViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcGuestLogin") as! vcGuestLogin
            appDelegate.ynHome = false
            self.navigationController?.pushViewController(NextViewController, animated: true)
            
        }
    }
    
    @objc func GoBack(_ sender: UIButton) {
        if myWebView.canGoBack {
            myWebView.goBack()
        }
    }
    
    @objc func GoPagMenu(_ sender: UIButton) {
        myWebView.loadRequest(URLRequest(url: URL(string: urlHome)!))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appDelegate.gblGoHome = false

        if (appDelegate.gstrLoginPeopleID == ""){//si se ha deslogueado
            
            //print("viewDidAppearSignIn")
            
            if btnNext.titleLabel?.text != NSLocalizedString("Iniciar",comment:"")
            {
                appDelegate.gtblLogin = nil
                tblLogin = nil
                PinNo = "-1"
                Email = ""
                FullName = ""
                FirstName = ""
                
                mas = NSMutableAttributedString(string: NSLocalizedString("Iniciar",comment:""), attributes: [
                    NSAttributedString.Key.font: UIFont(name:strFont, size:appDelegate.gblFont9 + appDelegate.gblDeviceFont3)!
                    ])
                btnNext.setAttributedTitle(mas, for: UIControl.State())
                btnNext.titleLabel?.textAlignment = NSTextAlignment.right
                btnNext.titleLabel?.text = NSLocalizedString("Iniciar",comment:"")
                btnNext.sizeToFit()
                
                btnNext.titleLabel?.text = ""
                
                navigationItem.rightBarButtonItems?.removeAll()
                
                searchImage  = UIImage(named: "ic_redo")!
                
                editButton   = UIBarButtonItem(title: NSLocalizedString("Iniciar",comment:""),  style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.Clicknext(_:)))
                searchButton = UIBarButtonItem(image: searchImage,  style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.Clicknext(_:)))
                
                navigationItem.rightBarButtonItems = [searchButton, editButton]
                
            }

            appDelegate.gblGoOut = false
        }else{
            if (appDelegate.gtblLogin != nil){
                
                //print("viewDidAppearUser")
                
                tblLogin = appDelegate.gtblLogin //si le dio click a home
                Email = tblLogin["Email"]!
                FullName = tblLogin["FullName"]!
                PinNo = tblLogin["PIN"]!
                FirstName = tblLogin["FirstName"]!
                
                mas = NSMutableAttributedString(string: tblLogin["FirstName"]!, attributes: [
                    NSAttributedString.Key.font: UIFont(name:strFont, size:appDelegate.gblFont6 + appDelegate.gblDeviceFont3)!
                    ])
                btnNext.setAttributedTitle(mas, for: UIControl.State())
                btnNext.setTitleColor(UIColor.blue, for: UIControl.State())
                btnNext.titleLabel?.textAlignment = NSTextAlignment.right
                btnNext.sizeToFit()
                
                navigationItem.rightBarButtonItems?.removeAll()
                
                searchImage  = UIImage(named: "ic_input")!
                
                editButton   = UIBarButtonItem(title: NSLocalizedString(tblLogin["FirstName"]!,comment:""),  style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.Clicknext(_:)))
                searchButton = UIBarButtonItem(image: searchImage,  style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.Clicknext(_:)))
                
                navigationItem.rightBarButtonItems = [searchButton, editButton]
                
            }
            
        }
        
    }

    //Funcion para refrescar la la pagina
    @objc func barButtonItemRefreshClicked(){
        
        myWebView.reload()
        
    }
    
}

