//
//  vcMessage.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 21/09/15.
//  Copyright (c) 2015 Marco Cocom. All rights reserved.
//

import UIKit
import WebKit

class vcMessage: UIViewController{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var width: CGFloat!
    var height: CGFloat!
    var btnBack = UIButton()
    var strCategoryDesc: String = ""
    var strDate: String = ""
    var strHour: String = ""
    var strMessage: String = ""
    var strHTMLMessage: String = ""
    var strImageURL: String = ""
    var strViewed: String = ""
    var strID: String = ""
    
    @IBOutlet var ViewItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 44));
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center;
        label.textColor = UIColor.black
        label.numberOfLines = 1;
        
        //fSizeFont = 15.0 + appDelegate.gblDeviceFont
        
        label.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont9 + appDelegate.gblDeviceFont3);
        label.text = NSLocalizedString("lblMessageat",comment:"") + strDate;
        //label.frame = CGRectMake(0.3*width, 0.01*height, 0.4*width, 0.05*height);
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString("lblNotificationDetail",comment:"");
        
        
        let lblCategory = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 44));
        lblCategory.backgroundColor = UIColor.clear
        lblCategory.textAlignment = NSTextAlignment.left;
        lblCategory.textColor = colorWithHexString("ba8748")
        lblCategory.numberOfLines = 1;
        lblCategory.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont5 + appDelegate.gblDeviceFont3);
        lblCategory.text = strCategoryDesc;
        lblCategory.frame = CGRect(x: 0.05*width, y: 0.08*height, width: 0.5*width, height: 0.04*height)
        
        let lblDate = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 44));
        lblDate.backgroundColor = UIColor.clear
        lblDate.textAlignment = NSTextAlignment.left;
        lblDate.textColor = colorWithHexString("ba8748")
        lblDate.numberOfLines = 1;
        lblDate.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont5 + appDelegate.gblDeviceFont3);
        lblDate.text = strDate + " " + strHour;
        lblDate.frame = CGRect(x: 0.65*width, y: 0.08*height, width: 0.3*width, height: 0.04*height)
        
        let lblMessage = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 44));
        lblMessage.backgroundColor = UIColor.clear
        lblMessage.textAlignment = NSTextAlignment.left;
        lblMessage.textColor = colorWithHexString("ba8748")
        lblMessage.numberOfLines = 0;
        lblMessage.font = UIFont.boldSystemFont(ofSize: appDelegate.gblFont5 + appDelegate.gblDeviceFont3);
        lblMessage.text = strMessage;
        lblMessage.frame = CGRect(x: 0.05*width, y: 0.15*height, width: 0.9*width, height: 0.2*height)
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            lblCategory.textColor = UIColor.black
            lblDate.textColor = UIColor.black
            lblMessage.textColor = UIColor.black
            
        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            lblCategory.textColor = colorWithHexString("ba8748")
            lblDate.textColor = colorWithHexString("ba8748")
            lblMessage.textColor = colorWithHexString("ba8748")
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            lblCategory.textColor = colorWithHexString("00467f")
            lblDate.textColor = colorWithHexString("00467f")
            lblMessage.textColor = colorWithHexString("00467f")
            
        }
        
        let myWebView = WKWebView()
        myWebView.loadHTMLString(strHTMLMessage, baseURL: nil)
        
        myWebView.frame = CGRect(x: 0.05*width, y: 0.15*height, width: 0.9*width, height: 0.6*height)
        
        
        var imgCell = UIImage()
        var imgvwCell = UIImageView()
        
        imgvwCell = UIImageView(image: imgCell)
        if strImageURL != "" {
            imgvwCell.downloadedFrom(url: URL(string: strImageURL)!)
        }

        imgvwCell.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imgvwCell.translatesAutoresizingMaskIntoConstraints = true
        
        imgvwCell.contentMode = .scaleToFill
        
        imgvwCell.frame = CGRect(x: 0.05*width, y: 0.15*height, width: 0.9*width, height: 0.2*height)
        
        if strHTMLMessage.description.trimmingCharacters(in: .whitespacesAndNewlines) == "null"{
            
            strHTMLMessage = ""
        }
        
        if strHTMLMessage != ""
        {
            
            self.view.addSubview(lblCategory)
            self.view.addSubview(lblDate)
            self.view.addSubview(myWebView)
 
        }else{
            
            if strImageURL != ""
            {
                
                self.view.addSubview(lblCategory)
                self.view.addSubview(lblDate)
                self.view.addSubview(imgvwCell)
                
            }else{
                
                self.view.addSubview(lblCategory)
                self.view.addSubview(lblDate)
                self.view.addSubview(lblMessage)
                
            }
            
        }

        if (strViewed == "0"){
        
            updateYnViewed(PeopleID: appDelegate.gstrLoginPeopleID, ID: strID)
        
        }
        
    }
    
    func updateYnViewed(PeopleID: String, ID: String) {
        
        var queueFM: FMDatabaseQueue?
        
        queueFM = FMDatabaseQueue(path: Util.getPath("GuestStay.sqlite"))
        
        queueFM?.inTransaction { db, rollback in
            do {
                
                try db.executeUpdate("UPDATE tblPushMessage SET ynViewed = 1 WHERE _id=?", withArgumentsIn: [ID])
                
            } catch {
                rollback.pointee = true
                return
                    print(error)
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
    
    @IBAction func clickAccount(sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            //print("link")
            guard let url = navigationAction.request.url else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        //print("no link")
        decisionHandler(WKNavigationActionPolicy.allow)

    }
    
    /*func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        if navigationType == .linkClicked {
            
            guard let url = request.url else { return true }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return false
        }
        return true
    }*/
    
}
