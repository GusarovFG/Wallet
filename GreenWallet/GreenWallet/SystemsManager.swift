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
    
    func getSystems() {
        
        DispatchQueue.global().async {
            NetworkManager.share.getSystems { system in
                self.systems = system
            }
        }
    }
}
