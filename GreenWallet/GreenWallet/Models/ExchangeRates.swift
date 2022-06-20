//
//  ExchangeRates.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 20.06.2022.
//

import Foundation

struct ExchangeRates: Codable {
    let data: [Datum]
    let status: String
    let ts: Int

    enum CodingKeys: String, CodingKey {
        case data
        case status
        case ts
    }
}

// MARK: - Datum
struct Datum: Codable {
    let symbol: String
    let high: Double
    let low: Double
    let close: Double
    let amount: Double
    let vol: Double
    let count: Int
    let bid: Double
    let bidSize: Double
    let ask: Double
    let askSize: Double

    enum CodingKeys: String, CodingKey {
        case symbol
        case high
        case low
        case close
        case amount
        case vol
        case count
        case bid
        case bidSize
        case ask
        case askSize
    }
}
