//
//  TermsOfUseViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 25.04.2022.
//

import UIKit

class TermsOfUseViewController: UIViewController {
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var agreeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.continueButton.isEnabled = false
        self.continueButton.backgroundColor = #colorLiteral(red: 0.6106664538, green: 0.6106664538, blue: 0.6106664538, alpha: 1)
        self.checkBoxButton.contentMode = .center
        
        setupAgreeLabel()
        
        self.agreeLabel.addRangeGesture(stringRange: "условиями пользования") {
            let url = URL(string: "https://devushka.ru/upload/posts/a1797083197722a6b1ab8e2f4beb2b08.jpg")
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!, options: [:])
            }
        }
        

        
    }
    
    private func setupAgreeLabel() {
        let prefixString = "Я соглашаюсь с  "
        let infixAttributedString = NSAttributedString(
            string: "условиями пользования",
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)]
        )
        
        let attributedString = NSMutableAttributedString(string: prefixString)
        attributedString.append(infixAttributedString)
        
        self.agreeLabel.attributedText = attributedString
    }

    
    @IBAction func tappedOnCheckboxButton(_ sender: UIButton){
        if sender.imageView?.image != UIImage(systemName: "checkmark.square.fill") {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            sender.tintColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            sender.backgroundColor = .white
            sender.imageView?.layer.cornerRadius = 5
            
            self.continueButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            self.continueButton.isEnabled = true
        } else {
            sender.setImage(UIImage(systemName: "squareshape.fill"), for: .normal)
            sender.imageView?.layer.cornerRadius = 5
            sender.tintColor = .white
            
            self.continueButton.backgroundColor = #colorLiteral(red: 0.6106664538, green: 0.6106664538, blue: 0.6106664538, alpha: 1)
            self.continueButton.isEnabled = false
        }

    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        let passwordVC = storyboard?.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
        self.present(passwordVC, animated: true)

    }
    
}
