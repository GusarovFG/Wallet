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
        mainVC.tabBarItem = UITabBarItem(title: "Кошелек", image: UIImage(named: "wallet")!, selectedImage: UIImage(named: "wallet")!)
        
        let secondMainVC = storyboard?.instantiateViewController(withIdentifier: "navi") as! UINavigationController
        secondMainVC.tabBarItem = UITabBarItem(title: "Получить", image: UIImage(named: "get")!, selectedImage: UIImage(named: "get")!)
        
        let thirdMainVC = storyboard?.instantiateViewController(withIdentifier: "navi") as! UINavigationController
        thirdMainVC.tabBarItem = UITabBarItem(title: "Отправить", image: UIImage(named: "push")!, selectedImage: UIImage(named: "push")!)
        
        let fourMainVC = storyboard?.instantiateViewController(withIdentifier: "navi") as! UINavigationController
        fourMainVC.tabBarItem = UITabBarItem(title: "Транзакции", image: UIImage(named: "transaction")!, selectedImage: UIImage(named: "transaction")!)

        self.setViewControllers([mainVC, secondMainVC, thirdMainVC, fourMainVC], animated: true)
        self.navigationController?.navigationBar.delegate = self
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if tabBar.selectedItem?.title == "Получить" {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showGetVC"), object: nil)

            
        }
        
        if tabBar.selectedItem?.title == "Отправить" {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showPushVC"), object: nil)
        }
        
        if tabBar.selectedItem?.title == "Транзакции" {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showTransVC"), object: nil)
        }
    }
    
    
}

extension MainTabBarController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}
