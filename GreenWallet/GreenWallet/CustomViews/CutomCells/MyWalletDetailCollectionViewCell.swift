//
//  MyWalletDetailCollectionViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 19.05.2022.
//

import UIKit

class MyWalletDetailCollectionViewCell: UICollectionViewCell {
    
    var complitionHandler: (() -> ())?

    @IBOutlet weak var linkTitleLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var publicTitleLabel: UILabel!
    @IBOutlet weak var publicKeyDetailLabel: UILabel!
    @IBOutlet weak var mnemonicTitleLabel: UILabel!
    @IBOutlet weak var mnemonicLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        localization()
    }
    
    private func localization() {
        self.linkTitleLabel.text = LocalizationManager.share.translate?.result.list.wallet.wallet_data_adress
        self.publicTitleLabel.text = LocalizationManager.share.translate?.result.list.wallet.wallet_data_public_key
        self.mnemonicLabel.text = LocalizationManager.share.translate?.result.list.wallet.wallet_data_mnemonics
    }

    @IBAction func copyingLink(_ sender: Any) {
        UIPasteboard.general.string = self.linkLabel.text
        self.complitionHandler?()
    }
    
    @IBAction func copyingPublicKey(_ sender: Any) {
        UIPasteboard.general.string = self.publicKeyDetailLabel.text
        self.complitionHandler?()
    }
    
    @IBAction func copyingMnemonic(_ sender: Any) {
        UIPasteboard.general.string = self.mnemonicLabel.text
        self.complitionHandler?()
    }
}
