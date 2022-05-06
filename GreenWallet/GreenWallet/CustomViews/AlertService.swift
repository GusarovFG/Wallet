//
//  AlertService.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 04.05.2022.
//

import UIKit

class AlertService {
    
    
    func alert(title: String, discription: String) -> AllertWalletViewController {
        
        let storyboard = UIStoryboard(name: "Alert", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AllertWalletViewController") as! AllertWalletViewController
        alertVC.setupUI(label: title, discription: discription)
        
        return alertVC
        
        
    }
}
