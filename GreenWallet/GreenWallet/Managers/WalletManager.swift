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
    
    func qwe(index: Int) {
        var name = ""
        var id = ""
        var token : [String] = []
        var tokens: [[String]] = []
        let group = DispatchGroup()
        print("нычало")
        let wallet = CoreDataManager.share.fetchChiaWalletPrivateKey()[index]
        let walletTokens = CoreDataManager.share.fetchChiaWalletPrivateKey()[index].token ?? []
        
        if self.isUpdate {
                for wal in 0..<CoreDataManager.share.fetchChiaWalletPrivateKey().count {
                    DispatchQueue.global().async {
                    let wallet = CoreDataManager.share.fetchChiaWalletPrivateKey()[wal]
                    let walletTokens = CoreDataManager.share.fetchChiaWalletPrivateKey()[wal].token ?? []
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
                                            if walletTokens.count > tokens.count {
                                            tokens.append(token)
                                            }
                                            print(tokens)
                                            print(walletTokens)
                                            print(token)
                                            token.removeAll()
                                            if walletTokens != tokens && walletTokens.count <= tokens.count{
                                                print("Новье")
                                                CoreDataManager.share.editChiaWalletPrivateKey(index: wal, name: wallet.name ?? "", fingerprint: Int(wallet.fingerprint) , pk: wallet.pk ?? "", seed: wallet.seed ?? "", sk: wallet.sk ?? "", adress: wallet.adres ?? "", tokens: tokens)
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
            }
        } else {
            return

        }
        
    }
    
    @objc func updateBalances() {
        
        let group = DispatchGroup()
        var count = 0
            for i in 0..<CoreDataManager.share.fetchChiaWalletPrivateKey().count {
                self.qwe(index: i)
                print("ЖОПА")
                print(CoreDataManager.share.fetchChiaWalletPrivateKey().count)
                count += 1
                print(count)
            }
        }
        
    
    
}

class Password {
    
    static let sahre = Password()
    
    var password = "323508"
    
    private init(){}
}
