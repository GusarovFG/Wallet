//
//  MainViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 26.04.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private var balance = 0
    private var wallets: [System] = []
//    [System(name: "Green App Development", token: "GAD", image: UIImage(named: "emptyLogo")!), System(name: "Marmot", token: "MRT", image: UIImage(named: "emptyLogo")!), System(name: "Chia MEM", token: "CMM", image: UIImage(named: "emptyLogo")!), System(name: "USD Stable", token: "USDS", image: UIImage(named: "emptyLogo")!)]
    private var footerButtonTitle = "Все кошельки"

    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var riseLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var walletsTableView: UITableView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var footerButtom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaultsManager.shared.userDefaults.bool(forKey: UserDefaultsStringKeys.hideWalletsBalance.rawValue) {
            self.balanceLabel.text = "***** USD"
        } else {
            self.balanceLabel.text = "\(self.balance) USD"
        }
        
        self.walletsTableView.register(UINib(nibName: "BalanceTableViewCell", bundle: nil), forCellReuseIdentifier: "walletCell")
        self.walletsTableView.register(UINib(nibName: "ImportTableViewCell", bundle: nil), forCellReuseIdentifier: "importCell")        
        
        self.headerView.layer.cornerRadius = 15
        self.headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.footerView.layer.cornerRadius = 15
        self.footerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        if self.wallets.isEmpty {
            self.footerButtom.setTitle("Добавить кошелек", for: .normal)
            self.footerButtom.addTarget(self, action: #selector(addWalletButtonPressed), for: .touchUpInside)
        } else {
            self.footerButtom.setTitle(self.footerButtonTitle, for: .normal)
        }
        
        self.navigationController?.navigationBar.isHidden = false
        let navigationItem = UINavigationItem()
        let settingsItem = UIBarButtonItem(image: UIImage(named: "Menu")!, style: .done, target: self, action: #selector(pushSettingsController))
        settingsItem.tintColor = .white
        navigationItem.rightBarButtonItem = settingsItem
        self.navigationController?.navigationBar.setItems([navigationItem], animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(hideWallet), name: NSNotification.Name(rawValue: "hideWallet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showWallet), name: NSNotification.Name(rawValue: "showWallet"), object: nil)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let qwe = self.walletsTableView.visibleCells.map{$0.frame.height}.reduce(0, +)
        
        self.stackViewHeightConstraint.constant = self.headerView.frame.height + qwe + self.footerView.frame.height
    }
    
    private func presentSelectSystemVC() {
        
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "SelectSystemViewController") as! SelectSystemViewController
        let nav = UINavigationController(rootViewController: detailViewController)
        
        nav.modalPresentationStyle = .pageSheet
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc private func pushSettingsController() {
        
        let settingsViewController = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        let nav = UINavigationController(rootViewController: settingsViewController)
        nav.navigationBar.isHidden = true
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc private func hideWallet(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let text = userInfo[""] as? String else { return }
        self.balanceLabel.text = text
        
    }
    
    @objc private func showWallet(notification: Notification) {
        self.balanceLabel.text = "\(self.balance) USD"
        
    }
    
    @IBAction @objc func addWalletButtonPressed(_ sender: Any) {
        presentSelectSystemVC()
       
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.wallets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let importCell = tableView.dequeueReusableCell(withIdentifier: "importCell", for: indexPath) as! ImportTableViewCell
        let walletCell = tableView.dequeueReusableCell(withIdentifier: "walletCell", for: indexPath) as! BalanceTableViewCell
        switch indexPath {
        case [0,self.wallets.count - 1]:
            return importCell
        default:
            let wallet = self.wallets[indexPath.row]
            walletCell.cellImage.image = wallet.image
            walletCell.balanceLabel.text = "0 \(wallet.token)"
            walletCell.convertLabel.text = "⁓ 504.99 USD"
            walletCell.tokenLabel.text = wallet.name
            
            return walletCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0,self.wallets.count - 1]:
            let importTokensVC = storyboard?.instantiateViewController(withIdentifier: "ImportTokensViewController") as! ImportTokensViewController
            importTokensVC.modalPresentationStyle = .fullScreen
            self.navigationController!.present(importTokensVC, animated: true, completion: nil)
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
