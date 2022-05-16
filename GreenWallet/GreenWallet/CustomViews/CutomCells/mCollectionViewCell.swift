//
//  mCollectionViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 16.05.2022.
//

import UIKit

class mCollectionViewCell: UICollectionViewCell {
    
    var wallet = Wallet(name: "", number: 0, image: UIImage(systemName: "eye")!, tokens: [])
    var controller = UIViewController()
    var height: CGFloat = 0
    
    @IBOutlet weak var footerButton: UIButton!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(UINib(nibName: "BalanceTableViewCell", bundle: nil), forCellReuseIdentifier: "BalanceTableViewCell")
        self.tableView.register(UINib(nibName: "ImportTableViewCell", bundle: nil), forCellReuseIdentifier: "ImportTableViewCell")
        
        self.headerView.layer.cornerRadius = 15
        self.headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.footerView.layer.cornerRadius = 15
        self.footerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        if self.wallet.tokens.isEmpty  {
            self.footerButton.setTitle("Добавить кошелек", for: .normal)
//            self.footerButton.addTarget(self, action: #selector(addWalletButtonPressed), for: .touchUpInside)
        } else {
            self.footerButton.setTitle("Все кошельки", for: .normal)
        }
    }

    override func layoutSubviews(){
        super.layoutSubviews()
        self.heightConstraint.constant = self.frame.height - (self.footerView.frame.height + self.headerView.frame.height + CGFloat((76 * self.wallet.tokens.count )) + 46)
        

    }
    
    
}

extension mCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.wallet.tokens.count {
        case 0:
            return 1
        default:
            return self.wallet.tokens.count + 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let walletCell = tableView.dequeueReusableCell(withIdentifier: "BalanceTableViewCell", for: indexPath) as! BalanceTableViewCell
        let importCell = tableView.dequeueReusableCell(withIdentifier: "ImportTableViewCell", for: indexPath) as! ImportTableViewCell
        
        switch indexPath {
        case [0,self.wallet.tokens.count]:
            self.height += importCell.frame.height
           

            return importCell
        default:
            self.height += walletCell.frame.height
            let wallet = self.wallet.tokens[indexPath.row]
            walletCell.cellImage.image = wallet.image
            walletCell.balanceLabel.text = "\(wallet.balance) \(wallet.token)"
            walletCell.convertLabel.text = "⁓ 504.99 USD"
            walletCell.tokenLabel.text = wallet.name

            return walletCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == [0,self.wallet.tokens.count] {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let importVC = storyboard.instantiateViewController(withIdentifier: "ImportTokensViewController") as! ImportTokensViewController
            importVC.modalPresentationStyle = .fullScreen
            self.controller.present(importVC, animated: true)
        }
    }
    
    
}
