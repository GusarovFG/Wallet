//
//  SecureBalanceTableViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 28.04.2022.
//

import UIKit

class SecureAndPushTableViewCell: UITableViewCell {

    private let userInfo = ["": "***** USD"]
    
    @IBOutlet weak var mainLabel: UILabel?
    @IBOutlet weak var detailLabel: UILabel?
    @IBOutlet weak var cellSwitch: UISwitch?
    @IBOutlet weak var eyeImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func hideWallet(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hideWallet"), object: nil, userInfo: userInfo)
    }
    
}
