//
//  vcServices.swift
//  Royal Resorts Guest
//
//  Created by Soluciones on 10/18/19.
//  Copyright © 2019 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging
import DGRunkeeperSwitch

class vcServices: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var width: CGFloat!
    var height: CGFloat!
    var btnBack = UIButton()
    var btnNext = UIButton()
    var tblFollowUp: [Dictionary<String, String>]!
    var tblFollowUpType: [Dictionary<String, String>]!
    
    var StayInfoID: String = ""
    var PeopleID: String = ""
    var PeopleFDeskID: String = ""
    var formatter = NumberFormatter()
    var btnAddRequest = UIButton()
    var tblLogin: Dictionary<String, String>!
    var LastName: String = ""
    var ynShowHistory: Bool = false
    var swTypePay = UISwitch()
    var tableViewContentOffset = CGPoint()
    
    var Voucher: String!
    var fSizeFont: CGFloat = 0
    var ynConn:Bool=false
    var lastIndex = IndexPath()
    var ynActualiza: Bool = false
    var refreshControl: UIRefreshControl!
    var runkeeperSwitch: DGRunkeeperSwitch!
    var imgBack = UIImage()
    var imgvwBack = UIImageView()
    var strFont: String = ""
    var imgCell = UIImage()
    var imgvwCell = UIImageView()
    var imgvwHouse = UIImageView()
    var imgvwMant = UIImageView()
    var imgvwFdesk = UIImageView()
    var imgvwSep = UIImageView()
    var imgvwTransfer = UIImageView()
    var imgvwOnLine = UIImageView()
    var imgvwRent = UIImageView()
    var imgvwGift = UIImageView()
    var imgvwMarket = UIImageView()

    var btnHouse = UIButton()
    var btnMant = UIButton()
    var btnFdesk = UIButton()
    var btnTransfer = UIButton()
    var btnOnLine = UIButton()
    var btnRent = UIButton()
    var btnGift = UIButton()
    var btnMarket = UIButton()
    
    var URLTransfer: String = ""
    var URLOnLine: String = ""
    var URLRent: String = ""
    var URLGift: String = ""
    var URLMarket: String = ""
    
    var HouseID: String = ""
    var MantID: String = ""
    var FdeskID: String = ""
    
    var HouseDesc: String = ""
    var MantDesc: String = ""
    var FdeskDesc: String = ""
    
    var strEmailList: String = ""
    
    var lblHouse: UILabel = UILabel()
    var lblMant: UILabel = UILabel()
    var lblFdesk: UILabel = UILabel()
    var lblTransfer: UILabel = UILabel()
    var lblOnLine: UILabel = UILabel()
    var lblRent: UILabel = UILabel()
    var lblGift: UILabel = UILabel()
    var lblMarket: UILabel = UILabel()
    var lineView: UIView = UIView()
    
    @IBOutlet var ViewItem: UINavigationItem!
    @IBOutlet weak var BodyView: UIView!
    @IBOutlet weak var AccView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = appDelegate.width
        height = appDelegate.height
        
        self.view.bounds = CGRect(x: 0.0, y: -20, width: width, height: height);
        self.tabBarController?.navigationController?.navigationBar.isHidden = true;
        self.navigationController?.navigationBar.isHidden = false;
        self.navigationController?.isToolbarHidden = false;
        
        BodyView.frame = CGRect(x: 0.0, y: 0.05*height, width: width, height: height);
        
        //Titulo de la vista
        ViewItem.title = NSLocalizedString("lblAddServices",comment:"");

        self.ynActualiza = true
        
        if appDelegate.ynIPad {
                switch appDelegate.Model {
                case "iPad 2":
                    self.imgvwHouse.frame = CGRect(x: 0.07*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwMant.frame = CGRect(x: 0.37*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwFdesk.frame = CGRect(x: 0.67*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwSep.frame = CGRect(x: 0.0, y: 0.14*self.height, width: 0.99*self.width, height: 0.05*self.height)
                    self.lineView.frame = CGRect(x: 0.04*self.width, y: 0.26*self.height, width: 0.92*self.width, height: 1.0)
                    self.imgvwTransfer.frame = CGRect(x: 0.17*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwOnLine.frame = CGRect(x: 0.5*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwRent.frame = CGRect(x: 0.17*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwGift.frame = CGRect(x: 0.5*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwMarket.frame = CGRect(x: 0.3*self.width, y: 0.56*self.height, width: 0.3*self.width, height: 0.13*self.height)
                    AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.9*height);
                case "iPad Air":
                    self.imgvwHouse.frame = CGRect(x: 0.07*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwMant.frame = CGRect(x: 0.37*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwFdesk.frame = CGRect(x: 0.67*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwSep.frame = CGRect(x: 0.0, y: 0.14*self.height, width: 0.99*self.width, height: 0.05*self.height)
                    self.lineView.frame = CGRect(x: 0.04*self.width, y: 0.26*self.height, width: 0.92*self.width, height: 1.0)
                    self.imgvwTransfer.frame = CGRect(x: 0.17*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwOnLine.frame = CGRect(x: 0.5*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwRent.frame = CGRect(x: 0.17*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwGift.frame = CGRect(x: 0.5*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwMarket.frame = CGRect(x: 0.3*self.width, y: 0.56*self.height, width: 0.3*self.width, height: 0.13*self.height)
                    AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.9*height);
                case "iPad Air 2":
                    self.imgvwHouse.frame = CGRect(x: 0.07*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwMant.frame = CGRect(x: 0.37*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwFdesk.frame = CGRect(x: 0.67*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwSep.frame = CGRect(x: 0.0, y: 0.14*self.height, width: 0.99*self.width, height: 0.05*self.height)
                    self.lineView.frame = CGRect(x: 0.04*self.width, y: 0.26*self.height, width: 0.92*self.width, height: 1.0)
                    self.imgvwTransfer.frame = CGRect(x: 0.17*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwOnLine.frame = CGRect(x: 0.5*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwRent.frame = CGRect(x: 0.17*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwGift.frame = CGRect(x: 0.5*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwMarket.frame = CGRect(x: 0.3*self.width, y: 0.56*self.height, width: 0.3*self.width, height: 0.13*self.height)
                    AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.9*height);
                case "iPad Pro":
                    self.imgvwHouse.frame = CGRect(x: 0.07*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwMant.frame = CGRect(x: 0.37*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwFdesk.frame = CGRect(x: 0.67*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwSep.frame = CGRect(x: 0.0, y: 0.14*self.height, width: 0.99*self.width, height: 0.05*self.height)
                    self.lineView.frame = CGRect(x: 0.04*self.width, y: 0.26*self.height, width: 0.92*self.width, height: 1.0)
                    self.imgvwTransfer.frame = CGRect(x: 0.17*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwOnLine.frame = CGRect(x: 0.5*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwRent.frame = CGRect(x: 0.17*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwGift.frame = CGRect(x: 0.5*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwMarket.frame = CGRect(x: 0.3*self.width, y: 0.56*self.height, width: 0.3*self.width, height: 0.13*self.height)
                    AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.9*height);
                case "iPad Retina":
                    self.imgvwHouse.frame = CGRect(x: 0.07*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwMant.frame = CGRect(x: 0.37*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwFdesk.frame = CGRect(x: 0.67*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwSep.frame = CGRect(x: 0.0, y: 0.14*self.height, width: 0.99*self.width, height: 0.05*self.height)
                    self.lineView.frame = CGRect(x: 0.04*self.width, y: 0.26*self.height, width: 0.92*self.width, height: 1.0)
                    self.imgvwTransfer.frame = CGRect(x: 0.17*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwOnLine.frame = CGRect(x: 0.5*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwRent.frame = CGRect(x: 0.17*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwGift.frame = CGRect(x: 0.5*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwMarket.frame = CGRect(x: 0.3*self.width, y: 0.56*self.height, width: 0.3*self.width, height: 0.13*self.height)
                    AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.9*height);
                default:
                    self.imgvwHouse.frame = CGRect(x: 0.07*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwMant.frame = CGRect(x: 0.37*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwFdesk.frame = CGRect(x: 0.67*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwSep.frame = CGRect(x: 0.0, y: 0.14*self.height, width: 0.99*self.width, height: 0.05*self.height)
                    self.lineView.frame = CGRect(x: 0.04*self.width, y: 0.26*self.height, width: 0.92*self.width, height: 1.0)
                    self.imgvwTransfer.frame = CGRect(x: 0.17*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwOnLine.frame = CGRect(x: 0.5*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwRent.frame = CGRect(x: 0.17*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwGift.frame = CGRect(x: 0.5*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwMarket.frame = CGRect(x: 0.3*self.width, y: 0.56*self.height, width: 0.3*self.width, height: 0.13*self.height)
                    AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.9*height);
                }
            }else{
                switch appDelegate.Model {
                case "iPhone":
                    self.imgvwHouse.frame = CGRect(x: 0.07*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwMant.frame = CGRect(x: 0.37*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwFdesk.frame = CGRect(x: 0.67*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwSep.frame = CGRect(x: 0.0, y: 0.14*self.height, width: 0.99*self.width, height: 0.05*self.height)
                    self.lineView.frame = CGRect(x: 0.04*self.width, y: 0.26*self.height, width: 0.92*self.width, height: 1.0)
                    self.imgvwTransfer.frame = CGRect(x: 0.17*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwOnLine.frame = CGRect(x: 0.5*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwRent.frame = CGRect(x: 0.17*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwGift.frame = CGRect(x: 0.5*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwMarket.frame = CGRect(x: 0.3*self.width, y: 0.56*self.height, width: 0.3*self.width, height: 0.13*self.height)
                    AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.9*height);
                case "iPhone 4":
                    self.imgvwHouse.frame = CGRect(x: 0.07*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwMant.frame = CGRect(x: 0.37*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwFdesk.frame = CGRect(x: 0.67*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwSep.frame = CGRect(x: 0.0, y: 0.14*self.height, width: 0.99*self.width, height: 0.05*self.height)
                    self.lineView.frame = CGRect(x: 0.04*self.width, y: 0.26*self.height, width: 0.92*self.width, height: 1.0)
                    self.imgvwTransfer.frame = CGRect(x: 0.17*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwOnLine.frame = CGRect(x: 0.5*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwRent.frame = CGRect(x: 0.17*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwGift.frame = CGRect(x: 0.5*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwMarket.frame = CGRect(x: 0.3*self.width, y: 0.56*self.height, width: 0.3*self.width, height: 0.13*self.height)
                    AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.9*height);
                case "iPhone 4s":
                    self.imgvwHouse.frame = CGRect(x: 0.07*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwMant.frame = CGRect(x: 0.37*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwFdesk.frame = CGRect(x: 0.67*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwSep.frame = CGRect(x: 0.0, y: 0.14*self.height, width: 0.99*self.width, height: 0.05*self.height)
                    self.lineView.frame = CGRect(x: 0.04*self.width, y: 0.26*self.height, width: 0.92*self.width, height: 1.0)
                    self.imgvwTransfer.frame = CGRect(x: 0.17*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwOnLine.frame = CGRect(x: 0.5*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwRent.frame = CGRect(x: 0.17*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwGift.frame = CGRect(x: 0.5*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwMarket.frame = CGRect(x: 0.3*self.width, y: 0.56*self.height, width: 0.3*self.width, height: 0.13*self.height)
                    AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.9*height);
                case "iPhone 5":
                    self.imgvwHouse.frame = CGRect(x: 0.07*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwMant.frame = CGRect(x: 0.37*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwFdesk.frame = CGRect(x: 0.67*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwSep.frame = CGRect(x: 0.0, y: 0.14*self.height, width: 0.99*self.width, height: 0.05*self.height)
                    self.lineView.frame = CGRect(x: 0.04*self.width, y: 0.26*self.height, width: 0.92*self.width, height: 1.0)
                    self.imgvwTransfer.frame = CGRect(x: 0.17*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwOnLine.frame = CGRect(x: 0.5*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwRent.frame = CGRect(x: 0.17*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwGift.frame = CGRect(x: 0.5*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwMarket.frame = CGRect(x: 0.3*self.width, y: 0.56*self.height, width: 0.3*self.width, height: 0.13*self.height)
                    AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.9*height);
                case "iPhone 5c":
                    self.imgvwHouse.frame = CGRect(x: 0.07*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwMant.frame = CGRect(x: 0.37*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwFdesk.frame = CGRect(x: 0.67*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwSep.frame = CGRect(x: 0.0, y: 0.14*self.height, width: 0.99*self.width, height: 0.05*self.height)
                    self.lineView.frame = CGRect(x: 0.04*self.width, y: 0.26*self.height, width: 0.92*self.width, height: 1.0)
                    self.imgvwTransfer.frame = CGRect(x: 0.17*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwOnLine.frame = CGRect(x: 0.5*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwRent.frame = CGRect(x: 0.17*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwGift.frame = CGRect(x: 0.5*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwMarket.frame = CGRect(x: 0.3*self.width, y: 0.56*self.height, width: 0.3*self.width, height: 0.13*self.height)
                    AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.9*height);
                case "iPhone 5s":
                    self.imgvwHouse.frame = CGRect(x: 0.07*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwMant.frame = CGRect(x: 0.37*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwFdesk.frame = CGRect(x: 0.67*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwSep.frame = CGRect(x: 0.0, y: 0.14*self.height, width: 0.99*self.width, height: 0.05*self.height)
                    self.lineView.frame = CGRect(x: 0.04*self.width, y: 0.26*self.height, width: 0.92*self.width, height: 1.0)
                    self.imgvwTransfer.frame = CGRect(x: 0.17*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwOnLine.frame = CGRect(x: 0.5*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwRent.frame = CGRect(x: 0.17*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwGift.frame = CGRect(x: 0.5*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwMarket.frame = CGRect(x: 0.3*self.width, y: 0.56*self.height, width: 0.3*self.width, height: 0.13*self.height)
                    AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.9*height);
                case "iPhone 6":
                    self.imgvwHouse.frame = CGRect(x: 0.07*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwMant.frame = CGRect(x: 0.37*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwFdesk.frame = CGRect(x: 0.67*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwSep.frame = CGRect(x: 0.0, y: 0.14*self.height, width: 0.99*self.width, height: 0.05*self.height)
                    self.lineView.frame = CGRect(x: 0.04*self.width, y: 0.26*self.height, width: 0.92*self.width, height: 1.0)
                    self.imgvwTransfer.frame = CGRect(x: 0.17*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwOnLine.frame = CGRect(x: 0.5*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwRent.frame = CGRect(x: 0.17*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwGift.frame = CGRect(x: 0.5*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwMarket.frame = CGRect(x: 0.3*self.width, y: 0.56*self.height, width: 0.3*self.width, height: 0.13*self.height)
                    AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.9*height);
                case "iPhone 6 Plus":
                    self.imgvwHouse.frame = CGRect(x: 0.07*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwMant.frame = CGRect(x: 0.37*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwFdesk.frame = CGRect(x: 0.67*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwSep.frame = CGRect(x: 0.0, y: 0.14*self.height, width: 0.99*self.width, height: 0.05*self.height)
                    self.lineView.frame = CGRect(x: 0.04*self.width, y: 0.26*self.height, width: 0.92*self.width, height: 1.0)
                    self.imgvwTransfer.frame = CGRect(x: 0.17*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwOnLine.frame = CGRect(x: 0.5*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwRent.frame = CGRect(x: 0.17*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwGift.frame = CGRect(x: 0.5*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwMarket.frame = CGRect(x: 0.3*self.width, y: 0.56*self.height, width: 0.3*self.width, height: 0.13*self.height)
                    AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.9*height);
                case "iPhone 6s":
                    self.imgvwHouse.frame = CGRect(x: 0.07*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwMant.frame = CGRect(x: 0.37*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwFdesk.frame = CGRect(x: 0.67*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwSep.frame = CGRect(x: 0.0, y: 0.14*self.height, width: 0.99*self.width, height: 0.05*self.height)
                    self.lineView.frame = CGRect(x: 0.04*self.width, y: 0.26*self.height, width: 0.92*self.width, height: 1.0)
                    self.imgvwTransfer.frame = CGRect(x: 0.17*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwOnLine.frame = CGRect(x: 0.5*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwRent.frame = CGRect(x: 0.17*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwGift.frame = CGRect(x: 0.5*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwMarket.frame = CGRect(x: 0.3*self.width, y: 0.56*self.height, width: 0.3*self.width, height: 0.13*self.height)
                    AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.9*height);
                case "iPhone 6s Plus":
                    self.imgvwHouse.frame = CGRect(x: 0.07*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwMant.frame = CGRect(x: 0.37*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwFdesk.frame = CGRect(x: 0.67*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwSep.frame = CGRect(x: 0.0, y: 0.14*self.height, width: 0.99*self.width, height: 0.05*self.height)
                    self.lineView.frame = CGRect(x: 0.04*self.width, y: 0.26*self.height, width: 0.92*self.width, height: 1.0)
                    self.imgvwTransfer.frame = CGRect(x: 0.17*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwOnLine.frame = CGRect(x: 0.5*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwRent.frame = CGRect(x: 0.17*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwGift.frame = CGRect(x: 0.5*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwMarket.frame = CGRect(x: 0.3*self.width, y: 0.56*self.height, width: 0.3*self.width, height: 0.13*self.height)
                    AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.9*height);
                default:
                    self.imgvwHouse.frame = CGRect(x: 0.07*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwMant.frame = CGRect(x: 0.37*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwFdesk.frame = CGRect(x: 0.67*self.width, y: 0.01*self.height, width: 0.18*self.width, height: 0.1*self.height)
                    self.imgvwSep.frame = CGRect(x: 0.0, y: 0.14*self.height, width: 0.99*self.width, height: 0.05*self.height)
                    self.lineView.frame = CGRect(x: 0.04*self.width, y: 0.26*self.height, width: 0.92*self.width, height: 1.0)
                    self.imgvwTransfer.frame = CGRect(x: 0.17*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwOnLine.frame = CGRect(x: 0.5*self.width, y: 0.18*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwRent.frame = CGRect(x: 0.17*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwGift.frame = CGRect(x: 0.5*self.width, y: 0.37*self.height, width: 0.25*self.width, height: 0.13*self.height)
                    self.imgvwMarket.frame = CGRect(x: 0.3*self.width, y: 0.56*self.height, width: 0.3*self.width, height: 0.13*self.height)
                    AccView.frame = CGRect(x: 0.05*width, y: 0.09*height, width: 0.9*width, height: 0.9*height);
                }
            }
            
            //Boton Home
            //ViewItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("btnHome",comment:""), style: .plain, target: self, action: #selector(vcRequestFollowUp.clickHome(_:)))
            
            let TabTitleFont = UIFont(name: "HelveticaNeue", size: appDelegate.gblFont10 + appDelegate.gblDeviceFont2)!
            
            if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{

                
                self.AccView.addSubview(self.imgvwHouse)
                
                lblHouse = UILabel(frame: CGRect(x: 0.05*self.width, y: 0.12*height, width: 0.22*width, height: 0.03*height));
                lblHouse.backgroundColor = UIColor.clear;
                lblHouse.textAlignment = NSTextAlignment.center;
                lblHouse.textColor = colorWithHexString("465261")
                lblHouse.numberOfLines = 1;
                lblHouse.font = UIFont(name: "Verdana", size: appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
                lblHouse.text = NSLocalizedString("lblHouse",comment:"");
                self.AccView.addSubview(self.lblHouse)
                
                var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapHouse(tapGestureRecognizer:)))
                self.imgvwHouse.isUserInteractionEnabled = true
                self.imgvwHouse.addGestureRecognizer(tapGestureRecognizer)
                
                
                self.AccView.addSubview(self.imgvwMant)
                
                lblMant = UILabel(frame: CGRect(x: 0.35*self.width, y: 0.12*height, width: 0.22*width, height: 0.03*height));
                lblMant.backgroundColor = UIColor.clear;
                lblMant.textAlignment = NSTextAlignment.center;
                lblMant.textColor = colorWithHexString("465261")
                lblMant.numberOfLines = 1;
                lblMant.font = UIFont(name: "Verdana", size: appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
                lblMant.text = NSLocalizedString("lblMant",comment:"");
                self.AccView.addSubview(self.lblMant)
                
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapMant(tapGestureRecognizer:)))
                self.imgvwMant.isUserInteractionEnabled = true
                self.imgvwMant.addGestureRecognizer(tapGestureRecognizer)
                
                
                self.AccView.addSubview(self.imgvwFdesk)
                
                lblFdesk = UILabel(frame: CGRect(x: 0.65*self.width, y: 0.12*height, width: 0.22*width, height: 0.03*height));
                lblFdesk.backgroundColor = UIColor.clear;
                lblFdesk.textAlignment = NSTextAlignment.center;
                lblFdesk.textColor = colorWithHexString("465261")
                lblFdesk.numberOfLines = 1;
                lblFdesk.font = UIFont(name: "Verdana", size: appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
                lblFdesk.text = NSLocalizedString("lblFdesk",comment:"");
                self.AccView.addSubview(self.lblFdesk)
                
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapFdesk(tapGestureRecognizer:)))
                self.imgvwFdesk.isUserInteractionEnabled = true
                self.imgvwFdesk.addGestureRecognizer(tapGestureRecognizer)
                
                //self.imgvwSep.downloadedFrom(url: URL.init(string: "https://ya-webdesign.com/images600_/thin-line-png-19.png")!)
                //self.imgvwSep.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                //self.imgvwSep.translatesAutoresizingMaskIntoConstraints = true
                //self.imgvwSep.contentMode = .scaleToFill
                
                lineView.layer.borderWidth = 1.0
                lineView.layer.borderColor = UIColor.black.cgColor
                self.view.addSubview(lineView)
                
                self.AccView.addSubview(self.imgvwSep)
                
                self.AccView.addSubview(self.imgvwTransfer)
                
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapTransfer(tapGestureRecognizer:)))
                self.imgvwTransfer.isUserInteractionEnabled = true
                self.imgvwTransfer.addGestureRecognizer(tapGestureRecognizer)
                
                lblTransfer = UILabel(frame: CGRect(x: 0.03*self.width, y: 0.3*height, width: 0.5*width, height: 0.03*height));
                lblTransfer.backgroundColor = UIColor.clear;
                lblTransfer.textAlignment = NSTextAlignment.center;
                lblTransfer.textColor = colorWithHexString("465261")
                lblTransfer.numberOfLines = 0;
                lblTransfer.font = UIFont(name: "Verdana", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont4)
                lblTransfer.text = NSLocalizedString("lblTransfer",comment:"");
                //lblTransfer.adjustsFontSizeToFitWidth = false
                lblTransfer.lineBreakMode = .byWordWrapping
                self.AccView.addSubview(self.lblTransfer)
                
                
                self.AccView.addSubview(self.imgvwOnLine)
                
                lblOnLine = UILabel(frame: CGRect(x: 0.45*self.width, y: 0.3*height, width: 0.4*width, height: 0.03*height));
                lblOnLine.backgroundColor = UIColor.clear;
                lblOnLine.textAlignment = NSTextAlignment.center;
                lblOnLine.textColor = colorWithHexString("465261")
                lblOnLine.numberOfLines = 0;
                lblOnLine.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
                lblOnLine.text = NSLocalizedString("lblOnLine",comment:"");
                lblTransfer.adjustsFontSizeToFitWidth = true
                self.AccView.addSubview(self.lblOnLine)
                
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapOnLine(tapGestureRecognizer:)))
                self.imgvwOnLine.isUserInteractionEnabled = true
                self.imgvwOnLine.addGestureRecognizer(tapGestureRecognizer)
                
                self.AccView.addSubview(self.imgvwRent)
                
                lblRent = UILabel(frame: CGRect(x: 0.1*self.width, y: 0.52*height, width: 0.4*width, height: 0.03*height));
                lblRent.backgroundColor = UIColor.clear;
                lblRent.textAlignment = NSTextAlignment.center;
                lblRent.textColor = colorWithHexString("465261")
                lblRent.numberOfLines = 0;
                lblRent.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
                lblRent.text = NSLocalizedString("lblRent",comment:"");
                lblTransfer.adjustsFontSizeToFitWidth = true
                self.AccView.addSubview(self.lblRent)
                
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapRent(tapGestureRecognizer:)))
                self.imgvwRent.isUserInteractionEnabled = true
                self.imgvwRent.addGestureRecognizer(tapGestureRecognizer)
                
                self.AccView.addSubview(self.imgvwGift)
                
                lblGift = UILabel(frame: CGRect(x: 0.45*self.width, y: 0.52*height, width: 0.4*width, height: 0.03*height));
                lblGift.backgroundColor = UIColor.clear;
                lblGift.textAlignment = NSTextAlignment.center;
                lblGift.textColor = colorWithHexString("465261")
                lblGift.numberOfLines = 0;
                lblGift.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
                lblGift.text = NSLocalizedString("lblGift",comment:"");
                lblTransfer.adjustsFontSizeToFitWidth = true
                self.AccView.addSubview(self.lblGift)
                
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGift(tapGestureRecognizer:)))
                self.imgvwGift.isUserInteractionEnabled = true
                self.imgvwGift.addGestureRecognizer(tapGestureRecognizer)
                
                self.AccView.addSubview(self.imgvwMarket)
                
                lblMarket = UILabel(frame: CGRect(x: 0.25*self.width, y: 0.72*height, width: 0.4*width, height: 0.03*height));
                lblMarket.backgroundColor = UIColor.clear;
                lblMarket.textAlignment = NSTextAlignment.center;
                lblMarket.textColor = colorWithHexString("465261")
                lblMarket.numberOfLines = 0;
                lblMarket.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
                lblMarket.text = NSLocalizedString("lblMarket",comment:"");
                lblTransfer.adjustsFontSizeToFitWidth = true
                self.AccView.addSubview(self.lblMarket)
                
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapMarket(tapGestureRecognizer:)))
                self.imgvwMarket.isUserInteractionEnabled = true
                self.imgvwMarket.addGestureRecognizer(tapGestureRecognizer)
                
                cargarDatos()
                
                strFont = "Helvetica"
                self.navigationController?.navigationBar.tintColor = colorWithHexString("0D94FC")
                self.navigationController?.navigationBar.barStyle = UIBarStyle.default
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
                
                ViewItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: colorWithHexString("0D94FC")], for: UIControl.State())
                
                
            }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{

                //Boton Add
                /*ViewItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(vcRequestFollowUp.clickAdd(_:)))
                
                AccView.addSubview(runkeeperSwitch)
                
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
                self.navigationController?.navigationBar.shadowImage = UIImage()
                
                strFont = "HelveticaNeue"
                let img = UIImage(named:appDelegate.gstrNavImg)
                let resizable = img!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
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
                
                var imgBack = UIImage()
                var imgvwBack = UIImageView()
                
                AccView.backgroundColor = UIColor.clear
                
                self.view.backgroundColor = UIColor.white
                
                imgBack = UIImage(named:"bg.png")!
                imgvwBack = UIImageView(image: imgBack)
                imgvwBack.frame = CGRect(x: 0.0, y: -0.05*height, width: width, height: height+(0.05*height));
                imgvwBack.alpha = 0.3
                imgvwBack.contentMode = UIView.ContentMode.scaleAspectFill
                //self.view.addSubview(imgvwBack)
                
                runkeeperSwitch.backgroundColor = self.colorWithHexString ("ba8748")
                runkeeperSwitch.selectedTitleColor = self.colorWithHexString ("ba8748")
                
                ViewItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State())*/

                self.AccView.addSubview(self.imgvwHouse)
                
                lblHouse = UILabel(frame: CGRect(x: 0.05*self.width, y: 0.12*height, width: 0.22*width, height: 0.03*height));
                lblHouse.backgroundColor = UIColor.clear;
                lblHouse.textAlignment = NSTextAlignment.center;
                lblHouse.textColor = colorWithHexString("ba8748")
                lblHouse.numberOfLines = 1;
                lblHouse.font = UIFont(name: "Verdana", size: appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
                lblHouse.text = NSLocalizedString("lblHouse",comment:"");
                self.AccView.addSubview(self.lblHouse)
                
                var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapHouse(tapGestureRecognizer:)))
                self.imgvwHouse.isUserInteractionEnabled = true
                self.imgvwHouse.addGestureRecognizer(tapGestureRecognizer)
                
                
                self.AccView.addSubview(self.imgvwMant)
                
                lblMant = UILabel(frame: CGRect(x: 0.35*self.width, y: 0.12*height, width: 0.22*width, height: 0.03*height));
                lblMant.backgroundColor = UIColor.clear;
                lblMant.textAlignment = NSTextAlignment.center;
                lblMant.textColor = colorWithHexString("ba8748")
                lblMant.numberOfLines = 1;
                lblMant.font = UIFont(name: "Verdana", size: appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
                lblMant.text = NSLocalizedString("lblConcierge",comment:"");
                self.AccView.addSubview(self.lblMant)
                
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapMant(tapGestureRecognizer:)))
                self.imgvwMant.isUserInteractionEnabled = true
                self.imgvwMant.addGestureRecognizer(tapGestureRecognizer)
                
                self.AccView.addSubview(self.imgvwFdesk)
                
                lblFdesk = UILabel(frame: CGRect(x: 0.65*self.width, y: 0.12*height, width: 0.22*width, height: 0.03*height));
                lblFdesk.backgroundColor = UIColor.clear;
                lblFdesk.textAlignment = NSTextAlignment.center;
                lblFdesk.textColor = colorWithHexString("ba8748")
                lblFdesk.numberOfLines = 1;
                lblFdesk.font = UIFont(name: "Verdana", size: appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
                lblFdesk.text = NSLocalizedString("lblFdesk",comment:"");
                self.AccView.addSubview(self.lblFdesk)
                
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapFdesk(tapGestureRecognizer:)))
                self.imgvwFdesk.isUserInteractionEnabled = true
                self.imgvwFdesk.addGestureRecognizer(tapGestureRecognizer)
                
                lineView.layer.borderWidth = 1.0
                lineView.layer.borderColor = UIColor.black.cgColor
                self.view.addSubview(lineView)
                
                self.AccView.addSubview(self.imgvwSep)
                
                cargarDatos()
                
                strFont = "Helvetica"
                self.navigationController?.navigationBar.tintColor = colorWithHexString("ffffff")
                self.navigationController?.navigationBar.barStyle = UIBarStyle.default
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                
                ViewItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: colorWithHexString("ffffff")], for: UIControl.State())
                
            }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{

                self.navigationController?.navigationBar.tintColor = UIColor.white
                
                self.AccView.addSubview(self.imgvwHouse)
                
                lblHouse = UILabel(frame: CGRect(x: 0.05*self.width, y: 0.12*height, width: 0.22*width, height: 0.03*height));
                lblHouse.backgroundColor = UIColor.clear;
                lblHouse.textAlignment = NSTextAlignment.center;
                lblHouse.textColor = colorWithHexString("2e3634")
                lblHouse.numberOfLines = 1;
                lblHouse.font = UIFont(name: "Verdana", size: appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
                lblHouse.text = NSLocalizedString("lblHouse",comment:"");
                self.AccView.addSubview(self.lblHouse)
                
                var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapHouse(tapGestureRecognizer:)))
                self.imgvwHouse.isUserInteractionEnabled = true
                self.imgvwHouse.addGestureRecognizer(tapGestureRecognizer)
                
                
                self.AccView.addSubview(self.imgvwMant)
                
                lblMant = UILabel(frame: CGRect(x: 0.35*self.width, y: 0.12*height, width: 0.22*width, height: 0.03*height));
                lblMant.backgroundColor = UIColor.clear;
                lblMant.textAlignment = NSTextAlignment.center;
                lblMant.textColor = colorWithHexString("2e3634")
                lblMant.numberOfLines = 1;
                lblMant.font = UIFont(name: "Verdana", size: appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
                lblMant.text = NSLocalizedString("lblMant",comment:"");
                self.AccView.addSubview(self.lblMant)
                
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapMant(tapGestureRecognizer:)))
                self.imgvwMant.isUserInteractionEnabled = true
                self.imgvwMant.addGestureRecognizer(tapGestureRecognizer)
                
                
                self.AccView.addSubview(self.imgvwFdesk)
                
                lblFdesk = UILabel(frame: CGRect(x: 0.65*self.width, y: 0.12*height, width: 0.22*width, height: 0.03*height));
                lblFdesk.backgroundColor = UIColor.clear;
                lblFdesk.textAlignment = NSTextAlignment.center;
                lblFdesk.textColor = colorWithHexString("2e3634")
                lblFdesk.numberOfLines = 1;
                lblFdesk.font = UIFont(name: "Verdana", size: appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
                lblFdesk.text = NSLocalizedString("lblFdesk",comment:"");
                self.AccView.addSubview(self.lblFdesk)
                
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapFdesk(tapGestureRecognizer:)))
                self.imgvwFdesk.isUserInteractionEnabled = true
                self.imgvwFdesk.addGestureRecognizer(tapGestureRecognizer)
                
                lineView.layer.borderWidth = 1.0
                lineView.layer.borderColor = UIColor.black.cgColor
                self.view.addSubview(lineView)
                
                self.AccView.addSubview(self.imgvwSep)
                
                cargarDatos()

                ViewItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: colorWithHexString("ffffff")], for: UIControl.State())
            }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{

                self.navigationController?.navigationBar.tintColor = UIColor.white
                
                self.AccView.addSubview(self.imgvwHouse)
                
                lblHouse = UILabel(frame: CGRect(x: 0.05*self.width, y: 0.12*height, width: 0.22*width, height: 0.03*height));
                lblHouse.backgroundColor = UIColor.clear;
                lblHouse.textAlignment = NSTextAlignment.center;
                lblHouse.textColor = colorWithHexString("2e3634")
                lblHouse.numberOfLines = 1;
                lblHouse.font = UIFont(name: "Verdana", size: appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
                lblHouse.text = NSLocalizedString("lblHouse",comment:"");
                self.AccView.addSubview(self.lblHouse)
                
                var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapHouse(tapGestureRecognizer:)))
                self.imgvwHouse.isUserInteractionEnabled = true
                self.imgvwHouse.addGestureRecognizer(tapGestureRecognizer)
                
                
                self.AccView.addSubview(self.imgvwMant)
                
                lblMant = UILabel(frame: CGRect(x: 0.35*self.width, y: 0.12*height, width: 0.22*width, height: 0.03*height));
                lblMant.backgroundColor = UIColor.clear;
                lblMant.textAlignment = NSTextAlignment.center;
                lblMant.textColor = colorWithHexString("2e3634")
                lblMant.numberOfLines = 1;
                lblMant.font = UIFont(name: "Verdana", size: appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
                lblMant.text = NSLocalizedString("lblMant",comment:"");
                self.AccView.addSubview(self.lblMant)
                
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapMant(tapGestureRecognizer:)))
                self.imgvwMant.isUserInteractionEnabled = true
                self.imgvwMant.addGestureRecognizer(tapGestureRecognizer)
                
                
                self.AccView.addSubview(self.imgvwFdesk)
                
                lblFdesk = UILabel(frame: CGRect(x: 0.65*self.width, y: 0.12*height, width: 0.22*width, height: 0.03*height));
                lblFdesk.backgroundColor = UIColor.clear;
                lblFdesk.textAlignment = NSTextAlignment.center;
                lblFdesk.textColor = colorWithHexString("2e3634")
                lblFdesk.numberOfLines = 1;
                lblFdesk.font = UIFont(name: "Verdana", size: appDelegate.gblFont4 + appDelegate.gblDeviceFont3)
                lblFdesk.text = NSLocalizedString("lblFdesk",comment:"");
                self.AccView.addSubview(self.lblFdesk)
                
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapFdesk(tapGestureRecognizer:)))
                self.imgvwFdesk.isUserInteractionEnabled = true
                self.imgvwFdesk.addGestureRecognizer(tapGestureRecognizer)
                
                lineView.layer.borderWidth = 1.0
                lineView.layer.borderColor = UIColor.black.cgColor
                self.view.addSubview(lineView)
                
                self.AccView.addSubview(self.imgvwSep)
                
                cargarDatos()

                ViewItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: TabTitleFont, NSAttributedString.Key.foregroundColor: colorWithHexString("ffffff")], for: UIControl.State())
                
            }
            
        }
    
    @objc func TapHouse(tapGestureRecognizer: UITapGestureRecognizer)
    {

        if self.appDelegate.strUnitStayInfoID == ""{
            RKDropdownAlert.title(NSLocalizedString("validStay",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
        }else{
            let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcAddFolloUp") as! vcAddFolloUp
            appDelegate.strFollowUpTypeID = self.HouseID
            appDelegate.strDescriptionForExternal = self.HouseDesc
            appDelegate.strEmailList = self.strEmailList
            self.navigationController?.pushViewController(tercerViewController, animated: true)
        }

    }

    @objc func TapMant(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if self.appDelegate.strUnitStayInfoID == ""{
            RKDropdownAlert.title(NSLocalizedString("validStay",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
        }else{
            let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcAddFolloUp") as! vcAddFolloUp
            if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                appDelegate.strFollowUpTypeID = self.MantID
                appDelegate.strDescriptionForExternal = self.MantDesc
            }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                appDelegate.strFollowUpTypeID = self.FdeskID
                appDelegate.strDescriptionForExternal = self.FdeskDesc
            }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
                appDelegate.strFollowUpTypeID = self.MantID
                appDelegate.strDescriptionForExternal = self.MantDesc
                appDelegate.strEmailList = self.strEmailList
            }


            self.navigationController?.pushViewController(tercerViewController, animated: true)
        }

    }
    
    @objc func TapFdesk(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if self.appDelegate.strUnitStayInfoID == ""{
            RKDropdownAlert.title(NSLocalizedString("validStay",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
        }else{
            let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcAddFolloUp") as! vcAddFolloUp
            if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
                appDelegate.strFollowUpTypeID = self.FdeskID
                appDelegate.strDescriptionForExternal = self.FdeskDesc
            }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
                appDelegate.strFollowUpTypeID = self.MantID
                appDelegate.strDescriptionForExternal = self.MantDesc
            }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.clbrservices"{
                appDelegate.strFollowUpTypeID = self.FdeskID
                appDelegate.strDescriptionForExternal = self.FdeskDesc
                appDelegate.strEmailList = self.strEmailList
            }

            self.navigationController?.pushViewController(tercerViewController, animated: true)
        }
    }
    
    @objc func TapTransfer(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        /*let alert = UIAlertController(title: NSLocalizedString("lblRequestFollowUp",comment:""), message: "Usted se está dirigiendo a un sitio seguro de Royal Resorts fuera de la app. Sus transacciones no se reflejarán aquí.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                
                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcServicesNav") as! vcServicesNav
                tercerViewController.urlHome = self.URLTransfer
                tercerViewController.titleCode = "lblTransfer"
                self.navigationController?.pushViewController(tercerViewController, animated: true)
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)*/

        if self.appDelegate.gstrStayInfoTransfer == ""{
            RKDropdownAlert.title(NSLocalizedString("validStay",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
        }else{
            let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcTransferDate") as! vcTransferDate
            tercerViewController.urlHome = self.URLTransfer
            tercerViewController.titleCode = "lblTransfer"
            self.navigationController?.pushViewController(tercerViewController, animated: true)
        }

    }
    
    @objc func TapOnLine(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        let alert = UIAlertController(title: NSLocalizedString("lblRequestFollowUp",comment:""), message: NSLocalizedString("goingOutSide",comment:""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:

                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcServicesNav") as! vcServicesNav
                tercerViewController.urlHome = self.URLOnLine
                tercerViewController.titleCode = "lblOnLine"
                self.navigationController?.pushViewController(tercerViewController, animated: true)
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func TapRent(tapGestureRecognizer: UITapGestureRecognizer)
    {

        let alert = UIAlertController(title: NSLocalizedString("goingOutSide",comment:""), message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                
                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcServicesNav") as! vcServicesNav
                tercerViewController.urlHome = self.URLRent
                tercerViewController.titleCode = "lblRent"
                self.navigationController?.pushViewController(tercerViewController, animated: true)
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func TapGift(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        let alert = UIAlertController(title: NSLocalizedString("lblRequestFollowUp",comment:""), message: NSLocalizedString("goingOutSide",comment:""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                
                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcServicesNav") as! vcServicesNav
                tercerViewController.urlHome = self.URLGift
                tercerViewController.titleCode = "lblGift"
                self.navigationController?.pushViewController(tercerViewController, animated: true)
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func TapMarket(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        let alert = UIAlertController(title: NSLocalizedString("lblRequestFollowUp",comment:""), message: NSLocalizedString("goingOutSide",comment:""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                
                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcServicesNav") as! vcServicesNav
                tercerViewController.urlHome = self.URLMarket
                tercerViewController.titleCode = "lblMarket"
                self.navigationController?.pushViewController(tercerViewController, animated: true)
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func cargarDatos(){
        
        var tableItems = RRDataSet()
        var val: String = "0"
        var iRes: String = ""
        var tblFollow: Dictionary<String, String>!
        var tblFollowType: Dictionary<String, String>!
        var iIndex: Int32 = 0
        val = "0"
        
        tblFollowUp = []
        tblFollowUpType = []
        
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 100
        config.backgroundColor = UIColor(white: 1, alpha: 0.5)
        config.spinnerColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.titleTextColor = UIColor(red:0.36, green:0.62, blue:0.8, alpha:1)
        config.spinnerLineWidth = 2.0
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        SwiftLoader.show(title: NSLocalizedString("lblLoading",comment:""), animated: true)
        
        let queue = OperationQueue()
        
        queue.addOperation() {//1
            //accion base de datos
            //print(1)
            
            if Reachability.isConnectedToNetwork(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
                print(self.appDelegate.gstrAppName)
                print(self.appDelegate.gstrLoginPeopleID)
                print(self.appDelegate.strDataBaseByStay)
                print(self.appDelegate.strLenguaje)
                
                let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                tableItems = (service?.spGetMobileFollowUpVw(val, appCode: self.appDelegate.gstrAppName, peopleID: self.appDelegate.gstrLoginPeopleID, followUpId: "0", dataBase: self.appDelegate.strDataBaseByStay, sLanguage: self.appDelegate.strLenguaje))!
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            OperationQueue.main.addOperation() {
                queue.addOperation() {//2
                    //accion base de datos
                    //print(2)

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
                            
                            var tableType = RRDataTable()
                            tableType = tableItems.tables.object(at: 1) as! RRDataTable
                            
                            var rType = RRDataRow()
                            rType = tableType.rows.object(at: 0) as! RRDataRow
                            
                            iIndex = 0
                            
                            for rType in tableType.rows{
                                iIndex += 1
                                (rType as AnyObject).getColumnByName("pkFollowUpTypeID").content as? String
                                tblFollowType = [:]
                                tblFollowType["pkFollowUpTypeID"] = (rType as AnyObject).getColumnByName("pkFollowUpTypeID").content as? String
                                tblFollowType["DescriptionForExternal"] = (rType as AnyObject).getColumnByName("DescriptionForExternal").content as? String
                                tblFollowType["emailList"] = (rType as AnyObject).getColumnByName("emailList").content as? String
                                
                                self.strEmailList = ((rType as AnyObject).getColumnByName("emailList").content as? String)!
                                
                                if Int((rType as AnyObject).getColumnByName("ID").content as! String) == 1{
                                    if let url = URL.init(string: (rType as AnyObject).getColumnByName("sIcon").content as! String) {
                                        self.imgvwHouse.downloadedFrom(url: url)
                                        //self.imgvwHouse.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                                        //self.imgvwHouse.translatesAutoresizingMaskIntoConstraints = true
                                        //self.imgvwHouse.contentMode = .scaleToFill
                                        
                                        self.HouseID = ((rType as AnyObject).getColumnByName("pkFollowUpTypeID").content as? String)!
                                        self.HouseDesc = ((rType as AnyObject).getColumnByName("DescriptionForExternal").content as? String)!
                                        
                                    }
                                }else if Int((rType as AnyObject).getColumnByName("ID").content as! String) == 2{
                                    if let url = URL.init(string: (rType as AnyObject).getColumnByName("sIcon").content as! String) {
                                        self.imgvwMant.downloadedFrom(url: url)
                                        //self.imgvwMant.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                                        //self.imgvwMant.translatesAutoresizingMaskIntoConstraints = true
                                        //self.imgvwMant.contentMode = .scaleToFill
                                        
                                        self.MantID = ((rType as AnyObject).getColumnByName("pkFollowUpTypeID").content as? String)!
                                        self.MantDesc = ((rType as AnyObject).getColumnByName("DescriptionForExternal").content as? String)!
                                        
                                    }
                                }else if Int((rType as AnyObject).getColumnByName("ID").content as! String) == 3{
                                    if let url = URL.init(string: (rType as AnyObject).getColumnByName("sIcon").content as! String) {
                                        self.imgvwFdesk.downloadedFrom(url: url)
                                        //self.imgvwFdesk.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                                        //self.imgvwFdesk.translatesAutoresizingMaskIntoConstraints = true
                                        //self.imgvwFdesk.contentMode = .scaleToFill
                                        
                                        self.FdeskID = ((rType as AnyObject).getColumnByName("pkFollowUpTypeID").content as? String)!
                                        self.FdeskDesc = ((rType as AnyObject).getColumnByName("DescriptionForExternal").content as? String)!
                                        
                                    }
                                }
                                
                                self.tblFollowUpType.append(tblFollowType)
                            }
                            
                            self.appDelegate.gtblFollowUpType = self.tblFollowUpType
                            
                            if tableItems.getTotalTables() > 3{
                                
                                var tableTypeServ = RRDataTable()
                                tableTypeServ = tableItems.tables.object(at: 3) as! RRDataTable
                                
                                for rTypeServ in tableTypeServ.rows{
                                    
                                    if (rTypeServ as AnyObject).getColumnByName("Code").content as! String == "Transfer_" + self.appDelegate.strLenguaje{
                                        if let url = URL.init(string: (rTypeServ as AnyObject).getColumnByName("img").content as! String) {
                                            
                                            self.URLTransfer = (rTypeServ as AnyObject).getColumnByName("sUlr").content as! String
                                            
                                            self.imgvwTransfer.downloadedFrom(url: url)
                                            //self.imgvwTransfer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                                            //elf.imgvwTransfer.translatesAutoresizingMaskIntoConstraints = true
                                            //self.imgvwTransfer.contentMode = .scaleToFill
                                            
                                        }
                                    }else if (rTypeServ as AnyObject).getColumnByName("Code").content as! String == "OnLine_" + self.appDelegate.strLenguaje{
                                        if let url = URL.init(string: (rTypeServ as AnyObject).getColumnByName("img").content as! String) {
                                            
                                            self.URLOnLine = (rTypeServ as AnyObject).getColumnByName("sUlr").content as! String
                                            
                                            self.imgvwOnLine.downloadedFrom(url: url)
                                            //self.imgvwOnLine.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                                            //self.imgvwOnLine.translatesAutoresizingMaskIntoConstraints = true
                                            //self.imgvwOnLine.contentMode = .scaleToFill
                                            
                                        }
                                    }else if (rTypeServ as AnyObject).getColumnByName("Code").content as! String == "Rent_" + self.appDelegate.strLenguaje{
                                        if let url = URL.init(string: (rTypeServ as AnyObject).getColumnByName("img").content as! String) {
                                            
                                            self.URLRent = (rTypeServ as AnyObject).getColumnByName("sUlr").content as! String
                                            
                                            self.imgvwRent.downloadedFrom(url: url)
                                            //self.imgvwRent.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                                            //self.imgvwRent.translatesAutoresizingMaskIntoConstraints = true
                                            //self.imgvwRent.contentMode = .scaleToFill
                                            
                                        }
                                    }else if (rTypeServ as AnyObject).getColumnByName("Code").content as! String == "Gift_" + self.appDelegate.strLenguaje{
                                        if let url = URL.init(string: (rTypeServ as AnyObject).getColumnByName("img").content as! String) {
                                            
                                            self.URLGift = (rTypeServ as AnyObject).getColumnByName("sUlr").content as! String
                                            
                                            self.imgvwGift.downloadedFrom(url: url)
                                            //self.imgvwGift.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                                            //self.imgvwGift.translatesAutoresizingMaskIntoConstraints = true
                                            //self.imgvwGift.contentMode = .scaleToFill
                                            
                                        }
                                    }else if (rTypeServ as AnyObject).getColumnByName("Code").content as! String == "Market_" + self.appDelegate.strLenguaje{
                                        if let url = URL.init(string: (rTypeServ as AnyObject).getColumnByName("img").content as! String) {
                                            
                                            self.URLMarket = (rTypeServ as AnyObject).getColumnByName("sUlr").content as! String
                                            
                                            self.imgvwMarket.downloadedFrom(url: url)
                                            //self.imgvwMarket.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                                            //self.imgvwMarket.translatesAutoresizingMaskIntoConstraints = true
                                            //self.imgvwMarket.contentMode = .scaleToFill
                                            
                                        }
                                    }

                                }
                            }
                            
                            
                        }
                        
                    }
                    
                    OperationQueue.main.addOperation() {
                        //accion
                        if !Reachability.isConnectedToNetwork(){
                            RKDropdownAlert.title(NSLocalizedString("MsgError6",comment:""), backgroundColor: self.colorWithHexString ("5C9FCC"), textColor: UIColor.black)
                        }
                        
                        SwiftLoader.hide()
                    }
                }
            }
        }
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
            AnalyticsParameterItemID: "id-Request",
            AnalyticsParameterItemName: "Request",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("Request", screenClass: appDelegate.gstrAppName)
        
    }
    
    @objc func clickAdd(_ sender: AnyObject){
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
    }
    
}

