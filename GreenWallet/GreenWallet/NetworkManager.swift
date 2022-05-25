//
//  NetworkManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 25.05.2022.
//

import Foundation

class NetworkManager {
    
    static let share = NetworkManager()
    
    private init(){}
    
    func getLocalization() {
        guard let url = URL(string: MainURLS.API.rawValue + "localization" + "/languages") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let json = try decoder.decode(Language.self, from: data)
                
                print(json)
            } catch {
                print(error)
            }

        }.resume()
        
    }
    

    
}

enum MainURLS: String {
    case API = "https://greenapp.siterepository.ru/api/v1.0/"
    case language = "https://greenapp.siterepository.ru/api/v1.0/localization/languages"
}
