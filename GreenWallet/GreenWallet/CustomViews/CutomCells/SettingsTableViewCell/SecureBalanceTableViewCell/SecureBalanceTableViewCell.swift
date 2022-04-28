//
//  SecureBalanceTableViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 28.04.2022.
//

import UIKit

class SecureAndPushTableViewCell: UITableViewCell {
    
    var secure = false
    
    @IBOutlet weak var mainLabel: UILabel?
    @IBOutlet weak var detailLabel: UILabel?
    @IBOutlet weak var cellSwitch: UISwitch?
    @IBOutlet weak var eyeImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func hideWallet(_ sender: UISwitch) {
        let userInfo = ["": "***** USD"]
        if self.secure {
            if sender.isOn {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hideWallet"), object: nil, userInfo: userInfo)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showWallet"), object: nil, userInfo: userInfo)
            }
            
        }
    }
}


