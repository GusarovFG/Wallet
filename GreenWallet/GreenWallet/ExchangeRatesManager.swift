//
//  ExchangeRatesManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 20.06.2022.
//

import Foundation
import UIKit

class ExchangeRatesManager {
    
    static let share = ExchangeRatesManager()
    
    private init(){}
    
    var newRatePerDollar: Double = 0
    var oldRatePerDollar: Double = 0
    var difference: Double = 0
    
    var newChivesRatePerDollar: Double = 0
    var oldChivesRatePerDollar: Double = 0
    var differenceChives: Double = 0
    
    func differenceСalculation()  {
        if self.newRatePerDollar > self.oldRatePerDollar {
            self.difference = ((self.newRatePerDollar - self.oldRatePerDollar) / self.newRatePerDollar) * 100
            print(newRatePerDollar)
            print(oldRatePerDollar)
            print(difference)
        } else {
            self.difference = ((self.oldRatePerDollar - self.newRatePerDollar) / self.newRatePerDollar) * 100
            print(newRatePerDollar)
            print(oldRatePerDollar)
            print(difference)
        }
    }
    
    func differenceChivesСalculation()  {
        if self.newChivesRatePerDollar > self.oldChivesRatePerDollar {
            self.differenceChives = ((self.newChivesRatePerDollar - self.oldChivesRatePerDollar) / self.newChivesRatePerDollar) * 100
            print(newChivesRatePerDollar)
            print(oldChivesRatePerDollar)
            print(differenceChives)
        } else {
            self.differenceChives = ((self.oldChivesRatePerDollar - self.newChivesRatePerDollar) / self.newChivesRatePerDollar) * 100
            print(newRatePerDollar)
            print(oldRatePerDollar)
            print(difference)
        }
    }
    
    func changeColorOfView(label: UILabel) {
        if self.newRatePerDollar > self.oldRatePerDollar {
            label.text?.insert("▲", at: label.text!.startIndex)
            label.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        } else {
            label.backgroundColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
            label.text?.insert("▼", at: label.text!.startIndex)
        }
    }
    
    func changeChivesColorOfView(label: UILabel) {
        if self.newChivesRatePerDollar > self.oldChivesRatePerDollar {
            label.text?.insert("▲", at: label.text!.startIndex)
            label.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        } else {
            label.backgroundColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
            label.text?.insert("▼", at: label.text!.startIndex)
        }
    }
}

