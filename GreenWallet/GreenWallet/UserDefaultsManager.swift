//
//  UserDefaultsManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 28.04.2022.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    let userDefaults = UserDefaults.standard
    
    private init(){}
    

}

enum UserDefaultsStringKeys: String {
    case hideWalletsBalance = "HideWalletsBalance"
    case Language = "Language"
    case theme = "Theme"
}
