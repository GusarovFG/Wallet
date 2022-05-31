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
    
    func getLocalization(from url: String?, with complition: @escaping (Language) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
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
                
                print(json.result.version)
                DispatchQueue.main.async {
                    complition(json)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getTranslate(from url: String, languageCode: String, with complition: @escaping (ListOfTranslate) -> Void) {
        guard let url = URL(string: "\(url)/localization/translate?code=\(languageCode)") else { return }
        print(url)
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            print(data)
            do {
               
                let json = try JSONDecoder().decode(ListOfTranslate.self, from: data)
                
                DispatchQueue.main.async {
                    complition(json)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}

enum MainURLS: String {
    case API = "https://greenapp.siterepository.ru/api/v1.0"
    case language = "https://greenapp.siterepository.ru/api/v1.0/localization/languages"
}


