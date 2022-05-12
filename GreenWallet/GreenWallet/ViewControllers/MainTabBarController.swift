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

        self.setViewControllers([mainVC, secondMainVC], animated: true)
        self.navigationController?.navigationBar.delegate = self
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if tabBar.selectedItem?.title == "Получить" {
            let getTokenViewController = storyboard?.instantiateViewController(withIdentifier: "GetTokenViewController") as! GetTokenViewController
//            let nav = UINavigationController(rootViewController: getTokenViewController)
            
            getTokenViewController.modalPresentationStyle = .fullScreen
            
//            if let sheet = nav.sheetPresentationController {
//                sheet.detents = [.medium()]
//            }
//
            self.present(getTokenViewController, animated: true, completion: nil)
        }
    }
    
    
}
