//
//  WalletManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 12.05.2022.
//

import UIKit
import CryptoKit

class WalletManager {
    
    static let share = WalletManager()
    var vallets: [ChiaWalletPrivateKey] = CoreDataManager.share.fetchChiaWalletPrivateKey()
    var isUpdate = false
    var myTimer = Timer()
    var favoritesWallets: [ChiaWalletPrivateKey] = CoreDataManager.share.fetchChiaWalletPrivateKey()
    var index = 0
    private init(){
        self.myTimer = Timer(timeInterval: 30.0, target: self, selector: #selector(updateBalances), userInfo: nil, repeats: true)
        RunLoop.main.add(self.myTimer, forMode: .default)
    }

    
    @objc func updateBalances() {
        var name = ""
        var id = ""
        var token : [String] = []
        var tokens: [[String]] = []
        
        if self.index == (CoreDataManager.share.fetchChiaWalletPrivateKey().count - 1) {
            self.index = 0
            print("индекс")
            print(self.index)
 
                
                print(CoreDataManager.share.fetchChiaWalletPrivateKey())
                
                NotificationCenter.default.post(name: NSNotification.Name("updateBalances"), object: nil)
            
        } else {
            self.index += 1
            print("новый индекс")
            print(self.index)

                
                print(CoreDataManager.share.fetchChiaWalletPrivateKey())
                
                NotificationCenter.default.post(name: NSNotification.Name("updateBalances"), object: nil)

        }
        
        if !CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
            print("нычало")
            print(self.index)
            if self.isUpdate {
                DispatchQueue.global().async {
                    let wallet = CoreDataManager.share.fetchChiaWalletPrivateKey()[self.index]
                    print("индекс кошелька")
                    print(self.index)
                    let walletTokens = CoreDataManager.share.fetchChiaWalletPrivateKey()[self.index].token ?? []
                    if wallet.name == "Chia Wallet" {
                        ChiaBlockchainManager.share.logIn(Int(wallet.fingerprint)) { log in
                            print("fingerprint \(wallet.fingerprint)")
                            print(log.fingerprint)
                            if log.success {
                                ChiaBlockchainManager.share.getWallets { wallets in
                                    
                                    for walletONe in 0..<wallets.wallets.count {

                                        ChiaBlockchainManager.share.getWalletBalance(wallets.wallets[walletONe].id) { balance in
                                            id = "\(wallets.wallets[walletONe].id)"
                                            name = wallets.wallets[walletONe].name
                                            token.append(name)
                                            token.append(id)
                                            token.append("\(balance.wallet_balance.confirmed_wallet_balance)")
                                            token.append("show")
                                            print(tokens)
                                            print(walletTokens)
                                            print(token)
                                            if !walletTokens.contains(where: {$0[0] == token[0]}) {
                                                print("Новье")
                                                CoreDataManager.share.addCatBalanceChiaWalletPrivateKey(index: self.index, token: token)
                                                token.removeAll()
                                
                                                
                                            } else {
                                                CoreDataManager.share.updateCatBalanceChiaWalletPrivateKey(index: self.index, id: wallets.wallets[walletONe].id, balance: "\(balance.wallet_balance.confirmed_wallet_balance)")
                                                
                                                token.removeAll()
                                                print("То же самое")
                                            }
                                            print("qweqweqwe \(tokens)")
                                        }
                                    }
                                }
                            }
                        }
                    }
               
                    
                }
            } else {
                return
                
            }
        } else {
            return
        }
    }
}





class Password {
    
    static let sahre = Password()
    
    var password = "323508"
    
    private init(){}
}
