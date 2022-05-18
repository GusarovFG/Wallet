//
//  AllWalletsViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 18.05.2022.
//

import UIKit

class AllWalletsViewController: UIViewController {
    
    var wallets: [Wallet] = []

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var walletsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.walletsTableView.register(UINib(nibName: "AddWalletTableViewCell", bundle: nil), forCellReuseIdentifier: "AddWalletTableViewCell")
        self.walletsTableView.register(UINib(nibName: "AllWalletsTableViewCell", bundle: nil), forCellReuseIdentifier: "AllWalletsTableViewCell")

    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension AllWalletsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.wallets.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let addWalletCell = tableView.dequeueReusableCell(withIdentifier: "AddWalletTableViewCell", for: indexPath) as! AddWalletTableViewCell
        let walletCell = tableView.dequeueReusableCell(withIdentifier: "AllWalletsTableViewCell", for: indexPath) as! AllWalletsTableViewCell
        
        switch indexPath {
        case [0,self.wallets.count]:
            return addWalletCell
        default:
            walletCell.setupCell(wallet: self.wallets[indexPath.row])
            return walletCell
        }
    }
    
    
}
