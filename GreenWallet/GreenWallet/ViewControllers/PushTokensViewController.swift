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
    private var wallet: Wallet?
    private var wallets: [Wallet] = []
    
    private let link = "qwertyuiopasdfghjkl"
    private let contact = "Faddey"
    
    @IBOutlet weak var tokenImage: UIImageView!
    @IBOutlet weak var tokenButton: UIButton!
    @IBOutlet weak var balanceButton: UIButton!
    @IBOutlet weak var balanceStackView: UIStackView!
    @IBOutlet weak var balanceViewConstraint: NSLayoutConstraint!
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
    
    @IBOutlet weak var transitionView: UIView!
    @IBOutlet weak var transitionTokenLabel: UILabel!
    @IBOutlet weak var transitionBlockchainLabel: UILabel!
    @IBOutlet weak var transitinSumLabel: UILabel!
    @IBOutlet weak var transitionLinkLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wallets = WalletManager.share.vallets
        self.wallet = self.wallets.first
        self.balanceButton.setTitle("\(self.wallet?.tokens[0].balance ?? 0) \(self.wallet?.tokens[0].token ?? "")", for: .normal)
        self.tokenButton.setTitle(self.wallet?.name, for: .normal)
        self.walletsView.isHidden = true
        
        self.walletErrorLabel.alpha = 0
        self.transferErrorLabel.alpha = 0
        self.secondTransferErrorLabel.alpha = 0
        self.contactLabel.isHidden = true
        self.walletLinkError.alpha = 0
        self.transitionView.isHidden = true

        self.contactTextField.bottomCorner()
        self.transferTextField.bottomCorner()
        self.comissionTextField.bottomCorner()
        self.linkOfWalletTextField.bottomCorner()
        self.adressTextField.bottomCorner()
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(showSeccessAlert), name: NSNotification.Name(rawValue: "Seccess"), object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupWalletButton()
    }
    
    private func setupWalletButton() {
        self.tokenButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        let qwe = ("\(self.wallet?.number ?? 0)")
        var numberOfWallet = ""
        for numb in qwe {
            
            if numberOfWallet.count < qwe.count - 4 {
                numberOfWallet += "*"
            } else {
                numberOfWallet.append(numb)
            }
        }
        
        let buttonText: NSString = numberOfWallet + "\n\(self.wallet?.name ?? "")" as NSString

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

            //appending both attributed strings
            attrString1.append(attrString2)

            //assigning the resultant attributed strings to the button
        self.tokenButton.setAttributedTitle(attrString1, for: [])
    }
    
    @objc func showSeccessAlert(notification: Notification) {
        let storyboard = UIStoryboard(name: "Alert", bundle: .main)
        let seccsessAlertVC = storyboard.instantiateViewController(withIdentifier: "seccsessTransitViewController") as! AllertWalletViewController
        self.transitionView.isHidden = true
        self.present(seccsessAlertVC, animated: true)
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
                let wallet = self.wallets[i]
                let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.walletStackView.frame.width, height: 40))
                button.setTitle(wallet.name, for: .normal)
                self.walletStackView.addArrangedSubview(button)
                self.walletStackViewConstraint.constant += button.frame.height
                button.addTarget(self, action: #selector(setupWalletsMenuButtons), for: .touchUpInside)
            }
        }
    }
    
    @IBAction func balanceMenuOpen(_ sender: Any) {
        if self.balanceView.isHidden == true {
            self.balanceView.isHidden = false
            for i in 0..<(self.wallet?.tokens.count)! {
                if self.balanceStackView.arrangedSubviews.count == (self.wallet?.tokens.count)! {
                } else {
                    let token = self.wallet?.tokens[i].token
                    let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.balanceStackView.frame.width, height: 40))
                    button.setTitle(token, for: .normal)
                    self.balanceStackView.addArrangedSubview(button)
                    self.balanceViewConstraint.constant += button.frame.height
                    button.addTarget(self, action: #selector(setupBalanceMenuButtons), for: .touchUpInside)
                }
            }
        } else {
            self.balanceView.isHidden = true
            return
        }
    }
    
    @objc func setupWalletsMenuButtons(_ sender: UIButton) {
        for i in 0..<self.walletStackView.arrangedSubviews.count {
            self.walletStackView.arrangedSubviews[i].backgroundColor = .systemBackground
            if sender == self.walletStackView.arrangedSubviews[i] {
                self.wallet = self.wallets[i]
                setupWalletButton()
                sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            }
        }
    }
    
    @objc func setupBalanceMenuButtons(_ sender: UIButton) {
        for i in 0..<self.balanceStackView.arrangedSubviews.count {
            self.balanceStackView.arrangedSubviews[i].backgroundColor = .systemBackground
            if sender == self.balanceStackView.arrangedSubviews[i] {
                self.balanceButton.setTitle("\(self.wallet?.tokens[i].balance ?? 0) \(self.wallet?.tokens[i].token ?? "")", for: .normal)
                sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            } else {
                return
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
            
        } else {
            self.walletErrorLabel.alpha = 0
        }
        
 
    }
    
    @IBAction func linkCheck(_ sender: UITextField) {
        if sender.text != self.link && sender.text != "" {
            self.walletLinkError.alpha = 1
            sender.textColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
            self.walletErrorLabel.textColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
        } else {
            self.walletLinkError.alpha = 0
            sender.textColor = .white
            self.walletErrorLabel.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        }
    }
    
    @IBAction func contactCheck(_ sender: UITextField) {
        if sender.text == self.contact {
            self.walletLinkError.text = "Адрес уже есть в адресной книге"
            self.walletLinkError.textColor = #colorLiteral(red: 0.1176470588, green: 0.5764705882, blue: 1, alpha: 1)
            self.walletLinkError.alpha = 1
        } else if self.adressTextField.text != self.link {
                self.walletLinkError.textColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
                self.walletLinkError.text = "Несуществующий адрес"
            } else if self.adressTextField.text == "" {
                self.walletLinkError.alpha = 0
            
        }
    }
    
    @IBAction func transferSummCheck(_ sender: UITextField) {
        self.comissionTextField.text = sender.text
        self.transferTokenLabel.text = self.balanceButton.currentTitle?.filter{!$0.isNumber && !$0.isPunctuation}
        if (Double(sender.text ?? "") ?? 0) > NSString(string: self.balanceButton.currentTitle ?? "").doubleValue && sender.text != ""{
            self.transferErrorLabel.alpha = 1
            self.transferErrorLabel.textColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
            self.secondTransferErrorLabel.alpha = 1
            sender.textColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
            self.transferViewConstraint.constant = 165
        } else if sender.text != "" {
            self.transferErrorLabel.alpha = 1
            self.transferErrorLabel.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            sender.textColor = .white
            self.secondTransferErrorLabel.alpha = 0
            self.transferViewConstraint.constant = 130
        } else {
            self.transferErrorLabel.alpha = 0
            sender.textColor = .white
            self.secondTransferErrorLabel.alpha = 0
            self.transferViewConstraint.constant = 130
        }
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
    @IBAction func transferSuccsessCheck(_ sender: Any) {
        if self.adressTextField.text == self.link && (Double(self.transferTextField.text ?? "") ?? 0) < NSString(string: self.balanceButton.currentTitle ?? "").doubleValue  {
            
            self.continueButton.isEnabled = true
        } else {
            self.continueButton.isEnabled = false
        }
    }
    
    
    @IBAction func contactsButtonPressed(_ sender: Any) {
    }
    
    @IBAction func qrScanButtonPressed(_ sender: Any) {
        startRunning()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        self.transitionView.isHidden = false
        self.transitionTokenLabel.text = self.wallet?.tokens[0].name
        self.transitionBlockchainLabel.text = self.wallet?.name
        self.transitinSumLabel.text = self.transferTextField.text
        self.transitionLinkLabel.text = self.adressTextField.text
        
    }
    @IBAction func transitionBackButtomPressed(_ sender: Any) {
        self.transitionView.isHidden = true

    }
    
}

extension PushTokensViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func setupVideo() {
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            self.session.addInput(input)
        } catch {
            fatalError(error.localizedDescription)
        }
        let output = AVCaptureMetadataOutput()
        self.session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        self.video = AVCaptureVideoPreviewLayer(session: self.session)
        self.video.frame = view.layer.bounds
    }
    
    func startRunning() {
        self.view.layer.addSublayer(video)
        self.session.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard metadataObjects.count > 0 else { return }
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            if object.type == AVMetadataObject.ObjectType.qr {
                self.linkOfWalletTextField.text = object.stringValue
                self.view.layer.sublayers?.removeLast()
                self.session.stopRunning()
            }
        }
    }
}
