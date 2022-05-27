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
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {


            UIView.animate(withDuration: 5, delay: 0) {
                self.view.alpha = 0
            }

            NotificationCenter.default.post(name: NSNotification.Name("setupRootVC"), object: nil)


        }
    }
}