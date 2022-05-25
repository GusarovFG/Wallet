//
//  AllWalletsTableViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 18.05.2022.
//

import UIKit

class AllWalletsTableViewCell: UITableViewCell {
    
 
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(wallet: WalletModel) {
        self.cellImage.image = wallet.image
        self.walletLabel.text = wallet.name
        self.tokenLabel.text = wallet.toket
        self.keyLabel.text = "Приватный ключ с публичным отпечатком 8745635630"
    }
    
}
