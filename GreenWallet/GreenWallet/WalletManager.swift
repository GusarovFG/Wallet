//
//  WalletManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 12.05.2022.
//

import UIKit

class WalletManager {
    
    static let share = WalletManager()
    var vallets: [Wallet] = [Wallet(name: "Chia", number: 111111111, image: UIImage(named: "LogoChia")!, tokens: [System(name: "GAD", token: "GAD", image: UIImage(named: "gad")!, balance: 5.4523), System(name: "GAD", token: "GAD", image: UIImage(named: "gad")!, balance: 6.4523), System(name: "GAD", token: "GAD", image: UIImage(named: "gad")!, balance: 9.4523)]), Wallet(name: "Chives", number: 222222222, image: UIImage(named: "USDS")!, tokens: [System(name: "GAD", token: "GAD", image: UIImage(named: "ChivesLogo")!, balance: 1.45323)]), Wallet(name: "Chives", number: 333333333, image: UIImage(named: "LogoChia")!, tokens: [System(name: "USDS", token: "USDS", image: UIImage(named: "USDS")!, balance: 5.111)]), ]
    
    
    private init(){}
    
    
}