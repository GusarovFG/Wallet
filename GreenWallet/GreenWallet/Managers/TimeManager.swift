//
//  TImeManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 24.05.2022.
//

import Foundation

class TimeManager {
    
    static let share = TimeManager()
    
    let currentDate = Double(Date().timeIntervalSince1970)
    
    private init(){}
    
    func getTime() -> Int {
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        print("\(hour): \(minutes)")
        return hour
    }
    
    func convertUnixTime(unix: Double, format: String) -> String {

        let date = Date(timeIntervalSince1970: unix)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    
    func getCurrentDate() {
        
    }
    
    func dateToUnix(string: String) -> Double {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd.MM.yy"
        let date = dateFormatter.date(from: string)
        let unixTime = date?.timeIntervalSince1970 ?? 0.0
        return unixTime
    }

}
