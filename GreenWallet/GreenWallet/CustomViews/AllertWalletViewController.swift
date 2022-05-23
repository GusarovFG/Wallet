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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(closeAlert), name: NSNotification.Name("Seccess"), object: nil)
        
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
