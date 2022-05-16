//
//  MainViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 26.04.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private var balance = 0
    private var wallets: [Wallet] = []

    private var footerButtonTitle = "Все кошельки"

    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var riseLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var cellectionView: UICollectionView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        self.wallets = WalletManager.share.vallets
        self.pageControl.numberOfPages = WalletManager.share.vallets.count
        self.cellectionView.register(UINib(nibName: "mCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mCollectionViewCell")
        
        
        if UserDefaultsManager.shared.userDefaults.bool(forKey: UserDefaultsStringKeys.hideWalletsBalance.rawValue) {
            self.balanceLabel.text = "***** USD"
        } else {
            self.balanceLabel.text = "\(self.balance) USD"
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
        cell.wallet = self.wallets[indexPath.row]
        cell.controller = self
        cell.frame.size.height = cell.stackView.frame.height
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: self.cellectionView.frame.width, height: self.cellectionView.frame.height)
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.cellectionView.contentOffset, size: self.cellectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.cellectionView.indexPathForItem(at: visiblePoint) {
            self.pageControl.currentPage = visibleIndexPath.row
        }
    }

}


