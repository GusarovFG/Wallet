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
    private let systems: [System] = [System(name: "Chia", token: "XCH", image: UIImage(named: "LogoChia")!, balance: 0), System(name: "Chives", token: "XCC", image: UIImage(named: "ChivesLogo")!, balance: 0)]
    private let typseOfNewWallet = ["Новый", "Импорт мнемоники"]
    private var isSelectedSystem = false
    private var gerToken = false
    private var pushToken = false

    private var footerButtonTitle = "Все кошельки"

    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var riseLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var cellectionView: UICollectionView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var systemBackgroundView: UIView!
    @IBOutlet weak var systemViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectSystemView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.tabBarController?.selectedIndex == 1 {
            self.systemBackgroundView.isHidden = false
        }
        
        self.systemBackgroundView.isHidden = true
        self.systemViewConstraint.constant = self.view.frame.height
        self.tableView.register(UINib(nibName: "SelectSystemTableViewCell", bundle: nil), forCellReuseIdentifier: "systemCell")
        self.navigationController?.navigationBar.isHidden = true
        self.tableView.backgroundColor = #colorLiteral(red: 0.246493727, green: 0.246493727, blue: 0.246493727, alpha: 1)
        self.selectSystemView.layer.cornerRadius = 15
        
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSelectedSystem {
            return self.typseOfNewWallet.count
        } else {
            return self.systems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedSystemCell = tableView.dequeueReusableCell(withIdentifier: "systemCell", for: indexPath) as! SelectSystemTableViewCell
        
        selectedSystemCell.nameOfSystemLabel.text = self.systems[indexPath.row].name
        selectedSystemCell.tokensLabel.text = self.systems[indexPath.row].token
        selectedSystemCell.systemImage.image = self.systems[indexPath.row].image
        
        let selectTypeOfWalletCell = tableView.dequeueReusableCell(withIdentifier: "typeOfWalletCell", for: indexPath)
        
        selectTypeOfWalletCell.accessoryType = .disclosureIndicator
        var content = selectTypeOfWalletCell.defaultContentConfiguration()
        content.text = self.typseOfNewWallet[indexPath.row]
        selectTypeOfWalletCell.contentConfiguration = content
        selectedSystemCell.backgroundColor = #colorLiteral(red: 0.246493727, green: 0.246493727, blue: 0.246493727, alpha: 1)

        switch self.isSelectedSystem {
        case false:
            return selectedSystemCell
        case true:
            return selectTypeOfWalletCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isSelectedSystem {
            switch indexPath {
            case [0,0]:
                guard let newWalletVC = storyboard?.instantiateViewController(withIdentifier: "NewWalletViewController") else { return }
                self.present(newWalletVC, animated: true, completion: nil)
            case [0,1]:
                guard let newWalletVC = storyboard?.instantiateViewController(withIdentifier: "qwes") else { return }
                self.present(newWalletVC, animated: true, completion: nil)
            default:
                break
            }
        } else {
            self.isSelectedSystem = true
            tableView.reloadData()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


