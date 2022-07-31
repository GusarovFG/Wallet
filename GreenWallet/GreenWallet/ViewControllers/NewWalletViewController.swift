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
    var isFromImport = false
    
    private var agrees: [CoinsInfoResultList] = []
    
    
    @IBOutlet weak var creatingNewWalletView: UIView!
    @IBOutlet weak var agreeLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var createNewWalletButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var disctriptionLabel: UILabel!
    @IBOutlet weak var disctiption: UILabel!
    @IBOutlet weak var characteristicsTitle: UILabel!
    @IBOutlet weak var newWalletLAbel: UILabel!
    @IBOutlet weak var creatingNewWalletLabel: UILabel!
    @IBOutlet weak var systemImage: UIImageView!
    @IBOutlet weak var characteristicTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.agrees = AgreesManager.share.agrees
        self.creatingNewWalletView.isHidden = true
        self.creatingNewWalletView.alpha = 0
        
        self.createNewWalletButton.isEnabled = false
        self.createNewWalletButton.contentMode = .center
        localization()
        setupAgreeLabel()
        
        if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
            self.createNewWalletButton.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1)
        } else {
            self.createNewWalletButton.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        }
        
        
        
        if self.isChia || self.isChiaTest {
            self.systemImage.image = UIImage(named: "chia_logo")!
            self.titleLabel.text = "Chia Network"
        } else {
            self.systemImage.image = UIImage(named: "chives_logo")!
            self.titleLabel.text = "Chives Network"
        }
        
        if self.isFromImport {
            self.checkBoxButton.isHidden = true
            self.agreeLabel.isHidden = true
            self.createNewWalletButton.isHidden = true
        }
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.systemImage.layer.cornerRadius = self.systemImage.frame.width / 2
        self.systemImage.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.systemImage.layer.borderWidth = 2
        
        
        if self.isChia || self.isChiaTest {
            let char = self.agrees.filter({$0.blockchain_name.contains("Chia")}).first?.specification.replacingOccurrences(of: "\n", with: "\n• ")
            self.disctiption.text = self.agrees.filter({$0.blockchain_name.contains("Chia")}).first?.description
            self.characteristicTextView.text = char
        } else if self.isChives || self.isChivesTest  {
            let char = self.agrees.filter({$0.blockchain_name.contains("Chives")}).first?.specification.replacingOccurrences(of: "\n", with: "\n• ")
            self.disctiption.text = self.agrees.filter({$0.blockchain_name.contains("Chives")}).first?.description
            self.characteristicTextView.text = char
        }
        
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
        let split = self.agreeLabel.text?.split(separator: " ")
        var first = ""
        var second = ""
        
        for i in 0..<(split?.count ?? 0){
            if i + 1 == split?.count || i + 2 == split?.count || i + 3 == split?.count {
                second += " \(split?[i] ?? "")"
            } else {
                first += "\(split?[i] ?? "") "
            }
            
        }
        let prefixString = first
        let infixAttributedString = NSAttributedString(
            string: second,
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
