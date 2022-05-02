//
//  NewWalletViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 02.05.2022.
//

import UIKit

class NewWalletViewController: UIViewController {

    @IBOutlet weak var agreeLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var createNewWalletButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createNewWalletButton.isEnabled = false
        self.createNewWalletButton.backgroundColor = #colorLiteral(red: 0.6106664538, green: 0.6106664538, blue: 0.6106664538, alpha: 1)
        self.createNewWalletButton.contentMode = .center
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func checkBoxButtonPressed(_ sender: UIButton) {
        
        if sender.imageView?.image != UIImage(systemName: "checkmark.square.fill") {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            sender.tintColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            sender.backgroundColor = .white
            sender.imageView?.layer.cornerRadius = 5
            
            self.createNewWalletButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            self.createNewWalletButton.isEnabled = true
        } else {
            sender.setImage(UIImage(systemName: "squareshape.fill"), for: .normal)
            sender.imageView?.layer.cornerRadius = 5
            sender.tintColor = .white
            
            self.createNewWalletButton.backgroundColor = #colorLiteral(red: 0.6106664538, green: 0.6106664538, blue: 0.6106664538, alpha: 1)
            self.createNewWalletButton.isEnabled = false
        }
    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}