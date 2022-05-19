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
        // Initialization code
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
