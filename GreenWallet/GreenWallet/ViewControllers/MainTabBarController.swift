//
//  MainTabBarController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 03.05.2022.
//
import MaterialDesignWidgets
import UIKit

class MainTabBarController: UITabBarController, UINavigationBarDelegate {
    
    let pushButton = MaterialVerticalButton(icon: UIImage(named: "push")!, text: LocalizationManager.share.translate?.result.list.main_screen.main_screen_send_btn ?? "", font: .systemFont(ofSize: 10), useOriginalImg: true, cornerRadius: 0, buttonStyle: .fill)
    let getButton = MaterialVerticalButton(icon: UIImage(named: "get")!, text: LocalizationManager.share.translate?.result.list.main_screen.main_screen_recive_btn ?? "", font: .systemFont(ofSize: 10), useOriginalImg: true, cornerRadius: 0, buttonStyle: .fill)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTabs()
        self.tabBar.tintColor = #colorLiteral(red: 0.2274509804, green: 0.6745098039, blue: 0.3490196078, alpha: 1)
        self.tabBar.addSubview(pushButton)
        self.pushButton.addTarget(self, action: #selector(showPostVC), for: .touchUpInside)
        self.pushButton.backgroundColor = self.tabBar.backgroundColor
        
        
        self.pushButton.rippleEnabled = false
       
        
        self.tabBar.addSubview(getButton)
        self.getButton.addTarget(self, action: #selector(showGettVC), for: .touchUpInside)
        self.getButton.backgroundColor = self.tabBar.backgroundColor
      
        
        
        
        self.getButton.rippleEnabled = false
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeIndex), name: NSNotification.Name("localized"), object: nil)
    }
    
    @objc func showPostVC() {
        if !CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
            let selectSystemVC = storyboard?.instantiateViewController(withIdentifier: "SelectSystemViewController") as! SelectSystemViewController
            selectSystemVC.isPushToken = true
            selectSystemVC.isMainScreen = true
            selectSystemVC.modalPresentationStyle = .overFullScreen
            self.present(selectSystemVC, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let selectSystemVC = storyboard.instantiateViewController(withIdentifier: "SelectSystemViewController") as! SelectSystemViewController
            selectSystemVC.isNewWallet = true
            self.present(selectSystemVC, animated: true)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newWallet"), object: nil)
        }
            
    }
    
    @objc func showGettVC() {
        if !CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
            let selectSystemVC = storyboard?.instantiateViewController(withIdentifier: "SelectSystemViewController") as! SelectSystemViewController
            selectSystemVC.isGetToken = true
            selectSystemVC.modalPresentationStyle = .overFullScreen
            self.present(selectSystemVC, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let selectSystemVC = storyboard.instantiateViewController(withIdentifier: "SelectSystemViewController") as! SelectSystemViewController
            selectSystemVC.isNewWallet = true
            self.present(selectSystemVC, animated: true)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newWallet"), object: nil)
        }
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.pushButton.frame.size = CGSize(width: (self.tabBar.frame.width / 6) + 5, height: 51)
        self.pushButton.frame.origin = CGPoint(x: self.tabBar.frame.midX - (self.pushButton.frame.width / 2), y: 1)
        self.pushButton.label.frame.origin.y = self.pushButton.imageView.frame.maxY
  
        self.getButton.frame.size = CGSize(width: (self.tabBar.frame.width / 6) + 5, height: 51)
        self.getButton.frame.origin = CGPoint(x: (self.tabBar.frame.maxX / 5) + 5, y: 1)
        self.getButton.label.frame.origin.y = self.getButton.imageView.frame.maxY
        
        self.pushButton.imageView.contentMode = .center
        self.getButton.imageView.contentMode = .center
        
        if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
            self.pushButton.label.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1)
            self.getButton.label.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1)
            
            self.pushButton.imageView.alpha = 0.5
            self.getButton.imageView.alpha = 0.5
        } else {
            self.pushButton.label.textColor = #colorLiteral(red: 0.7058823529, green: 0.7058823529, blue: 0.7058823529, alpha: 1)
            self.getButton.label.textColor = #colorLiteral(red: 0.7058823529, green: 0.7058823529, blue: 0.7058823529, alpha: 1)

            self.pushButton.imageView.alpha = 1
            self.getButton.imageView.alpha = 1
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addTabs()
    }
    
    @objc private func changeIndex() {
        self.addTabs()

        self.pushButton.label.text = LocalizationManager.share.translate?.result.list.main_screen.main_screen_send_btn ?? ""
        self.getButton.label.text = LocalizationManager.share.translate?.result.list.main_screen.main_screen_recive_btn ?? ""
    }
    
    private func addTabs() {
        
        
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "navi") as! UINavigationController
        mainVC.tabBarItem = UITabBarItem(title: LocalizationManager.share.translate?.result.list.main_screen.main_screen_title_purse, image: UIImage(named: "wallet")!, selectedImage: nil)
        
        let secondMainVC = UIViewController()
        secondMainVC.tabBarItem = UITabBarItem(title: "", image: nil, selectedImage: nil)
        secondMainVC.tabBarItem.isEnabled = false
        
        let thirdMainVC = UIViewController()
        thirdMainVC.tabBarItem = UITabBarItem(title: "", image: nil, selectedImage: nil)
        thirdMainVC.tabBarItem.isEnabled = false
        
        let fourMainVC = storyboard?.instantiateViewController(withIdentifier: "TransactionHistoryVC") as! TransactionHistoryViewController
        fourMainVC.modalPresentationStyle = .fullScreen
        fourMainVC.tabBarItem = UITabBarItem(title: LocalizationManager.share.translate?.result.list.main_screen.main_screen_transaction_btn, image: UIImage(named: "transaction")!, selectedImage: UIImage(named: "transaction")!)
        
        let fiveMainVC = storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
        fiveMainVC.modalPresentationStyle = .fullScreen
        fiveMainVC.tabBarItem = UITabBarItem(title: LocalizationManager.share.translate?.result.list.main_screen.main_screen_addresses_btn, image: UIImage(named: "adress")!, selectedImage: UIImage(named: "adress")!)
        
        self.setViewControllers([mainVC, secondMainVC, thirdMainVC, fourMainVC, fiveMainVC], animated: true)
        self.navigationController?.navigationBar.delegate = self
    }
    
}

extension MainTabBarController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}
