//
//  NetworkManager.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 25.05.2022.
//

import Foundation
import SwiftyJSON

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
    
    func getExchangeRates(complition: @escaping (NewRates) -> Void) {
        guard let url = URL(string: MainURLS.ExchangeRates.rawValue) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                
                let json = try JSONDecoder().decode(NewRates.self, from: data)
                
                DispatchQueue.main.async {
                    complition(json)
                    
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }.resume()
    }
    
    
    func getFAQ(complition: @escaping ([[String]]) -> Void) {
        guard let url = URL(string: "https://greenapp.siterepository.ru/api/v1.0/faq?code=\(CoreDataManager.share.fetchLanguage()[0].languageCode ?? "")") else { return }
        let session = URLSession.shared
        var questions: [String] = []
        var answers: [String] = []
        var questionsDictionary: [[String]] = []
        
        
        session.dataTask(with: url) { data, response, error in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let jsonQuestions = json["result"]["list"]
                    
                    for i in jsonQuestions {
                        jsonQuestions[i.0].forEach { (s, j) in
                            questions.append(j["question"].rawValue as! String)
                            answers.append(j["answer"].rawValue as! String)
                        }
                    }
                    
                    questionsDictionary.append(questions)
                    questionsDictionary.append(answers)
                    complition(questionsDictionary)
                    
                } catch {
                    print("Can't parse responce.")
                }
            }
            
        }.resume()
        
       
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
    
    func getPushNotifications(complition: @escaping (PushNotifications) -> Void) {
        guard let url = URL(string: "\(MainURLS.PushNotifications.rawValue)?code=\(CoreDataManager.share.fetchLanguage()[0].languageCode ?? "")") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                
                let json = try JSONDecoder().decode(PushNotifications.self, from: data)
                
                DispatchQueue.main.async {
                    complition(json)
                }
            } catch {
                print(error.localizedDescription)
                
            }
        }.resume()
    }
    
    func getAgreement(complition: @escaping (Agreement) -> Void) {
        guard let url = URL(string: "\(MainURLS.Agreement.rawValue)?code=\(CoreDataManager.share.fetchLanguage()[0].languageCode ?? "en")") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                
                let json = try JSONDecoder().decode(Agreement.self, from: data)
                
                DispatchQueue.main.async {
                    complition(json)
                }
            } catch {
                print(error.localizedDescription)
                
            }
        }.resume()
    }
    
    func getTails(complition: @escaping (Tails) -> Void) {
        guard let url = URL(string: MainURLS.tails.rawValue) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                
                let json = try JSONDecoder().decode(Tails.self, from: data)
                
                DispatchQueue.main.async {
                    print("хвосты")
                    complition(json)
                }
            } catch {
                print(error.localizedDescription)
                
            }
        }.resume()
    }
    
    func getTailsPrices(complition: @escaping (TailsPrices) -> Void) {
        guard let url = URL(string: MainURLS.TailsPrices.rawValue) else { return }
        print("цены")
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                
                let json = try JSONDecoder().decode(TailsPrices.self, from: data)
                
                DispatchQueue.main.async {
                    complition(json)
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
               

            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }.resume()
    }
    
    func getCoinInfo(complition: @escaping (CoinsInfo) -> Void) {
        guard let url = URL(string: "\(MainURLS.coinsInfo.rawValue)\(CoreDataManager.share.fetchLanguage()[0].languageCode ?? "en")") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                
                let json = try JSONDecoder().decode(CoinsInfo.self, from: data)
                
                DispatchQueue.main.async {
                    complition(json)
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                DispatchQueue.main.async {
                    
                    NotificationCenter.default.post(name: NSNotification.Name("alertErrorGerCodingKeys"), object: nil)
                }
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }.resume()
    }
    
    
}




enum MainURLS: String {
    case API = "https://greenapp.siterepository.ru/api/v1.0"
    case language = "https://greenapp.siterepository.ru/api/v1.0/localization/languages"
    case ExchangeRates = "https://api.coingecko.com/api/v3/simple/price?ids=chives-coin,chia&vs_currencies=usd&include_market_cap=true&include_24hr_vol=true&include_24hr_change=true"
    case systems = "https://greenapp.siterepository.ru/api/v1.0/blockchains"
    case listing = "https://greenapp.siterepository.ru/api/v1.0/listing"
    case question = "https://greenapp.siterepository.ru/api/v1.0/support"
    case faq = "https://greenapp.siterepository.ru/api/v1.0/faq"
    case PushNotifications = "https://greenapp.siterepository.ru/api/v1.0/notifications"
    case Agreement = "https://greenapp.siterepository.ru/api/v1.0/agreements"
    case tails = "https://greenapp.siterepository.ru/api/v1.0/tails?blockchain=Chia Network"
    case TailsPrices = "https://greenapp.siterepository.ru/api/v1.0/tails/price"
    case coinsInfo = "https://greenapp.siterepository.ru/api/v1.0/coins?code="
}


