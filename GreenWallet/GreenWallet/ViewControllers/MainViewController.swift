//
//  MainViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 26.04.2022.
//

import UIKit
import AVFAudio

class MainViewController: UIViewController {
    
    private var balance = 0
    private var wallets: [ChiaWalletPrivateKey] = []
    private var wallet: ChiaWalletPrivateKey?
    private var index = 0
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var balandeTitle: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var riseLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var cellectionView: CustomMainCollectionView!
    @IBOutlet weak var balanceView: UIView!
    
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.wallets = WalletManager.share.favoritesWallets
        WalletManager.share.vallets = CoreDataManager.share.fetchChiaWalletPrivateKey()
        
        self.pageControl.numberOfPages = WalletManager.share.favoritesWallets.count
        self.cellectionView.register(UINib(nibName: "mCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mCollectionViewCell")
    
        
        if UserDefaultsManager.shared.userDefaults.bool(forKey: UserDefaultsStringKeys.hideWalletsBalance.rawValue) {
            self.balanceLabel.text = "***** USD"
        } else {
            self.balanceLabel.text = "\(NSString(format:"%.2f", self.balance)) USD"
        }
        
        self.navigationController?.navigationBar.isHidden = false
        let navigationItem = UINavigationItem()
        let settingsItem = UIBarButtonItem(image: UIImage(named: "Menu")!, style: .done, target: self, action: #selector(pushSettingsController))
        settingsItem.tintColor = .white
        navigationItem.rightBarButtonItem = settingsItem
        self.navigationController?.navigationBar.setItems([navigationItem], animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(hideWallet), name: NSNotification.Name(rawValue: "hideWallet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showWallet), name: NSNotification.Name(rawValue: "showWallet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(localization), name: NSNotification.Name("localized"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadcellectionView), name: NSNotification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBalances), name: NSNotification.Name("updateBalances"), object: nil)
        
        
        
        localization()
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !self.wallets.isEmpty {
            WalletManager.share.isUpdate = true
            self.cellectionView.isScrollEnabled = true
            self.wallet = self.wallets[0]
            let summ: Double = (((self.wallet?.token?.map({Double($0[2]) ?? 0}).reduce(0, +) ?? 0) / 1000000000000) * ExchangeRatesManager.share.newRatePerDollar).rounded(toPlaces: 8)
            self.balanceLabel.text = "⁓\(NSString(format:"%.2f", summ)) USD"
            self.pageControl.numberOfPages = self.wallets.count
            self.cellectionView.reloadData()
        } else {
            self.cellectionView.isScrollEnabled = false
            self.riseLabel.text = "XCH price: \(ExchangeRatesManager.share.newRatePerDollar) $"
            self.percentLabel.text = "  \(String(ExchangeRatesManager.share.difference).prefix(5)) % "
            ExchangeRatesManager.share.changeColorOfView(label: self.percentLabel)
            return
        }
        
        if self.wallet?.name == "Chia Wallet" {
            self.riseLabel.text = "XCH price: \(ExchangeRatesManager.share.newRatePerDollar) $"
            self.percentLabel.text = "  \(String(ExchangeRatesManager.share.difference).prefix(5)) % "
            ExchangeRatesManager.share.changeColorOfView(label: self.percentLabel)
        } else {
            if ExchangeRatesManager.share.newChivesRatePerDollar == 0 {
                self.percentLabel.text = "  \(String(ExchangeRatesManager.share.differenceChives).prefix(5)) % "
                self.riseLabel.text = "XCC price: ~"
            } else {
                self.percentLabel.text = "  \(String(ExchangeRatesManager.share.differenceChives).prefix(5)) % "
                self.riseLabel.text = "XCC price: \(ExchangeRatesManager.share.newChivesRatePerDollar) $"
                ExchangeRatesManager.share.changeColorOfView(label: self.percentLabel)
            }
        }
        
        if self.wallet?.name == "Chia Wallet" || self.wallet?.name == "Chia Wallet" {
            
            self.percentLabel.text = "  \(String(ExchangeRatesManager.share.difference).prefix(5)) % "
            self.riseLabel.text = "XCH price: \(ExchangeRatesManager.share.newRatePerDollar) $"
        } else {
            self.percentLabel.text = "  \(String(ExchangeRatesManager.share.differenceChives).prefix(5)) % "
            self.riseLabel.text = "XCC price: \(ExchangeRatesManager.share.newChivesRatePerDollar) $"
        }
        ExchangeRatesManager.share.changeColorOfView(label: self.percentLabel)
        
        if !CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
            
            self.cellectionView.scrollToItem(at: [0,0], at: .left, animated: true)
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        localization()
        LocalNotificationsManager.share.checkUpdates()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @objc func updateBalances() {
        self.wallets = WalletManager.share.favoritesWallets
        WalletManager.share.vallets = CoreDataManager.share.fetchChiaWalletPrivateKey()
        if self.wallet?.name == "Chia Wallet" {
            let summ: Double = (((self.wallet?.token?.map({Double($0[2]) ?? 0}).reduce(0, +) ?? 0) / 1000000000000) * ExchangeRatesManager.share.newRatePerDollar).rounded(toPlaces: 8)
            self.balanceLabel.text = "⁓\(NSString(format:"%.2f", summ)) USD"
        } else {
            let summ: Double = (((self.wallet?.token?.map({Double($0[2]) ?? 0}).reduce(0, +) ?? 0) / 100000000) * ExchangeRatesManager.share.newChivesRatePerDollar).rounded(toPlaces: 8)
            self.balanceLabel.text = "⁓\(NSString(format:"%.2f", summ)) USD"
        }
        
        
        self.cellectionView.reloadData()
    }
    
    @objc private func localization() {
        self.balandeTitle.text = LocalizationManager.share.translate?.result.list.main_screen.main_screen_title_balance
        self.cellectionView.reloadData()
    }
    
    @objc func reloadcellectionView() {
        self.wallets = CoreDataManager.share.fetchChiaWalletPrivateKey()
        self.cellectionView.reloadData()
    }
    
    @objc private func presentSelectSystemVC() {
        
        let selectSystemVC = storyboard?.instantiateViewController(withIdentifier: "SelectSystemViewController") as! SelectSystemViewController
        selectSystemVC.isNewWallet = true
        selectSystemVC.modalPresentationStyle = .overFullScreen
        self.present(selectSystemVC, animated: true)
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
        let summ: Double = (((self.wallet?.token?.map({Double($0[2])!}).reduce(0, +) ?? 0) / 1000000000000) * ExchangeRatesManager.share.newRatePerDollar).rounded(toPlaces: 8)
        if !CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
            self.balanceLabel.text = "⁓ \(NSString(format:"%.2f", summ)) USD"
        } else {
            self.balanceLabel.text = "0 USD"
        }
        
        
    }

    @IBAction func sendButtonPressed(_ sender: Any) {
        if !CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
            let pushVC = storyboard?.instantiateViewController(withIdentifier: "PushTokensViewController") as! PushTokensViewController
            pushVC.wallet = self.wallet
            pushVC.isInMyWallet = true
            pushVC.isChia = self.wallet?.name == "Chia Wallet"
            pushVC.isChiaTest = self.wallet?.name == "Chia TestNet"
            pushVC.isChives = self.wallet?.name == "Chives Wallet"
            pushVC.isChivesTest = self.wallet?.name == "Chives TestNet"
            pushVC.modalPresentationStyle = .overFullScreen
            self.tabBarController?.present(pushVC, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let selectSystemVC = storyboard.instantiateViewController(withIdentifier: "SelectSystemViewController") as! SelectSystemViewController
            selectSystemVC.isNewWallet = true
            self.tabBarController?.present(selectSystemVC, animated: true)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newWallet"), object: nil)
        }
        
    }
    @IBAction func qrButtonPressed(_ sender: Any) {
        if !CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
            let getTokenViewController = storyboard?.instantiateViewController(withIdentifier: "GetTokenViewController") as! GetTokenViewController
            getTokenViewController.isChia = self.wallet!.name!.contains("Chia Wallet")
            getTokenViewController.isChiaTest = self.wallet!.name!.contains("Chia TestNet")
            getTokenViewController.isChives = self.wallet!.name!.contains("Chives Wallet")
            getTokenViewController.isChivesTest = self.wallet!.name!.contains("Chives TestNet")
            getTokenViewController.isMyWallet = true
            getTokenViewController.wallet = self.wallet
            getTokenViewController.modalPresentationStyle = .fullScreen
            self.tabBarController?.present(getTokenViewController, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let selectSystemVC = storyboard.instantiateViewController(withIdentifier: "SelectSystemViewController") as! SelectSystemViewController
            selectSystemVC.isNewWallet = true
            self.tabBarController?.present(selectSystemVC, animated: true)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newWallet"), object: nil)
        }
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.wallets.count {
        case 0:
            return 1
        default:
            return self.wallets.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mCollectionViewCell", for: indexPath) as! mCollectionViewCell
        if CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
            
            cell.footerButton.setTitle("+ \(LocalizationManager.share.translate?.result.list.main_screen.main_screen_purse_add_wallet ?? "")" , for: .normal)
            cell.footerButton.addTarget(self, action: #selector(presentSelectSystemVC), for: .touchUpInside)
            cell.tableView.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
            cell.numberOFWallet.text = ""
            cell.headerButton.isHidden = true
            cell.footerButtonConstraint.constant = 0
            cell.tableView.reloadData()
            self.collectionViewHeightConstraint = cell.collectionVieww
            if cell.wallet?.token != nil {
                self.balanceLabel.text = "\(cell.wallet?.token?.map({Double($0[2])!}).reduce(0, +) ?? 0) USD"
                
            } else {
                self.balanceLabel.text = "0 USD"
            }
        } else {
            if cell.stackView.arrangedSubviews.contains(where: {$0 == cell.tableView}) {
                let wallet = self.wallets[indexPath.row]
                cell.wallet = wallet
                cell.index = self.index
                cell.numberOFWallet.text = "\(wallet.name ?? "") ****\(String(wallet.fingerprint).suffix(4))"
                cell.controller = self.tabBarController ?? self
                self.collectionViewHeightConstraint = cell.collectionVieww
            } else {
                cell.stackView.addArrangedSubview(cell.tableView)
                cell.wallet = CoreDataManager.share.fetchChiaWalletPrivateKey()[indexPath.row]
                cell.controller = self.tabBarController ?? self
                cell.tableView.reloadData()
                self.collectionViewHeightConstraint = cell.collectionVieww
                
            }
            
        }
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
            let visibleRect = CGRect(origin: self.cellectionView.contentOffset, size: self.cellectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = self.cellectionView.indexPathForItem(at: visiblePoint) {
                self.pageControl.currentPage = visibleIndexPath.row
                self.wallet = self.wallets[visibleIndexPath.row]
                self.index = visibleIndexPath.row
                print(self.index)
                if self.wallet?.name == "Chia Wallet" || self.wallet?.name == "Chia TestNet" {
                    let summ: Double = (((self.wallet?.token?.map({Double($0[2]) ?? 0}).reduce(0, +) ?? 0) / 1000000000000) * ExchangeRatesManager.share.newRatePerDollar).rounded(toPlaces: 8)
                    self.riseLabel.text = "XCH price: \(ExchangeRatesManager.share.newRatePerDollar) $"
                    self.balanceLabel.text = "⁓\(NSString(format:"%.2f", summ)) USD"
                    self.percentLabel.text = "  \(String(ExchangeRatesManager.share.difference).prefix(5)) % "
                    ExchangeRatesManager.share.changeColorOfView(label: self.percentLabel)
                } else if self.wallet?.name == "Chives Wallet" || self.wallet?.name == "Chives TestNet" {
                    let summ: Double = (((self.wallet?.token?.map({Double($0[2]) ?? 0}).reduce(0, +) ?? 0) / 100000000) * ExchangeRatesManager.share.newChivesRatePerDollar).rounded(toPlaces: 8)
                    self.balanceLabel.text = "⁓\(NSString(format:"%.2f", summ)) USD"
                    self.riseLabel.text = "XCC price: \(ExchangeRatesManager.share.newChivesRatePerDollar) $"
                    self.percentLabel.text = "  \(String(ExchangeRatesManager.share.differenceChives).prefix(5)) % "
                    ExchangeRatesManager.share.changeColorOfView(label: self.percentLabel)
                }
                
               
                
            }
        }
    }
    
}



