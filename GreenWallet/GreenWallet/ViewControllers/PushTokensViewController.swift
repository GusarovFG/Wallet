//
//  PushTokensViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 12.05.2022.
//

import UIKit
import AVFoundation

class PushTokensViewController: UIViewController {
    
    private var video = AVCaptureVideoPreviewLayer()
    private let session = AVCaptureSession()
    private var wallet: ChiaWalletPrivateKey?
    private var wallets: [ChiaWalletPrivateKey] = []
    private var walletId = 1
    
    
    private let link = "qwertyuiopasdfghjkl"
    private let contact = "Faddey"
    
    @IBOutlet weak var tokenImage: UIImageView!
    @IBOutlet weak var tokenButton: UIButton!
    @IBOutlet weak var balanceButton: UIButton!
    @IBOutlet weak var balanceStackView: UIStackView!
    @IBOutlet weak var balanceViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var balaceStackViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var balanceView: UIView!
    @IBOutlet weak var systemButton: UIButton!
    @IBOutlet weak var linkOfWalletTextField: UITextField!
    @IBOutlet weak var transferTextField: UITextField!
    @IBOutlet weak var addContactLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var gadLabel: UILabel!
    @IBOutlet weak var comissionTextField: UITextField!
    @IBOutlet weak var recomendedComissionLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var walletStackView: UIStackView!
    @IBOutlet weak var walletStackViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var walletsView: UIView!
    @IBOutlet weak var walletErrorLabel: UILabel!
    @IBOutlet weak var transferErrorLabel: UILabel!
    @IBOutlet weak var transferViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondTransferErrorLabel: UILabel!
    @IBOutlet weak var transferView: UIView!
    @IBOutlet weak var walletAdressViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var checkboxButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var checkboxLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var transferTokenLabel: UILabel!
    @IBOutlet weak var walletLinkError: UILabel!
    @IBOutlet weak var systemView: UIView!
    @IBOutlet weak var systemChiaButton: UIButton!
    @IBOutlet weak var systemChivesButton: UIButton!
    
    @IBOutlet weak var transitionView: UIView!
    @IBOutlet weak var transitionTokenLabel: UILabel!
    @IBOutlet weak var transitionBlockchainLabel: UILabel!
    @IBOutlet weak var transitinSumLabel: UILabel!
    @IBOutlet weak var transitionLinkLabel: UILabel!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var transitionTokenTitle: UILabel!
    @IBOutlet weak var blockchainTitle: UILabel!
    @IBOutlet weak var summTitle: UILabel!
    @IBOutlet weak var arderLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var confirmTitle: UILabel!
    @IBOutlet weak var confitmBackButton: UIButton!
    @IBOutlet weak var qrBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        self.wallets = CoreDataManager.share.fetchChiaWalletPrivateKey()
        self.wallet = self.wallets.first
        self.balanceButton.setTitle("\((String((self.wallet?.balances as? [NSNumber])?[0] as! Double / 1000000000000.0)).prefix(8)) XCH", for: .normal)
        self.tokenButton.setTitle(self.wallet?.name, for: .normal)
        self.walletsView.isHidden = true
        
        self.walletErrorLabel.alpha = 0
        self.transferErrorLabel.alpha = 0
        self.secondTransferErrorLabel.alpha = 0
        self.contactLabel.isHidden = true
        self.walletLinkError.alpha = 0
        self.transitionView.isHidden = true
        self.transitionView.alpha = 0
        self.continueButton.isEnabled = false
        self.continueButton.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        
        self.contactTextField.bottomCorner()
        self.transferTextField.bottomCorner()
        self.comissionTextField.bottomCorner()
        self.adressTextField.bottomCorner()
        
        self.walletsView.layer.borderWidth = 1
        self.walletsView.layer.borderColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        
        self.balanceView.layer.borderWidth = 1
        self.balanceView.layer.borderColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        self.cameraView.isHidden = true
        
        self.systemView.layer.borderWidth = 1
        self.systemView.layer.borderColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        self.systemView.isHidden = true
        self.systemView.alpha = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(showSeccessAlert), name: NSNotification.Name(rawValue: "Seccess"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupWalletButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
    }
    
    private func localization() {
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
        self.walletErrorLabel.text = LocalizationManager.share.translate?.result.list.send_token.send_token_adress
        self.adressTextField.placeholder = LocalizationManager.share.translate?.result.list.send_token.send_token_adress
        self.contactLabel.text = LocalizationManager.share.translate?.result.list.send_token.send_token_name_of_adres
        self.contactTextField.placeholder = LocalizationManager.share.translate?.result.list.send_token.send_token_name_of_adres
        self.addContactLabel.text = LocalizationManager.share.translate?.result.list.send_token.send_token_add_address
        self.walletLinkError.text = LocalizationManager.share.translate?.result.list.all.non_existent_adress_error
        self.transferErrorLabel.text = LocalizationManager.share.translate?.result.list.send_token.send_token_amount
        self.transferTextField.placeholder = LocalizationManager.share.translate?.result.list.send_token.send_token_amount
        self.secondTransferErrorLabel.text = LocalizationManager.share.translate?.result.list.send_token.send_token_insufficient_funds_error
        self.comissionTextField.placeholder = LocalizationManager.share.translate?.result.list.send_token.send_token_commission_amount
        self.recomendedComissionLabel.text = LocalizationManager.share.translate?.result.list.send_token.send_token_commission_recommended
        self.continueButton.setTitle(LocalizationManager.share.translate?.result.list.all.next_btn, for: .normal)
        
        self.blockchainTitle.text = LocalizationManager.share.translate?.result.list.listing_request.listing_request_blockchain
        self.arderLabel.text = LocalizationManager.share.translate?.result.list.wallet.wallet_data_adress
        self.confirmButton.setTitle(LocalizationManager.share.translate?.result.list.all.confirm_btn, for: .normal)
        
        self.transitionTokenTitle.text = LocalizationManager.share.translate?.result.list.send_token.send_token_pop_up_confirmation_token
        self.blockchainTitle.text = LocalizationManager.share.translate?.result.list.send_token.send_token_pop_up_confirmation_blockchain
        self.summTitle.text = LocalizationManager.share.translate?.result.list.send_token.send_token_pop_up_confirmation_amount
        self.arderLabel.text = LocalizationManager.share.translate?.result.list.send_token.send_token_pop_up_confirmation_adress
        self.confirmButton.setTitle(LocalizationManager.share.translate?.result.list.all.confirm_btn, for: .normal)
        self.confirmTitle.text = LocalizationManager.share.translate?.result.list.send_token.send_token_pop_up_confirmation
        self.confitmBackButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
        
        self.qrBackButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
    }
    
    private func setupWalletButton() {
        self.tokenButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        let numbers = ("\(self.wallet?.fingerprint ?? 0)")
        var numberOfWallet = ""
        for numb in numbers {
            
            if numberOfWallet.count < numbers.count - 4 {
                numberOfWallet += "*"
            } else {
                numberOfWallet.append(numb)
            }
        }
        
        let buttonText: NSString = numberOfWallet + "\n\(self.wallet?.name?.split(separator: " ").first ?? "")" as NSString
        
        //getting the range to separate the button title strings
        let newlineRange: NSRange = buttonText.range(of: "\n")
        
        //getting both substrings
        var substring1 = ""
        var substring2 = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = buttonText.substring(to: newlineRange.location)
            substring2 = buttonText.substring(from: newlineRange.location)
        }
        
        //assigning diffrent fonts to both substrings
        let font1: UIFont = UIFont(name: "Arial", size: 12.0)!
        let attributes1 = [NSMutableAttributedString.Key.font: font1]
        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)
        
        let font2: UIFont = UIFont(name: "Arial", size: 18.0)!
        let attributes2 = [NSMutableAttributedString.Key.font: font2]
        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)
        
        attrString1.append(attrString2)
        
        self.tokenButton.setAttributedTitle(attrString1, for: [])
    }
    
    @objc func showSeccessAlert(notification: Notification) {
        self.transitionView.isHidden = true
        AlertManager.share.seccessSendToken(self)
    }
    
    
    @IBAction func systemButton(_ sender: UIButton) {
        if self.systemView.isHidden {
            UIView.animate(withDuration: 0.5) {
                self.systemView.isHidden = false
                self.systemView.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.systemView.alpha = 0
                self.systemView.isHidden = true
            }
        }
        
        if sender.titleLabel?.text == "Chia Network" {
            self.systemChiaButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            self.systemChiaButton.titleLabel?.textColor = .white
            self.systemChivesButton.backgroundColor = .systemBackground
            self.systemChivesButton.titleLabel?.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        } else {
            self.systemChivesButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            self.systemChivesButton.titleLabel?.textColor = .white
            self.systemChiaButton.backgroundColor = .systemBackground
            self.systemChiaButton.titleLabel?.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        }
        
    }
    
    @IBAction func systemButtonsPressed(_ sender: UIButton) {
        self.systemButton.setTitle("Chia Network", for: .normal)
        self.systemChiaButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.systemChiaButton.titleLabel?.textColor = .white
        self.systemChivesButton.backgroundColor = .systemBackground
        self.systemChivesButton.titleLabel?.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.systemView.isHidden = true
    }
    
    @IBAction func systemChivesButtonPressed(_ sender: Any) {
        self.systemButton.setTitle("Chives Network", for: .normal)
        self.systemChivesButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.systemChivesButton.titleLabel?.textColor = .white
        self.systemChiaButton.backgroundColor = .systemBackground
        self.systemChiaButton.titleLabel?.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.systemView.isHidden = true
    }
    
    
    @IBAction func walletMenuOpen(_ sender: Any) {
        if self.walletsView.isHidden == true {
            self.walletsView.isHidden = false
        } else {
            self.walletsView.isHidden = true
            return
        }
        
        
        
        
        for i in 0...(self.wallets.count - 1) {
            if self.walletStackView.arrangedSubviews.count == self.wallets.count {
                break
            } else {
                var numberOfWallet = ""
                let numbers = ("\(self.wallets[i].fingerprint )")
                for numb in numbers {
                    
                    if numberOfWallet.count < numbers.count - 4 {
                        numberOfWallet += "*"
                    } else {
                        numberOfWallet.append(numb)
                    }
                }
                
                let wallet = self.wallets[i]
                let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.walletStackView.frame.width, height: 40))
                button.setTitle("\(wallet.name) \(numberOfWallet)", for: .normal)
                let prefixString = wallet.name?.split(separator: " ").first ?? ""
                let infixAttributedString = NSAttributedString(
                    string: "     \(numberOfWallet)",
                    attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4588235294, green: 0.4588235294, blue: 0.4588235294, alpha: 1), NSAttributedString.Key.font: UIFont(name: "System Font Regular", size: 12)!]
                )
                
                let attributedString = NSMutableAttributedString(string: String(prefixString))
                attributedString.append(infixAttributedString)
                
                button.setAttributedTitle(attributedString, for: .normal)
                button.contentHorizontalAlignment = .center
                
                self.walletStackView.addArrangedSubview(button)
                self.walletStackViewConstraint.constant += button.frame.height
                button.addTarget(self, action: #selector(setupWalletsMenuButtons), for: .touchUpInside)
                
            }
        }
    }
    
    @IBAction func balanceMenuOpen(_ sender: Any) {
        if self.balanceView.isHidden == true {
            self.balanceView.isHidden = false
            for i in 0..<((self.wallet?.wallets as! [NSNumber]).count) {
                if self.balanceStackView.arrangedSubviews.count == ((self.wallet?.wallets as! [NSNumber]).count) {
                } else {
                    let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.balanceStackView.frame.width, height: 40))
                    button.setTitle("\((String((self.wallet?.balances as? [NSNumber])?[i] as! Double / 1000000000000.0)).prefix(8)) XCH", for: .normal)
                    self.balanceStackView.addArrangedSubview(button)
                    self.balanceViewConstraint.constant += button.frame.height
                    self.balaceStackViewConstraint.constant += button.frame.height
                    button.addTarget(self, action: #selector(setupBalanceMenuButtons), for: .touchUpInside)
                    
                }
            }
        } else {
            self.balanceView.isHidden = true
            self.walletsView.isHidden = true
            self.balanceStackView.removeAllSubviews()
            self.balanceViewConstraint.constant = 0
            self.balaceStackViewConstraint.constant = 0
        }
    }
    
    @objc func setupWalletsMenuButtons(_ sender: UIButton) {
        for i in 0..<self.walletStackView.arrangedSubviews.count {
            self.walletStackView.arrangedSubviews[i].backgroundColor = .systemBackground
            if sender == self.walletStackView.arrangedSubviews[i] {
                self.wallet = self.wallets[i]
                self.tokenImage.image = UIImage(named: "LogoChia")!
                setupWalletButton()
                sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                self.balanceButton.setTitle("\((String((self.wallet?.balances as? [NSNumber])?[0] as! Double / 1000000000000.0)).prefix(8)) XCH", for: .normal)
                self.balanceView.isHidden = true
                self.walletsView.isHidden = true
                self.balanceStackView.removeAllSubviews()
                self.balanceViewConstraint.constant = 0
                self.balaceStackViewConstraint.constant = 0
            }
        }
    }
    
    @objc func setupBalanceMenuButtons(_ sender: UIButton) {
        for i in 0..<self.balanceStackView.arrangedSubviews.count {
            self.balanceStackView.arrangedSubviews[i].backgroundColor = .systemBackground
            if sender == self.balanceStackView.arrangedSubviews[i] {
                self.balanceButton.setTitle("\((String((self.wallet?.balances as? [NSNumber])?[i] as! Double / 1000000000000.0)).prefix(8)) XCH", for: .normal)
                sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                self.balanceView.isHidden = true
                self.walletsView.isHidden = true
                self.walletId = (i + 1)
            }
        }
    }
    
    @IBAction func CyrillicCheck(_ sender: UITextField) {
        guard let text = sender.text else { return }
        let engCharacters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM"
        let digits = "1234567890"
        sender.text = text.filter { engCharacters.contains($0) || digits.contains($0) }
        
        if sender.text != "" {
            self.walletErrorLabel.alpha = 1
            self.walletErrorLabel.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            self.walletLinkError.alpha = 0
            
        } else {
            self.walletErrorLabel.alpha = 0
            if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                sender.textColor = .black
            } else {
                sender.textColor = .white
            }
            
        }
        
        
    }
    
    @IBAction func linkCheck(_ sender: UITextField) {
        if sender.text != self.link && sender.text != "" {
            
        } else {
            
        }
    }
    
    @IBAction func contactCheck(_ sender: UITextField) {
        if sender.text == self.contact {
            self.walletLinkError.text = LocalizationManager.share.translate?.result.list.send_token.send_token_address_is_already_exist
            self.walletLinkError.textColor = #colorLiteral(red: 0.1176470588, green: 0.5764705882, blue: 1, alpha: 1)
            self.walletLinkError.alpha = 1
        } else if self.adressTextField.text != self.link {
            self.walletLinkError.textColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
            self.walletLinkError.text = LocalizationManager.share.translate?.result.list.all.non_existent_adress_error
        } else if self.adressTextField.text == "" {
            self.walletLinkError.alpha = 0
            
        }
    }
    
    @IBAction func transferSummCheck(_ sender: UITextField) {
        self.comissionTextField.text = sender.text
        self.transferTokenLabel.text = self.balanceButton.currentTitle?.filter{!$0.isNumber && !$0.isPunctuation}
        
    }
    
    @IBAction func checkBoxButtonPressed(_ sender: UIButton) {
        if sender.imageView?.image != UIImage(systemName: "checkmark.square.fill") {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            sender.tintColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            sender.backgroundColor = .white
            sender.imageView?.layer.cornerRadius = 5
            self.contactLabel.isHidden = false
            self.contactTextField.isHidden = false
            self.walletAdressViewConstraint.constant += 65
            self.checkboxLabelConstraint.constant += 65
            self.checkboxButtonConstraint.constant += 65
            self.contactTextField.text = "My Binance Wallet"
            
        } else {
            sender.setImage(UIImage(systemName: "squareshape.fill"), for: .normal)
            sender.imageView?.layer.cornerRadius = 5
            sender.tintColor = .white
            
            self.contactLabel.isHidden = true
            self.contactTextField.isHidden = true
            self.walletAdressViewConstraint.constant -= 65
            self.checkboxLabelConstraint.constant -= 65
            self.checkboxButtonConstraint.constant -= 65
            
        }
        
    }
    @IBAction func transferSuccsessCheck(_ sender: UITextField) {
        
        if sender.text != "" && self.adressTextField.text != "" {
            
            self.continueButton.isEnabled = true
            self.continueButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            self.transferErrorLabel.alpha = 1
            self.transferErrorLabel.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                sender.textColor = .black
            } else {
                sender.textColor = .white
            }
            self.secondTransferErrorLabel.alpha = 0
        } else {
            self.continueButton.isEnabled = false
            self.continueButton.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
            self.transferErrorLabel.alpha = 0
            
        }
    }
    
    @IBAction func confirmationButtonPressed(_ sender: Any) {
        let passwordStoryboard = UIStoryboard(name: "PasswordStoryboard", bundle: .main)
        let passwordVC = passwordStoryboard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
        passwordVC.modalPresentationStyle = .fullScreen
        self.present(passwordVC, animated: true)
    }
    
    @IBAction func contactsButtonPressed(_ sender: Any) {
        let contactsVC = storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
        contactsVC.modalPresentationStyle = .fullScreen
        contactsVC.isNotTabbar = true
        self.present(contactsVC, animated: true)
    }
    
    @IBAction func qrScanButtonPressed(_ sender: Any) {
        setupVideo()
        startRunning()
        self.cameraView.isHidden = false
    }
    
    @IBAction func qrScanBackButton(_ sender: Any) {
        self.cameraView.isHidden = true
        self.session.stopRunning()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        
        if (Double(self.transferTextField.text ?? "") ?? 0) <= NSString(string: self.balanceButton.currentTitle ?? "").doubleValue {
            self.secondTransferErrorLabel.alpha = 0
            self.transferErrorLabel.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        } else {
            self.secondTransferErrorLabel.alpha = 1
            self.transferErrorLabel.alpha = 1
            self.transferTextField.textColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
            self.transferErrorLabel.textColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
        }
        
        if self.adressTextField.text == self.link  {
            
            self.walletLinkError.alpha = 0
            self.adressTextField.textColor = .white
            self.walletErrorLabel.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            
            
            self.transitionTokenLabel.text = "XCH"
            self.transitionBlockchainLabel.text = self.wallet?.name
            self.transitinSumLabel.text = self.transferTextField.text
            self.transitionLinkLabel.text = self.adressTextField.text
        } else {
            self.walletLinkError.alpha = 1
            self.adressTextField.textColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
            self.walletErrorLabel.textColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
        }
        if (Double(self.transferTextField.text ?? "") ?? 0) < Double(self.balanceButton.currentTitle?.split(separator: " ").first ?? "0") ?? 0 {
            let storyoard = UIStoryboard(name: "spinner", bundle: .main)
            let spinnerVC = storyoard.instantiateViewController(withIdentifier: "spinner") as! SprinnerViewController
            
            self.present(spinnerVC, animated: true)
            DispatchQueue.global().sync {
                
                ChiaBlockchainManager.share.logIn(Int(self.wallet?.fingerprint ?? 0)) { log in
                    if log.success {
                        ChiaBlockchainManager.share.getSyncStatus(self.walletId) { status in
                            if status.synced {
                                DispatchQueue.main.sync {
                                    
                                    ChiaBlockchainManager.share.sendTransactions(self.walletId, amount: Double(self.transferTextField.text!)!, fee: Double(self.comissionTextField.text!)!, address: self.adressTextField.text!) { 
                                        
                                        
                                        DispatchQueue.main.async {
                                            self.transitionView.isHidden = false
                                            self.transitionView.alpha = 1
                                            spinnerVC.dismiss(animated: true)
                                        }
                                    }
                                }
                            } else {
                                DispatchQueue.main.async {
                                    spinnerVC.dismiss(animated: true)
                                    print("хуй там")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func transitionBackButtomPressed(_ sender: Any) {
        self.transitionView.isHidden = true
    }
}
extension PushTokensViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    
    func setupVideo() {
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        } catch {
            fatalError(error.localizedDescription)
        }
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = self.cameraView.layer.bounds
    }
    
    func startRunning() {
        self.cameraView.layer.addSublayer(video)
        self.session.startRunning()
    }
    
    
    
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard metadataObjects.count > 0 else { return }
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            if object.type == AVMetadataObject.ObjectType.qr {
                self.adressTextField.text = object.stringValue
                self.cameraView.isHidden = true
            }
        }
    }
    
    
}


