//
//  Models.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 27.04.2022.
//

import Foundation
import UIKit

struct System {
    var name: String
    var token: String
    var image: UIImage
    var balance: Double
}

struct Wallet {
    
    var name: String
    var number: Int
    var image: UIImage
    var tokens: [System]
    var toket: String
}
