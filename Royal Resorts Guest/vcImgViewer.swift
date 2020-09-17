//
//  vcImgViewer.swift
//  Royal Resorts Guest
//
//  Created by Soluciones on 1/13/20.
//  Copyright © 2020 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging

class vcImgViewer: UIViewController {
    
    var barCode = UIImageView()
    @IBOutlet var ViewItem: UINavigationItem!
    
let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        self.tabBarController?.navigationController?.navigationBar.isHidden = true;
        self.navigationController?.navigationBar.isHidden = false;
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        self.navigationController?.isToolbarHidden = false;
        
        ViewItem.title = "";

        barCode.frame = CGRect(x: 0.2*width, y: 0.2*height, width: 0.6*width, height: 0.6*width)
        
        self.view.addSubview(barCode)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.toolbar.isHidden = true
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-QRViewer",
            AnalyticsParameterItemName: "QRViewer",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("QRViewer", screenClass: appDelegate.gstrAppName)
        
        UIScreen.main.brightness = CGFloat(1)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        UIScreen.main.brightness = appDelegate.gblBrillo
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.navigationController?.popViewController(animated: false)
        }
    }

}
