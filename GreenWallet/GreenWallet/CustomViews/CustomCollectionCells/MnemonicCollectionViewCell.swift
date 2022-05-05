//
//  MnemonicCollectionViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 03.05.2022.
//

import UIKit

class MnemonicCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mnemonicWord: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
        
    }

}
