//
//  ImportTableViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 27.04.2022.
//

import UIKit

class ImportTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel.text = "+ \(LocalizationManager.share.translate?.result.list.main_screen.main_screen_purse_import ?? "")"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
