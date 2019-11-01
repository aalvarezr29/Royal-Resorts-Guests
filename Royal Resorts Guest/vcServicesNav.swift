//
//  vcServicesNav.swift
//  Royal Resorts Guest
//
//  Created by Soluciones on 10/21/19.
//  Copyright © 2019 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging

class vcServicesNav: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var strFont: String = ""
    var myWebView = UIWebView()
    var urlHome: String = ""
    var btnPageBack = UIButton()
    var btnMenu = UIButton()
    var viewBar: UIView = UIView()
    var imgvw: UIImageView = UIImageView()
    var titleCode:String = ""
  
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
        
        //Boton Home
        //ViewItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("btnHome",comment:""), style: .plain, target: self, action: #selector(vcActivity.clickHome(_:)))
        
        let TabTitleFont = UIFont(name: "HelveticaNeue", size: appDelegate.gblFont10 + appDelegate.gblDeviceFont2)!
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            strFont = "Helvetica"
            self.navigationController?.navigationBar.tintColor = colorWithHexString("0D94FC")
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            
            //UIWebView
            //urlHome = appDelegate.urlActiv
            if appDelegate.ynIPad == true{
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: -10, width: width, height: height+10))
            }else{
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: -10, width: width, height: height))
            }
            myWebView.loadRequest(URLRequest(url: URL(string: urlHome)!))
            myWebView.clipsToBounds = true
            self.view.addSubview(myWebView)
            
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
            
            self.view.backgroundColor = UIColor.white
            
            var image3 = UIImage()
            image3 = UIImage(named:"Logo.png")!
            
            imgvw = UIImageView(image: image3)
            
            //UIWebView
            urlHome = appDelegate.urlActiv
            
            ViewItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State())
            
            /*if appDelegate.ynIPad == true{
             myWebView = UIWebView(frame: CGRectMake(0.0, 0.1*height, width, 0.83*height))
             viewBar.frame = CGRectMake(0.0, 0.03*height, width, 0.1*height);
             btnPageBack.frame = CGRectMake(0.0, 0.02*height, 0.07*width, 0.04*height);
             btnMenu.frame = CGRectMake(0.9*width, 0.02*height, 0.07*width, 0.04*height);
             imgvw.frame = CGRectMake(0.47*width, 0.015*height, 0.07*width, 0.05*height);
             }else{
             myWebView = UIWebView(frame: CGRectMake(0.0, 0.14*height, width, 0.73*height))
             viewBar.frame = CGRectMake(0.0, 0.04*height, width, 0.1*height);
             btnPageBack.frame = CGRectMake(0.0, 0.05*height, 0.07*width, 0.04*height);
             btnMenu.frame = CGRectMake(0.9*width, 0.05*height, 0.07*width, 0.04*height);
             imgvw.frame = CGRectMake(0.45*width, 0.04*height, 0.1*width, 0.05*height);
             }*/
            
            
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
            
            //UIWebView
            urlHome = appDelegate.urlActiv
            if appDelegate.ynIPad == true{
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: -10, width: width, height: height+10))
            }else{
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: -10, width: width, height: height))
            }
            myWebView.loadRequest(URLRequest(url: URL(string: urlHome)!))
            myWebView.clipsToBounds = true
            self.view.addSubview(myWebView)
            
            ViewItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State())
            
        }
        
        if appDelegate.ynIPad {
            switch appDelegate.Model {
            case "iPad 2":
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.1*height, width: width, height: 0.83*height))
                viewBar.frame = CGRect(x: 0.0, y: 0.03*height, width: width, height: 0.1*height);
                btnPageBack.frame = CGRect(x: 0.0, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                btnMenu.frame = CGRect(x: 0.9*width, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                imgvw.frame = CGRect(x: 0.47*width, y: 0.015*height, width: 0.07*width, height: 0.05*height);
            case "iPad Air":
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.1*height, width: width, height: 0.83*height))
                viewBar.frame = CGRect(x: 0.0, y: 0.03*height, width: width, height: 0.1*height);
                btnPageBack.frame = CGRect(x: 0.0, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                btnMenu.frame = CGRect(x: 0.9*width, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                imgvw.frame = CGRect(x: 0.47*width, y: 0.015*height, width: 0.07*width, height: 0.05*height);
            case "iPad Air 2":
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.1*height, width: width, height: 0.83*height))
                viewBar.frame = CGRect(x: 0.0, y: 0.03*height, width: width, height: 0.1*height);
                btnPageBack.frame = CGRect(x: 0.0, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                btnMenu.frame = CGRect(x: 0.9*width, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                imgvw.frame = CGRect(x: 0.47*width, y: 0.015*height, width: 0.07*width, height: 0.05*height);
            case "iPad Pro":
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.1*height, width: width, height: 0.83*height))
                viewBar.frame = CGRect(x: 0.0, y: 0.03*height, width: width, height: 0.1*height);
                btnPageBack.frame = CGRect(x: 0.0, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                btnMenu.frame = CGRect(x: 0.9*width, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                imgvw.frame = CGRect(x: 0.47*width, y: 0.015*height, width: 0.07*width, height: 0.05*height);
            case "iPad Retina":
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.1*height, width: width, height: 0.83*height))
                viewBar.frame = CGRect(x: 0.0, y: 0.03*height, width: width, height: 0.1*height);
                btnPageBack.frame = CGRect(x: 0.0, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                btnMenu.frame = CGRect(x: 0.9*width, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                imgvw.frame = CGRect(x: 0.47*width, y: 0.015*height, width: 0.07*width, height: 0.05*height);
            default:
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.1*height, width: width, height: 0.83*height))
                viewBar.frame = CGRect(x: 0.0, y: 0.03*height, width: width, height: 0.1*height);
                btnPageBack.frame = CGRect(x: 0.0, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                btnMenu.frame = CGRect(x: 0.9*width, y: 0.02*height, width: 0.07*width, height: 0.04*height);
                imgvw.frame = CGRect(x: 0.47*width, y: 0.015*height, width: 0.07*width, height: 0.05*height);
            }
        }else{
            switch appDelegate.Model {
            case "iPhone":
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.14*height, width: width, height: 0.73*height))
                viewBar.frame = CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.1*height);
                btnPageBack.frame = CGRect(x: 0.0, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                btnMenu.frame = CGRect(x: 0.9*width, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
            case "iPhone 4":
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.14*height, width: width, height: 0.73*height))
                viewBar.frame = CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.1*height);
                btnPageBack.frame = CGRect(x: 0.0, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                btnMenu.frame = CGRect(x: 0.9*width, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
            case "iPhone 4s":
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.14*height, width: width, height: 0.73*height))
                viewBar.frame = CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.1*height);
                btnPageBack.frame = CGRect(x: 0.0, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                btnMenu.frame = CGRect(x: 0.9*width, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
            case "iPhone 5":
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.14*height, width: width, height: 0.73*height))
                viewBar.frame = CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.1*height);
                btnPageBack.frame = CGRect(x: 0.0, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                btnMenu.frame = CGRect(x: 0.9*width, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
            case "iPhone 5c":
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.14*height, width: width, height: 0.73*height))
                viewBar.frame = CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.1*height);
                btnPageBack.frame = CGRect(x: 0.0, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                btnMenu.frame = CGRect(x: 0.9*width, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
            case "iPhone 5s":
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.14*height, width: width, height: 0.73*height))
                viewBar.frame = CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.1*height);
                btnPageBack.frame = CGRect(x: 0.0, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                btnMenu.frame = CGRect(x: 0.9*width, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
            case "iPhone 6":
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.14*height, width: width, height: 0.73*height))
                viewBar.frame = CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.1*height);
                btnPageBack.frame = CGRect(x: 0.0, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                btnMenu.frame = CGRect(x: 0.9*width, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
            case "iPhone 6 Plus":
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.14*height, width: width, height: 0.77*height))
                viewBar.frame = CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.1*height);
                btnPageBack.frame = CGRect(x: 0.0, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                btnMenu.frame = CGRect(x: 0.9*width, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
            case "iPhone 6s":
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.14*height, width: width, height: 0.73*height))
                viewBar.frame = CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.1*height);
                btnPageBack.frame = CGRect(x: 0.0, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                btnMenu.frame = CGRect(x: 0.9*width, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
            case "iPhone 6s Plus":
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.14*height, width: width, height: 0.73*height))
                viewBar.frame = CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.1*height);
                btnPageBack.frame = CGRect(x: 0.0, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                btnMenu.frame = CGRect(x: 0.9*width, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                imgvw.frame = CGRect(x: 0.45*width, y: 0.04*height, width: 0.1*width, height: 0.05*height);
            default:
                myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.14*height, width: width, height: 0.73*height))
                viewBar.frame = CGRect(x: 0.0, y: 0.04*height, width: width, height: 0.1*height);
                btnPageBack.frame = CGRect(x: 0.0, y: 0.05*height, width: 0.07*width, height: 0.04*height);
                btnMenu.frame = CGRect(x: 0.9*width, y: 0.05*height, width: 0.07*width, height: 0.04*height);
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
        
        //myWebView.scrollView.backgroundColor = UIColor.whiteColor()
        myWebView.isOpaque = true
        myWebView.backgroundColor = UIColor.white
        
        self.view.addSubview(viewBar)
        self.view.addSubview(myWebView)
        //self.view.backgroundColor = UIColor.blackColor()
        
    }
    
    @objc func GoBack(_ sender: UIButton) {
        if myWebView.canGoBack {
            myWebView.goBack()
        }
    }
    
    @objc func GoPagMenu(_ sender: UIButton) {
        myWebView.loadRequest(URLRequest(url: URL(string: urlHome)!))
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.toolbar.isHidden = true
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Activity",
            AnalyticsParameterItemName: "Activity",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Activity", screenClass: appDelegate.gstrAppName)
        
    }
    
}

