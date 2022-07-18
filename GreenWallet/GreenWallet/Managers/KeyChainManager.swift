//
//  KeyChainManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 23.05.2022.
//

import Foundation
import Locksmith

class KeyChainManager {
    
    static let share = KeyChainManager()
    
    private init(){}
    
    func savePassword(_ password: String) {
        do {
            
           try Locksmith.saveData(data: ["Password" : password ], forUserAccount: "GreenWallet")
        } catch {
            print("Unable to save data")
        }
        
    }
    
    func loadPassword() -> String {
        let password = Locksmith.loadDataForUserAccount(userAccount: "GreenWallet")
        
        return password?["Password"] as! String
    }
    
    func deletePassword() {
        do {
            
            try Locksmith.deleteDataForUserAccount(userAccount: "GreenWallet")
        } catch {
            print("Unable to save data")
        }
        
       
    }
}
