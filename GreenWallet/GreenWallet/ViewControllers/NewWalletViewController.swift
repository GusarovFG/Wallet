//
//  NewWalletViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 02.05.2022.
//

import UIKit

class NewWalletViewController: UIViewController {
    
    var isChia = false
    var isChives = false
    var isChiaTest = false
    var isChivesTest = false
    var isMainScreen = false
    

    @IBOutlet weak var creatingNewWalletView: UIView!
    @IBOutlet weak var agreeLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var createNewWalletButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var disctriptionLabel: UILabel!
    @IBOutlet weak var disctiption: UILabel!
    @IBOutlet weak var characteristicsTitle: UILabel!
    @IBOutlet weak var emissionLabel: UILabel!
    @IBOutlet weak var praymanLabel: UILabel!
    @IBOutlet weak var iCOLabel: UILabel!
    @IBOutlet weak var stackingLAbel: UILabel!
    @IBOutlet weak var supportTokensLabel: UILabel!
    @IBOutlet weak var newWalletLAbel: UILabel!
    @IBOutlet weak var creatingNewWalletLabel: UILabel!
    @IBOutlet weak var systemImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.creatingNewWalletView.isHidden = true
        self.creatingNewWalletView.alpha = 0
        
        self.createNewWalletButton.isEnabled = false
        self.createNewWalletButton.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        self.createNewWalletButton.contentMode = .center
        
//        setupAgreeLabel()
        
        if self.isChia || self.isChiaTest {
            self.systemImage.image = UIImage(named: "LogoChia")!
            self.titleLabel.text = "Chia Network"
        } else {
            self.systemImage.image = UIImage(named: "ChivesLogo")!
            self.titleLabel.text = "Chives Network"
        }
        
        self.agreeLabel.addRangeGesture(stringRange: "условиями пользования") {
            let url = URL(string: "https://devushka.ru/upload/posts/a1797083197722a6b1ab8e2f4beb2b08.jpg")
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!, options: [:])
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localization()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.creatingNewWalletView.isHidden = true

    }
    
    private func localization() {
        self.newWalletLAbel.text = LocalizationManager.share.translate?.result.list.screen_for_creating_a_new_wallet.screen_for_creating_a_new_wallet_title
        self.creatingNewWalletLabel.text = LocalizationManager.share.translate?.result.list.screen_for_creating_a_new_wallet.screen_for_creating_a_new_wallet_description
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
        self.createNewWalletButton.setTitle(LocalizationManager.share.translate?.result.list.network_description.network_description_btn, for: .normal)
        self.agreeLabel.text = LocalizationManager.share.translate?.result.list.all.agreement_with_terms_of_use_chekbox
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
        
        self.creatingNewWalletView.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.creatingNewWalletView.alpha = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let creatingVC = self.storyboard?.instantiateViewController(withIdentifier: "MnemonicViewController") as! MnemonicViewController
            creatingVC.isChia = self.isChia
            creatingVC.isChiaTest = self.isChiaTest
            creatingVC.isChives = self.isChives
            creatingVC.isChivesTest = self.isChivesTest
            self.present(creatingVC, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
