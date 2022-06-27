//
//  ChiaModels.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 09.06.2022.
//

import Foundation
import CoreData

struct ChiaGeneratingMnemonic: Codable {
    let mnemonic: [String]
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case mnemonic
        case success
    }
}

struct ChiaFingerPrint: Codable {
    let fingerprint: Int
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case fingerprint
        case success
    }
}

struct ChiaImportMnemonic: Codable {
    var mnemonic: [String]
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case mnemonic
        case type
    }
}

struct ChiaPrivate: Codable {
    let private_key: ChiaPrivateKey
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case private_key
        case success
    }
}

struct ChiaPrivateKey: Codable {
    let farmer_pk: String
    let fingerprint: Int
    let pk: String
    let pool_pk: String
    let seed: String
    let sk: String

    enum CodingKeys: String, CodingKey {
        case farmer_pk
        case fingerprint
        case pk
        case pool_pk
        case seed
        case sk
    }
}

struct ChiaWallets: Codable {
    let success: Bool
    let wallets: [ChiaWallet]

    enum CodingKeys: String, CodingKey {
        case success
        case wallets
    }
}

// MARK: - Wallet
struct ChiaWallet: Codable {
    let data: String
    let id: Int
    let name: String
    let type: Int

    enum CodingKeys: String, CodingKey {
        case data
        case id
        case name
        case type
    }
}

struct ChiaWalletBalance: Codable {
    let success: Bool
    let wallet_balance: WalletBalance

    enum CodingKeys: String, CodingKey {
        case success
        case wallet_balance
    }
}

// MARK: - WalletBalance
struct WalletBalance: Codable {
    let confirmed_wallet_balance: Double
    let fingerprint: Int
    let max_send_amount: Double
    let pending_change: Double
    let pending_coin_removal_count: Double
    let spendable_balance: Double
    let unconfirmed_wallet_balance: Double
    let unspent_coin_count: Double
    let wallet_id: Int

    enum CodingKeys: String, CodingKey {
        case confirmed_wallet_balance
        case fingerprint
        case max_send_amount
        case pending_change
        case pending_coin_removal_count
        case spendable_balance
        case unconfirmed_wallet_balance
        case unspent_coin_count
        case wallet_id
    }
}

struct LogIn: Codable {
    
    var fingerprint: Int
    var success: Bool
    
    enum CodingKeys: String, CodingKey {
        case fingerprint
        case success
      
    }

}

struct ChiaAdres: Codable {
    let address: String
    let success: Bool
    let wallet_id: Int

    enum CodingKeys: String, CodingKey {
        case address
        case success
        case wallet_id
    }
}

struct CoinRecords: Codable {
    let coin_records: [CoinRecord]
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case coin_records
        case success
    }
}

// MARK: - CoinRecord
struct CoinRecord: Codable {
    let coin: Coin
    let coinbase: Bool
    let confirmed_block_index: Int
    let spent: Bool
    let spent_block_index: Int
    let timestamp: Int

    enum CodingKeys: String, CodingKey {
        case coin
        case coinbase
        case confirmed_block_index
        case spent
        case spent_block_index
        case timestamp
    }
}

// MARK: - Coin
struct Coin: Codable {
    let amount: Int
    let parent_coin_info: String
    let puzzle_hash: String

    enum CodingKeys: String, CodingKey {
        case amount
        case parent_coin_info
        case puzzle_hash
    }
}

struct ChiaTransactions: Codable {
    let success: Bool
    let transactions: [ChiaTransaction]

    enum CodingKeys: String, CodingKey {
        case success
        case transactions
    }
}

// MARK: - Transaction
struct ChiaTransaction: Codable {
    let amount: Int
    let confirmed: Bool
    let confirmed_at_height: Int
    let created_at_time: Double
    let type: Int
    

    enum CodingKeys: String, CodingKey {
        case amount
        case confirmed
        case confirmed_at_height = "confirmed_at_height"
        case created_at_time = "created_at_time"
        case type
    }
}

// MARK: - Addition
struct Addition: Codable {
    let amount: Int
    let parentCoinInfo: String
    let puzzleHash: String

    enum CodingKeys: String, CodingKey {
        case amount
        case parentCoinInfo
        case puzzleHash
    }
}

struct ChiaSyncStatus: Codable {
    let genesis_initialized: Bool
    let success: Bool
    let synced: Bool
    let syncing: Bool

    enum CodingKeys: String, CodingKey {
        case genesis_initialized
        case success
        case synced
        case syncing
    }
}

