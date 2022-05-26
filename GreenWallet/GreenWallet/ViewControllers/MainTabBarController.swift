//
//  MainTabBarController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 03.05.2022.
//

import UIKit

class MainTabBarController: UITabBarController, UINavigationBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        addTabs()
        self.tabBar.tintColor = #colorLiteral(red: 0.2274509804, green: 0.6745098039, blue: 0.3490196078, alpha: 1)
    }
    
    private func addTabs() {
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "navi") as! UINavigationController
        mainVC.tabBarItem = UITabBarItem(title: LocalizationManager.share.translate?.result.list.main_screen.main_screen_title_purse, image: UIImage(named: "wallet")!, selectedImage: UIImage(named: "wallet")!)
        
        let secondMainVC = storyboard?.instantiateViewController(withIdentifier: "navi") as! UINavigationController
        secondMainVC.tabBarItem = UITabBarItem(title: LocalizationManager.share.translate?.result.list.main_screen.main_screen_recive_btn, image: UIImage(named: "get")!, selectedImage: UIImage(named: "get")!)
        
        let thirdMainVC = storyboard?.instantiateViewController(withIdentifier: "navi") as! UINavigationController
        thirdMainVC.tabBarItem = UITabBarItem(title: LocalizationManager.share.translate?.result.list.main_screen.main_screen_send_btn, image: UIImage(named: "push")!, selectedImage: UIImage(named: "push")!)
        
        let fourMainVC = storyboard?.instantiateViewController(withIdentifier: "TransactionHistoryVC") as! TransactionHistoryViewController
        fourMainVC.modalPresentationStyle = .fullScreen
        fourMainVC.tabBarItem = UITabBarItem(title: LocalizationManager.share.translate?.result.list.main_screen.main_screen_transaction_btn, image: UIImage(named: "transaction")!, selectedImage: UIImage(named: "transaction")!)

        self.setViewControllers([mainVC, secondMainVC, thirdMainVC, fourMainVC], animated: true)
        self.navigationController?.navigationBar.delegate = self
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if tabBar.selectedItem?.title == LocalizationManager.share.translate?.result.list.main_screen.main_screen_recive_btn {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showGetVC"), object: nil)

            
        }
        
        if tabBar.selectedItem?.title == LocalizationManager.share.translate?.result.list.main_screen.main_screen_send_btn {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showPushVC"), object: nil)
        }
        

    }
    
    
}

extension MainTabBarController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}
