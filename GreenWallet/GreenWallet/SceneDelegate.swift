//
//  SceneDelegate.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 25.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
//        UserDefaultsManager.shared.userDefaults.set("First", forKey: UserDefaultsStringKeys.firstSession.rawValue)
        
        if #available(iOS 12, *), UserDefaultsManager.shared.userDefaults.string(forKey: UserDefaultsStringKeys.theme.rawValue) == "dark" || UserDefaultsManager.shared.userDefaults.string(forKey: UserDefaultsStringKeys.theme.rawValue) == nil {
            self.window?.overrideUserInterfaceStyle = .dark
        } else if #available(iOS 12, *), UserDefaultsManager.shared.userDefaults.string(forKey: UserDefaultsStringKeys.theme.rawValue) == "light" {
            self.window?.overrideUserInterfaceStyle = .light
        }
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let startVC = storyboard.instantiateViewController(withIdentifier: "startVC")
        
        let passwordStoryboard = UIStoryboard(name: "PasswordStoryboard", bundle: .main)
        let enterPasswordVC = passwordStoryboard.instantiateViewController(withIdentifier: "EnteringPasswordViewController") as! PasswordViewController
        enterPasswordVC.modalPresentationStyle = .fullScreen
        
        self.window?.rootViewController = enterPasswordVC
        enterPasswordVC.view.alpha = 0
        if UserDefaultsManager.shared.userDefaults.string(forKey: UserDefaultsStringKeys.firstSession.rawValue) == "First" {
            NetworkManager.share.getLocalization(from: MainURLS.language.rawValue) { language in
                LanguageManager.share.language = language
                print(language.result.version)
                
            }
            
            print("\(CoreDataManager.share.fetchLanguage().count) + ---------------------------------__-_-_--_-_-_----")
            NetworkManager.share.getTranslate(from: MainURLS.API.rawValue, languageCode: CoreDataManager.share.fetchLanguage()[0].languageCode ?? "") { translate in
                LocalizationManager.share.translate = translate
                enterPasswordVC.viewDidLoad()
                UIView.animate(withDuration: 1, delay: 0) {
                    enterPasswordVC.view.alpha = 1
                }
                
            }
        } else {
            
            NetworkManager.share.getLocalization(from: MainURLS.language.rawValue) { language in
                LanguageManager.share.language = language
                self.window?.rootViewController = startVC
                
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
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataManager.share.saveContext()
        DispatchQueue.main.asyncAfter(deadline: .now() + 180) {
            let passwordStoryboard = UIStoryboard(name: "PasswordStoryboard", bundle: .main)
            self.window?.rootViewController = passwordStoryboard.instantiateViewController(withIdentifier: "EnteringPasswordViewController") as! PasswordViewController
        }
    }
    
    
}

