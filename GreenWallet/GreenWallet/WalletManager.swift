//
//  WalletManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 12.05.2022.
//

import UIKit

class WalletManager {
    
    static let share = WalletManager()
    var vallets: [ChiaWalletPrivateKey] = CoreDataManager.share.fetchChiaWalletPrivateKey()
    
    var favoritesWallets: [ChiaWalletPrivateKey] = CoreDataManager.share.fetchChiaWalletPrivateKey()
    private init(){}
    
    
}

class Password {
    
    static let sahre = Password()
    
    var password = "323508"
    
    private init(){}
}
