//
//  mCollectionViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 16.05.2022.
//

import UIKit
import CryptoKit

class mCollectionViewCell: UICollectionViewCell {
    
    var wallet: ChiaWalletPrivateKey?
    var controller = UIViewController()
    var height: CGFloat = 0
    var collectionVieww = NSLayoutConstraint()
    
    @IBOutlet weak var walletTitle: UILabel!
    @IBOutlet weak var footerButton: UIButton!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var headerButton: UIButton!
    @IBOutlet weak var footerButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var numberOFWallet: UILabel!
    
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
        
        
        localization()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name("reload"), object: nil)

    }

    
    override func layoutSubviews(){
        super.layoutSubviews()
        if self.stackView.arrangedSubviews.count == 2 {
            self.heightConstraint.constant = (self.frame.size.height) - (self.footerView.frame.height + self.headerView.frame.height)
            self.collectionVieww.constant = self.heightConstraint.constant
        } else {
            if self.tableView.visibleCells.count >= 5 {
                self.heightConstraint.constant = (self.frame.size.height) - (self.footerView.frame.height + self.headerView.frame.height + CGFloat((76 * 5)) + 46)
                self.collectionVieww.constant = self.heightConstraint.constant
            } else {
                if self.wallet?.wallets != nil {
                    //                self.tableView.reloadData()
                    self.heightConstraint.constant = (self.frame.size.height) - (self.footerView.frame.height + self.headerView.frame.height + CGFloat((self.wallet?.wallets as! [NSNumber]).count * 76 + 46))
                    self.collectionVieww.constant = self.heightConstraint.constant
                    
                } else {
                    self.heightConstraint.constant = (self.frame.size.height) - (self.footerView.frame.height + self.headerView.frame.height)
                    self.collectionVieww.constant = self.heightConstraint.constant
                }
            }
        }
        if self.wallet?.wallets != nil {
            if (self.wallet?.wallets as! [NSNumber]).count > 5 {
                self.tableView.isScrollEnabled = true
            } else {
                self.tableView.isScrollEnabled = false
            }
        }

    }
    
    @objc func reloadTableView() {
        self.tableView.reloadData()
    }
    
   @objc private func localization() {
        self.walletTitle.text = LocalizationManager.share.translate?.result.list.main_screen.main_screen_title_purse
        
        self.footerButton.setTitle(LocalizationManager.share.translate?.result.list.main_screen.main_screen_purse_all_wallets, for: .normal)
        self.footerButton.addTarget(self, action: #selector(allWalletButtonPressed), for: .touchUpInside)
    }
    
    @objc func allWalletButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let allWalletsVC = storyboard.instantiateViewController(withIdentifier: "AllWalletsViewController") as! AllWalletsViewController
        allWalletsVC.modalPresentationStyle = .fullScreen
        self.controller.present(allWalletsVC, animated: true)
        
    }
    
    
    @objc func newwalletButtomPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let selectSystemVC = storyboard.instantiateViewController(withIdentifier: "SelectSystemViewController") as! SelectSystemViewController
        selectSystemVC.isNewWallet = true
        self.controller.present(selectSystemVC, animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newWallet"), object: nil)
    }
    
    @IBAction func footerButtonPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == "Добавить кошелек"  {
            self.newwalletButtomPressed(sender)
        } else {
            self.allWalletButtonPressed()
        }
    }

}

extension mCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.wallet == nil {
            return 0
        } else {
            if self.wallet?.wallets != nil {
                return (self.wallet?.wallets as! [NSNumber]).count + 1
            } else {
                return 0
            }

        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let walletCell = tableView.dequeueReusableCell(withIdentifier: "BalanceTableViewCell", for: indexPath) as! BalanceTableViewCell
        let importCell = tableView.dequeueReusableCell(withIdentifier: "ImportTableViewCell", for: indexPath) as! ImportTableViewCell
        
        switch indexPath {
        case [0,(self.wallet?.wallets as! [NSNumber]).count]:
            self.height += importCell.frame.height
          
            
            return importCell
        default:
            self.height += walletCell.frame.height
           
            if !CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
                
                walletCell.cellImage.image = UIImage(named: "LogoChia")!
                walletCell.balanceLabel.text = "\((self.wallet?.balances as? [NSNumber])?[indexPath.row] as! Double / 1000000000000.0 ) XCH"
                let summ: Double = (((self.wallet?.balances as? [Double])?[indexPath.row] ?? 0) / 1000000000000) * ExchangeRatesManager.share.newRatePerDollar
               
                walletCell.convertLabel.text = "⁓ \(String(summ).prefix(5)) USD"
                walletCell.tokenLabel.text = self.wallet?.name ?? ""
            }
            
            return walletCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == [0,(self.wallet?.wallets as! [NSNumber]).count] {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let importVC = storyboard.instantiateViewController(withIdentifier: "ImportTokensViewController") as! ImportTokensViewController
            importVC.modalPresentationStyle = .fullScreen
            self.controller.present(importVC, animated: true)
        }
    }
    
    
}
