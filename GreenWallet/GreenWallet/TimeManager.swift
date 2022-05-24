//
//  TImeManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 24.05.2022.
//

import Foundation

class TimeManager {
    
    static let share = TimeManager()
    
    private init(){}
    
    func getTime() -> Int {
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        print("\(hour): \(minutes)")
        return hour
    }
}
