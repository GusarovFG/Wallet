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
        self.myTimer = Timer(timeInterval: 15.0, target: self, selector: #selector(updateBalances), userInfo: nil, repeats: true)
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
        } else {
            self.index += 1
            print("новый индекс")
            print(self.index)
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
                                                tokens.append(token)
                                            print(tokens)
                                            print(walletTokens)
                                            print(token)
                                            token.removeAll()
                                            if walletTokens != tokens && walletTokens.count <= tokens.count{
                                                print("Новье")
                                                CoreDataManager.share.editChiaWalletPrivateKey(index: self.index, name: wallet.name ?? "", fingerprint: Int(wallet.fingerprint) , pk: wallet.pk ?? "", seed: wallet.seed ?? "", sk: wallet.sk ?? "", adress: wallet.adres ?? "", tokens: tokens)
                                               
                                                DispatchQueue.main.async {
                                                    
                                                    print(CoreDataManager.share.fetchChiaWalletPrivateKey())
                                                    
                                                    NotificationCenter.default.post(name: NSNotification.Name("updateBalances"), object: nil)
                                                }
                                                
                                            } else {
                                  
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
