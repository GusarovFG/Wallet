//
//  ChiaWalletsManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 09.06.2022.
//

import Foundation

class ChiaWalletsManager {
    
    static let share = ChiaWalletsManager()
    
    private init(){}
    
    var wallets = ChiaWallets(success: true, wallets: [])
    var balance = ChiaWalletBalance(success: true, wallet_balance: WalletBalance(confirmed_wallet_balance: 0, fingerprint: 0, max_send_amount: 22, pending_change: 0, pending_coin_removal_count: 0, spendable_balance: 0, unconfirmed_wallet_balance: 0, unspent_coin_count: 0, wallet_id: 0))
}
