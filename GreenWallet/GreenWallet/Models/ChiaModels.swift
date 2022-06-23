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

// MARK: - Memos
struct Memos: Codable {
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
