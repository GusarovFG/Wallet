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
                    if !CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
                        if wallet.name == "Chia Wallet" {
                            ChiaBlockchainManager.share.logIn(Int(wallet.fingerprint)) { log in
                                if log.success {
                                    ChiaBlockchainManager.share.getWallets { wallets in
                                        for wallet in wallets.wallets {
                                            print(wallet.id)
                                            ChiaBlockchainManager.share.getWalletBalance(wallet.id) { balance in
                                                newbalances.append(balance.wallet_balance.confirmed_wallet_balance as NSNumber)
                                                print(newbalances)
                                                if balance.success {
                                                    if (CoreDataManager.share.fetchChiaWalletPrivateKey()[wal].balances as! [NSNumber]) != newbalances {
                                                        CoreDataManager.share.editChiaWalletPrivateKey(index: wal, balances: newbalances)
                                                        print("save")
                                                    } else {
                                                        print("dont save")
                                                        return
                                                    }
                                                } else {
                                                    return
                                                }
                                            }
                                            
                                            DispatchQueue.main.async {
                                                NotificationCenter.default.post(name: NSNotification.Name("updateBalances"), object: nil)
                                            }
                                        }
                                    }
                                }
                            }
                        } else if wallet.name == "Chives Wallet" {
                            ChivesBlockchainManager.share.logIn(Int(wallet.fingerprint)) { log in
                                if log.success {
                                    ChivesBlockchainManager.share.getWallets { wallets in
                                        for wallet in wallets.wallets {
                                            print(wallet.id)
                                            ChivesBlockchainManager.share.getWalletBalance(wallet.id) { balance in
                                                newbalances.append(balance.wallet_balance.confirmed_wallet_balance as NSNumber)
                                                print(newbalances)
                                                CoreDataManager.share.editChiaWalletPrivateKey(index: wal, balances: newbalances)
                                            }
                                            
                                            DispatchQueue.main.async {
                                                NotificationCenter.default.post(name: NSNotification.Name("updateBalances"), object: nil)
                                            }
                                        }
                                    }
                                }
                            }
                        } else if wallet.name == "Chia TestNet" {
                            ChiaTestBlockchainManager.share.logIn(Int(wallet.fingerprint)) { log in
                                if log.success {
                                    ChiaTestBlockchainManager.share.getWallets { wallets in
                                        for wallet in wallets.wallets {
                                            print(wallet.id)
                                            ChiaTestBlockchainManager.share.getWalletBalance(wallet.id) { balance in
                                                newbalances.append(balance.wallet_balance.confirmed_wallet_balance as NSNumber)
                                                print(newbalances)
                                                CoreDataManager.share.editChiaWalletPrivateKey(index: wal, balances: newbalances)
                                            }
                                            
                                            DispatchQueue.main.async {
                                                NotificationCenter.default.post(name: NSNotification.Name("updateBalances"), object: nil)
                                            }
                                        }
                                    }
                                }
                            }
                        } else if wallet.name == "Chives TestNet" {
                            ChivesTestBlockchainManager.share.logIn(Int(wallet.fingerprint)) { log in
                                if log.success {
                                    ChivesTestBlockchainManager.share.getWallets { wallets in
                                        for wallet in wallets.wallets {
                                            print(wallet.id)
                                            ChivesTestBlockchainManager.share.getWalletBalance(wallet.id) { balance in
                                                newbalances.append(balance.wallet_balance.confirmed_wallet_balance as NSNumber)
                                                print(newbalances)
                                                CoreDataManager.share.editChiaWalletPrivateKey(index: wal, balances: newbalances)
                                            }
                                            
                                            DispatchQueue.main.async {
                                                NotificationCenter.default.post(name: NSNotification.Name("updateBalances"), object: nil)
                                            }
                                        }
                                    }
                                }
                            }
                        }
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
