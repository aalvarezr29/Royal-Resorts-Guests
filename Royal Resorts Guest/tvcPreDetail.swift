//
//  tvcPreDetail.swift
//  Royal Resorts Guest
//
//  Created by Administrator on 25/11/15.
//  Copyright © 2015 Marco Cocom. All rights reserved.
//

import UIKit

open class tvcPreDetail: UITableViewCell {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var lblccNumber: UILabel!
    @IBOutlet weak var lblccType: UILabel!
    @IBOutlet weak var lblTrxDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    open func SetValues(ccNumber: String?, ccType: String?, TrxDate: String?, Amount: String?, width: CGFloat?, height: CGFloat?) {
        
        lblccNumber.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblccType.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblTrxDate.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblAmount.font = UIFont(name: "Helvetica", size: appDelegate.gblFont2 + appDelegate.gblDeviceFont3)
        lblccNumber.adjustsFontSizeToFitWidth = true
        lblccType.adjustsFontSizeToFitWidth = true
        lblTrxDate.adjustsFontSizeToFitWidth = true
        lblAmount.adjustsFontSizeToFitWidth = true
        lblccNumber.text = ccNumber
        lblccType.text = ccType
        lblTrxDate.text = TrxDate
        lblAmount.text = Amount
        lblccNumber.frame = CGRect(x: 0.05*width!, y: 0, width: 0.2*width!, height: 0.036*height!);
        lblccType.frame = CGRect(x: 0.2*width!, y: 0, width: 0.2*width!, height: 0.036*height!);
        lblTrxDate.frame = CGRect(x: 0.4*width!, y: 0, width: 0.2*width!, height: 0.036*height!);
        lblAmount.frame = CGRect(x: 0.6*width!, y: 0, width: 0.2*width!, height: 0.036*height!);
    }
    
}
