//
//  SceneDelegate.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 25.04.2022.
//
import UIKit
import AudioToolbox

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var currentHour = 0
    private var currentMinutes = 0
    private var enterBackGroundHour = 0
    private var enterBackGroundMinutes = 0
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        
        
        if #available(iOS 12, *), UserDefaultsManager.shared.userDefaults.string(forKey: UserDefaultsStringKeys.theme.rawValue) == "dark" || UserDefaultsManager.shared.userDefaults.string(forKey: UserDefaultsStringKeys.theme.rawValue) == nil {
            self.window?.overrideUserInterfaceStyle = .dark
        } else if #available(iOS 12, *), UserDefaultsManager.shared.userDefaults.string(forKey: UserDefaultsStringKeys.theme.rawValue) == "light" {
            self.window?.overrideUserInterfaceStyle = .light
        }
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let startVC = storyboard.instantiateViewController(withIdentifier: "startVC")
        
        
        
        if UserDefaultsManager.shared.userDefaults.string(forKey: UserDefaultsStringKeys.firstSession.rawValue) == "First" {
           
            WalletManager.share.isUpdate = true
            WalletManager.share.updateBalances()
            let passwordStoryboard = UIStoryboard(name: "PasswordStoryboard", bundle: .main)
            let enterPasswordVC = passwordStoryboard.instantiateViewController(withIdentifier: "EnteringPasswordViewController") as! PasswordViewController
            enterPasswordVC.view.alpha = 0
            DispatchQueue.global().async {
                
                NetworkManager.share.getLocalization(from: MainURLS.language.rawValue) { language in
                    LanguageManager.share.language = language
                    print(language.result.version)
                    
                }
                
                NetworkManager.share.getTranslate(from: MainURLS.API.rawValue, languageCode: CoreDataManager.share.fetchLanguage()[0].languageCode ?? "") { translate in
                    LocalizationManager.share.translate = translate
                    DispatchQueue.main.async {
                        
                        self.window?.rootViewController = enterPasswordVC
                        enterPasswordVC.modalPresentationStyle = .fullScreen
                        
                        enterPasswordVC.viewDidLoad()
                        UIView.animate(withDuration: 1, delay: 0) {
                            enterPasswordVC.view.alpha = 1
                        }
                        
                    }
                }
            }
        } else {
            
            NetworkManager.share.getLocalization(from: MainURLS.language.rawValue) { language in
                LanguageManager.share.language = language
                DispatchQueue.main.async {
                    self.window?.rootViewController = startVC
                    UIView.animate(withDuration: 1, delay: 0) {
                        startVC.view.alpha = 1
                    }
                }
                
            }
            
        }
        
        
        
        UserDefaultsManager.shared.userDefaults.set(false, forKey: UserDefaultsStringKeys.hideWalletsBalance.rawValue)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setupRootVC), name: NSNotification.Name("setupRootVC"), object: nil)
        
    }
    
    @objc func setupRootVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let startVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
        self.window?.rootViewController = startVC
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        self.currentHour = self.timerOn().0 ?? 0
        self.currentMinutes = self.timerOn().1 ?? 0
        
        if (self.currentHour == self.enterBackGroundHour && self.currentMinutes - self.enterBackGroundMinutes >= 3) || (self.currentHour != self.enterBackGroundHour && self.currentMinutes - self.enterBackGroundMinutes >= 3) {
            let passwordStoryboard = UIStoryboard(name: "PasswordStoryboard", bundle: .main)
            self.window?.rootViewController = passwordStoryboard.instantiateViewController(withIdentifier: "EnteringPasswordViewController") as! PasswordViewController
        } else {
            return
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataManager.share.saveContext()
        self.enterBackGroundHour = self.timerOn().0 ?? 0
        self.enterBackGroundMinutes = self.timerOn().1 ?? 0
    }
    
    private func timerOn() -> (Int?, Int?) {
        
        let date = NSDate()
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date as Date)
        let hour = components.hour
        let minutes = components.minute
        
        return (hour, minutes)
    }
    
}

