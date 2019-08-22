//
//  settingCell.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 23/09/15.
//  Copyright (c) 2015 Marco Cocom. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var settingsSwitch: UISwitch!
    @IBOutlet weak var lblChannelCode: UILabel!
    
    weak var cellDelegate: SettingCellDelegate?
    
    internal func SetValues(Channel: String?, ChannelCode: String?, Value: String?, ID: Int, width: CGFloat?, height: CGFloat?) {
        
        settingsLabel.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        settingsLabel.textAlignment = NSTextAlignment.left
        settingsLabel.adjustsFontSizeToFitWidth = true
        
        settingsLabel.frame = CGRect(x: 0.05*width!, y: 0, width: 0.2*width!, height: 0.036*height!)
        settingsSwitch.frame = CGRect(x: 0.72*width!, y: 0.01*height!, width: 0.2*width!, height: 0.036*height!)
        settingsLabel.text = ChannelCode
        settingsSwitch.isOn = Bool((Value?.lowercased())!)!
        lblChannelCode.text = ChannelCode
        settingsSwitch.tag = ID

    }
    
    @IBAction func handledSwitchChange(sender: UISwitch) {
        self.cellDelegate?.didChangeSwitchState(sender: self, isOn:settingsSwitch.isOn)
        
    }

}
