//
//  AllertWalletViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 04.05.2022.
//

import UIKit

class AllertWalletViewController: UIViewController {
    
    var controller = UIViewController()
    var index = 0
    var isInMyWallet = false
    var isContact = false
    var isEditingContact = false
    var isNewWalletError = false
    var isSendError = false
    var isImportMnemonicError = false
    var isAskAQuestion = false
    var isImport = false
    var isAllWallets = false
    var islisting = false
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var importTitle: UILabel!
    @IBOutlet weak var importDescription: UILabel!
    @IBOutlet weak var transactionLabel: UILabel!
    @IBOutlet weak var transactionDescription: UILabel!
    @IBOutlet weak var deleteTitle: UILabel!
    @IBOutlet weak var deleteDescription: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var wasDeletedTitle: UILabel!
    @IBOutlet weak var wasDeletedDescription: UILabel!
    @IBOutlet weak var confirmutton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        NotificationCenter.default.addObserver(self, selector: #selector(closeAlert), name: NSNotification.Name("Seccess"), object: nil)
        
        
    }
    
    private func localization() {
        if self.restorationIdentifier == "AllertWalletViewController" {
            self.mainLabel.text = LocalizationManager.share.translate?.result.list.mnemonic_phrase_verification.mnemonic_phrase_verification_pop_up_sucsess_title
            self.descriptionLabel.text = LocalizationManager.share.translate?.result.list.mnemonic_phrase_verification.mnemonic_phrase_verification_pop_up_sucsess_description
            self.mainButton.setTitle(LocalizationManager.share.translate?.result.list.all.ready_btn, for: .normal)
            
        } else if self.restorationIdentifier == "AllertImportViewController" {
            self.importTitle.text = LocalizationManager.share.translate?.result.list.import_tokens.import_mnemonics_pop_up_sucsess_title
            self.importDescription.text = LocalizationManager.share.translate?.result.list.import_mnemonics.import_mnemonics_pop_up_sucsess_description
            self.mainButton.setTitle(LocalizationManager.share.translate?.result.list.all.ready_btn, for: .normal)
            
        } else if self.restorationIdentifier == "DeleteWallet" {
            self.deleteTitle.text = LocalizationManager.share.translate?.result.list.all.delet_wallet_warning_title
            self.deleteDescription.text = LocalizationManager.share.translate?.result.list.all.delet_wallet_warning_description
            self.deleteButton.setTitle(LocalizationManager.share.translate?.result.list.all.confirm_btn, for: .normal)
            self.cancelButton.setTitle(LocalizationManager.share.translate?.result.list.all.return_btn, for: .normal)
            
        } else if self.restorationIdentifier == "DeletingAlert" {
            self.wasDeletedTitle.text = LocalizationManager.share.translate?.result.list.all.pop_up_wallet_removed_title
            self.wasDeletedDescription.text = LocalizationManager.share.translate?.result.list.all.pop_up_wallet_removed_description
            self.mainButton.setTitle(LocalizationManager.share.translate?.result.list.all.ready_btn, for: .normal)
        } else if self.restorationIdentifier == "seccsessTransitViewController" {
            if !self.isAskAQuestion {
                self.transactionLabel.text = LocalizationManager.share.translate?.result.list.send_token.send_token_pop_up_succsess_title
                self.transactionDescription.text = LocalizationManager.share.translate?.result.list.send_token.send_token_pop_up_succsess_description
                self.mainButton.setTitle(LocalizationManager.share.translate?.result.list.all.ready_btn, for: .normal)
            } else {
                self.transactionLabel.text = LocalizationManager.share.translate?.result.list.all.pop_up_sent_title
                self.transactionDescription.text = LocalizationManager.share.translate?.result.list.ask_a_question.pop_up_sent_a_question_description
                
            }
        } else if self.restorationIdentifier == "AddContactAlert" {
            self.wasDeletedTitle.text = LocalizationManager.share.translate?.result.list.address_book.address_book_pop_up_added_title
            if self.islisting {
                self.wasDeletedTitle.text = LocalizationManager.share.translate?.result.list.listing_request.listing_request_title
                self.wasDeletedDescription.text = LocalizationManager.share.translate?.result.list.listing_request.pop_up_listing_request_description
            } else if !self.isContact {
                self.wasDeletedDescription.text = LocalizationManager.share.translate?.result.list.address_book.address_book_pop_up_added_description
            } else if self.isContact {
                self.wasDeletedTitle.text = LocalizationManager.share.translate?.result.list.address_book.adress_book_pop_up_removed_title
                self.wasDeletedDescription.text = LocalizationManager.share.translate?.result.list.address_book.adress_book_pop_up_removed_description
            } else if isEditingContact {
                self.wasDeletedTitle.text = LocalizationManager.share.translate?.result.list.address_book.adress_book_edit_contact_pop_up_changed_title
                self.wasDeletedDescription.text = LocalizationManager.share.translate?.result.list.address_book.adress_book_edit_contact_pop_up_changed_description
            } 
            self.mainButton.setTitle(LocalizationManager.share.translate?.result.list.all.ready_btn, for: .normal)
        } else if self.restorationIdentifier == "DeleteContact" {
            if !self.isNewWalletError && !self.isSendError {
                self.deleteTitle.text = LocalizationManager.share.translate?.result.list.address_book.address_book_pop_up_delete_title
                self.deleteDescription.text = LocalizationManager.share.translate?.result.list.address_book.address_book_pop_up_delete_description
                self.confirmutton.setTitle(LocalizationManager.share.translate?.result.list.all.confirm_btn, for: .normal)
            } else if self.isNewWalletError && !self.isSendError {
                self.deleteTitle.text = LocalizationManager.share.translate?.result.list.create_a_mnemonic_phrase.pop_up_failed_create_a_mnemonic_phrase_title
                self.deleteDescription.text = LocalizationManager.share.translate?.result.list.all.pop_up_failed_error_description
                self.confirmutton.setTitle(LocalizationManager.share.translate?.result.list.all.pop_up_failed_error_return_btn, for: .normal)
            } else if self.isSendError && !self.isNewWalletError {
                self.deleteTitle.text = LocalizationManager.share.translate?.result.list.all.pop_up_failed_error_title
                self.deleteDescription.text = LocalizationManager.share.translate?.result.list.send_token.send_token_pop_up_transaction_fail_error_description
                self.confirmutton.setTitle(LocalizationManager.share.translate?.result.list.all.pop_up_failed_error_return_btn, for: .normal)
            } else if self.isImportMnemonicError {
                self.deleteTitle.text = LocalizationManager.share.translate?.result.list.import_mnemonics.pop_up_failed_import_mnemonics_title
                self.deleteDescription.text = LocalizationManager.share.translate?.result.list.all.pop_up_failed_error_description
                self.confirmutton.setTitle(LocalizationManager.share.translate?.result.list.all.pop_up_failed_error_return_btn, for: .normal)
            }
        }
    }
    
    @IBAction func dismissTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func setupUI(label: String, discription: String) {
        self.mainLabel.text = label
        self.descriptionLabel.text = discription
    }
    
    @objc func closeAlert(notification: Notification) {
        self.dismiss(animated: false)
        
    }
    
    @IBAction func mainButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("setupRootVC"), object: nil)
    }
    
    @IBAction func confirmDeleteContact(_ sender: Any) {
        if !self.isNewWalletError && !self.isSendError && !self.isImportMnemonicError {
            CoreDataManager.share.deleteContact(self.index)
            self.dismiss(animated: true)
            NotificationCenter.default.post(name: NSNotification.Name("showSpinner"), object: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                NotificationCenter.default.post(name: NSNotification.Name("deleteComplite"), object: nil)
            }
        } else {
            self.dismiss(animated: true)
        }
        
    }
    @IBAction func confirmButtonPressed(_ sender: Any) {
        if self.isInMyWallet {
            let passwordStoryboard = UIStoryboard(name: "PasswordStoryboard", bundle: .main)
            let passwordVC = passwordStoryboard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
            passwordVC.modalPresentationStyle = .fullScreen
            passwordVC.index = self.index
            self.dismiss(animated: true)
            self.controller.present(passwordVC, animated: true)
            
            NotificationCenter.default.post(name: NSNotification.Name("deleteInMyWallet"), object: nil)
        }
        
        if self.isAllWallets {
            let passwordStoryboard = UIStoryboard(name: "PasswordStoryboard", bundle: .main)
            let passwordVC = passwordStoryboard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
            passwordVC.modalPresentationStyle = .fullScreen
            passwordVC.index = self.index
            passwordVC.isAllWallets = true
            self.dismiss(animated: true)
            self.controller.present(passwordVC, animated: true)
            
        }
    }
    @IBAction func dismissButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
        if !self.isContact {
            NotificationCenter.default.post(name: NSNotification.Name("dismissAddContactVC"), object: nil)
        } else if self.islisting {
            NotificationCenter.default.post(name: NSNotification.Name("dismissVC"), object: nil)
        }
    }
    
    
}
