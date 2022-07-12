//
//  ImportTokensTableViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 27.04.2022.
//

import UIKit

class ImportTokensTableViewCell: UITableViewCell {

    var switchPressed: (() -> ())?
    var switchoff: (() -> ())?
    var token: TailsList?
    
    @IBOutlet weak var nameOfSystemLabel: UILabel!
    @IBOutlet weak var tokensLabel: UILabel!
    @IBOutlet weak var systemImage: UIImageView!
    @IBOutlet weak var choiceSwitch: CustomSwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.choiceSwitch.isOn = false
        
    }
    
    func setupCell(tail: TailsList) {
        self.nameOfSystemLabel.text = tail.name
        self.tokensLabel.text = tail.code
        self.systemImage.load(url: URL(string: tail.logo_url)!)
        self.systemImage.layer.cornerRadius = self.systemImage.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func switchIsOn(_ sender: CustomSwitch) {
        if sender.isOn {
            
            self.switchPressed?()
        } else {
            self.switchoff?()
        }
        
    }
    
}
