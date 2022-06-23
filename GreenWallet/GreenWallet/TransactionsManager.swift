//
//  TransactionsManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 23.06.2022.
//

import Foundation

class TransactionsManager {
    
    static let share = TransactionsManager()
    
    var newTransactions: [ChiaTransactions] = []
    var filterTransactions: [ChiaTransaction] = []
    
    private init(){}
    
//    func getTransactions() -> [ChiaTransaction]{
//        
//        var ewq: [ChiaTransaction] = []
//        DispatchQueue.global().sync {
////            for wallet in CoreDataManager.share.fetchChiaWalletPrivateKey() {
//            ChiaBlockchainManager.share.logIn(1693917638) { log in
//                if log.success {
//                    ChiaBlockchainManager.share.getTransactions(1) { transactions in
//                        self.newTransactions.append(transactions)
//                        print(transactions)
//                        ewq = transactions.transactions ?? []
//                    }
//                }
//            }
//            
////                for id in (wallet.wallets as! [NSNumber]) {
//                    
////                    }
////                }
//            }
//            
//        let qwe: [[ChiaTransaction]] = self.newTransactions.map{$0.transactions ?? []}
//           
//            
//            return ewq
//
//        }
    }

