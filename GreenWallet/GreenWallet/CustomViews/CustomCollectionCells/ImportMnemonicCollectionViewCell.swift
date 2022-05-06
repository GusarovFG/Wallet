//
//  ImportMnemonicCollectionViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 05.05.2022.
//

import UIKit

class ImportMnemonicCollectionViewCell: UICollectionViewCell {

    var appendInPhrase: (() -> ())?
    var endEditing: (() -> ())?
    var tap: (() -> ())?
    
    @IBOutlet weak var cellTextLabel: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        super.awakeFromNib()
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
    }

    @IBAction func didEditingChangedTextField(_ sender: UITextField) {
        self.appendInPhrase?()
    }
    
    @IBAction func endEditingForTextView(_ sender: Any) {
        self.endEditing?()
    }
    
    @IBAction func tap(_ sender: Any) {
        self.tap?()
    }
    
}
