//
//  vcTransferDate.swift
//  Royal Resorts Guest
//
//  Created by Soluciones on 11/14/19.
//  Copyright © 2019 Marco Cocom. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications
import FirebaseMessaging
import DGRunkeeperSwitch

class vcTransferDate: UIViewController {
    
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
    var strTotalPriceUSD: String = ""
    var btnChangeDates = UIButton()
    var lblOr = UILabel()
    
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

        let TabTitleFont = UIFont(name: "HelveticaNeue", size: appDelegate.gblFont10 + appDelegate.gblDeviceFont2)!

        SwitchRound = DGRunkeeperSwitch(titles: [NSLocalizedString("lblRoundTrip",comment:""),NSLocalizedString("lblOneWay",comment:"")])
        SwitchShared = DGRunkeeperSwitch(titles: [NSLocalizedString("lblPrivateTrans",comment:""),NSLocalizedString("lblSharedTrans",comment:"")])
        btnContinue.addTarget(self, action: #selector(vcTransferDate.clickContinue(_:)), for: UIControl.Event.touchUpInside)
        btnChooseDate.addTarget(self, action: #selector(vcTransferDate.clickAdd(_:)), for: UIControl.Event.touchUpInside)
        btnChangeDates.addTarget(self, action: #selector(vcTransferDate.clickAdd(_:)), for: UIControl.Event.touchUpInside)
        
        UpdForm()
        
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
        
        recargarHotelItems()

    }
    
    func UpdForm(){
        
        var strArrivalDate: String = ""
        let strdateFormatter = DateFormatter()
        strdateFormatter.dateFormat = "MMMM dd, yyyy";
        let ArrivalDate = moment(self.appDelegate.gstrArrivalTransfer)
        strArrivalDate = strdateFormatter.string(from: ArrivalDate!.date)

        var strDeparturedate: String = ""
        let Departuredate = moment(self.appDelegate.gstrDepartureTransfer)
        strDeparturedate = strdateFormatter.string(from: Departuredate!.date)
        
        lblUserName.removeFromSuperview()

        lblMsgError.removeFromSuperview()
        lblArrivalDate.removeFromSuperview()
        btnChooseDate.removeFromSuperview()
        lblUsaCan.removeFromSuperview()
        lblUSTel.removeFromSuperview()
        lblMex.removeFromSuperview()
        lblMexTel.removeFromSuperview()
        lblOther.removeFromSuperview()
        lblOtherTel1.removeFromSuperview()
        lblOtherTel2.removeFromSuperview()
        lblOffice.removeFromSuperview()
        lblMon.removeFromSuperview()
        lblSat.removeFromSuperview()
        lblEmail.removeFromSuperview()
        imgvwThomas.removeFromSuperview()
        imgvwTrip.removeFromSuperview()
        btnChooseDate.removeFromSuperview()
        btnChangeDates.removeFromSuperview()
        
        if self.appDelegate.ynTransferOutDate == false{

            //Boton Add
            //ViewItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("btnEditInfo",comment:""), style: .plain, target: self, action: #selector(vcTransferDate.clickAdd(_:)))

            lblUserName = UILabel(frame: CGRect(x: 0.05*width, y: 0.07*height, width: 0.9*width, height: 0.06*height));
            lblMsgError = UILabel(frame: CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.12*height));
            lblArrivalDate = UILabel(frame: CGRect(x: 0.05*width, y: 0.26*height, width: 0.9*width, height: 0.03*height));
            lblUsaCan = UILabel(frame: CGRect(x: 0.05*width, y: 0.29*height, width: 0.9*width, height: 0.03*height));
            SwitchRound.frame = CGRect(x: 0.1*width, y: 0.34*height, width: 0.8*width, height: 0.05*height)
            SwitchShared.frame = CGRect(x: 0.1*width, y: 0.4*height, width: 0.8*width, height: 0.05*height)
            lblMex = UILabel(frame: CGRect(x: 0.05*width, y: 0.47*height, width: 0.9*width, height: 0.03*height));
            lblOther = UILabel(frame: CGRect(x: 0.05*width, y: 0.5*height, width: 0.9*width, height: 0.05*height));
            lblSat = UILabel(frame: CGRect(x: 0.05*width, y: 0.54*height, width: 0.9*width, height: 0.05*height));
            btnChangeDates.frame = CGRect(x: 0.1*width, y: 0.6*height, width: 0.8*width, height: 0.05*height);
            lblOr = UILabel(frame: CGRect(x: 0.05*width, y: 0.66*height, width: 0.9*width, height: 0.03*height));
            btnContinue.frame = CGRect(x: 0.1*width, y: 0.7*height, width: 0.8*width, height: 0.05*height);
            lblMon = UILabel(frame: CGRect(x: 0.05*width, y: 0.78*height, width: 0.9*width, height: 0.03*height));
            lblEmail = UILabel(frame: CGRect(x: 0.05*width, y: 0.82*height, width: 0.9*width, height: 0.03*height));

            lblUserName.backgroundColor = UIColor.clear
            lblUserName.textAlignment = NSTextAlignment.center
            lblUserName.textColor = colorWithHexString("000000")
            lblUserName.numberOfLines = 0;
            lblUserName.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
            lblUserName.text = NSLocalizedString("lblUserNameTransfer",comment:"") + " " + self.appDelegate.gstrPeopleFNameTransfer
            
            lblMsgError.backgroundColor = UIColor.clear
            lblMsgError.textAlignment = NSTextAlignment.center
            lblMsgError.textColor = colorWithHexString("000000")
            lblMsgError.numberOfLines = 0;
            lblMsgError.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblMsgError.text = NSLocalizedString("lblMsgErrorFrag1",comment:"") + " " + self.appDelegate.gstrConfirmationCodeTransfer
            + " " + NSLocalizedString("lblMsgErrorFrag2",comment:"") + " " + strArrivalDate
            + " " + NSLocalizedString("lblMsgErrorFrag3",comment:"") + " " + strDeparturedate
            + ". " + NSLocalizedString("lblMsgErrorFrag4",comment:"") + " " + self.appDelegate.gstrPropertyTransfer + "."
            
            lblArrivalDate.backgroundColor = UIColor.clear
            lblArrivalDate.textAlignment = NSTextAlignment.center
            lblArrivalDate.textColor = colorWithHexString("000000")
            lblArrivalDate.numberOfLines = 0;
            lblArrivalDate.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblArrivalDate.text = NSLocalizedString("lblMsgErrorFrag5",comment:"") + " " + self.appDelegate.giPeopleNumTransfer.description
            + " " + NSLocalizedString("lblMsgErrorFrag6",comment:"")

            lblUsaCan.backgroundColor = UIColor.clear;
            lblUsaCan.textAlignment = NSTextAlignment.center;
            lblUsaCan.textColor = colorWithHexString("000000")
            lblUsaCan.numberOfLines = 0
            lblUsaCan.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblUsaCan.text = NSLocalizedString("lblMsgErrorFrag7",comment:"")
            
            lblMex.backgroundColor = UIColor.clear;
            lblMex.textAlignment = NSTextAlignment.center;
            lblMex.textColor = colorWithHexString("000000")
            lblMex.numberOfLines = 1;
            lblMex.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblMex.text = NSLocalizedString("lblSharedService",comment:"");
            lblMex.adjustsFontSizeToFitWidth = true
            
            lblOther.backgroundColor = UIColor.clear;
            lblOther.textAlignment = NSTextAlignment.center;
            lblOther.textColor = colorWithHexString("000000")
            lblOther.numberOfLines = 1;
            lblOther.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
            lblOther.text = NSLocalizedString("lblTransferTotal",comment:"");
            
            lblSat.backgroundColor = UIColor.clear;
            lblSat.textAlignment = NSTextAlignment.center;
            lblSat.textColor = colorWithHexString("000000")
            lblSat.numberOfLines = 1;
            lblSat.font = UIFont(name: "Verdana", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
            lblSat.text = "$0.0 USD"
            
            lblMon.backgroundColor = UIColor.clear;
            lblMon.textAlignment = NSTextAlignment.center;
            lblMon.textColor = colorWithHexString("000000")
            lblMon.numberOfLines = 1;
            lblMon.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblMon.text = NSLocalizedString("lblHelpTransfer",comment:"");

            lblEmail.backgroundColor = UIColor.clear;
            lblEmail.textAlignment = NSTextAlignment.center;
            lblEmail.textColor = colorWithHexString("000000")
            lblEmail.numberOfLines = 1;
            lblEmail.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblEmail.text = NSLocalizedString("lblEmail",comment:"");

            SwitchRound.backgroundColor = colorWithHexString ("5C9FCC")
            SwitchRound.selectedBackgroundColor = .white
            SwitchRound.titleColor = .white
            SwitchRound.selectedTitleColor = colorWithHexString ("5C9FCC")
            SwitchRound.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
            SwitchRound.addTarget(self, action: #selector(vcTransferDate.switchRoundDidChange(_:)), for: .valueChanged)

            SwitchShared.backgroundColor = colorWithHexString ("5C9FCC")
            SwitchShared.selectedBackgroundColor = .white
            SwitchShared.titleColor = .white
            SwitchShared.selectedTitleColor = colorWithHexString ("5C9FCC")
            SwitchShared.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
            SwitchShared.addTarget(self, action: #selector(vcTransferDate.switchPrivateDidChange(_:)), for: .valueChanged)

            btnChangeDates.setTitle(NSLocalizedString("btnChangeDates",comment:""), for: UIControl.State())
            btnChangeDates.titleLabel?.font = UIFont(name: "Helvetica", size: appDelegate.gblFont7 + appDelegate.gblDeviceFont5)
            btnChangeDates.backgroundColor = colorWithHexString("FFFFFF")
            btnChangeDates.layer.borderWidth = 0
            btnChangeDates.setTitleColor(colorWithHexString("FF8000"), for: UIControl.State())
            btnChangeDates.titleLabel?.textAlignment = NSTextAlignment.center
            
            lblOr.backgroundColor = UIColor.clear;
            lblOr.textAlignment = NSTextAlignment.center;
            lblOr.textColor = colorWithHexString("000000")
            lblOr.numberOfLines = 1;
            lblOr.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblOr.text = NSLocalizedString("lblOr",comment:"");
            
            btnContinue.setTitle(NSLocalizedString("lblTransferContinue",comment:""), for: UIControl.State())
            btnContinue.titleLabel?.font = UIFont(name: "Helvetica", size: appDelegate.gblFont5 + appDelegate.gblDeviceFont4)
            btnContinue.backgroundColor = colorWithHexString("5C9FCC")
            btnContinue.layer.borderWidth = 0.8
            btnContinue.setTitleColor(UIColor.white, for: UIControl.State())
            btnContinue.titleLabel?.textAlignment = NSTextAlignment.center

            var strArrivalDate: String = ""
            let strdateFormatter = DateFormatter()
            strdateFormatter.dateFormat = "MMMM dd, yyyy";
            let ArrivalDate = moment(self.appDelegate.gstrArrivalTransfer)
            strArrivalDate = strdateFormatter.string(from: ArrivalDate!.date)

            var strDeparturedate: String = ""
            let Departuredate = moment(self.appDelegate.gstrDepartureTransfer)
            strDeparturedate = strdateFormatter.string(from: Departuredate!.date)

            lblMsgError.text = NSLocalizedString("lblMsgErrorFrag1",comment:"") + " " + self.appDelegate.gstrConfirmationCodeTransfer
            + " " + NSLocalizedString("lblMsgErrorFrag2",comment:"") + " " + strArrivalDate
            + " " + NSLocalizedString("lblMsgErrorFrag3",comment:"") + " " + strDeparturedate
            + ". " + NSLocalizedString("lblMsgErrorFrag4",comment:"") + " " + self.appDelegate.gstrPropertyTransfer + "."
            lblArrivalDate.text = NSLocalizedString("lblMsgErrorFrag5",comment:"") + " " + self.appDelegate.giPeopleNumTransfer.description
            + " " + NSLocalizedString("lblMsgErrorFrag6",comment:"")
            
            self.view.addSubview(self.lblUserName)
            self.view.addSubview(self.lblMsgError)
            self.view.addSubview(self.lblArrivalDate)
            self.view.addSubview(self.lblUsaCan)
            self.view.addSubview(self.lblMex)
            self.view.addSubview(self.lblOther)
            self.view.addSubview(self.lblMon)
            self.view.addSubview(self.lblSat)
            self.view.addSubview(self.lblEmail)
            self.view.addSubview(SwitchRound)
            self.view.addSubview(SwitchShared)
            self.view.addSubview(self.btnChangeDates)
            self.view.addSubview(self.lblOr)
            self.view.addSubview(self.btnContinue)
            
        }else{

            lblUserName = UILabel(frame: CGRect(x: 0.05*width, y: 0.07*height, width: 0.9*width, height: 0.06*height));
            lblMsgError = UILabel(frame: CGRect(x: 0.05*width, y: 0.13*height, width: 0.9*width, height: 0.15*height));
            lblArrivalDate = UILabel(frame: CGRect(x: 0.05*width, y: 0.28*height, width: 0.9*width, height: 0.03*height));
            //btnChooseDate.frame = CGRect(x: 0.1*width, y: 0.32*height, width: 0.8*width, height: 0.05*height);
            lblUsaCan = UILabel(frame: CGRect(x: 0.05*width, y: 0.35*height, width: 0.9*width, height: 0.03*height));
            lblUSTel = UILabel(frame: CGRect(x: 0.45*width, y: 0.35*height, width: 0.4*width, height: 0.03*height));
            lblMex = UILabel(frame: CGRect(x: 0.05*width, y: 0.41*height, width: 0.9*width, height: 0.03*height));
            lblMexTel = UILabel(frame: CGRect(x: 0.45*width, y: 0.44*height, width: 0.4*width, height: 0.03*height));
            lblOther = UILabel(frame: CGRect(x: 0.05*width, y: 0.47*height, width: 0.9*width, height: 0.03*height));
            lblOtherTel1 = UILabel(frame: CGRect(x: 0.45*width, y: 0.47*height, width: 0.4*width, height: 0.03*height));
            //lblOtherTel2 = UILabel(frame: CGRect(x: 0.45*width, y: 0.47*height, width: 0.4*width, height: 0.03*height));
            lblOffice = UILabel(frame: CGRect(x: 0.05*width, y: 0.53*height, width: 0.9*width, height: 0.03*height));
            lblMon = UILabel(frame: CGRect(x: 0.05*width, y: 0.56*height, width: 0.9*width, height: 0.03*height));
            lblSat = UILabel(frame: CGRect(x: 0.05*width, y: 0.59*height, width: 0.9*width, height: 0.03*height));
            lblEmail = UILabel(frame: CGRect(x: 0.05*width, y: 0.65*height, width: 0.9*width, height: 0.03*height));
            imgvwThomas.frame = CGRect(x: 0.2*width, y: 0.72*height, width: 0.3*width, height: 0.13*height)
            imgvwTrip.frame = CGRect(x: 0.5*width, y: 0.72*height, width: 0.3*width, height: 0.13*height)
            
            lblUserName.backgroundColor = UIColor.clear;
            lblUserName.textAlignment = NSTextAlignment.center;
            lblUserName.textColor = colorWithHexString("000000")
            lblUserName.numberOfLines = 2;
            lblUserName.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblUserName.text = NSLocalizedString("lblUserNameTransfer",comment:"") + " " + self.appDelegate.gstrPeopleFNameTransfer;
            
            lblMsgError.backgroundColor = UIColor.clear;
            lblMsgError.textAlignment = NSTextAlignment.center;
            lblMsgError.textColor = colorWithHexString("000000")
            lblMsgError.numberOfLines = 5;
            lblMsgError.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblMsgError.text = NSLocalizedString("lblMsgError",comment:"");
            
            lblArrivalDate.backgroundColor = UIColor.clear;
            lblArrivalDate.textAlignment = NSTextAlignment.center;
            lblArrivalDate.textColor = colorWithHexString("000000")
            lblArrivalDate.numberOfLines = 1;
            lblArrivalDate.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblArrivalDate.text = NSLocalizedString("lblArrivalDate",comment:"") + ": " + strArrivalDate;
            
            btnChooseDate.setTitle(NSLocalizedString("strChooseAnother",comment:""), for: UIControl.State())
            btnChooseDate.titleLabel?.font = UIFont(name: "Helvetica", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont4)
            btnChooseDate.backgroundColor = colorWithHexString("5C9FCC")
            btnChooseDate.layer.borderWidth = 0.8
            btnChooseDate.setTitleColor(UIColor.white, for: UIControl.State())
            btnChooseDate.titleLabel?.textAlignment = NSTextAlignment.center

            lblUsaCan.backgroundColor = UIColor.clear;
            lblUsaCan.textAlignment = NSTextAlignment.center;
            lblUsaCan.textColor = colorWithHexString("000000")
            lblUsaCan.numberOfLines = 1;
            lblUsaCan.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblUsaCan.text = NSLocalizedString("lblUsaCan",comment:"") + " " + NSLocalizedString("lblUSTel",comment:"");
            lblUsaCan.adjustsFontSizeToFitWidth = true
            
            lblUSTel.backgroundColor = UIColor.clear;
            lblUSTel.textAlignment = NSTextAlignment.left;
            lblUSTel.textColor = colorWithHexString("5C9FCC")
            lblUSTel.numberOfLines = 1;
            lblUSTel.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblUSTel.text = ""
            lblUSTel.adjustsFontSizeToFitWidth = true
            
            lblMex.backgroundColor = UIColor.clear;
            lblMex.textAlignment = NSTextAlignment.center;
            lblMex.textColor = colorWithHexString("000000")
            lblMex.numberOfLines = 1;
            lblMex.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblMex.text = NSLocalizedString("lblMex",comment:"") + " " + NSLocalizedString("lblMexTel",comment:"");
            lblMex.adjustsFontSizeToFitWidth = true
            
            lblMexTel.backgroundColor = UIColor.clear;
            lblMexTel.textAlignment = NSTextAlignment.left;
            lblMexTel.textColor = colorWithHexString("5C9FCC")
            lblMexTel.numberOfLines = 1;
            lblMexTel.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblMexTel.text = ""
            lblMexTel.adjustsFontSizeToFitWidth = true
            
            lblOther.backgroundColor = UIColor.clear;
            lblOther.textAlignment = NSTextAlignment.center;
            lblOther.textColor = colorWithHexString("000000")
            lblOther.numberOfLines = 1;
            lblOther.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblOther.text = NSLocalizedString("lblOther",comment:"") + " " + NSLocalizedString("lblOtherTel1",comment:"");
            
            lblOtherTel1.backgroundColor = UIColor.clear;
            lblOtherTel1.textAlignment = NSTextAlignment.left;
            lblOtherTel1.textColor = colorWithHexString("5C9FCC")
            lblOtherTel1.numberOfLines = 1;
            lblOtherTel1.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblOtherTel1.text = ""
            
            lblOtherTel2.backgroundColor = UIColor.clear;
            lblOtherTel2.textAlignment = NSTextAlignment.left;
            lblOtherTel2.textColor = colorWithHexString("5C9FCC")
            lblOtherTel2.numberOfLines = 1;
            lblOtherTel2.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblOtherTel2.text = NSLocalizedString("lblOtherTel1",comment:"");
            
            lblOffice.backgroundColor = UIColor.clear;
            lblOffice.textAlignment = NSTextAlignment.center;
            lblOffice.textColor = colorWithHexString("000000")
            lblOffice.numberOfLines = 1;
            lblOffice.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblOffice.text = NSLocalizedString("lblOffice",comment:"");
            
            lblMon.backgroundColor = UIColor.clear;
            lblMon.textAlignment = NSTextAlignment.center;
            lblMon.textColor = colorWithHexString("000000")
            lblMon.numberOfLines = 1;
            lblMon.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblMon.text = NSLocalizedString("lblMon",comment:"");

            lblSat.backgroundColor = UIColor.clear;
            lblSat.textAlignment = NSTextAlignment.center;
            lblSat.textColor = colorWithHexString("000000")
            lblSat.numberOfLines = 1;
            lblSat.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblSat.text = NSLocalizedString("lblSat",comment:"");

            lblEmail.backgroundColor = UIColor.clear;
            lblEmail.textAlignment = NSTextAlignment.center;
            lblEmail.textColor = colorWithHexString("000000")
            lblEmail.numberOfLines = 1;
            lblEmail.font = UIFont(name: "HelveticaNeue-Bold", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont2)
            lblEmail.text = NSLocalizedString("lblEmail",comment:"");
            
            self.imgvwThomas.downloadedFrom(url: URL.init(string: ("https://www.royalresorts.com/wp-content/uploads/2019/11/imagotipo-VTM.png"))!)
            if appDelegate.strLenguaje == "ENG"{
                self.imgvwTrip.downloadedFrom(url: URL.init(string: ("https://www.royalresorts.com/wp-content/uploads/2019/11/Trip-EN.png"))!)
            }else{
                self.imgvwTrip.downloadedFrom(url: URL.init(string: ("https://www.royalresorts.com/wp-content/uploads/2019/11/trip-ES.png"))!)
            }
            

            /*lblUserName.text = NSLocalizedString("lblUserNameTrans",comment:"") + " " + self.appDelegate.gstrPeopleNameTransfer;
            lblMsgError.text = NSLocalizedString("lblMsgError",comment:"Sorry, the reservation, must be made two days in advance, please review you information or contact us.");
            lblArrivalDate.text = NSLocalizedString("lblArrivalDate",comment:"Arrival date: September 25th, 2019") + " " + strArrivalDate;
            lblUsaCan.text = NSLocalizedString("lblUsaCan",comment:"From USA-Canada: 1-800-791-4496");
            lblMex.text = NSLocalizedString("lblMex",comment:"From Mexico: 01-800-888-6627");
            lblOther.text = NSLocalizedString("lblOther",comment:"Other Countries: 998-885-1741 / 998-881-0166");
            lblOffice.text = NSLocalizedString("lblOffice",comment:"OFFICE HOURS");
            lblMon.text = NSLocalizedString("lblMon",comment:"Monday to friday: 8:00 a.m. to 7:00 p.m.");
            lblSat.text = NSLocalizedString("lblSat",comment:"Saturday to sunday: 9:00 a.m. to 5:00 p.m.");
            lblEmail.text = NSLocalizedString("lblEmail",comment:"airportservice@thomasmoretravel.com");
            btnChooseDate.setTitle(NSLocalizedString("strChooseAnother",comment:"Choose another date"), for: UIControl.State())*/

            self.view.addSubview(self.lblUserName)
            self.view.addSubview(self.lblMsgError)
            self.view.addSubview(self.lblArrivalDate)
            //self.view.addSubview(self.btnChooseDate)
            self.view.addSubview(self.lblUsaCan)
            self.view.addSubview(self.lblUSTel)
            self.view.addSubview(self.lblMex)
            self.view.addSubview(self.lblMexTel)
            self.view.addSubview(self.lblOther)
            self.view.addSubview(self.lblOtherTel1)
            //self.view.addSubview(self.lblOtherTel2)
            self.view.addSubview(self.lblOffice)
            self.view.addSubview(self.lblMon)
            self.view.addSubview(self.lblSat)
            self.view.addSubview(self.lblEmail)
            self.view.addSubview(self.imgvwThomas)
            self.view.addSubview(self.imgvwTrip)

        }
        
        /*if self.appDelegate.gstrStayInfoTransfer != ""{

            var strArrivalDate: String = ""
            let strdateFormatter = DateFormatter()
            strdateFormatter.dateFormat = "MMMM dd, yyyy";
            let ArrivalDate = moment(self.appDelegate.gstrArrivalTransfer)
            strArrivalDate = strdateFormatter.string(from: ArrivalDate!.date)

            var strDeparturedate: String = ""
            let Departuredate = moment(self.appDelegate.gstrDepartureTransfer)
            strDeparturedate = strdateFormatter.string(from: Departuredate!.date)

            lblMsgError.text = NSLocalizedString("lblMsgErrorFrag1",comment:"") + " " + self.appDelegate.gstrConfirmationCodeTransfer
            + " " + NSLocalizedString("lblMsgErrorFrag2",comment:"") + " " + strArrivalDate
            + " " + NSLocalizedString("lblMsgErrorFrag3",comment:"") + " " + strDeparturedate
            + ". " + NSLocalizedString("lblMsgErrorFrag4",comment:"") + " " + self.appDelegate.gstrPropertyTransfer + "."
            lblArrivalDate.text = NSLocalizedString("lblMsgErrorFrag5",comment:"") + " " + self.appDelegate.giPeopleNumTransfer.description
            + " " + NSLocalizedString("lblMsgErrorFrag6",comment:"")

            
        }else{


            lblUserName.text = NSLocalizedString("lblUserNameTrans",comment:"") + " " + self.appDelegate.gstrPeopleFNameTransfer;

        }*/
    }
    
        @objc func switchRoundDidChange(_ sender: DGRunkeeperSwitch!) {
        
        strPriceUSD = "0"
        strTotalPriceUSD = "0"
        strPriceMX = ""
        strItemClassCode = ""
        strItemTypeCode = ""
        self.appDelegate.gpkItemVariantID = "0"
            
        if (self.SwitchRound.selectedIndex == 0){
            
            for index in 0...self.tblTransferType.count-1 {
                if(self.tblTransferType[index]["ItemClassCode"]=="ROUNDTRIP"){
                    
                    self.appDelegate.gItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                    
                    if (SwitchShared.selectedIndex == 0){
                        if (self.tblTransferType[index]["ItemTypeCode"]=="PRIVATE"){
                            
                            self.appDelegate.gItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                            
                            strTotalPriceUSD = self.tblTransferType[index]["TotalPriceUSD"]!
                            strPriceUSD = self.tblTransferType[index]["PriceUSD"]!
                            strPriceMX = self.tblTransferType[index]["PriceMX"]!
                            strItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                            strItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                            self.appDelegate.gpkItemVariantID = self.tblTransferType[index]["pkItemVariantID"]!
                            
                        }
                    }else{
                        if (self.tblTransferType[index]["ItemTypeCode"]=="SHARED"){
                            
                            self.appDelegate.gItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                            
                            strTotalPriceUSD = self.tblTransferType[index]["TotalPriceUSD"]!
                            strPriceUSD = self.tblTransferType[index]["PriceUSD"]!
                            strPriceMX = self.tblTransferType[index]["PriceMX"]!
                            strItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                            strItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                            self.appDelegate.gpkItemVariantID = self.tblTransferType[index]["pkItemVariantID"]!
                            
                        }
                    }
                }else{
                    
                    if(self.tblTransferType[index]["ItemClassCode"]=="R.T. MIX"){
                        
                        self.appDelegate.gItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                        
                        if (SwitchShared.selectedIndex == 0){
                            if (self.tblTransferType[index]["ItemTypeCode"]=="PRIVATE"){
                                
                                self.appDelegate.gItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                                
                                strTotalPriceUSD = self.tblTransferType[index]["TotalPriceUSD"]!
                                strPriceUSD = self.tblTransferType[index]["PriceUSD"]!
                                strPriceMX = self.tblTransferType[index]["PriceMX"]!
                                strItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                                strItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                                self.appDelegate.gpkItemVariantID = self.tblTransferType[index]["pkItemVariantID"]!
                                
                            }
                        }else{
                            if (self.tblTransferType[index]["ItemTypeCode"]=="SHARED"){
                                
                                self.appDelegate.gItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                                
                                strTotalPriceUSD = self.tblTransferType[index]["TotalPriceUSD"]!
                                strPriceUSD = self.tblTransferType[index]["PriceUSD"]!
                                strPriceMX = self.tblTransferType[index]["PriceMX"]!
                                strItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                                strItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                                self.appDelegate.gpkItemVariantID = self.tblTransferType[index]["pkItemVariantID"]!
                                
                            }
                        }
                        
                    }
                    
                    
                }
            }
            
        }else{
            
            for index in 0...self.tblTransferType.count-1 {
                if(self.tblTransferType[index]["ItemClassCode"]=="ONEWAY"){
                    
                    self.appDelegate.gItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                    
                    if (SwitchShared.selectedIndex == 0){
                        if (self.tblTransferType[index]["ItemTypeCode"]=="PRIVATE"){
                            
                            self.appDelegate.gItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                            
                            strTotalPriceUSD = self.tblTransferType[index]["TotalPriceUSD"]!
                            strPriceUSD = self.tblTransferType[index]["PriceUSD"]!
                            strPriceMX = self.tblTransferType[index]["PriceMX"]!
                            strItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                            strItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                            self.appDelegate.gpkItemVariantID = self.tblTransferType[index]["pkItemVariantID"]!
                        }
                    }else{
                        if (self.tblTransferType[index]["ItemTypeCode"]=="SHARED"){
                            
                            self.appDelegate.gItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                            
                            strTotalPriceUSD = self.tblTransferType[index]["TotalPriceUSD"]!
                            strPriceUSD = self.tblTransferType[index]["PriceUSD"]!
                            strPriceMX = self.tblTransferType[index]["PriceMX"]!
                            strItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                            strItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                            self.appDelegate.gpkItemVariantID = self.tblTransferType[index]["pkItemVariantID"]!
                            
                        }
                    }
                }
            }
        }
        //print(strPriceUSD,strItemClassCode,strItemTypeCode)
        if self.appDelegate.ynTransferOutDate == false{
            
            lblSat.text = "$" + String(format: "%.2f", (String(format: "%.2f0", (strTotalPriceUSD as NSString).floatValue) as NSString).floatValue) + " USD"
            self.appDelegate.gblTotalReserv = Double((strTotalPriceUSD as NSString).floatValue)
            
        }
        
    }
    
    @objc func switchPrivateDidChange(_ sender: DGRunkeeperSwitch!) {
        strPriceUSD = "0"
        strTotalPriceUSD = "0"
        strPriceMX = ""
        strItemClassCode = ""
        strItemTypeCode = ""
        self.appDelegate.gpkItemVariantID = "0"
        if (self.SwitchRound.selectedIndex == 0){
                   
                   for index in 0...self.tblTransferType.count-1 {
                       if(self.tblTransferType[index]["ItemClassCode"]=="ROUNDTRIP"){
                        
                        self.appDelegate.gItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                        
                           if (SwitchShared.selectedIndex == 0){
                               if (self.tblTransferType[index]["ItemTypeCode"]=="PRIVATE"){
                                
                                self.appDelegate.gItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                                
                                   strTotalPriceUSD = self.tblTransferType[index]["TotalPriceUSD"]!
                                   strPriceUSD = self.tblTransferType[index]["PriceUSD"]!
                                   strPriceMX = self.tblTransferType[index]["PriceMX"]!
                                   strItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                                   strItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                                   self.appDelegate.gpkItemVariantID = self.tblTransferType[index]["pkItemVariantID"]!
                                
                               }
                           }else{
                               if (self.tblTransferType[index]["ItemTypeCode"]=="SHARED"){
                                
                                self.appDelegate.gItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                                   
                                   strTotalPriceUSD = self.tblTransferType[index]["TotalPriceUSD"]!
                                   strPriceUSD = self.tblTransferType[index]["PriceUSD"]!
                                   strPriceMX = self.tblTransferType[index]["PriceMX"]!
                                   strItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                                   strItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                                   self.appDelegate.gpkItemVariantID = self.tblTransferType[index]["pkItemVariantID"]!
                                
                               }
                           }
                       }else{
                           
                           if(self.tblTransferType[index]["ItemClassCode"]=="R.T. MIX"){
                               
                               self.appDelegate.gItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                               
                               if (SwitchShared.selectedIndex == 0){
                                   if (self.tblTransferType[index]["ItemTypeCode"]=="PRIVATE"){
                                       
                                       self.appDelegate.gItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                                       
                                       strTotalPriceUSD = self.tblTransferType[index]["TotalPriceUSD"]!
                                       strPriceUSD = self.tblTransferType[index]["PriceUSD"]!
                                       strPriceMX = self.tblTransferType[index]["PriceMX"]!
                                       strItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                                       strItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                                       self.appDelegate.gpkItemVariantID = self.tblTransferType[index]["pkItemVariantID"]!
                                       
                                   }
                               }else{
                                   if (self.tblTransferType[index]["ItemTypeCode"]=="SHARED"){
                                       
                                       self.appDelegate.gItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                                       
                                       strTotalPriceUSD = self.tblTransferType[index]["TotalPriceUSD"]!
                                       strPriceUSD = self.tblTransferType[index]["PriceUSD"]!
                                       strPriceMX = self.tblTransferType[index]["PriceMX"]!
                                       strItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                                       strItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                                       self.appDelegate.gpkItemVariantID = self.tblTransferType[index]["pkItemVariantID"]!
                                       
                                   }
                               }
                               
                           }
                           
                           
                       }
                   }
                   
               }else{
                   
                   for index in 0...self.tblTransferType.count-1 {
                       if(self.tblTransferType[index]["ItemClassCode"]=="ONEWAY"){
                        
                        self.appDelegate.gItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                        
                           if (SwitchShared.selectedIndex == 0){
                               if (self.tblTransferType[index]["ItemTypeCode"]=="PRIVATE"){
                                
                                self.appDelegate.gItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                                
                                   strTotalPriceUSD = self.tblTransferType[index]["TotalPriceUSD"]!
                                   strPriceUSD = self.tblTransferType[index]["PriceUSD"]!
                                   strPriceMX = self.tblTransferType[index]["PriceMX"]!
                                   strItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                                   strItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                                   self.appDelegate.gpkItemVariantID = self.tblTransferType[index]["pkItemVariantID"]!
                               }
                           }else{
                               if (self.tblTransferType[index]["ItemTypeCode"]=="SHARED"){
                                
                                self.appDelegate.gItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                                
                                   strTotalPriceUSD = self.tblTransferType[index]["TotalPriceUSD"]!
                                   strPriceUSD = self.tblTransferType[index]["PriceUSD"]!
                                   strPriceMX = self.tblTransferType[index]["PriceMX"]!
                                   strItemClassCode = self.tblTransferType[index]["ItemClassCode"]!
                                   strItemTypeCode = self.tblTransferType[index]["ItemTypeCode"]!
                                   self.appDelegate.gpkItemVariantID = self.tblTransferType[index]["pkItemVariantID"]!
                                
                               }
                           }
                       }
                   }
               }
               //print(strPriceUSD,strItemClassCode,strItemTypeCode)
        if self.appDelegate.ynTransferOutDate == false{
            
            lblSat.text = "$" + String(format: "%.2f", (String(format: "%.2f0", (strTotalPriceUSD as NSString).floatValue) as NSString).floatValue) + " USD"
            self.appDelegate.gblTotalReserv = Double((strTotalPriceUSD as NSString).floatValue)
            
        }
    }
    
    func recargarHotelItems(){
        
        var tableItems = RRDataSet()
        var iRes: String = ""
        var sRes: String = ""
        var tblTransfer: [Dictionary<String, String>]
        var tblTransferTp: Dictionary<String, String>
        var iInd: Int = 0
        
        var tblHotel: [Dictionary<String, String>]
        var tblHotelItem: Dictionary<String, String>
        
        var tbltransferConf: [Dictionary<String, String>]
        var tbltransferConfItem: Dictionary<String, String>
        
        tblTransfer = []
        tblTransferTp = [:]
        tblHotel = []
        tblHotelItem = [:]
        tbltransferConf = []
        tbltransferConfItem = [:]
        
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
        
        if self.appDelegate.ynCalcTransfer == false{
            let queue = OperationQueue()
            
            queue.addOperation() {//1
                //accion webservice-db
                if Reachability.isConnectedToNetwork(){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true

                    let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                    tableItems = service!.wmGetCalagoHoteles("D+Uc8486oGRjSoaDa+EfCvr13Bblzsw/", sAppToken: "D+Uc8486oGRjSoaDa+EfCqW0Yz+KVG4Z", sleguage: "ES", iModo: "1", strToken1: "", strToken2: "", strToken3: "", strToken4: "", strToken5: "POS")
                    
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
                                            
                                            tblHotelItem = [:]
                                            tblHotelItem["sHotelCode"] = ((r as AnyObject).getColumnByName("sHotelCode").content as? String)!
                                            tblHotelItem["sHotelName"] = ((r as AnyObject).getColumnByName("sHotelName").content as? String)!
                                            tblHotelItem["pkHotelID"] = ((r as AnyObject).getColumnByName("pkHotelID").content as? String)!
                                            tblHotelItem["ynRRClub"] = ((r as AnyObject).getColumnByName("ynRRClub").content as? String)!
                                            tblHotelItem["PropertyID"] = ((r as AnyObject).getColumnByName("PropertyID").content as? String)!
                                            tblHotel.append(tblHotelItem)
                                            
                                            if (((r as AnyObject).getColumnByName("PropertyID").content as? String)! == self.appDelegate.gifkPropertyID.description){
                                                
                                                
                                                    self.appDelegate.gstrHotelCode = ((r as AnyObject).getColumnByName("sHotelCode").content as? String)!
                                                    self.appDelegate.gstrHotelName = ((r as AnyObject).getColumnByName("sHotelName").content as? String)!
                                                    self.appDelegate.gstrDepHotelCode = ((r as AnyObject).getColumnByName("sHotelCode").content as? String)!
                                                    self.appDelegate.gstrDepHotelName = ((r as AnyObject).getColumnByName("sHotelName").content as? String)!
                                                    self.appDelegate.strArrivalHotelID = ((r as AnyObject).getColumnByName("pkHotelID").content as? String)!
                                                    self.appDelegate.strDepartureHotelID = ((r as AnyObject).getColumnByName("pkHotelID").content as? String)!
                                                    self.appDelegate.gstrHotelCodeAux = self.appDelegate.gstrHotelCode
                                                    self.appDelegate.gstrHotelNameAux = self.appDelegate.gstrHotelName
                                                    self.appDelegate.gstrDepHotelCodeAux = self.appDelegate.gstrDepHotelCode
                                                    self.appDelegate.gstrDepHotelNameAux = self.appDelegate.gstrDepHotelName
                                                    self.appDelegate.strArrivalHotelIDAux = self.appDelegate.strArrivalHotelID
                                                    self.appDelegate.strDepartureHotelIDAux = self.appDelegate.strDepartureHotelID
                                                
                                            }

                                        }
                                        
                                        
                                    } catch {
                                        rollback.pointee = true
                                        print(error)
                                    }
                                }
                            
                            if (tblHotel.count>0){
                                self.appDelegate.gtblhotel = tblHotel
                            }
                        }
                    }
                            let queue = OperationQueue()
                            
                            queue.addOperation() {//1
                                //accion webservice-db
                                if Reachability.isConnectedToNetwork(){
                                    UIApplication.shared.isNetworkActivityIndicatorVisible = true

                                    let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                                    tableItems = service!.wmGetCalagoHoteles("D+Uc8486oGRjSoaDa+EfCvr13Bblzsw/", sAppToken: "D+Uc8486oGRjSoaDa+EfCqW0Yz+KVG4Z", sleguage: "ES", iModo: "3", strToken1: "", strToken2: "", strToken3: "", strToken4: "", strToken5: "POS")
                                    
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
                                                            
                                                            tbltransferConfItem = [:]
                                                            tbltransferConfItem["Concept"] = ((r as AnyObject).getColumnByName("Concept").content as? String)!
                                                            tbltransferConfItem["ValString"] = ((r as AnyObject).getColumnByName("ValString").content as? String)!
                                                            tbltransferConfItem["ValBit"] = ((r as AnyObject).getColumnByName("ValBit").content as? String)!
                                                            tbltransferConfItem["pkApplicationClientID"] = ((r as AnyObject).getColumnByName("pkApplicationClientID").content as? String)!
                                                            tbltransferConfItem["Val"] = ((r as AnyObject).getColumnByName("Val").content as? String)!
                                                            tbltransferConfItem["MaxDateReservation"] = ((r as AnyObject).getColumnByName("MaxDateReservation").content as? String)!
                                                            tbltransferConf.append(tbltransferConfItem)
                                                            
                                                            if ((r as AnyObject).getColumnByName("Concept").content as? String)! == "TERMINALCODE"{
                                                                self.appDelegate.gsTerminalCode = ((r as AnyObject).getColumnByName("ValString").content as? String)!
                                                            }
                                                            
                                                            if ((r as AnyObject).getColumnByName("Concept").content as? String)! == "WORKSTATION"{
                                                                self.appDelegate.gsWorkStationCode = ((r as AnyObject).getColumnByName("ValString").content as? String)!
                                                            }
 
                                                        }
                                                        
                                                        
                                                    } catch {
                                                        rollback.pointee = true
                                                        print(error)
                                                    }
                                                }
                                            
                                            if (tbltransferConf.count>0){
                                                self.appDelegate.gtblTransferConf = tbltransferConf
                                            }
                                    
                                }
                                
                            }
                            
                            if self.appDelegate.gstrHotelCode.description != ""{
                                let queue2 = OperationQueue()
                                
                                queue2.addOperation() {//1
                                    //accion webservice-db
                                    if Reachability.isConnectedToNetwork(){
                                        UIApplication.shared.isNetworkActivityIndicatorVisible = true

                                        let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                                        tableItems = service!.wmGetCatalogItemsVtm("ES", sItemCode: "", sAttributeCodes: "", iTransferTypeID: "0", sItemTypeCodes: "", sHotelArrivalCode: self.appDelegate.gstrHotelCode.description, sHotelDeparturCode: self.appDelegate.gstrDepHotelCode.description, iNumPax: self.appDelegate.giPeopleNumTransfer.description, sClientToken: "D+Uc8486oGRjSoaDa+EfCvr13Bblzsw/", sAppToken: "D+Uc8486oGRjSoaDa+EfCqW0Yz+KVG4Z", strToken1: "", strToken2: "", strToken3: "", strToken4: "", strToken5: "POS")
                                        
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
                                                iInd = 0

                                                self.appDelegate.gItemClassCodeSel = ""
                                                self.appDelegate.gItemTypeCodeSel = ""
                                                self.appDelegate.ynOtherHotel = false
                                                
                                                    queueFM?.inTransaction { db, rollback in
                                                        do {
                                                            
                                                            for r in table.rows{
                                                                
                                                                if iInd == 0{
                                                                    self.appDelegate.gItemClassCodeSel = ((r as AnyObject).getColumnByName("ItemClassCode").content as? String)!
                                                                    self.appDelegate.gItemTypeCodeSel = ((r as AnyObject).getColumnByName("ItemTypeCode").content as? String)!
                                                                }
                                                                
                                                                if self.appDelegate.gItemClassCodeSel == "R.T. MIX"{
                                                                    self.appDelegate.ynOtherHotel = true
                                                                }

                                                                tblTransferTp = [:]
                                                                tblTransferTp["PriceUSD"] = ((r as AnyObject).getColumnByName("PriceUSD").content as? String)!
                                                                tblTransferTp["PriceMX"] = ((r as AnyObject).getColumnByName("PriceMX").content as? String)!
                                                                tblTransferTp["ItemClassCode"] = ((r as AnyObject).getColumnByName("ItemClassCode").content as? String)!
                                                                tblTransferTp["CategoryCode"] = ((r as AnyObject).getColumnByName("CategoryCode").content as? String)!
                                                                tblTransferTp["ItemTypeCode"] = ((r as AnyObject).getColumnByName("ItemTypeCode").content as? String)!
                                                                tblTransferTp["MinPax"] = ((r as AnyObject).getColumnByName("MinPax").content as? String)!
                                                                tblTransferTp["MaxPax"] = ((r as AnyObject).getColumnByName("MaxPax").content as? String)!
                                                                tblTransferTp["attributeName"] = ((r as AnyObject).getColumnByName("attributeName").content as? String)!
                                                                tblTransferTp["pkItemVariantID"] = ((r as AnyObject).getColumnByName("pkItemVariantID").content as? String)!
                                                                tblTransferTp["TotalPriceUSD"] = ((r as AnyObject).getColumnByName("TotalPriceUSD").content as? String)!
                                                                tblTransfer.append(tblTransferTp)
                                                                
                                                                iInd = iInd + 1
                                                                
                                                            }
                                                            
                                                            
                                                        } catch {
                                                            rollback.pointee = true
                                                            print(error)
                                                        }
                                                }
                                                
                                                
                                                if (tblTransfer.count>0){
                                                    self.tblTransferType = tblTransfer
                                                }
                                                
                                                if self.appDelegate.ynTransferOutDate == false{
                                                    
                                                    if self.appDelegate.gItemClassCode != "ONEWAY"{
                                                        self.SwitchRound.setSelectedIndex(0, animated: true)
                                                    }
                                                    
                                                    if self.appDelegate.ynOtherHotel{
                                                        self.SwitchRound.isEnabled = false
                                                        self.SwitchRound.backgroundColor = UIColor.gray
                                                    }else{
                                                        self.SwitchRound.isEnabled = true
                                                        self.SwitchRound.backgroundColor = self.colorWithHexString ("5C9FCC")
                                                    }
                                                    
                                                    /*if self.appDelegate.gItemClassCodeSel == "ROUNDTRIP"{
                                                        self.SwitchRound.setSelectedIndex(0, animated: true)
                                                    }
                                                    if self.appDelegate.gItemClassCodeSel == "ONEWAY"{
                                                        self.SwitchRound.setSelectedIndex(1, animated: true)
                                                    }*/
                                                    if self.appDelegate.gItemTypeCodeSel == "PRIVATE"{
                                                        self.SwitchShared.setSelectedIndex(0, animated: true)
                                                    }
                                                    if self.appDelegate.gItemTypeCodeSel == "SHARED"{
                                                        self.SwitchShared.setSelectedIndex(1, animated: true)
                                                    }

                                                    self.switchRoundDidChange(self.SwitchRound)
                                                    self.switchPrivateDidChange(self.SwitchShared)
                                                    SwiftLoader.hide()
                                                    
                                                }
                                                
                                                
                                            }
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
                                }
                            }
                            
                            SwiftLoader.hide()
                                    
                        }

                    }

                    
                }
            }//1
        }else{

                let queue2 = OperationQueue()
                
                queue2.addOperation() {//1
                    //accion webservice-db
                    if Reachability.isConnectedToNetwork(){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = true

                        let service=RRRestaurantService(url: self.appDelegate.URLService as String, host: self.appDelegate.Host as String, userNameMobile : self.appDelegate.UserName, passwordMobile: self.appDelegate.Password);
                        tableItems = service!.wmGetCatalogItemsVtm("ES", sItemCode: "", sAttributeCodes: "", iTransferTypeID: "0", sItemTypeCodes: "", sHotelArrivalCode: self.appDelegate.gstrHotelCode.description, sHotelDeparturCode: self.appDelegate.gstrDepHotelCode.description, iNumPax: self.appDelegate.giPeopleNumTransfer.description, sClientToken: "D+Uc8486oGRjSoaDa+EfCvr13Bblzsw/", sAppToken: "D+Uc8486oGRjSoaDa+EfCqW0Yz+KVG4Z", strToken1: "", strToken2: "", strToken3: "", strToken4: "", strToken5: "POS")
                        
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
                                iInd = 0

                                self.appDelegate.gItemClassCodeSel = ""
                                self.appDelegate.gItemTypeCodeSel = ""
                                self.appDelegate.ynOtherHotel = false
                                
                                    queueFM?.inTransaction { db, rollback in
                                        do {
                                            
                                            for r in table.rows{
                                                
                                                if iInd == 0{
                                                    self.appDelegate.gItemClassCodeSel = ((r as AnyObject).getColumnByName("ItemClassCode").content as? String)!
                                                    self.appDelegate.gItemTypeCodeSel = ((r as AnyObject).getColumnByName("ItemTypeCode").content as? String)!
                                                }
                                                
                                                if self.appDelegate.gItemClassCodeSel == "R.T. MIX"{
                                                    self.appDelegate.ynOtherHotel = true
                                                }
                                                
                                                tblTransferTp = [:]
                                                tblTransferTp["PriceUSD"] = ((r as AnyObject).getColumnByName("PriceUSD").content as? String)!
                                                tblTransferTp["PriceMX"] = ((r as AnyObject).getColumnByName("PriceMX").content as? String)!
                                                tblTransferTp["ItemClassCode"] = ((r as AnyObject).getColumnByName("ItemClassCode").content as? String)!
                                                tblTransferTp["CategoryCode"] = ((r as AnyObject).getColumnByName("CategoryCode").content as? String)!
                                                tblTransferTp["ItemTypeCode"] = ((r as AnyObject).getColumnByName("ItemTypeCode").content as? String)!
                                                tblTransferTp["MinPax"] = ((r as AnyObject).getColumnByName("MinPax").content as? String)!
                                                tblTransferTp["MaxPax"] = ((r as AnyObject).getColumnByName("MaxPax").content as? String)!
                                                tblTransferTp["attributeName"] = ((r as AnyObject).getColumnByName("attributeName").content as? String)!
                                                tblTransferTp["pkItemVariantID"] = ((r as AnyObject).getColumnByName("pkItemVariantID").content as? String)!
                                                tblTransferTp["TotalPriceUSD"] = ((r as AnyObject).getColumnByName("TotalPriceUSD").content as? String)!
                                                tblTransfer.append(tblTransferTp)
                                                
                                                iInd = iInd + 1
                                                
                                            }
                                            
                                            
                                        } catch {
                                            rollback.pointee = true
                                            print(error)
                                        }
                                      
                                }
                                
                                
                                if (tblTransfer.count>0){
                                    self.tblTransferType = tblTransfer
                                }
                                
                                if self.appDelegate.gItemClassCode != "ONEWAY"{
                                    self.SwitchRound.setSelectedIndex(0, animated: true)
                                }

                                if self.appDelegate.ynOtherHotel{
                                    self.SwitchRound.isEnabled = false
                                    self.SwitchRound.backgroundColor = UIColor.gray
                                }else{
                                    self.SwitchRound.isEnabled = true
                                    self.SwitchRound.backgroundColor = self.colorWithHexString ("5C9FCC")
                                }
                                
                                /*if self.appDelegate.gItemClassCodeSel == "ROUNDTRIP"{
                                    self.SwitchRound.setSelectedIndex(0, animated: true)
                                }
                                if self.appDelegate.gItemClassCodeSel == "ONEWAY"{
                                    self.SwitchRound.setSelectedIndex(1, animated: true)
                                }*/
                                if self.appDelegate.gItemTypeCodeSel == "PRIVATE"{
                                    self.SwitchShared.setSelectedIndex(0, animated: true)
                                }
                                if self.appDelegate.gItemTypeCodeSel == "SHARED"{
                                    self.SwitchShared.setSelectedIndex(1, animated: true)
                                }
                                self.switchRoundDidChange(self.SwitchRound)
                                self.switchPrivateDidChange(self.SwitchShared)
                                SwiftLoader.hide()
                                

                            }
                            
                        }
                        
                        
                    }
                    
                    
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.toolbar.isHidden = true
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-TransferInfo",
            AnalyticsParameterItemName: "TransferInfo",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("TransferInfo", screenClass: appDelegate.gstrAppName)
        
        self.appDelegate.gstrOperatorNameArrival = ""
        self.appDelegate.gstrOperatorNameDeparture = ""
        self.appDelegate.strArrivalFlightHourAux = ""
        self.appDelegate.strDepartureFlightHourAux = ""
        self.appDelegate.strArrivalFlightCode = ""
        self.appDelegate.strDepartureFlightCode = ""
        self.appDelegate.gstrOperatorNameCodeArrival = ""
        self.appDelegate.gstrOperatorNameCodeDeparture = ""
        
        if appDelegate.ynUpdTransfer{

            //self.appDelegate.ynTransferOutDate = false
            
            if appDelegate.ynCalcTransfer{
                recargarHotelItems()
            }
            
            UpdForm()

            /*if !appDelegate.ynCalcTransfer{
                self.SwitchRound.setSelectedIndex(0, animated: true)
                self.SwitchShared.setSelectedIndex(0, animated: true)
                self.switchRoundDidChange(self.SwitchRound)
                self.switchPrivateDidChange(self.SwitchShared)
            }*/
            
        }
    }

    @objc func clickAdd(_ sender: AnyObject){
        
        //let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcAddFolloUp") as! vcAddFolloUp
        //self.navigationController?.pushViewController(tercerViewController, animated: true)

        let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcTransferEdit") as! vcTransferEdit
        self.navigationController?.pushViewController(tercerViewController, animated: true)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self.view)
            /*if lblUSTel.frame.contains(location) {
                UIApplication.shared.openURL(NSURL(string: lblUSTel.text!.description) as! URL)
            }
            if lblMexTel.frame.contains(location) {
                UIApplication.shared.openURL(NSURL(string: lblMexTel.text!.description) as! URL)
            }*/

        }
    }

    @objc func clickContinue(_ sender: AnyObject) {
        if (strTotalPriceUSD as NSString).floatValue > 0{
            let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcTransferSubmit") as! vcTransferSubmit
            self.navigationController?.pushViewController(tercerViewController, animated: true)
        }

    }
    
}

