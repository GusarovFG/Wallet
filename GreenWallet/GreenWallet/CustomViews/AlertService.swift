//
//  AlertService.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 04.05.2022.
//

import UIKit

class AlertService {
    
    
    func alert() -> AllertWalletViewController {
        
        let storyboard = UIStoryboard(name: "Alert", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AllertWalletViewController") as! AllertWalletViewController
        
        return alertVC
        
        
    }
}
