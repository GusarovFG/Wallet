//
//  AllWalletsViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 18.05.2022.
//

import UIKit

class AllWalletsViewController: UIViewController {
    
    var wallets: [ChiaWalletPrivateKey] = []
    var newWallets = ChiaWalletsManager.share.wallets.wallets
    var index = 0
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var walletsTableView: UITableView!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        self.favoriteLabel.alpha = 0
        
        
        self.walletsTableView.register(UINib(nibName: "AddWalletTableViewCell", bundle: nil), forCellReuseIdentifier: "AddWalletTableViewCell")
        self.walletsTableView.register(UINib(nibName: "AllWalletsTableViewCell", bundle: nil), forCellReuseIdentifier: "AllWalletsTableViewCell")

        NotificationCenter.default.addObserver(self, selector: #selector(openAlert), name: NSNotification.Name("closeAlert"), object: nil)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.wallets = CoreDataManager.share.fetchChiaWalletPrivateKey()
        self.walletsTableView.reloadData()

    }
    
    @objc func openAlert(notification: Notification)  {
        let storyBoard = UIStoryboard(name: "Alert", bundle: .main)
        let alertVC = storyBoard.instantiateViewController(withIdentifier: "DeletingAlert") as! AllertWalletViewController
        alertVC.isInMyWallet = true
        self.present(alertVC, animated: true)
//        WalletManager.share.vallets.removeAll(where: {$0 == self.wallets[index]})
        self.walletsTableView.reloadData()
    }
    
    private func localization() {
        self.mainLabel.text = LocalizationManager.share.translate?.result.list.my_wallets.my_wallets_title
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
    }

    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension AllWalletsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.wallets.isEmpty {
            return 0
        } else {
            
            return self.wallets.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let addWalletCell = tableView.dequeueReusableCell(withIdentifier: "AddWalletTableViewCell", for: indexPath) as! AddWalletTableViewCell
        let walletCell = tableView.dequeueReusableCell(withIdentifier: "AllWalletsTableViewCell", for: indexPath) as! AllWalletsTableViewCell
        
        switch indexPath {
        case [0,self.wallets.count]:
            addWalletCell.addPressed = {
                let systemViewController = self.storyboard?.instantiateViewController(withIdentifier: "SelectSystemViewController") as! SelectSystemViewController
                systemViewController.isNewWallet = true
                self.present(systemViewController, animated: true, completion: nil)
            }
            return addWalletCell
        default:
            walletCell.setupCell(wallet: self.wallets[indexPath.row])
            return walletCell
        }
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let wallet = self.wallets[indexPath.row]
        let favorite = UIContextualAction(style: .normal,
                                         title: "") {  (action, view, completionHandler) in
            if WalletManager.share.favoritesWallets.filter({$0 == wallet}).count == 0 {
                WalletManager.share.favoritesWallets.append(wallet)
                self.favoriteLabel.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.6745098039, blue: 0.3490196078, alpha: 1)
                self.favoriteLabel.text = LocalizationManager.share.translate?.result.list.my_wallets.my_wallets_label_added
                UIView.animate(withDuration: 1, delay: 0) {
                    self.favoriteLabel.alpha = 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    UIView.animate(withDuration: 1, delay: 0) {
                        self.favoriteLabel.alpha = 0
                    }
                }
            } else {
                WalletManager.share.favoritesWallets.removeAll(where: {$0 == wallet})
                self.favoriteLabel.backgroundColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 1)
                self.favoriteLabel.text = LocalizationManager.share.translate?.result.list.my_wallets.my_wallets_label_removed
                UIView.animate(withDuration: 1, delay: 0) {
                    self.favoriteLabel.alpha = 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    UIView.animate(withDuration: 1, delay: 0) {
                        self.favoriteLabel.alpha = 0
                    }
                }
            }
            completionHandler(true)
        }

        favorite.backgroundColor = #colorLiteral(red: 0.1189827248, green: 0.6536024213, blue: 1, alpha: 1)
        if WalletManager.share.favoritesWallets.filter({$0 == wallet}).count == 0 {
            favorite.image = UIImage(named: "favorite")!
        } else {
            favorite.image = UIImage(named: "favoriteIs")!
        }
        
        let trash = UIContextualAction(style: .normal,
                                       title: "") { (action, view, completionHandler) in
            let storyBoard = UIStoryboard(name: "Alert", bundle: .main)
            let alertVC = storyBoard.instantiateViewController(withIdentifier: "DeleteWallet") as! AllertWalletViewController
            alertVC.controller = self
            self.index = indexPath.row
            self.present(alertVC, animated: true)
            completionHandler(true)
        }
        
        trash.backgroundColor = .systemRed
        trash.image = UIImage(named: "Trash")!
        
        let configuration = UISwipeActionsConfiguration(actions: [favorite, trash])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myWalletsVC = storyboard?.instantiateViewController(withIdentifier: "MyWalletsViewController") as! MyWalletsViewController
        myWalletsVC.index = indexPath.row
        self.present(myWalletsVC, animated: true)
    }
}
