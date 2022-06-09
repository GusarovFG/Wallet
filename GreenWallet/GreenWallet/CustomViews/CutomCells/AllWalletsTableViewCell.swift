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
    
    func setupCell(wallet: ChiaWallet) {
        self.cellImage.image = UIImage(named: "LogoChia")!
        self.walletLabel.text = wallet.name
        self.tokenLabel.text = wallet.data
        self.keyLabel.text = LocalizationManager.share.translate?.result.list.wallet.wallet_data_public_key
    }
    
}
