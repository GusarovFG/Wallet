//
//  BalanceTableViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 26.04.2022.
//

import UIKit

class BalanceTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var convertLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellImage.layer.cornerRadius = self.cellImage.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(wallet: ChiaWalletPrivateKey?, index: Int) {
//        guard let url = URL(string:TailsManager.share.tails?.result.list.filter({$0.name == wallet?.names?[index] ?? ""}).first?.logo_url ?? "") else { return }
        
        
//            self.cellImage.load(url: url )
            
        
            
        
    }
}
