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
    
    private var footerButtonTitle = "Все кошельки"
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var balandeTitle: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var riseLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var cellectionView: CustomMainCollectionView!
    
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.wallets = CoreDataManager.share.fetchChiaWalletPrivateKey()

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
        NotificationCenter.default.addObserver(self, selector: #selector(showGetSystem), name: NSNotification.Name(rawValue: "showGetVC"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showPushSystem), name: NSNotification.Name(rawValue: "showPushVC"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(localization), name: NSNotification.Name("localized"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadcellectionView), name: NSNotification.Name("reload"), object: nil)
        if ((self.wallet?.name?.contains("Chia")) != nil) {
            self.riseLabel.text = "XCС price: \(ExchangeRatesManager.share.newRatePerDollar) $"
            
        }
        self.percentLabel.text = "  \(String(ExchangeRatesManager.share.difference).prefix(5)) % "
        ExchangeRatesManager.share.changeColorOfView(label: self.percentLabel)
        
        localization()
        
        
        
        self.cellectionView.reloadData()
        self.cellectionView.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.wallets = CoreDataManager.share.fetchChiaWalletPrivateKey()
        if !self.wallets.isEmpty {
            self.cellectionView.isScrollEnabled = true
            self.wallet = self.wallets[0]
            let summ: Double = (((self.wallet?.balances as? [Double])?.reduce(0, +) ?? 0) / 1000000000000) * ExchangeRatesManager.share.newRatePerDollar
            self.balanceLabel.text = "⁓ \(NSString(format:"%.2f", summ)) USD"
            self.pageControl.numberOfPages = self.wallets.count
            self.cellectionView.reloadData()
        } else {
            self.cellectionView.isScrollEnabled = false
            return
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        localization()
        self.cellectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @objc private func localization() {
        self.balandeTitle.text = LocalizationManager.share.translate?.result.list.main_screen.main_screen_title_balance
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
        let summ: Double = (((self.wallet?.balances as? [Double])?.reduce(0, +) ?? 0) / 1000000000000) * ExchangeRatesManager.share.newRatePerDollar
        self.balanceLabel.text = "⁓ \(NSString(format:"%.2f", summ)) USD"
        
        
    }
    
    @objc private func showGetSystem(notification: Notification) {
        let selectSystemVC = storyboard?.instantiateViewController(withIdentifier: "SelectSystemViewController") as! SelectSystemViewController
        selectSystemVC.isGetToken = true
        selectSystemVC.modalPresentationStyle = .overFullScreen
        self.present(selectSystemVC, animated: true)
    }
    
    @objc private func showPushSystem(notification: Notification) {
        let selectSystemVC = storyboard?.instantiateViewController(withIdentifier: "SelectSystemViewController") as! SelectSystemViewController
        selectSystemVC.isPushToken = true
        selectSystemVC.modalPresentationStyle = .overFullScreen
        self.present(selectSystemVC, animated: true)
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showPushVC"), object: nil)
    
    }
    @IBAction func qrButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showGetVC"), object: nil)
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
            cell.headerButton.isHidden = true
            cell.footerButtonConstraint.constant = 0
            cell.tableView.reloadData()
            self.collectionViewHeightConstraint.constant = cell.frame.height
            if cell.wallet?.balances != nil {
                self.balanceLabel.text = "\((cell.wallet?.balances as! [NSNumber])[indexPath.row]) USD"
                
            } else {
                self.balanceLabel.text = "0 USD"
            }
        } else {
            print(CoreDataManager.share.fetchChiaWalletPrivateKey())
            if cell.stackView.arrangedSubviews.contains(where: {$0 == cell.tableView}) {
                let wallet = self.wallets[indexPath.row]
                cell.wallet = wallet
                cell.numberOFWallet.text = "\(wallet.name ?? "") ****\(String(wallet.fingerprint).suffix(4))"
                cell.controller = self.tabBarController ?? self
                self.collectionViewHeightConstraint.constant = cell.frame.height
                cell.tableView.reloadData()
                print(self.collectionViewHeightConstraint.constant)
            } else {
                cell.stackView.addArrangedSubview(cell.tableView)
                cell.wallet = CoreDataManager.share.fetchChiaWalletPrivateKey()[indexPath.row]
                cell.controller = self.tabBarController ?? self
                cell.tableView.reloadData()
                self.collectionViewHeightConstraint.constant = cell.frame.height
                
            }
            
        }
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.cellectionView.contentOffset, size: self.cellectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.cellectionView.indexPathForItem(at: visiblePoint) {
            self.pageControl.currentPage = visibleIndexPath.row
            self.wallet = self.wallets[visibleIndexPath.row]
            
            let summ: Double = (((self.wallet?.balances as? [Double])?.reduce(0, +) ?? 0) / 1000000000000) * ExchangeRatesManager.share.newRatePerDollar
            
            self.balanceLabel.text = "⁓ \(NSString(format:"%.2f", summ)) USD"
        }
    }
    
}



