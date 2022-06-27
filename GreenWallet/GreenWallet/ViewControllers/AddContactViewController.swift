//
//  AddContactViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 01.06.2022.
//

import UIKit

class AddContactViewController: UIViewController {
    
    var contact: Contact?
    var isEditingContact = false
    var index = 0
    
    private var adres = "qwertyuiopasdfghjkl"
    
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactNameTextField: UITextField!
    @IBOutlet weak var contactAdresLabel: UILabel!
    @IBOutlet weak var contactAdresTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var descriptinLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var addContactButton: UIButton!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textViewheight: NSLayoutConstraint!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var backutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRightButtonInTextField()
        licalization()
        
        self.errorLabel.alpha = 0
        self.addContactButton.isEnabled = false
        self.addContactButton.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        self.contactNameTextField.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        self.contactAdresTextField.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        
        if self.isEditingContact {
            self.contactAdresTextField.isEnabled = false
            self.contactAdresLabel.textColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
            self.contactAdresTextField.textColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
            
            self.contactNameTextField.text = self.contact?.name ?? ""
            self.contactAdresTextField.text = self.contact?.adres ?? ""
            self.descriptionTextField.text = self.contact?.descriptionOfContact ?? ""
            self.addContactButton.isEnabled = true
            self.addContactButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.6745098039, blue: 0.3490196078, alpha: 1)
            self.mainTitle.text = LocalizationManager.share.translate?.result.list.address_book.address_book_edit_contact_title
            
            
        }
        self.descriptionTextField.isScrollEnabled = false
        self.descriptionTextField.sizeToFit()
//        
//        self.descriptionTextField.textContainer.maximumNumberOfLines = 3
//        self.descriptionTextField.textContainer.lineBreakMode = .byTruncatingTail
        NotificationCenter.default.addObserver(self, selector: #selector(backButtonPressed), name: NSNotification.Name("dismissAddContactVC"), object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func licalization() {
        self.errorLabel.text = LocalizationManager.share.translate?.result.list.address_book.address_book_wrong_adress_error
        self.contactNameLabel.text = LocalizationManager.share.translate?.result.list.address_book.address_book_add_contact_name
        self.contactNameTextField.placeholder = LocalizationManager.share.translate?.result.list.address_book.address_book_add_contact_name
        self.contactAdresTextField.placeholder = LocalizationManager.share.translate?.result.list.address_book.address_book_add_adress
        self.contactAdresLabel.text = LocalizationManager.share.translate?.result.list.address_book.address_book_add_adress
        self.descriptinLabel.text = LocalizationManager.share.translate?.result.list.address_book.address_book_add_contact_description
        
        self.addContactButton.setTitle(LocalizationManager.share.translate?.result.list.address_book.address_book_add_contact_add_btn, for: .normal)
        self.mainTitle.text = LocalizationManager.share.translate?.result.list.address_book.address_book_add_contact_title
        self.backutton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
    }
    
    private func setupRightButtonInTextField() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "qrscan")!, for: .normal)
        
        button.addTarget(self, action: #selector(presentQRScan), for: .touchUpInside)
        self.contactAdresTextField.rightView = button
        self.contactAdresTextField.rightViewMode = .always
        
    }
    
    @objc func presentQRScan() {
        let qrScanVC = storyboard?.instantiateViewController(withIdentifier: "QRScanViewController") as! QRScanViewController
        self.present(qrScanVC, animated: true)
    }
    @IBAction func checkTextFields(_ sender: UITextField) {
        if self.contactNameTextField.text != "" && self.contactAdresTextField.text != "" {
            self.addContactButton.isEnabled = true
            self.addContactButton.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.6745098039, blue: 0.3490196078, alpha: 1)
        } else {
            self.addContactButton.isEnabled = false
            self.addContactButton.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        }
    }
    
    @IBAction func hidingErrorLabel(_ sender: Any) {
        if self.errorLabel.alpha == 1 {
            self.errorLabel.alpha = 0
            self.contactAdresTextField.textColor = .white
            self.contactAdresTextField.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
            self.viewHeightConstraint.constant -= 20
        }
    }
    
    
    @IBAction @objc func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addContactButtonPressed(_ sender: Any) {
        if !self.isEditingContact {
            if self.contactAdresTextField.text != self.adres {
                self.errorLabel.alpha = 1
                self.contactAdresTextField.textColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 1)
                self.contactAdresTextField.buttonStroke(#colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 1))
                self.viewHeightConstraint.constant += 20
            } else {
                CoreDataManager.share.saveContact(self.contactNameTextField.text ?? "", adres: self.contactAdresTextField.text ?? "", description: self.descriptionTextField.text ?? "")
                AlertManager.share.seccessAddContect(self)
                
            }
        } else {
            if self.contactNameTextField.text != "" {
                CoreDataManager.share.editContact(index: self.index, name: self.contactNameTextField.text ?? "", adres: self.contactAdresTextField.text ?? "", description: self.descriptionTextField.text ?? "")
                AlertManager.share.seccessEditContact(self)
            }
        }
    }
    
}

extension AddContactViewController: UITextViewDelegate {
    
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
        
        return numberOfLines <= 3
    }
    
    
}
