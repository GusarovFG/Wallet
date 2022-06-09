//
//  AskAQuestionViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 08.06.2022.
//

import UIKit

class AskAQuestionViewController: UIViewController {
    
    private var isCheckBoxPressed = false
    private let email = "gusarovfg@gmail.com"
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var textViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewConstraint: NSLayoutConstraint!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionTextView.backgroundColor = #colorLiteral(red: 0.246493727, green: 0.246493727, blue: 0.246493727, alpha: 1)
        localization()
        self.nameTextField.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        self.emailTextField.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        self.sendButton.backgroundColor = #colorLiteral(red: 0.3364975452, green: 0.3364975452, blue: 0.3364975452, alpha: 1)
        self.sendButton.isEnabled = false
        self.nameLabel.alpha = 0
        self.emailLabel.alpha = 0
        self.questionLabel.alpha = 0
        self.errorLabel.alpha = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    	
    private func localization() {
        self.mainTitle.text = LocalizationManager.share.translate?.result.list.ask_a_question.ask_a_question_title
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
        self.nameTextField.placeholder = LocalizationManager.share.translate?.result.list.ask_a_question.ask_a_question_name
        self.emailTextField.placeholder = LocalizationManager.share.translate?.result.list.ask_a_question.ask_a_question_e_mail
        self.termsLabel.text = LocalizationManager.share.translate?.result.list.all.personal_data_agreement_chekbox
        self.questionTextView.text = LocalizationManager.share.translate?.result.list.ask_a_question.ask_a_question_question
        self.questionTextView.textColor = .gray
        self.sendButton.setTitle(LocalizationManager.share.translate?.result.list.main_screen.main_screen_send_btn, for: .normal)
        self.nameLabel.text = LocalizationManager.share.translate?.result.list.ask_a_question.ask_a_question_name
        self.emailLabel.text = LocalizationManager.share.translate?.result.list.ask_a_question.ask_a_question_e_mail
        self.questionLabel.text = LocalizationManager.share.translate?.result.list.ask_a_question.ask_a_question_question
        self.errorLabel.text = LocalizationManager.share.translate?.result.list.all.non_existent_adress_error
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func sendBbuttonPressed(_ sender: UIButton) {
        if emailTextField.text != self.email {
            self.textViewTopConstraint.constant += 30
            self.viewConstraint.constant += 30
            self.errorLabel.textColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 1)
            self.errorLabel.alpha = 1
            self.emailLabel.textColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 1)
            self.emailTextField.textColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 1)
            self.emailTextField.buttonStroke(#colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 1))
        } else {
            AlertManager.share.seccessAskAQuestion(self)
        }
    }
    
    @IBAction func nameTextFieldCheck(_ sender: UITextField) {
        if sender.text != "" {
            self.nameLabel.alpha = 1
        } else {
            self.nameLabel.alpha = 0
        }
        
        if self.nameTextField.text != "" && self.emailTextField.text != "" && self.questionTextView.text != "" && self.isCheckBoxPressed && self.questionTextView.text != LocalizationManager.share.translate?.result.list.ask_a_question.ask_a_question_question {
            self.sendButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            self.sendButton.isEnabled = true
        } else {
            self.sendButton.backgroundColor = #colorLiteral(red: 0.3364975452, green: 0.3364975452, blue: 0.3364975452, alpha: 1)
            self.sendButton.isEnabled = false
        }
    }
    
    @IBAction func emailTextFieldCheck(_ sender: UITextField) {
        if sender.text != "" {
            self.emailLabel.alpha = 1
        } else {
            self.emailLabel.alpha = 0
        }
        
        if self.nameTextField.text != "" && self.emailTextField.text != "" && self.questionTextView.text != "" && self.isCheckBoxPressed && self.questionTextView.text != LocalizationManager.share.translate?.result.list.ask_a_question.ask_a_question_question {
            self.sendButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            self.sendButton.isEnabled = true
        } else {
            self.sendButton.backgroundColor = #colorLiteral(red: 0.3364975452, green: 0.3364975452, blue: 0.3364975452, alpha: 1)
            self.sendButton.isEnabled = false
        }
    }
    
    
    @IBAction func checkBoxPressed(_ sender: UIButton) {
        if sender.imageView?.image != UIImage(systemName: "checkmark.square.fill") {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            sender.tintColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            sender.backgroundColor = .white
            sender.imageView?.layer.cornerRadius = 5
            self.isCheckBoxPressed = true
            if self.nameTextField.text != "" && self.emailTextField.text != "" && self.questionTextView.text != "" {
                self.sendButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                self.sendButton.isEnabled = true
                
            } else {
                self.sendButton.backgroundColor = #colorLiteral(red: 0.3364975452, green: 0.3364975452, blue: 0.3364975452, alpha: 1)
                self.sendButton.isEnabled = false
            }
        } else {
            sender.setImage(UIImage(systemName: "squareshape.fill"), for: .normal)
            sender.imageView?.layer.cornerRadius = 5
            sender.tintColor = .white
            self.isCheckBoxPressed = false
            self.sendButton.backgroundColor = #colorLiteral(red: 0.3364975452, green: 0.3364975452, blue: 0.3364975452, alpha: 1)
            self.sendButton.isEnabled = false
        }

    }
}

extension AskAQuestionViewController: UITextViewDelegate, UITextFieldDelegate {

    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != "" && textView.text != LocalizationManager.share.translate?.result.list.ask_a_question.ask_a_question_question {
            self.questionLabel.alpha = 1
        } else {
            self.questionLabel.alpha = 0
        }
        
        if self.nameTextField.text != "" && self.emailTextField.text != "" && self.questionTextView.text != "" && self.isCheckBoxPressed && self.questionTextView.text != LocalizationManager.share.translate?.result.list.ask_a_question.ask_a_question_question {
            self.sendButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            self.sendButton.isEnabled = true
        } else {
            self.sendButton.backgroundColor = #colorLiteral(red: 0.3364975452, green: 0.3364975452, blue: 0.3364975452, alpha: 1)
            self.sendButton.isEnabled = false
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray {
            textView.text = nil
            textView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = LocalizationManager.share.translate?.result.list.ask_a_question.ask_a_question_question
            textView.textColor = .gray
        }
        
        if self.nameTextField.text != "" && self.emailTextField.text != "" && textView.text != "" && self.isCheckBoxPressed && self.questionTextView.text != LocalizationManager.share.translate?.result.list.ask_a_question.ask_a_question_question {
            self.sendButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            self.sendButton.isEnabled = true
        } else {
            self.sendButton.backgroundColor = #colorLiteral(red: 0.3364975452, green: 0.3364975452, blue: 0.3364975452, alpha: 1)
            self.sendButton.isEnabled = false
        }
    }
    
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
}