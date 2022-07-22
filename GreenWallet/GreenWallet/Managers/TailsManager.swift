//
//  TailsManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 11.07.2022.
//

import Foundation

class TailsManager {
    
    
    static let share = TailsManager()
    
    var tails: Tails?
    
    var prices: [TailsPricesList] = []
    
    private init(){}
    
}
