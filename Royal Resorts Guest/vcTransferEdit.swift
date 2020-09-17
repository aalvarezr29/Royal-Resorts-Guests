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

class vcTransferEdit: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var strFont: String = ""
    var urlHome: String = ""
    var titleCode:String = ""
    var lblReservation = UILabel()
    var txtReservation = UITextField()
    var lblArrivalHotel = UILabel()
    var txtArrivalHotel = UITextField()
    var lblArrivalDate = UILabel()
    var txtArrivalDate = UITextField()
    var btnChooseDate = UIButton()
    var tableForm = UITableView()
    var imgCell = UIImage()
    var imgvwCell = UIImageView()
    var lastIndex = IndexPath()
    var btnSave = UIButton()
    var btnCancel = UIButton()
    var txtpax = UITextField()
    
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
        
        btnSave.addTarget(self, action: #selector(vcTransferEdit.clickSave(_:)), for: UIControl.Event.touchUpInside)
        btnCancel.addTarget(self, action: #selector(vcTransferEdit.clickCancel(_:)), for: UIControl.Event.touchUpInside)
        txtpax.addTarget(self, action: #selector(vcTransferEdit.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        txtpax.delegate = self
        
        tableForm.delegate = self
        tableForm.dataSource = self
        tableForm.separatorStyle = .none
        tableForm.backgroundColor = UIColor.clear
        self.tableForm.register(tvcTransferEdit.self, forCellReuseIdentifier: "tvcTransferEdit")
        
        if appDelegate.ynIPad {

                tableForm.frame = CGRect(x: 0.05*width, y: 0.01*height, width: 0.9*width, height: 0.9*height);

        }else{

                tableForm.frame = CGRect(x: 0.05*width, y: 0.01*height, width: 0.9*width, height: 0.9*height);

        }
        
        self.view.addSubview(tableForm)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 0.08*height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableForm.dequeueReusableCell(withIdentifier: "tvcTransferEdit", for: indexPath) as! tvcTransferEdit
        
        if appDelegate.strBundleIdentifier == "com.royalresorts.guestservices"{
            
            cell.backgroundColor = UIColor.clear
            
            if indexPath.row <= 5{
                // Initialize a gradient view
                let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 0.9*width, height: 0.12*height))
                
                // Set the gradient colors 8DE3F5 5C9F00
                gradientView.colors = [UIColor.white, colorWithHexString ("F2F2F2")]
                
                // Optionally set some locations
                gradientView.locations = [0.4, 1.0]
                
                // Optionally change the direction. The default is vertical.
                gradientView.direction = .vertical
                
                // Add some borders too if you want
                gradientView.topBorderColor = UIColor.lightGray
                
                gradientView.bottomBorderColor = colorWithHexString ("C7C7CD")

                cell.backgroundView = gradientView

            }

        }else if appDelegate.strBundleIdentifier == "com.royalresorts.guestservicesgrm"{
            
            cell.backgroundColor = UIColor.clear
            cell.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("e4c29c"))
            
            if indexPath.row == 0{
                imgCell = UIImage(named:"tblacchdr.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblacchdrSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }else if (4) == indexPath.row{
                imgCell = UIImage(named:"tblaccfooter.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblaccfooterSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            } else {
                
                imgCell = UIImage(named:"tblaccrow.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblaccrowSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }
            
            
        }else if appDelegate.strBundleIdentifier == "com.royalresortscaribbean.guestservices"{
            
            cell.backgroundColor = UIColor.clear
            cell.accessoryView = STKColorAccessoryView.init(color: colorWithHexString("94cce5"))
            
            if indexPath.row == 0{
                imgCell = UIImage(named:"tblacchdr.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblacchdrSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }else if (4) == indexPath.row{
                imgCell = UIImage(named:"tblaccfooter.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblaccfooterSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            } else {
                
                imgCell = UIImage(named:"tblaccrow.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.backgroundView = imgvwCell
                
                imgCell = UIImage(named:"tblaccrowSel.png")!
                imgvwCell = UIImageView(image: imgCell)
                cell.selectedBackgroundView = imgvwCell
            }
            
        }
        
        self.txtpax.text = self.appDelegate.giPeopleNumTransferAux.description
        
        cell.SetValues(indexPath.row.description, btnSave: self.btnSave, btnCancel: self.btnCancel, txtpax: self.txtpax, width: width, height: height)
        
        if self.appDelegate.gItemClassCode == "ONEWAY"{
            if indexPath.row <= 2{
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            }else{
                cell.accessoryType = UITableViewCell.AccessoryType.none
            }
        }else{
            if indexPath.row <= 4{
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            }else{
                cell.accessoryType = UITableViewCell.AccessoryType.none
            }
        }

        if indexPath.row > 5{
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.white
            cell.selectedBackgroundView = backgroundView
            cell.backgroundView = backgroundView
        }
        
        if indexPath.row == 5{
            
            let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 0.9*width, height: 0.12*height))
            gradientView.colors = [UIColor.white, colorWithHexString ("F2F2F2")]
            gradientView.locations = [0.4, 1.0]
            gradientView.direction = .vertical
            gradientView.topBorderColor = UIColor.lightGray
            gradientView.bottomBorderColor = colorWithHexString ("C7C7CD")
            cell.selectedBackgroundView = gradientView

        }
        
        lastIndex = IndexPath.init()
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row.description == "0"{
            if self.appDelegate.iCountStayF > 1{
                let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectStay") as! vcSelectStay
                tercerViewController.strMode = "TransferReserv"
                self.navigationController?.pushViewController(tercerViewController, animated: true)
            }
        } else if indexPath.row.description == "1"{
              let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectStay") as! vcSelectStay
              tercerViewController.strMode = "TransferArrivalHotel"
              self.navigationController?.pushViewController(tercerViewController, animated: true)
        } else if indexPath.row.description == "2"{
            let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectStay") as! vcSelectStay
            tercerViewController.strMode = "TransferArrivalDate"
            self.navigationController?.pushViewController(tercerViewController, animated: true)
        } else if indexPath.row.description == "3" && self.appDelegate.gItemClassCode != "ONEWAY"{
            let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectStay") as! vcSelectStay
            tercerViewController.strMode = "TransferDepartureHotel"
            self.navigationController?.pushViewController(tercerViewController, animated: true)
        } else if indexPath.row.description == "4" && self.appDelegate.gItemClassCode != "ONEWAY"{
            let tercerViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcSelectStay") as! vcSelectStay
            tercerViewController.strMode = "TransferDepartureDate"
            self.navigationController?.pushViewController(tercerViewController, animated: true)
        } else if indexPath.row.description == "5"{

        } else if indexPath.row.description == "6"{
 
        } else if indexPath.row.description == "7"{

        }
        
        tableView.cellForRow(at: indexPath)?.isUserInteractionEnabled = true

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
            AnalyticsParameterItemID: "id-TransferEdit",
            AnalyticsParameterItemName: "TransferEdit",
            AnalyticsParameterContentType: "Pantalla"
            ])
        
        Analytics.setScreenName("TransferEdit", screenClass: appDelegate.gstrAppName)
        
        var ynActualiza: Bool = false
        
        if(appDelegate.gstrConfirmationCodeTransfer != ""){
            
            ynActualiza = true

        }
        
        if ynActualiza == true {
            
            tableForm.reloadData()

        }
        
        appDelegate.ynUpdTransfer = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    @objc func clickSave(_ sender: AnyObject) {

        let dateFormatterdp: DateFormatter = DateFormatter()
        dateFormatterdp.dateFormat = "MM/dd/yyyy"
        let dtExpectedArrivalDateVal = dateFormatterdp.date(from: appDelegate.gstrArrivalTransferAux)!
        let dtExpectedDepartureDateVal = dateFormatterdp.date(from: appDelegate.gstrDepartureTransferAux)!
        appDelegate.ynUpdTransfer = false
        appDelegate.ynCalcTransfer = false
        
        if dtExpectedArrivalDateVal > dtExpectedDepartureDateVal{
            
            RKDropdownAlert.title(NSLocalizedString("strInvalidArrival",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)

            return
        }else if Int((txtpax.text! as NSString).floatValue) < 1{
            
            RKDropdownAlert.title(NSLocalizedString("strInvalidPax",comment:""), backgroundColor: UIColor.red, textColor: UIColor.black)
            
            return
        }else{
            
            if appDelegate.gstrConfirmationCodeTransfer != appDelegate.gstrConfirmationCodeTransferAux{
                appDelegate.ynUpdTransfer = true
                appDelegate.ynCalcTransfer = true
            }
            
            if appDelegate.gstrHotelCode != appDelegate.gstrHotelCodeAux{
                appDelegate.ynUpdTransfer = true
                appDelegate.ynCalcTransfer = true
            }
            
            if appDelegate.gstrHotelName != appDelegate.gstrHotelNameAux{
                appDelegate.ynUpdTransfer = true
                appDelegate.ynCalcTransfer = true
            }
            
            if appDelegate.gstrDepHotelCode != appDelegate.gstrDepHotelCodeAux{
                appDelegate.ynUpdTransfer = true
                appDelegate.ynCalcTransfer = true
            }
            
            if appDelegate.gstrDepHotelName != appDelegate.gstrDepHotelNameAux{
                appDelegate.ynUpdTransfer = true
                appDelegate.ynCalcTransfer = true
            }
            
            if appDelegate.strArrivalHotelID != appDelegate.strArrivalHotelIDAux{
                appDelegate.ynUpdTransfer = true
                appDelegate.ynCalcTransfer = true
            }
            
            if appDelegate.strDepartureHotelID != appDelegate.strDepartureHotelIDAux{
                appDelegate.ynUpdTransfer = true
                appDelegate.ynCalcTransfer = true
            }
            
            if appDelegate.gstrPropertyTransfer != appDelegate.gstrHotelName{
                appDelegate.ynUpdTransfer = true
                appDelegate.ynCalcTransfer = true
            }
            
            if appDelegate.gstrArrivalTransfer != appDelegate.gstrArrivalTransferAux{
                appDelegate.ynUpdTransfer = true
                appDelegate.ynCalcTransfer = true
            }
            
            if appDelegate.gstrDepartureTransfer != appDelegate.gstrDepartureTransferAux{
                appDelegate.ynUpdTransfer = true
                appDelegate.ynCalcTransfer = true
            }
            
            if appDelegate.giPeopleNumTransferAux != Int((txtpax.text! as NSString).floatValue){
                appDelegate.ynUpdTransfer = true
                appDelegate.ynCalcTransfer = true
            }
            
            //appDelegate.ynUpdTransfer = true
            
            /*if appDelegate.gstrHotelCodeAux == appDelegate.gstrDepHotelCodeAux{
                appDelegate.ynOtherHotel = false
            }else{
                appDelegate.ynOtherHotel = true
            }*/
            
            
            appDelegate.gstrConfirmationCodeTransfer = appDelegate.gstrConfirmationCodeTransferAux
            appDelegate.gstrHotelCode = appDelegate.gstrHotelCodeAux
            appDelegate.gstrHotelName = appDelegate.gstrHotelNameAux
            appDelegate.gstrDepHotelCode = appDelegate.gstrDepHotelCodeAux
            appDelegate.gstrDepHotelName = appDelegate.gstrDepHotelNameAux

            if self.appDelegate.gItemClassCode == "ONEWAY"{
                appDelegate.gstrArrivalTransfer = appDelegate.gstrArrivalTransferAux
                appDelegate.gstrDepartureTransfer = appDelegate.gstrArrivalTransferAux
                appDelegate.strArrivalHotelID = appDelegate.strArrivalHotelIDAux
                appDelegate.strDepartureHotelID = appDelegate.strArrivalHotelIDAux
            }else{
                appDelegate.gstrArrivalTransfer = appDelegate.gstrArrivalTransferAux
                appDelegate.gstrDepartureTransfer = appDelegate.gstrDepartureTransferAux
                appDelegate.strArrivalHotelID = appDelegate.strArrivalHotelIDAux
                appDelegate.strDepartureHotelID = appDelegate.strDepartureHotelIDAux
            }
            
            self.appDelegate.gstrPropertyTransfer = appDelegate.gstrHotelName
            appDelegate.giPeopleNumTransferAux = Int((txtpax.text! as NSString).floatValue)
            /*if appDelegate.giPeopleNumTransferAux != appDelegate.giPeopleNumTransfer{*/
                appDelegate.giPeopleNumTransfer = appDelegate.giPeopleNumTransferAux
            /*}else{
                appDelegate.ynCalcTransfer = false
            }*/
            
            appDelegate.giPeopleNumAITransfer = appDelegate.giPeopleNumTransferAux
            self.navigationController?.popViewController(animated: true)
        }

    }
    
    @objc func clickCancel(_ sender: AnyObject) {
        appDelegate.gstrArrivalTransferAux = appDelegate.gstrArrivalTransfer
        appDelegate.gstrDepartureTransferAux = appDelegate.gstrDepartureTransfer
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
           
           /*if Double((textField.text! as NSString).floatValue) > 0{
                
            self.appDelegate.giPeopleNumTransferAux = Int((textField.text! as NSString).floatValue)
            
            }*/

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var result = true
        var ireturn: Int = 11
        
        if textField == txtpax {

            let newLength = textField.text!.utf16.count + string.utf16.count - range.length
            result = (newLength <= ireturn)
            
            if string.characters.count > 0 && (result == true) {
                let disallowedCharacterSet = CharacterSet(charactersIn: "0123456789.").inverted
                let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }
            
        }

        return result
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

