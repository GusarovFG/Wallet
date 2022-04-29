//
//  ImportTokensTableViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 27.04.2022.
//

import UIKit

class ImportTokensTableViewCell: UITableViewCell {

    var switchPressed: (() -> ())?
    
    @IBOutlet weak var nameOfSystemLabel: UILabel!
    @IBOutlet weak var tokensLabel: UILabel!
    @IBOutlet weak var systemImage: UIImageView!
    @IBOutlet weak var choiceSwitch: CustomSwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.choiceSwitch.isOn = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func switchIsOn(_ sender: CustomSwitch) {
        if sender.isOn {
            
            self.switchPressed?()
        }
        
    }
    
}
