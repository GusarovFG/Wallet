//
//  ExchangeRates.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 20.06.2022.
//

import Foundation

struct NewRates: Codable {
    let chia: Chi
    let chives_сoin: Chi

    enum CodingKeys: String, CodingKey {
        case chia
        case chives_сoin = "chives-coin"
    }
}

// MARK: - Chi
struct Chi: Codable {
    let usd: Double
    let usd_market_cap: Double
    let usd_24h_vol: Double
    let usd_24h_change: Double

    enum CodingKeys: String, CodingKey {
        case usd
        case usd_market_cap
        case usd_24h_vol
        case usd_24h_change
    }
}
