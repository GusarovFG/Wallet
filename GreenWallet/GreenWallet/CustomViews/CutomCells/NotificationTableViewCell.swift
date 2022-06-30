//
//  NotificationTableViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 30.06.2022.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var ratesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
