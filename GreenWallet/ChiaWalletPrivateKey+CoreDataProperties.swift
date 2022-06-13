//
//  ChiaWalletPrivateKey+CoreDataProperties.swift
//  
//
//  Created by Фаддей Гусаров on 13.06.2022.
//
//

import Foundation
import CoreData


extension ChiaWalletPrivateKey {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChiaWalletPrivateKey> {
        return NSFetchRequest<ChiaWalletPrivateKey>(entityName: "ChiaWalletPrivateKey")
    }

    @NSManaged public var adres: String?
    @NSManaged public var balances: [NSNumber]
    @NSManaged public var fingerprint: Int64
    @NSManaged public var pk: String?
    @NSManaged public var seed: String?
    @NSManaged public var sk: String?
    @NSManaged public var wallets: [NSNumber]
    @NSManaged public var name: String?
}
