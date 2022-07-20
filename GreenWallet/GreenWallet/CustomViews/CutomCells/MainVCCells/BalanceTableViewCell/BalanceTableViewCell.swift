//
//  BalanceTableViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 26.04.2022.
//

import UIKit
import SDWebImage


class BalanceTableViewCell: UITableViewCell {
    
    var token: [String] = []
    
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
        
        guard let url = URL(string:TailsManager.share.tails?.result.list.filter({$0.hash.contains(wallet?.token?[index][0].dropFirst(4).dropLast(3) ?? "") }).first?.logo_url ?? "") else { return }
        DispatchQueue.global().async {
            
            self.cellImage.sd_setImage(with: url) { image, error, cach, url in
                DispatchQueue.main.async {
                    self.cellImage.image = image
                }
            }
        }

        
            
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
           self.cellImage.image = nil
        // self.userImage.image = nil // above line not working then try this
    }
}
