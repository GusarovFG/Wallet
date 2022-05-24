//
//  GreatingViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 24.05.2022.
//
import LocalAuthentication
import UIKit

class GreatingViewController: UIViewController {
    
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaultsManager.shared.userDefaults.string(forKey: UserDefaultsStringKeys.firstSession.rawValue) != "First" {
            
            UserDefaultsManager.shared.userDefaults.set("First", forKey: UserDefaultsStringKeys.firstSession.rawValue)
        }
        
        
        switch TimeManager.share.getTime() {
        case 6..<12:
            self.backGroundImage.image = UIImage(named: "goodMorning")!
            self.mainTitle.text = "Доброе утро!"
        case 12..<18:
            self.backGroundImage.image = UIImage(named: "goodDay")!
            self.mainTitle.text = "Добрый день!"
            self.mainTitle.textColor = .black
        case 18..<00:
            self.backGroundImage.image = UIImage(named: "goodevening")!
            self.mainTitle.text = "Добрый вечер!"
            
        default:
            self.backGroundImage.image = UIImage(named: "goodNight")!
            self.mainTitle.text = "Доброй ночи!"
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            
            
            UIView.animate(withDuration: 5, delay: 0) {
                self.view.alpha = 0
            }
            
            NotificationCenter.default.post(name: NSNotification.Name("setupRootVC"), object: nil)
            
            
        }
    }

    
}
