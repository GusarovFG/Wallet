//
//  SecureBalanceTableViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 28.04.2022.
//

import UIKit

class SecureAndPushTableViewCell: UITableViewCell {
    
    var secure = false
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var mainLabel: UILabel?
    @IBOutlet weak var detailLabel: UILabel?
    @IBOutlet weak var cellSwitch: CustomSwitch?
    @IBOutlet weak var eyeImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UserDefaultsManager.shared.userDefaults.bool(forKey: UserDefaultsStringKeys.hideWalletsBalance.rawValue) {
            cellSwitch?.isOn = true
        } else {
            self.cellSwitch?.isOn = false
        }
        
    }
    
    @IBAction func hideWallet(_ sender: CustomSwitch) {
        let userInfo = ["": "***** USD"]
        if self.secure {
            if sender.isOn {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hideWallet"), object: nil, userInfo: userInfo)
                UserDefaultsManager.shared.userDefaults.set(true, forKey: UserDefaultsStringKeys.hideWalletsBalance.rawValue)
                print("asdfasf")
            } else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showWallet"), object: nil, userInfo: userInfo)
                UserDefaultsManager.shared.userDefaults.set(false, forKey: UserDefaultsStringKeys.hideWalletsBalance.rawValue)
                
            }
            
        }
    }
}


