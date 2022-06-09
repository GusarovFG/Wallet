//
//  ChiaModels.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 09.06.2022.
//

import Foundation

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
