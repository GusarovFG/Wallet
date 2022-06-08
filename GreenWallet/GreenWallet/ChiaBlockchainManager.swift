//
//  ChiaBlockchainManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 08.06.2022.
//

import Foundation

class ChiaBlockchainManager {
    
    static let share = ChiaBlockchainManager()
    
    fileprivate let url = "https://chia.blockchain-list.store/"
    
    private init(){}
    
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
    
    func generateMnemonic() {
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
                    let json = try JSONSerialization.jsonObject(with: data)
                    print(json)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    
    func addKey(_ mnemonicPhrase: [String]) {
        let importMnemonicPhrase: ImportMnemonic = ImportMnemonic(mnemonic: mnemonicPhrase, type: "new_wallet")
        let method = "add_key"
        guard let url = URL(string: self.url + "/wallet/" + method) else { return }
        let parameters = [importMnemonicPhrase]
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
    
    func getWalletBalance(_ walletID: Int) {
        let method = "get_wallet_balance"
        guard let url = URL(string: self.url + "/wallet/" + method) else { return }
        let parameters = ["wallet_id":"\(walletID)"]
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
    
    func getTransactions(_ walletID: Int) {
        let method = "get_transactions"
        guard let url = URL(string: self.url + "/wallet/" + method) else { return }
        let parameters = ["wallet_id":"\(walletID)"]
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
}


struct ImportMnemonic: Codable {
    var mnemonic: [String]
    var type: String
}

