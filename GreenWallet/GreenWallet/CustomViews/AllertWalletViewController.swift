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
            self.transactionLabel.text = LocalizationManager.share.translate?.result.list.send_token.send_token_pop_up_succsess_title
            self.transactionDescription.text = LocalizationManager.share.translate?.result.list.send_token.send_token_pop_up_succsess_description
            self.mainButton.setTitle(LocalizationManager.share.translate?.result.list.all.ready_btn, for: .normal)
        }
    }


    func setupUI(label: String, discription: String) {
        self.mainLabel.text = label
        self.descriptionLabel.text = discription
    }
    
    @objc func closeAlert(notification: Notification) {
        self.dismiss(animated: false)
        
    }
  
    @IBAction func mainButtonPressed(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        let passwordStoryboard = UIStoryboard(name: "PasswordStoryboard", bundle: .main)
        let passwordVC = passwordStoryboard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
        passwordVC.modalPresentationStyle = .fullScreen
        passwordVC.index = self.index
        self.dismiss(animated: true)
        self.controller.present(passwordVC, animated: true)
        if self.isInMyWallet {
            NotificationCenter.default.post(name: NSNotification.Name("deleteInMyWallet"), object: nil)
        }
    }
    @IBAction func dismissButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
