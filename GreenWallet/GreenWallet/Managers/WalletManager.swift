//
//  WalletManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 12.05.2022.
//

import UIKit

class WalletManager {
    
    static let share = WalletManager()
    var vallets: [ChiaWalletPrivateKey] = CoreDataManager.share.fetchChiaWalletPrivateKey()
    var isUpdate = false
    var myTimer = Timer()
    var favoritesWallets: [ChiaWalletPrivateKey] = CoreDataManager.share.fetchChiaWalletPrivateKey()
    private init(){
        self.myTimer = Timer(timeInterval: 30.0, target: self, selector: #selector(updateBalances), userInfo: nil, repeats: true)
        RunLoop.main.add(self.myTimer, forMode: .default)
    }
    
    @objc func updateBalances() {
        
        if self.isUpdate {
            DispatchQueue.global().sync {
                for wal in 0..<CoreDataManager.share.fetchChiaWalletPrivateKey().count {
                    let wallet = CoreDataManager.share.fetchChiaWalletPrivateKey()[wal]
                    var newbalances: [NSNumber] = []
                    var walletsss: [NSNumber] = []
                    if wallet.name == "Chia Wallet" {
//                        ChiaBlockchainManager.share.logIn(Int(wallet.fingerprint)) { log in
//                            if log.success {
//                                ChiaBlockchainManager.share.getWallets { wallets in
//                                    for w in wallets.wallets {
//                                        walletsss.append(w.id as NSNumber)
//                                        ChiaBlockchainManager.share.getWalletBalance(w.id) { balance in
//                                            newbalances.append(balance.wallet_balance.confirmed_wallet_balance as NSNumber)
//                                            
//                                        }
//                                        
//                                    }
//                                    
//                                }
//                                
//                                CoreDataManager.share.saveChiaWalletPrivateKey(name: "name", fingerprint: 2, pk: "privateKey.private_key.pk", seed: "privateKey.private_key.seed", sk: "privateKey.private_key.seed", adress: "adreses", wallets: walletsss as [NSNumber], balances: newbalances as [NSNumber])
//                                
//                                DispatchQueue.main.async {
//                                    
//                                    NotificationCenter.default.post(name: NSNotification.Name("updateBalances"), object: nil)
//                                    CoreDataManager.share.editChiaWalletPrivateKey(index: wal, balances: newbalances)
//                                }
//                            }
//                        }
//                        
//                        
                        
                    } else {
                        return
                    }
                }
            }
        }
    }
}

class Password {
    
    static let sahre = Password()
    
    var password = "323508"
    
    private init(){}
}
