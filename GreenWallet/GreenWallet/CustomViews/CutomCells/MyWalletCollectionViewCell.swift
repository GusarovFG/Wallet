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
        // Initialization code
    }

    
    
    @IBAction func detailButtonPressed(_ sender: Any) {
        
        self.complitionHandler?()
    }
    

    
}
