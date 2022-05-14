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
    
    private var password = ""
    private var enteringPassword = ""

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.password = Password.sahre.password
        
        self.stackView.arrangedSubviews.forEach { view in
            view.layer.cornerRadius = view.frame.height / 2
            view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
            view.layer.borderWidth = 2
            view.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
    }
    
    @IBAction func enterIngDigit(_ sender: UIButton) {
        if self.enteringPassword.count < 6 {
            self.enteringPassword += (sender.titleLabel?.text)!
            
            self.stackView.arrangedSubviews[self.enteringPassword.count - 1].backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            self.stackView.arrangedSubviews[self.enteringPassword.count - 1].layer.borderWidth = 0
            print(self.enteringPassword)
        }
        
        if self.enteringPassword == self.password {
            self.dismiss(animated: true)
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
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate to proceed.") { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    guard let error = error else { return }
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
