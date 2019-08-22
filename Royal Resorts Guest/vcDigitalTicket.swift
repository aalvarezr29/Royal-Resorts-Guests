//
//  vcDigitalTicket.swift
//  Royal Resorts Guest
//
//  Created by Alan Alvarez Ramirez on 5/8/19.
//  Copyright © 2019 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging

class vcDigitalTicket: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var width: CGFloat!
    var height: CGFloat!
    var btnBack = UIButton()
    var barNavigate: UINavigationBar = UINavigationBar()
    var NavigationItem: UINavigationItem = UINavigationItem()
    var btnAccount: UIBarButtonItem = UIBarButtonItem()
    
    var strDate: String = ""
    var strOutDate: String = ""
    var strUnitCode: String = ""
    var strName: String = ""
    var strNumPerson: String = ""
    var StayInfoID: String = ""
    var Stays: Dictionary<String, String>!
    var Peoples: Dictionary<String, String>!
    var myWebView = UIWebView()
    var URLTicket: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        self.view.backgroundColor = UIColor.white
        self.view.bounds = CGRect(x: 0.0, y: 0.0, width: width, height: height);
        
        //Titulo de la vista
        self.title = NSLocalizedString("lbltitleDigitalTicket",comment:"");
        
        myWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.08*height, width: width, height: height))
        myWebView.loadRequest(URLRequest(url: URL(string: URLTicket)!))
        myWebView.scalesPageToFit = true
        self.view.addSubview(myWebView)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-Digital Ticket",
            AnalyticsParameterItemName: "Digital Ticket",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Digital Ticket", screenClass: appDelegate.gstrAppName)
        
    }

    func clickAccount(_ sender:UIButton!)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}

