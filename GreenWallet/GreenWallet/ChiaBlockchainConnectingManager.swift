//
//  ChiaBlockchainManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 08.06.2022.
//

import Foundation
import UIKit

class ChiaBlockchainManager {
    
    static let share = ChiaBlockchainManager()
 
    fileprivate let url = "https://chia.blockchain-list.store"
    
    private init(){}
    
    func logIn(_ fingerprint: Int, with complition: @escaping(LogIn) -> Void) {
        let method = "log_in"
        guard let url = URL(string: self.url + "/wallet/" + method) else { return }
        let parameters = ["fingerprint":fingerprint]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(LogIn.self, from: data)
 
                    complition(json)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func getPublicKeys() {
        let method = "get_public_keys"
        guard let url = URL(string: self.url + "/wallet/" + method) else { return }
        let parameters = ["":""]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    print(json)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func generateMnemonic(with complition: @escaping (ChiaGeneratingMnemonic) -> Void) {
        let method = "generate_mnemonic"
        guard let url = URL(string: self.url + "/wallet/" + method) else { return }
        let parameters = ["":""]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(ChiaGeneratingMnemonic.self, from: data)
                    DispatchQueue.main.async {
                        complition(json)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func addKey(_ mnemonicPhrase: [String],_ controller: UIViewController, with complition: @escaping (ChiaFingerPrint) -> Void) {

        let method = "add_key"
        guard let url = URL(string: self.url + "/wallet/" + method) else { return }
        let parameters = ["mnemonic":mnemonicPhrase, "type":"new_wallet"] as [String : Any]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        print(httpBody)
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(ChiaFingerPrint.self, from: data)
                    DispatchQueue.main.async {
                        complition(json)
                    }
                } catch {
                    DispatchQueue.main.async {
                        
                        AlertManager.share.seccessNewWallet(controller)
                        print(error.localizedDescription)
                    }
                }
            }
        }.resume()
    }
    
    func deleteAllKeys(){
        let method = "delete_all_keys"
        guard let url = URL(string: self.url + "/wallet/" + method) else { return }
        let parameters = ["":""]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(LogIn.self, from: data)
                    print(json.fingerprint)
                    print(json.success)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }

    func importMnemonic(_ mnemonicPhrase: [String], with complition: @escaping (ChiaFingerPrint) -> Void) {
        
        let method = "add_key"
        guard let url = URL(string: self.url + "/wallet/" + method) else { return }
        let parameters = ["mnemonic":mnemonicPhrase] as [String : Any]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(ChiaFingerPrint.self, from: data)
                    DispatchQueue.main.async {
                        complition(json)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func getPrivateKey(_ fingerPring: Int, with complition: @escaping (ChiaPrivate) -> Void) {
        let method = "get_private_key"
        guard let url = URL(string: self.url + "/wallet/" + method) else { return }
        let parameters = ["fingerprint":fingerPring ] as [String : Any]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(ChiaPrivate.self, from: data)
                    DispatchQueue.main.async {
                        complition(json)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func getWallets(with complition: @escaping (ChiaWallets) -> Void) {
        let method = "get_wallets"
        guard let url = URL(string: self.url + "/wallet/" + method) else { return }
        let parameters = ["":""]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(ChiaWallets.self, from: data)
                    DispatchQueue.main.async {
                        print(json.success)
                        print(json.wallets)
                        complition(json)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func getNextAddress(walletID: Int64, with complition: @escaping (ChiaAdres) -> Void) {
        let method = "get_next_address"
        guard let url = URL(string: self.url + "/wallet/" + method) else { return }
        let parameters = ["wallet_id": walletID, "new_address":false] as [String : Any]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(ChiaAdres.self, from: data)
                        complition(json)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    
    
    func getWalletBalance(_ walletID: Int, with complition: @escaping (ChiaWalletBalance) -> Void) {
        let method = "get_wallet_balance"
        guard let url = URL(string: self.url + "/wallet/" + method) else { return }
        let parameters = ["wallet_id":walletID]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(ChiaWalletBalance.self, from: data)
                    DispatchQueue.global().async {
                        complition(json)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func getTransactions(_ walletID: Int, with complition: @escaping(ChiaTransactions) -> Void) {
        let method = "get_transactions"
        guard let url = URL(string: self.url + "/wallet/" + method) else { return }
        let parameters = ["wallet_id":walletID]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let decored = JSONDecoder()

                    let json = try decored.decode(ChiaTransactions.self, from: data)
                    complition(json)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func getCoinRecordsByPuzzleHash(adress: String, with complition: @escaping(CoinRecords) -> Void) {
        let method = "get_coin_records_by_puzzle_hash"
        let puzzleHash = adress.hashValue
        guard let url = URL(string: self.url + "/full-node/" + method) else { return }
        let parameters = ["puzzle_hash":"\(puzzleHash)", "include_spend_coins": false] as [String : Any]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(CoinRecords.self, from: data)
                    DispatchQueue.global().async {
                        complition(json)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    
}





