//
//  ContactTableViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 01.06.2022.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    var contact: Contact?
    
    @IBOutlet weak var nameOfContactLabel: UILabel!
    @IBOutlet weak var adresOfContactLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func cellSetup() {
        self.nameOfContactLabel.text = self.contact?.name
        self.adresOfContactLabel.text = self.contact?.adres
    }
}
