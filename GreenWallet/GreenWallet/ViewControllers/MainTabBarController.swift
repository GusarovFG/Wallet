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
        // Do any additional setup after loading the view.
    }
    
    private func addTabs() {
        
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        mainVC.tabBarItem = UITabBarItem(title: "Кошелек", image: UIImage(named: "wallet")!, selectedImage: UIImage(named: "wallet")!)
        
        let selectSystemVC = storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        selectSystemVC.tabBarItem = UITabBarItem(title: "Получить", image: UIImage(named: "wallet")!, selectedImage: UIImage(named: "wallet")!)

        self.setViewControllers([mainVC, selectSystemVC], animated: true)
        self.navigationController?.navigationBar.delegate = self
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if tabBar.selectedItem?.title == "Получить" {
            let selectSystemVC = storyboard?.instantiateViewController(withIdentifier: "SelectSystemViewController") as! SelectSystemViewController
            self.present(selectSystemVC, animated: true, completion: nil)
        }
    }
    
    
}
