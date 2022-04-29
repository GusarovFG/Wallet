//
//  SelectSystemTableViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 27.04.2022.
//

import UIKit

class SelectSystemTableViewCell: UITableViewCell {

    @IBOutlet weak var nameOfSystemLabel: UILabel!
    @IBOutlet weak var tokensLabel: UILabel!
    @IBOutlet weak var systemImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
