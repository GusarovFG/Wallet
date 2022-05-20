//
//  PasswordViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 14.05.2022.
//

import UIKit
import AVFAudio
import LocalAuthentication

class PasswordViewController: UIViewController {
    
    var index = 0
    
    private var isEntering = false
    private var isRepitingPassword = false
    private var password = ""
    private var enteringPassword = ""
    private var repitingPassword = ""
    private var finalPassword = ""
    private var userInfo = ["seccsess": 0]
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var stackViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var dotsTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var dotsBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var faceIDButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleConstraint: NSLayoutConstraint!
    @IBOutlet weak var errorButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var discriptionTitle: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaultsManager.shared.userDefaults.string(forKey: UserDefaultsStringKeys.firstSession.rawValue) != "First" && !self.isRepitingPassword && !self.isEntering {
            self.mainButton.removeFromSuperview()
            self.stackViewConstraint.constant -= 120
            self.stackViewTopConstraint.constant += 120
            self.dotsTopConstraint.constant += 120
            self.dotsBottomConstraint.constant -= 120
            self.faceIDButton.alpha = 0
            self.faceIDButton.isEnabled = false
            
            self.discriptionTitle.text = "Используйте код-пароль котрый вы точно не забудете"
            self.mainTitle.text = "Создайте код - пароль"
            self.errorLabel.text = "Пароль должен содержать 6 цифр"
        }
        
        self.backButton.isHidden = true
        self.password = Password.sahre.password
        self.stackView.arrangedSubviews.forEach { view in
            view.layer.cornerRadius = view.frame.height / 2
            view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
            view.layer.borderWidth = 2
            view.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        
        
        
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func enterIngDigit(_ sender: UIButton) {
        
        
        
        if self.enteringPassword.count < 6  {
            self.enteringPassword += (sender.titleLabel?.text)!
            self.stackView.arrangedSubviews[self.enteringPassword.count - 1].backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            self.stackView.arrangedSubviews[self.enteringPassword.count - 1].layer.borderWidth = 0
            print(self.enteringPassword)
            print(self.repitingPassword)
        }
        
        if UserDefaultsManager.shared.userDefaults.string(forKey: UserDefaultsStringKeys.firstSession.rawValue) != "First" && !self.isRepitingPassword && !self.isEntering {
            if self.enteringPassword.count == 6 && !self.isRepitingPassword {
                self.isRepitingPassword = true
                self.repitingPassword = self.enteringPassword
                
                self.enteringPassword = ""
                
                self.mainTitle.text = "Повторите код - пароль"
                self.discriptionTitle.text = "Повторите пароль введенный раннее"
                self.errorLabel.text = "Данный пароль отличается от предыдущего"
                self.stackView.arrangedSubviews.forEach { view in
                    view.layer.cornerRadius = view.frame.height / 2
                    view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
                    view.layer.borderWidth = 2
                    view.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
            }
        }
        if UserDefaultsManager.shared.userDefaults.string(forKey: UserDefaultsStringKeys.firstSession.rawValue) != "First" && self.isRepitingPassword && !self.isEntering {
            
            if self.enteringPassword.count == 6 && self.repitingPassword == self.enteringPassword {
                print("qw;ljkaw")
                self.isEntering = true
                self.finalPassword = enteringPassword
                self.enteringPassword = ""
                self.mainTitle.text = "Введите пароль"
//                self.titleConstraint.constant += 52.5
                self.errorButtonConstraint.constant = 0
                self.errorLabel.alpha = 0
                self.stackView.arrangedSubviews.forEach { view in
                    view.layer.cornerRadius = view.frame.height / 2
                    view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
                    view.layer.borderWidth = 2
                    view.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    
                }
            }
            
        }
        
        if UserDefaultsManager.shared.userDefaults.string(forKey: UserDefaultsStringKeys.firstSession.rawValue) != "First" && self.isRepitingPassword && self.isEntering {
            if self.enteringPassword.count == 6  {
                if self.finalPassword == self.enteringPassword {
                            UserDefaultsManager.shared.userDefaults.set("First", forKey: UserDefaultsStringKeys.firstSession.rawValue)
                            let storyboard = UIStoryboard(name: "Main", bundle: .main)
                            let mainTabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
                            self.view.window?.rootViewController = mainTabBarVC
                    self.dismiss(animated: true)
                }
            }
        } else if self.enteringPassword == self.password && UserDefaultsManager.shared.userDefaults.string(forKey: UserDefaultsStringKeys.firstSession.rawValue) == "First" && !self.isRepitingPassword && !self.isEntering {
            self.dismiss(animated: true)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Seccess"), object: nil, userInfo: self.userInfo)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeAlert"), object: nil)
        } else {
            if self.enteringPassword.count == self.password.count {
                self.errorLabel.alpha = 1
            } else {
                self.errorLabel.alpha = 0
            }
        }
        
        
    }
    
    @IBAction func deleteLastDigit(_ sender: Any) {
        if self.enteringPassword.count > 0 {
            self.stackView.arrangedSubviews[self.enteringPassword.count - 1].backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
            self.stackView.arrangedSubviews[self.enteringPassword.count - 1].layer.borderWidth = 2
            self.stackView.arrangedSubviews[self.enteringPassword.count - 1].layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.enteringPassword.removeLast()
        }
    }
    
    @IBAction func faceIDButtonPressed(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self?.dismiss(animated: true)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Seccess"), object: nil, userInfo: self?.userInfo)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeAlert"), object: nil)
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
