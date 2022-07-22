//
//  GreatingViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 24.05.2022.
//
import LocalAuthentication
import UIKit
import UserNotifications

class GreatingViewController: UIViewController {
    
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SystemsManager.share.getSystems()
        print(CoreDataManager.share.fetchChiaWalletPrivateKey())
        NetworkManager.share.getTails { tails in
            TailsManager.share.tails = tails
            print("-------------------   ---\(tails)")
        }
        
        NetworkManager.share.getTailsPrices { prices in
            TailsManager.share.prices = prices.result.list
        }
        
        NetworkManager.share.getCoinInfo { info in
            AgreesManager.share.agrees = info.result.list
        }
        
        if UserDefaultsManager.shared.userDefaults.string(forKey: UserDefaultsStringKeys.firstSession.rawValue) != "First" {
            NetworkManager.share.getExchangeRates { rates in
                let rate = rates
                ExchangeRatesManager.share.newRatePerDollar = rate.chia.usd
                ExchangeRatesManager.share.newChivesRatePerDollar = rate.chives_сoin.usd
                CoreDataManager.share.saveExchangedRates(ratePerDollar: rate.chia.usd)
                CoreDataManager.share.saveChivesExchangedRates(ratePerDollar: rate.chives_сoin.usd )
                print(ExchangeRatesManager.share.newRatePerDollar = rate.chia.usd)
                print(ExchangeRatesManager.share.newChivesRatePerDollar = rate.chives_сoin.usd)
            }
            
           
        } else {
            NetworkManager.share.getExchangeRates { rates in
                let rate = rates
                ExchangeRatesManager.share.newRatePerDollar = rate.chia.usd
                ExchangeRatesManager.share.newChivesRatePerDollar = rate.chives_сoin.usd
                ExchangeRatesManager.share.oldRatePerDollar = CoreDataManager.share.fetchExchangeRates()
                ExchangeRatesManager.share.oldChivesRatePerDollar = CoreDataManager.share.fetchChivesExchangeRates()
                ExchangeRatesManager.share.differenceСalculation()
                ExchangeRatesManager.share.differenceChivesСalculation()
                
                CoreDataManager.share.saveExchangedRates(ratePerDollar: rate.chia.usd)
                CoreDataManager.share.saveChivesExchangedRates(ratePerDollar: rate.chives_сoin.usd )
                

            }

        }
        
        
        if UserDefaultsManager.shared.userDefaults.string(forKey: UserDefaultsStringKeys.firstSession.rawValue) != "First" {
            self.showPermissions()
            UserDefaultsManager.shared.userDefaults.set("First", forKey: UserDefaultsStringKeys.firstSession.rawValue)
        } else {
            self.dismissController()
        }
        
        
        switch TimeManager.share.getTime() {
        case 6..<12:
            self.backGroundImage.image = UIImage(named: "goodMorning")!
            self.mainTitle.text = LocalizationManager.share.translate?.result.list.welcome_screen.welcome_screen_titel_morning
        case 12..<18:
            self.backGroundImage.image = UIImage(named: "goodDay")!
            self.mainTitle.text = LocalizationManager.share.translate?.result.list.welcome_screen.welcome_screen_titel_afternoon
            self.mainTitle.textColor = .black
        case 18..<23:
            self.backGroundImage.image = UIImage(named: "goodevening")!
            self.mainTitle.text = LocalizationManager.share.translate?.result.list.welcome_screen.welcome_screen_titel_evening
            
        default:
            self.backGroundImage.image = UIImage(named: "goodNight")!
            self.mainTitle.text = LocalizationManager.share.translate?.result.list.welcome_screen.welcome_screen_titel_night
            
        }
        
        
        
    }
    
    private func showPermissions() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound, .badge]) { (granted, error) in
                    
                    guard granted else { return }
                    UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                        print(settings)
                        guard settings.authorizationStatus == .authorized else { return }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            
                            
                            UIView.animate(withDuration: 5, delay: 0) {
                                self.view.alpha = 0
                            }
                            
                            NotificationCenter.default.post(name: NSNotification.Name("setupRootVC"), object: nil)
                            
                            
                        }
                    }
                }
                
            }
        } else {
            let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    private func dismissController() {
        
        if UserDefaultsManager.shared.userDefaults.string(forKey: UserDefaultsStringKeys.walletExist.rawValue) == "Exist" {
            
            
            //            DispatchQueue.global().async {
            //                ChiaBlockchainManager.share.logIn(Int(CoreDataManager.share.fetchChiaWalletPrivateKey().fingerprint))
            //                ChiaBlockchainManager.share.getWallets { wallets in
            //                    ChiaWalletsManager.share.wallets = wallets
            //                    print(wallets)
            //                    ChiaBlockchainManager.share.getWalletBalance(1) { balance in
            //                        print(balance.wallet_balance.max_send_amount)
            //                        ChiaWalletsManager.share.balance = balance
            //                    }
            //
            //                }
            
            WalletManager.share.favoritesWallets = CoreDataManager.share.fetchChiaWalletPrivateKey()
            WalletManager.share.vallets = CoreDataManager.share.fetchChiaWalletPrivateKey()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                NotificationCenter.default.post(name: NSNotification.Name("setupRootVC"), object: nil)
            }
            //            }
            
        } else {
            WalletManager.share.favoritesWallets = CoreDataManager.share.fetchChiaWalletPrivateKey()
            WalletManager.share.vallets = CoreDataManager.share.fetchChiaWalletPrivateKey()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                
                
                UIView.animate(withDuration: 5, delay: 0) {
                    self.view.alpha = 0
                }
                
                NotificationCenter.default.post(name: NSNotification.Name("setupRootVC"), object: nil)
                
                
            }
            
        }
    }
}
