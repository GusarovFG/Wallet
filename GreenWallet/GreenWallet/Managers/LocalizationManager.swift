//
//  LocalizationManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 26.05.2022.
//

import Foundation

class LocalizationManager {
    static let share = LocalizationManager()
    
    var translate: ListOfTranslate?
    
    private init(){}
    

}

class LanguageManager {
    static let share = LanguageManager()
    
    var language: Language?
    
    private init(){}
    
}
