//
//  SupportTableViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 28.04.2022.
//

import UIKit

class SupportTableViewCell: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel?
    @IBOutlet weak var detailLabel: UILabel?

    @IBOutlet weak var cellImage: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
        self.accessoryView = UIImageView(image: UIImage(systemName: "chevron.right")!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
