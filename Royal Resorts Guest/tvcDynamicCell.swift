//
//  tvcDynamicCell.swift
//  Royal Resorts Guest
//
//  Created by Soluciones on 12/9/19.
//  Copyright © 2019 Marco Cocom. All rights reserved.
//

import Foundation

open class tvcDynamicCell: UITableViewCell {

let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var lblArrivalDate = UILabel()
    var lblDepartureDate = UILabel()
    var lblLabel = UILabel()
    var btnButoon = UIButton()
    var dtArrivalPicker = UIDatePicker()
    var dtArrivalPickerHour = UIDatePicker()
    var dtDeparturePicker = UIDatePicker()
    var dtDeparturePickerHour = UIDatePicker()
    var dtExpectedArrival: String = ""
    var dtExpectedArrivalDate: Date = Date()
    var strExpectedArrival: String = ""
    var dtExpectedDeparture: String = ""
    var dtExpectedDepartureDate: Date = Date()
    var strExpectedDeparture: String = ""
    var strDateTime: String = ""
    
    var dtExpectedArrivalDateMin: Date = Date()
    var strExpectedArrivalMin: String = ""
    var dtExpectedDepartureDateMax: Date = Date()
    var strExpectedDepartureDateMax: String = ""
    
    var dtCheckinConf: Date = Date()
    var strdtCheckinConf: String = ""
    
    public func SetValues(_ Code: String?, dtDate: String?, txtTextField: UITextField, width: CGFloat?, height: CGFloat?) {

        if (Code == "TransferArrivalDate"){
            
            let dateFormatterdp: DateFormatter = DateFormatter()
            dateFormatterdp.dateFormat = "MM/dd/yyyy"
            dtExpectedArrivalDate = dateFormatterdp.date(from: dtDate!)!
            dtExpectedArrivalDateMin = dateFormatterdp.date(from: appDelegate.gstrArrivalTransferAuxMin)!
            dtExpectedDepartureDateMax = dateFormatterdp.date(from: appDelegate.gstrDepartureTransferAuxMax)!
            
            let strFormatter: DateFormatter = DateFormatter()
            strFormatter.dateFormat = "yyyy-MM-dd"
            strExpectedArrival = strFormatter.string(from: dtExpectedArrivalDate)
            strExpectedArrivalMin = strFormatter.string(from: dtExpectedArrivalDateMin)
            strExpectedDepartureDateMax = strFormatter.string(from: dtExpectedDepartureDateMax)
            
            let dateFormatterck: DateFormatter = DateFormatter()
            dateFormatterck.dateFormat = "yyyy-MM-dd"
            dtExpectedArrivalDate = dateFormatterck.date(from: strExpectedArrival)!
            dtExpectedArrivalDateMin = dateFormatterck.date(from: strExpectedArrivalMin)!
            dtExpectedDepartureDateMax = dateFormatterck.date(from: strExpectedDepartureDateMax)!
            
            lblArrivalDate.frame = CGRect(x: 0.01*width!, y: 0.01*height!, width: 0.2*width!, height: 0.03*height!);
            lblArrivalDate.backgroundColor = UIColor.clear
            lblArrivalDate.textAlignment = NSTextAlignment.left
            lblArrivalDate.textColor = colorWithHexString("000000")
            lblArrivalDate.numberOfLines = 0;
            lblArrivalDate.adjustsFontSizeToFitWidth = true
            lblArrivalDate.font = UIFont(name: "Helvetica", size: appDelegate.gblFont9 + appDelegate.gblDeviceFont3)
            lblArrivalDate.text = NSLocalizedString("lblArrivalDate",comment:"");
            
            dtArrivalPicker.frame = CGRect(x: 0.01*width!, y: 0.04*height!, width: 0.8*width!, height: 0.08*height!);
            dtArrivalPicker.minimumDate = dtExpectedArrivalDateMin
            //dtArrivalPicker.maximumDate = dtExpectedDepartureDateMax
            dtArrivalPicker.datePickerMode = .date
            dtArrivalPicker.setDate(dtExpectedArrivalDate, animated: false)
            
            dtArrivalPicker.addTarget(self, action: #selector(tvcDynamicCell.dateTimeArrivalChanged(picker:)), for: UIControl.Event.valueChanged)
            
            self.addSubview(lblArrivalDate)
            self.addSubview(dtArrivalPicker)
            
            
        } else if (Code == "TransferDepartureDate"){
            
            let dateFormatterdp: DateFormatter = DateFormatter()
            dateFormatterdp.dateFormat = "MM/dd/yyyy"
            dtExpectedDepartureDate = dateFormatterdp.date(from: dtDate!)!
            dtExpectedArrivalDateMin = dateFormatterdp.date(from: appDelegate.gstrArrivalTransferAuxMin)!
            dtExpectedDepartureDateMax = dateFormatterdp.date(from: appDelegate.gstrDepartureTransferAuxMax)!

            let strFormatter: DateFormatter = DateFormatter()
            strFormatter.dateFormat = "yyyy-MM-dd"
            strExpectedDeparture = strFormatter.string(from: dtExpectedDepartureDate)
            strExpectedArrivalMin = strFormatter.string(from: dtExpectedArrivalDateMin)
            strExpectedDepartureDateMax = strFormatter.string(from: dtExpectedDepartureDateMax)
            
            let dateFormatterck: DateFormatter = DateFormatter()
            dateFormatterck.dateFormat = "yyyy-MM-dd"
            dtExpectedDepartureDate = dateFormatterck.date(from: strExpectedDeparture)!
            dtExpectedArrivalDateMin = dateFormatterck.date(from: strExpectedArrivalMin)!
            dtExpectedDepartureDateMax = dateFormatterck.date(from: strExpectedDepartureDateMax)!
            
            lblDepartureDate.frame = CGRect(x: 0.01*width!, y: 0.01*height!, width: 0.2*width!, height: 0.03*height!);
            lblDepartureDate.backgroundColor = UIColor.clear
            lblDepartureDate.textAlignment = NSTextAlignment.left
            lblDepartureDate.textColor = colorWithHexString("000000")
            lblDepartureDate.numberOfLines = 0;
            lblDepartureDate.adjustsFontSizeToFitWidth = true
            lblDepartureDate.font = UIFont(name: "Helvetica", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
            lblDepartureDate.text = NSLocalizedString("lblDepartureDate",comment:"");
            
            dtDeparturePicker.frame = CGRect(x: 0.01*width!, y: 0.04*height!, width: 0.8*width!, height: 0.08*height!);
            dtDeparturePicker.minimumDate = dtExpectedArrivalDateMin
            //dtDeparturePicker.maximumDate = dtExpectedDepartureDateMax
            dtDeparturePicker.locale = Locale(identifier: "en_US")
            dtDeparturePicker.datePickerMode = .date
            dtDeparturePicker.setDate(dtExpectedDepartureDate, animated: false)
            
            dtDeparturePicker.addTarget(self, action: #selector(tvcDynamicCell.dateTimeDepartureChanged(picker:)), for: UIControl.Event.valueChanged)
            
            self.addSubview(lblDepartureDate)
            self.addSubview(dtDeparturePicker)
            
            
        } else if (Code == "ArrivalFlightHour"){

            lblArrivalDate.frame = CGRect(x: 0.01*width!, y: 0.01*height!, width: 0.2*width!, height: 0.03*height!);
            lblArrivalDate.backgroundColor = UIColor.clear
            lblArrivalDate.textAlignment = NSTextAlignment.left
            lblArrivalDate.textColor = colorWithHexString("000000")
            lblArrivalDate.numberOfLines = 0;
            lblArrivalDate.adjustsFontSizeToFitWidth = true
            lblArrivalDate.font = UIFont(name: "Helvetica", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
            lblArrivalDate.text = NSLocalizedString("lblArrivalFlightHour",comment:"");
            
            dtArrivalPickerHour.frame = CGRect(x: 0.4*width!, y: 0.04*height!, width: 0.4*width!, height: 0.08*height!);

            let todaysDate:Date = Date()
            let dtdateFormatter:DateFormatter = DateFormatter()
            dtdateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let DateInFormat:String = dtdateFormatter.string(from: todaysDate)

            let dtdateFormatterAux:DateFormatter = DateFormatter()
            dtdateFormatterAux.dateFormat = "yyyy-MM-dd HH:mm"
            dtdateFormatterAux.locale = Locale(identifier: "en_GB")
            dtdateFormatterAux.timeZone = TimeZone(secondsFromGMT: 0)
            let DateInFormatAux:Date = dtdateFormatterAux.date(from: DateInFormat)!

            if self.appDelegate.gItemTypeCode == "SHARED"{
                dtArrivalPickerHour.minimumDate = appDelegate.gdtMOBAPP_TRAFROM
                dtArrivalPickerHour.maximumDate = appDelegate.gdtMOBAPP_TRATO
            }
            
            if self.appDelegate.strArrivalFlightHourAux == ""{
                
                dtArrivalPickerHour.datePickerMode = .time
                dtArrivalPickerHour.timeZone = TimeZone(secondsFromGMT: 0)
                dtArrivalPickerHour.setDate(DateInFormatAux, animated: false)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                dateFormatter.locale = Locale(identifier: "en_GB")
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                let dateStr = dateFormatter.string(from: DateInFormatAux)

                self.appDelegate.strArrivalFlightHourAux = dateStr
                
            }else{
                
                let dateFormatterWST: DateFormatter = DateFormatter()
                dateFormatterWST.dateFormat = "yyyy-MM-dd"
                let dateStrWST = dateFormatterWST.string(from: DateInFormatAux)
                
                let strDepartureDate = dateStrWST + " " + self.appDelegate.strArrivalFlightHourAux
                
                let dtdateFormatterAux:DateFormatter = DateFormatter()
                dtdateFormatterAux.dateFormat = "yyyy-MM-dd HH:mm"
                dtdateFormatterAux.locale = Locale(identifier: "en_GB")
                dtdateFormatterAux.timeZone = TimeZone(secondsFromGMT: 0)
                let DateInFormatAux:Date = dtdateFormatterAux.date(from: strDepartureDate)!
                
                dtArrivalPickerHour.timeZone = TimeZone(secondsFromGMT: 0)
                dtArrivalPickerHour.datePickerMode = .time
                dtArrivalPickerHour.setDate(DateInFormatAux, animated: false)

            }

            dtArrivalPickerHour.addTarget(self, action: #selector(tvcDynamicCell.ArrivalFlightHourChanged(picker:)), for: UIControl.Event.valueChanged)
            
            self.addSubview(lblArrivalDate)
            self.addSubview(dtArrivalPickerHour)
            
            
        } else if (Code == "DepartureFlightHour"){

            lblDepartureDate.frame = CGRect(x: 0.01*width!, y: 0.01*height!, width: 0.2*width!, height: 0.03*height!);
            lblDepartureDate.backgroundColor = UIColor.clear
            lblDepartureDate.textAlignment = NSTextAlignment.left
            lblDepartureDate.textColor = colorWithHexString("000000")
            lblDepartureDate.numberOfLines = 0;
            lblDepartureDate.adjustsFontSizeToFitWidth = true
            lblDepartureDate.font = UIFont(name: "Helvetica", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
            lblDepartureDate.text = NSLocalizedString("lblDepartureFlightHour",comment:"");
            
            dtDeparturePickerHour.frame = CGRect(x: 0.4*width!, y: 0.04*height!, width: 0.4*width!, height: 0.08*height!);
            
            let todaysDate:Date = Date()
            let dtdateFormatter:DateFormatter = DateFormatter()
            dtdateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let DateInFormat:String = dtdateFormatter.string(from: todaysDate)

            let dtdateFormatterAux:DateFormatter = DateFormatter()
            dtdateFormatterAux.dateFormat = "yyyy-MM-dd HH:mm"
            dtdateFormatterAux.locale = Locale(identifier: "en_GB")
            dtdateFormatterAux.timeZone = TimeZone(secondsFromGMT: 0)
            let DateInFormatAux:Date = dtdateFormatterAux.date(from: DateInFormat)!
            
            if self.appDelegate.gItemTypeCode == "SHARED"{
                dtDeparturePickerHour.minimumDate = appDelegate.gdtMOBAPP_TRDFROM
                dtDeparturePickerHour.maximumDate = appDelegate.gdtMOBAPP_TRDTO
            }

            if self.appDelegate.strDepartureFlightHourAux == ""{
                
                dtDeparturePickerHour.timeZone = TimeZone(secondsFromGMT: 0)
                dtDeparturePickerHour.datePickerMode = .time
                dtDeparturePickerHour.setDate(DateInFormatAux, animated: false)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                dateFormatter.locale = Locale(identifier: "en_GB")
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                let dateStr = dateFormatter.string(from: DateInFormatAux)

                self.appDelegate.strDepartureFlightHourAux = dateStr
                
            }else{
                
                let dateFormatterWST: DateFormatter = DateFormatter()
                dateFormatterWST.dateFormat = "yyyy-MM-dd"
                let dateStrWST = dateFormatterWST.string(from: dtExpectedDepartureDate)
                
                let strDepartureDate = dateStrWST + " " + self.appDelegate.strDepartureFlightHourAux
                
                let dtdateFormatterAux:DateFormatter = DateFormatter()
                dtdateFormatterAux.dateFormat = "yyyy-MM-dd HH:mm"
                dtdateFormatterAux.locale = Locale(identifier: "en_GB")
                dtdateFormatterAux.timeZone = TimeZone(secondsFromGMT: 0)
                let DateInFormatAux:Date = dtdateFormatterAux.date(from: strDepartureDate)!
                
                dtDeparturePickerHour.timeZone = TimeZone(secondsFromGMT: 0)
                dtDeparturePickerHour.datePickerMode = .time
                dtDeparturePickerHour.setDate(DateInFormatAux, animated: false)

            }
            
            dtDeparturePickerHour.addTarget(self, action: #selector(tvcDynamicCell.DepartureFlightHourChanged(picker:)), for: UIControl.Event.valueChanged)
            
            self.addSubview(lblDepartureDate)
            self.addSubview(dtDeparturePickerHour)
            
            
        } else if (Code == "ArrivalFlightCodeOtro"){
            
            lblLabel.frame = CGRect(x: 0.01*width!, y: 0.02*height!, width: 0.3*width!, height: 0.03*height!);
            lblLabel.backgroundColor = UIColor.clear
            lblLabel.textAlignment = NSTextAlignment.left
            lblLabel.textColor = colorWithHexString("000000")
            lblLabel.numberOfLines = 0;
            lblLabel.adjustsFontSizeToFitWidth = true
            lblLabel.font = UIFont(name: "Helvetica", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblLabel.text = NSLocalizedString("lblArrivalFlight",comment:"");
            
            txtTextField.frame = CGRect(x: 0.32*width!, y: 0.02*height!, width: 0.4*width!, height: 0.04*height!);
            txtTextField.backgroundColor = UIColor.clear;
            txtTextField.textAlignment = NSTextAlignment.right;
            txtTextField.textColor = colorWithHexString("465261")
            txtTextField.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtTextField.layer.borderColor = UIColor.black.cgColor
            txtTextField.borderStyle = UITextField.BorderStyle.roundedRect
            txtTextField.keyboardType = UIKeyboardType.numberPad
            txtTextField.text = ""
            
            self.addSubview(lblLabel)
            self.addSubview(txtTextField)
            
            
        } else if (Code == "DepartureFlightCodeOtro"){
            
            lblLabel.frame = CGRect(x: 0.01*width!, y: 0.02*height!, width: 0.3*width!, height: 0.03*height!);
            lblLabel.backgroundColor = UIColor.clear
            lblLabel.textAlignment = NSTextAlignment.left
            lblLabel.textColor = colorWithHexString("000000")
            lblLabel.numberOfLines = 0;
            lblLabel.adjustsFontSizeToFitWidth = true
            lblLabel.font = UIFont(name: "Helvetica", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            lblLabel.text = NSLocalizedString("lblDepartureFlight",comment:"");
            
            txtTextField.frame = CGRect(x: 0.32*width!, y: 0.02*height!, width: 0.4*width!, height: 0.04*height!);
            txtTextField.backgroundColor = UIColor.clear;
            txtTextField.textAlignment = NSTextAlignment.right;
            txtTextField.textColor = colorWithHexString("465261")
            txtTextField.font = UIFont(name: "Verdana", size: appDelegate.gblFont6 + appDelegate.gblDeviceFont3)
            txtTextField.layer.borderColor = UIColor.black.cgColor
            txtTextField.borderStyle = UITextField.BorderStyle.roundedRect
            txtTextField.keyboardType = UIKeyboardType.numberPad
            txtTextField.text = ""
            
            self.addSubview(lblLabel)
            self.addSubview(txtTextField)
            
            
        } else if (Code == "dtCheckinConf"){
            
            let dtdateFormatterAux:DateFormatter = DateFormatter()
            dtdateFormatterAux.dateFormat = "MM/dd/yyyy"
            dtdateFormatterAux.locale = Locale(identifier: "en_GB")
            dtdateFormatterAux.timeZone = TimeZone(secondsFromGMT: 0)
            let DateInFormatAux:Date = dtdateFormatterAux.date(from: self.appDelegate.gstrCheckin)!
                
            dtCheckinConf = DateInFormatAux

            lblLabel.frame = CGRect(x: 0.01*width!, y: 0.01*height!, width: 0.2*width!, height: 0.03*height!);
            lblLabel.backgroundColor = UIColor.clear
            lblLabel.textAlignment = NSTextAlignment.left
            lblLabel.textColor = colorWithHexString("000000")
            lblLabel.numberOfLines = 0;
            lblLabel.adjustsFontSizeToFitWidth = true
            lblLabel.font = UIFont(name: "Helvetica", size: appDelegate.gblFont8 + appDelegate.gblDeviceFont3)
            lblLabel.text = NSLocalizedString("lblArrivalDate",comment:"");
            
            dtArrivalPicker.frame = CGRect(x: 0.01*width!, y: 0.04*height!, width: 0.8*width!, height: 0.08*height!);
            //dtArrivalPicker.minimumDate = dtExpectedArrivalDateMin
            dtArrivalPicker.locale = Locale(identifier: "en_US")
            dtArrivalPicker.datePickerMode = .date
            dtArrivalPicker.setDate(dtCheckinConf, animated: false)
            
            dtArrivalPicker.addTarget(self, action: #selector(tvcDynamicCell.dateTimedtCheckinChanged), for: UIControl.Event.valueChanged)
            
            self.addSubview(lblArrivalDate)
            self.addSubview(dtArrivalPicker)
            
            
        }
        
    }
    @objc func dateTimedtCheckinChanged(picker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateStr = dateFormatter.string(from: picker.date)

        self.appDelegate.gstrCheckin = dateStr
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy/MM/dd"
        let dateStr2 = dateFormatter2.string(from: picker.date)

        self.appDelegate.gstrCheckinAux = dateStr2

    }
    
    @objc func dateTimeArrivalChanged(picker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateStr = dateFormatter.string(from: picker.date)

        if self.appDelegate.gItemClassCode == "ONEWAY"{
            self.appDelegate.gstrArrivalTransferAux = dateStr
            self.appDelegate.gstrDepartureTransferAux = dateStr
        }else{
            self.appDelegate.gstrArrivalTransferAux = dateStr
        }
        
    }
    @objc func dateTimeDepartureChanged(picker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateStr = dateFormatter.string(from: picker.date)

        self.appDelegate.gstrDepartureTransferAux = dateStr
        
    }
    @objc func ArrivalFlightHourChanged(picker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let dateStr = dateFormatter.string(from: picker.date)
        
        
        self.appDelegate.strArrivalFlightHourAux = dateStr
        
    }
    @objc func DepartureFlightHourChanged(picker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let dateStr = dateFormatter.string(from: picker.date)

        self.appDelegate.strDepartureFlightHourAux = dateStr
        
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
