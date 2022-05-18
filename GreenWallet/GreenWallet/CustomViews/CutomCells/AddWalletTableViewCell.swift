//
//  AddWalletTableViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 18.05.2022.
//

import UIKit

class AddWalletTableViewCell: UITableViewCell {

    var addPressed: (() -> ())?
    
    @IBOutlet weak var addButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func addButtonPressed(_ sender: UIButton) {
        self.addPressed?()
    }
    
}
