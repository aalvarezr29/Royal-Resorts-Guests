//
//  vcCheckOutSlip.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 7/12/15.
//  Copyright © 2015 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging
import WebKit

class vcCLPaymentGateway: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!
    var strJSONParams: NSString = ""
    var width: CGFloat = 0.0 
    var height: CGFloat = 0.0
    var strAppName: String = ""
    var request: URLRequest!
    var activityIndicator = UIActivityIndicatorView(style: .gray)
    let app = UIApplication.shared
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        //Titulo de la vista
        self.title = "Costa Linda";
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(vcCLPaymentGateway.barButtonItemRefreshClicked))
        
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.backBarButtonItem?.isEnabled = false
        app.beginIgnoringInteractionEvents()
        
        //"http://wdev.rrgapps.com/clpaymentgateway/ClPayment.aspx"
        
        request = URLRequest(url: URL(string: appDelegate.gtblLogin["URLcxPay"]!)!)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let postString = "Data={\(strJSONParams.description)}"

        request.httpBody = postString.data(using: .utf8)
        //webView.allowsLinkPreview = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.isUserInteractionEnabled = true
        webView.navigationDelegate = self
        webView.load(request)
        
        self.webView.addSubview(activityIndicator)
        self.activityIndicator.startAnimating()
        self.webView.navigationDelegate = self
        self.activityIndicator.hidesWhenStopped = true
        

    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.request.description.contains("CLPaymentResult"){
            navigationItem.backBarButtonItem?.isEnabled = true
            navigationItem.leftBarButtonItem?.isEnabled = true
            self.app.endIgnoringInteractionEvents()
            appDelegate.yncxPayClose = true
        }
        if navigationAction.request.description.contains("CLPaymentFinalCompletionPage"){
            let NextViewController = self.navigationController?.viewControllers[1]
            self.navigationController?.popToViewController(NextViewController!, animated: false)
            appDelegate.yncxPayClose = true
        }
        decisionHandler(.allow)

    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
    
    @objc func barButtonItemRefreshClicked(){
        
        webView.reload()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.backBarButtonItem?.tintColor = UIColor.white

        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Account Exit Pass",
            AnalyticsParameterItemName: "Account Exit Pass",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Account Exit Pass", screenClass: strAppName)

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

}

