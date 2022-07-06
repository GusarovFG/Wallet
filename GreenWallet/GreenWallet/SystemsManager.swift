//
//  SystemsManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 04.07.2022.
//

import Foundation

class SystemsManager {
    
    static let share = SystemsManager()
    
    private init(){}
    
    var systems = Systems(success: false, result: ResultSystems(version: "", list: [ListSystems(name: "", full_node: "", wallet: "", daemon: "", farmer: "", harvester: "")]))
    var listOfSystems: [ListSystems] = []
    
    func getSystems() {
        
        DispatchQueue.global().async {
            NetworkManager.share.getSystems { system in
                self.systems = system
                self.filterSystems()
                print(self.listOfSystems)
            }
        }
    }
    
    func filterSystems() {
        if !CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
            for i in self.systems.result.list {
                for wallet in CoreDataManager.share.fetchChiaWalletPrivateKey() {
                    if i.name == "Chia Network" && wallet.name == "Chia Wallet" {
                        self.listOfSystems.append(i)
                    } else if i.name == "Chia TestNet" && wallet.name == "Chia TestNet" {
                        self.listOfSystems.append(i)
                    } else if i.name == "Chives Network" && wallet.name == "Chives Wallet" {
                        self.listOfSystems.append(i)
                    } else if i.name == "Chives TestNet" && wallet.name == "Chives TestNet" {
                        self.listOfSystems.append(i)
                    }
                }
            }
            
        } else {
            self.listOfSystems = self.systems.result.list
        }
    }
}
