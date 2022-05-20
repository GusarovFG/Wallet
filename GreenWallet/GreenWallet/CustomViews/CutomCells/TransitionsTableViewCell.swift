//
//  TransitionsTableViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 20.05.2022.
//

import UIKit

class TransitionsTableViewCell: UITableViewCell {

    @IBOutlet weak var typeOfTransitionLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var summLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
