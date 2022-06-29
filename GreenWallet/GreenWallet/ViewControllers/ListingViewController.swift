//
//  ListingViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 28.06.2022.
//

import UIKit

class ListingViewController: UIViewController {

    var isCheckBoxPressed = false
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var projectTextField: UITextField!
    @IBOutlet weak var descriptionOfProjectLabel: UILabel!
    @IBOutlet weak var descriptionOfProjectTextView: UITextView!
    @IBOutlet weak var blockChianLabel: UILabel!
    @IBOutlet weak var blockChainTextField: UITextField!
    @IBOutlet weak var twitterLable: UILabel!
    @IBOutlet weak var twitterTextField: UITextField!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var blockChainMenuButton: UIButton!
    @IBOutlet weak var blockChainMenuView: UIView!
    @IBOutlet weak var chiaButton: UIButton!
    @IBOutlet weak var chivesButton: UIButton!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var mainViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextfieldBottonConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomStroke: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.alpha = 0
        self.emailLabel.alpha = 0
        self.projectLabel.alpha = 0
        self.descriptionOfProjectLabel.alpha = 0
        self.blockChianLabel.alpha = 0
        self.twitterLable.alpha = 0
        
        self.descriptionOfProjectTextView.isScrollEnabled = false
        self.descriptionOfProjectTextView.sizeToFit()
        
        self.mainButton.isEnabled = false
        self.mainButton.backgroundColor = #colorLiteral(red: 0.3364975452, green: 0.3364975452, blue: 0.3364975452, alpha: 1)
        self.descriptionOfProjectTextView.backgroundColor = self.mainView.backgroundColor
        self.descriptionOfProjectTextView.textColor = .systemGray
        self.emailErrorLabel.isHidden = true
        
        if UIDevice.modelName.contains("iPhone 8") || UIDevice.modelName.contains("iPhone 12") || UIDevice.modelName.contains("iPhone 13") {
            self.bottomConstraint.constant = 20
        }
       
        
        localization()
        
        NotificationCenter.default.addObserver(self, selector: #selector(selfdismiss), name: NSNotification.Name("dismissVC"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.descriptionOfProjectTextView.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))

    }
    
    private func localization() {
        
        self.nameLabel.text = LocalizationManager.share.translate?.result.list.listing_request.listing_request_name
        self.nameTextField.placeholder = LocalizationManager.share.translate?.result.list.listing_request.listing_request_name
        self.emailLabel.text = LocalizationManager.share.translate?.result.list.listing_request.listing_request_e_mail
        self.emailTextField.placeholder = LocalizationManager.share.translate?.result.list.listing_request.listing_request_e_mail
        self.projectLabel.text = LocalizationManager.share.translate?.result.list.listing_request.listing_request_project_name
        self.projectTextField.placeholder = LocalizationManager.share.translate?.result.list.listing_request.listing_request_project_name
        self.descriptionOfProjectLabel.text = LocalizationManager.share.translate?.result.list.listing_request.listing_request_project_description
        self.descriptionOfProjectTextView.text = LocalizationManager.share.translate?.result.list.listing_request.listing_request_project_description
        self.blockChianLabel.text = LocalizationManager.share.translate?.result.list.listing_request.listing_request_blockchain
        self.blockChainTextField.placeholder = LocalizationManager.share.translate?.result.list.listing_request.listing_request_blockchain
        self.twitterLable.text = LocalizationManager.share.translate?.result.list.listing_request.listing_request_twitter
        self.twitterTextField.placeholder = LocalizationManager.share.translate?.result.list.listing_request.listing_request_twitter
        self.emailErrorLabel.text = LocalizationManager.share.translate?.result.list.all.non_existent_adress_error
        
        self.titleLabel.text = LocalizationManager.share.translate?.result.list.listing_request.listing_request_title
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
        self.termsLabel.text = LocalizationManager.share.translate?.result.list.all.personal_data_agreement_chekbox
        self.mainButton.setTitle(LocalizationManager.share.translate?.result.list.main_screen.main_screen_send_btn, for: .normal)
    }
    
    private func isValidEmail(testStr: String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    @objc private func selfdismiss() {
        self.dismiss(animated: true)
    }
    
    @IBAction func nameTextFieldChange(_ sender: UITextField) {
        if sender.text!.isEmpty {
            self.nameLabel.alpha = 0
        } else {
            self.nameLabel.alpha = 1
        }
    }
    
    @IBAction func emailTextFieldChanged(_ sender: UITextField) {
        if sender.text!.isEmpty {
            self.emailLabel.alpha = 0
        } else {
            self.emailLabel.alpha = 1
            self.emailLabel.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                sender.textColor = .black
            } else {
                sender.textColor = .white
            }
            self.bottomStroke.backgroundColor = #colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1)
            if !self.emailErrorLabel.isHidden {
                self.mainViewHeightConstraint.constant -= 20
                self.emailTextfieldBottonConstraint.constant -= 20
                self.emailErrorLabel.isHidden = true
            }
        }
    }
    
    @IBAction func projectNameTextFieldChanged(_ sender: UITextField) {
        if sender.text!.isEmpty {
            self.projectLabel.alpha = 0
        } else {
            self.projectLabel.alpha = 1
        }
    }
    
    @IBAction func blockChainTextFieldTapped(_ sender: UITextField) {
        if sender.text!.isEmpty {
            self.blockChianLabel.alpha = 0
        } else {
            self.blockChianLabel.alpha = 1
        }
    }
    
    @IBAction func twitterTextFieldChanged(_ sender: UITextField) {
        if sender.text!.isEmpty {
            self.twitterLable.alpha = 0
        } else {
            self.twitterLable.alpha = 1
        }
    }
    
    @IBAction func checkBoxButtonPressed(_ sender: UIButton) {
        if sender.imageView?.image != UIImage(systemName: "checkmark.square.fill") {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            sender.tintColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            sender.backgroundColor = .white
            sender.imageView?.layer.cornerRadius = 5
            self.isCheckBoxPressed = true
            if self.nameTextField.text != "" && self.emailTextField.text != "" && self.descriptionOfProjectTextView.text != "" && self.projectTextField.text != "" && self.blockChainTextField.text != "" {
                self.mainButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                self.mainButton.isEnabled = true
                
            } else {
                self.mainButton.backgroundColor = #colorLiteral(red: 0.3364975452, green: 0.3364975452, blue: 0.3364975452, alpha: 1)
                self.mainButton.isEnabled = false
            }
        } else {
            sender.setImage(UIImage(systemName: "squareshape.fill"), for: .normal)
            sender.imageView?.layer.cornerRadius = 5
            sender.tintColor = .white
            self.isCheckBoxPressed = false
            self.mainButton.backgroundColor = #colorLiteral(red: 0.3364975452, green: 0.3364975452, blue: 0.3364975452, alpha: 1)
            self.mainButton.isEnabled = false
        }
        
    }
    
    @IBAction func mainButtomTapped(_ sender: UIButton) {
        if !self.isValidEmail(testStr: self.emailTextField.text ?? "") {
            self.emailTextField.textColor = #colorLiteral(red: 1, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
            self.emailErrorLabel.isHidden = false
            self.bottomStroke.backgroundColor = #colorLiteral(red: 1, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
            self.emailLabel.textColor = #colorLiteral(red: 1, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
            self.mainViewHeightConstraint.constant += 20
            self.emailTextfieldBottonConstraint.constant += 20
        } else {
            AlertManager.share.seccessListing(controller: self)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func blockChainsMenuOpen(_ sender: UIButton) {
        if self.blockChainMenuView.isHidden {
            self.blockChainMenuView.isHidden = false
            
            self.blockChainMenuButton.setImage(UIImage(systemName: "chevron.up")!, for: .normal)
        } else {
            self.blockChainMenuView.isHidden = true
            self.blockChainMenuButton.setImage(UIImage(systemName: "chevron.down")!, for: .normal)
        }
    }
    
    @IBAction func selectChia(_ sender: UIButton) {
        self.blockChainTextField.text = self.chiaButton.titleLabel?.text ?? ""
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.blockChainMenuView.isHidden = true
        self.blockChainMenuButton.setImage(UIImage(systemName: "chevron.down")!, for: .normal)
        self.blockChianLabel.alpha = 1
        
        if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
            chivesButton.backgroundColor = .white
        } else {
            chivesButton.backgroundColor = .black
        }
    }
    
    @IBAction func selectChives(_ sender: UIButton) {
        self.blockChainTextField.text = self.chivesButton.titleLabel?.text ?? ""
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.blockChainMenuView.isHidden = true
        self.blockChainMenuButton.setImage(UIImage(systemName: "chevron.down")!, for: .normal)
        self.blockChianLabel.alpha = 1
        if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
            chiaButton.backgroundColor = .white
        } else {
            chiaButton.backgroundColor = .black
        }
    }
}
     
extension ListingViewController: UITextViewDelegate, UITextFieldDelegate {
    
    func sizeOfString (string: String, constrainedToWidth width: Double, font: UIFont) -> CGSize {
        return (string as NSString).boundingRect(with: CGSize(width: width,
                                                              height: .greatestFiniteMagnitude),
                                                 options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                 attributes: [NSAttributedString.Key.font: font],
                                                 context: nil).size
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        var textWidth = textView.frame.inset(by: textView.textContainerInset).width
        textWidth -= 2.0 * textView.textContainer.lineFragmentPadding
        
        let boundingRect = sizeOfString(string: newText, constrainedToWidth: Double(textWidth), font: textView.font!)
        let numberOfLines = boundingRect.height / textView.font!.lineHeight
        
        
        
        return numberOfLines <= 2
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.descriptionOfProjectLabel.alpha = 1
        if textView.textColor == .systemGray {
            textView.text = nil
            if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                textView.textColor = .black
            } else {
                textView.textColor = .white
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = LocalizationManager.share.translate?.result.list.listing_request.listing_request_project_description
            textView.textColor = .gray
        }
    }
}
