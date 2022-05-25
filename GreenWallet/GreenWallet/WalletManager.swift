//
//  WalletManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 12.05.2022.
//

import UIKit

class WalletManager {
    
    static let share = WalletManager()
    var vallets: [WalletModel] = [WalletModel(name: "Chia", number: 111111111, image: UIImage(named: "LogoChia")!, tokens: [System(name: "GAD", token: "GAD", image: UIImage(named: "gad")!, balance: 5.4523), System(name: "GAD", token: "GAD", image: UIImage(named: "gad")!, balance: 6.4523), System(name: "GAD", token: "GAD", image: UIImage(named: "gad")!, balance: 9.4523)], toket: "XCH"), WalletModel(name: "Chives", number: 222222222, image: UIImage(named: "USDS")!, tokens: [System(name: "GAD", token: "GAD", image: UIImage(named: "ChivesLogo")!, balance: 1.45323)], toket: "XCH"), WalletModel(name: "Chives", number: 333333333, image: UIImage(named: "LogoChia")!, tokens: [System(name: "USDS", token: "USDS", image: UIImage(named: "USDS")!, balance: 5.111)], toket: "XCH")]
    
    var favoritesWallets: [WalletModel] = [WalletModel(name: "Chia", number: 111111111, image: UIImage(named: "LogoChia")!, tokens: [System(name: "GAD", token: "GAD", image: UIImage(named: "gad")!, balance: 5.4523), System(name: "GAD", token: "GAD", image: UIImage(named: "gad")!, balance: 6.4523), System(name: "GAD", token: "GAD", image: UIImage(named: "gad")!, balance: 9.4523)], toket: "XCH"), WalletModel(name: "Chives", number: 222222222, image: UIImage(named: "USDS")!, tokens: [System(name: "GAD", token: "GAD", image: UIImage(named: "ChivesLogo")!, balance: 1.45323)], toket: "XCH"), WalletModel(name: "Chives", number: 333333333, image: UIImage(named: "LogoChia")!, tokens: [System(name: "USDS", token: "USDS", image: UIImage(named: "USDS")!, balance: 5.111)], toket: "XCH")]
    private init(){}
    
    
}

class Password {
    
    static let sahre = Password()
    
    var password = "323508"
    
    private init(){}
}
