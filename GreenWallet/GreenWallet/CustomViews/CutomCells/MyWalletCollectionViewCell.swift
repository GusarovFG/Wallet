//
//  MyWalletCollectionViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 19.05.2022.
//

import UIKit

class MyWalletCollectionViewCell: UICollectionViewCell {
    
    var complitionHandler: (() -> ())?

    @IBOutlet weak var walletImage: UIImageView!
    @IBOutlet weak var publicKeyLabel: UILabel!
    @IBOutlet weak var balanceTitleLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var walletSystemLabel: UILabel!
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.publicKeyLabel.text = LocalizationManager.share.translate?.result.list.wallet.wallet_data_public_key
        self.balanceLabel.text = LocalizationManager.share.translate?.result.list.main_screen.main_screen_title_balance
        self.detailButton.setTitle(LocalizationManager.share.translate?.result.list.wallet.wallet_show_data, for: .normal)
        self.balanceLabel.text = LocalizationManager.share.translate?.result.list.main_screen.main_screen_title_balance
        self.balanceTitleLabel.text = LocalizationManager.share.translate?.result.list.main_screen.main_screen_title_balance
    }

    
    
    @IBAction func detailButtonPressed(_ sender: Any) {
        
        self.complitionHandler?()
    }
    

    
}
