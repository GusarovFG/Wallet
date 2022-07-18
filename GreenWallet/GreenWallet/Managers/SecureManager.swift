//
//  SecureManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 18.07.2022.
//

import Foundation
import CryptoSwift

class SecureManager {
    
    static let share = SecureManager()
    
    func encrypt(text: String) -> String?  {
        if let aes = try? AES(key: "passwordpassword", iv: "drowssapdrowssap"),
           let encrypted = try? aes.encrypt(Array(text.utf8)) {
            print(encrypted.toHexString())
            return encrypted.toHexString()
        }
        return nil
    }
    
    func decrypt(hexString: String) -> String? {
        if let aes = try? AES(key: "passwordpassword", iv: "drowssapdrowssap"),
            let decrypted = try? aes.decrypt(Array<UInt8>(hex: hexString)) {
            print(String(data: Data(bytes: decrypted), encoding: .utf8)!)
            return String(data: Data(bytes: decrypted), encoding: .utf8)
        }
        return nil
    }
}
