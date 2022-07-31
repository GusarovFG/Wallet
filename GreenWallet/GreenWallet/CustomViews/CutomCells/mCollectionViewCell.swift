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
    var index = 0
    var token: [[String]] = []
    
    private var balance = ""
    private var hideBalance = false
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateBalances), name: NSNotification.Name("updateBalances"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(hideWallet), name: NSNotification.Name(rawValue: "hideWallet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showWallet), name: NSNotification.Name(rawValue: "showWallet"), object: nil)
    }
    
    
    override func layoutSubviews(){
        super.layoutSubviews()
        self.token = self.wallet?.token?.filter({$0.contains("show")}).sorted{(Int($0[1]) ?? 0) < (Int($1[1]) ?? 0)} ?? []
        if self.stackView.arrangedSubviews.count == 2 {
            self.heightConstraint.constant = (self.frame.size.height) - (self.footerView.frame.height + self.headerView.frame.height)
            self.collectionVieww.constant = self.heightConstraint.constant
        } else {
            if (self.wallet?.token?.count ?? 0) >= 5 && !CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
                self.heightConstraint.constant = (self.frame.size.height) - (self.footerView.frame.height + self.headerView.frame.height + CGFloat((76 * 5)))
                self.collectionVieww.constant = self.heightConstraint.constant
            } else {
                if self.wallet != nil {
                    self.heightConstraint.constant = (self.frame.size.height) - (self.footerView.frame.height + self.headerView.frame.height + CGFloat(self.token.count * 76 + 46))
                    self.collectionVieww.constant = self.heightConstraint.constant
                    
                } else {
                    self.heightConstraint.constant = (self.frame.size.height) - (self.footerView.frame.height + self.headerView.frame.height)
                    self.collectionVieww.constant = self.heightConstraint.constant
                }
            }
        }
        if self.wallet?.token != nil {
            if self.token.count >= 5 {
                self.tableView.isScrollEnabled = true
            } else {
                self.tableView.isScrollEnabled = false
            }
        }
        
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    @objc private func hideWallet(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let text = userInfo[""] as? String else { return }
        self.balance = text
        self.hideBalance = true
        self.tableView.reloadData()
    }
    
    @objc private func showWallet(notification: Notification) {
        self.hideBalance = false
        self.tableView.reloadData()
    }
    
    @objc func updateBalances() {
        self.tableView.reloadData()
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
        if CoreDataManager.share.fetchChiaWalletPrivateKey().count == 10 {
            AlertManager.share.errorCountOfWallet(self.controller)
        } else {
            
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let selectSystemVC = storyboard.instantiateViewController(withIdentifier: "SelectSystemViewController") as! SelectSystemViewController
            selectSystemVC.isNewWallet = true
            self.controller.present(selectSystemVC, animated: true)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newWallet"), object: nil)
        }
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
            if self.wallet != nil {
                return self.token.count + 1
            } else {
                return 0
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let walletCell = tableView.dequeueReusableCell(withIdentifier: "BalanceTableViewCell", for: indexPath) as! BalanceTableViewCell
        let importCell = tableView.dequeueReusableCell(withIdentifier: "ImportTableViewCell", for: indexPath) as! ImportTableViewCell
        
        switch indexPath {
        case [0,self.token.count]:
//            self.height += importCell.frame.height
            if self.wallet?.name == "Chia Wallet" || self.wallet?.name == "Chia TestNet" {
                importCell.titleLabel.text = "+ \(LocalizationManager.share.translate?.result.list.main_screen.main_screen_purse_import ?? "")"
            } else {
                importCell.titleLabel.text = "+ \(LocalizationManager.share.translate?.result.list.main_screen.main_screen_purse_import ?? "") (скоро)"
            }
            
            print(token.count)
            return importCell
        default:
//            self.height += walletCell.frame.height
            
            
            let token = self.token[indexPath.row]
            if !CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
                if token[0] == "Chia Wallet" || token[0] == "Chia TestNet" {
                    walletCell.cellImage.image = UIImage(named: "LogoChia")!
                    let summ: Double = ((Double(token[2]) ?? 0) / 1000000000000) * ExchangeRatesManager.share.newRatePerDollar
                    walletCell.tokenLabel.text = token[0]
                    
                    if !self.hideBalance {
                        walletCell.convertLabel.text = "⁓ \(NSString(format:"%.2f", summ)) USD"
                        walletCell.balanceLabel.text = "\((Double(token[2]) ?? 0) / 1000000000000.0 ) XCH"
                        
                    } else {
                        walletCell.convertLabel.text = "***** UDS"
                        walletCell.balanceLabel.text = "*****"
                    }
                    
                } else if token[0] == "Chives Wallet" || token[0] == "Chives TestNet"  {
                    
                    walletCell.cellImage.image = UIImage(named: "ChivesLogo")!
                    
                    let summ: Double = ((Double(token[2]) ?? 0) / 100000000) * ExchangeRatesManager.share.newChivesRatePerDollar
                    if ExchangeRatesManager.share.newChivesRatePerDollar == 0 {
                        walletCell.convertLabel.text = "⁓ USD"
                    } else {
                        if !self.hideBalance {
                            walletCell.convertLabel.text = "⁓ \(NSString(format:"%.2f", summ)) USD"
                            walletCell.balanceLabel.text = "\(((Double(token[2]) ?? 0) / 100000000)) XCC"
                            
                        } else {
                            walletCell.convertLabel.text = "***** UDS"
                            walletCell.balanceLabel.text = "*****"
                        }
                    }
                    
                    walletCell.tokenLabel.text = token[0]
                    
                } else {
                    
                    walletCell.cellImage.downloadImage(from: TailsManager.share.tails?.result.list.filter({$0.hash.contains(token[0].dropFirst(4).dropLast(3)) || $0.name == token[0] }).first?.logo_url ?? "" )
                    let summ: Double = ((Double(token[2]) ?? 0) / 1000000000000) * ExchangeRatesManager.share.newRatePerDollar
                    
                    if !self.hideBalance {
                        walletCell.convertLabel.text = "⁓ \(NSString(format:"%.2f", summ)) USD"
                        walletCell.balanceLabel.text = "\((Double(token[2]) ?? 0) / 1000000000000.0 * ExchangeRatesManager.share.newRatePerDollar ) \(TailsManager.share.tails?.result.list.filter({$0.hash.contains(token[0].split(separator: " ").last?.prefix(15) ?? "") || $0.name.contains(token[0])}).first?.code ?? "")"
                        
                    } else {
                        walletCell.convertLabel.text = "***** UDS"
                        walletCell.balanceLabel.text = "*****"
                    }
                    
                    
                    walletCell.tokenLabel.text = TailsManager.share.tails?.result.list.filter({$0.hash.contains(self.token[indexPath.row][0].split(separator: " ").last?.prefix(15) ?? "") || $0.name.contains(token[0])}).first?.name
                    
                    
                    
                }
                
                
            } else {
                walletCell.balanceLabel.text = "0 XCH"
            }
            print(indexPath)
            return walletCell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == [0,self.token.count] {
            if self.wallet?.name == "Chia Wallet" || self.wallet?.name == "Chia TestNet" {
                
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                let importVC = storyboard.instantiateViewController(withIdentifier: "ImportTokensViewController") as! ImportTokensViewController
                importVC.index = CoreDataManager.share.fetchChiaWalletPrivateKey().firstIndex(of: self.wallet!) ?? 0
                print(self.index)
                importVC.modalPresentationStyle = .fullScreen
                self.controller.present(importVC, animated: true)
            } else {
                return
            }
        }
    }
    
    
    
    
}


