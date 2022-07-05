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
    
    func getExchangeRates(complition: @escaping (ExchangeRates) -> Void) {
        guard let url = URL(string: MainURLS.ExchangeRates.rawValue) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }

            do {
                
                let json = try JSONDecoder().decode(ExchangeRates.self, from: data)
                
                DispatchQueue.main.async {
                    complition(json)
                }
            } catch {
                print(error.localizedDescription)
                
            }
        }.resume()
    }
    
    func getFAQ() {
        
    }
    
    func getSystems(complition: @escaping (Systems) -> Void) {
        guard let url = URL(string: MainURLS.systems.rawValue) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }

            do {
                
                let json = try JSONDecoder().decode(Systems.self, from: data)
                
                DispatchQueue.main.async {
                    complition(json)
                }
            } catch {
                print(error.localizedDescription)
                
            }
        }.resume()
    }
    
    func postListing(name: String, email: String, nameOfProject: String, descriptionOfProject: String, blockChain: String, twitter: String) {
        guard let url = URL(string: MainURLS.listing.rawValue) else { return }
       
        
        let parameters = ["name": name, "email": email, "project_name": nameOfProject, "description": descriptionOfProject, "blockchain": blockChain.lowercased(), "twitter": twitter]
       
        func postBody(params: [String: String]) -> Data? { // (K.3)
                var paramsArr: [String] = []
                for (key, value) in params {
                    paramsArr.append("\(key)=\(value)")
                }
                let postBodyString: String = paramsArr.joined(separator: "&")
                let postBodyData: Data? = postBodyString.data(using: .utf8)
                return postBodyData
            }

            var request: URLRequest = URLRequest(url: url) // (K.4)
            request.httpMethod = "POST"
            request.httpBody = postBody(params: parameters)

           
        let task: URLSessionDownloadTask = URLSession.shared.downloadTask(with: request)
            task.resume()
    }
    
    func postQuestion(name: String, email: String, question: String) {
        guard let url = URL(string: MainURLS.question.rawValue) else { return }
       
        
        let parameters = ["name": name, "email": email, "question": question]
       
        func postBody(params: [String: String]) -> Data? { // (K.3)
                var paramsArr: [String] = []
                for (key, value) in params {
                    paramsArr.append("\(key)=\(value)")
                }
                let postBodyString: String = paramsArr.joined(separator: "&")
                let postBodyData: Data? = postBodyString.data(using: .utf8)
                return postBodyData
            }

            var request: URLRequest = URLRequest(url: url) // (K.4)
            request.httpMethod = "POST"
            request.httpBody = postBody(params: parameters)

           
        let task: URLSessionDownloadTask = URLSession.shared.downloadTask(with: request)
            task.resume()
    }
}




enum MainURLS: String {
    case API = "https://greenapp.siterepository.ru/api/v1.0"
    case language = "https://greenapp.siterepository.ru/api/v1.0/localization/languages"
    case ExchangeRates = "https://api.huobi.pro/market/tickers"
    case systems = "https://greenapp.siterepository.ru/api/v1.0/blockchains"
    case listing = "https://greenapp.siterepository.ru/api/v1.0/listing"
    case question = "https://greenapp.siterepository.ru/api/v1.0/support"
}


