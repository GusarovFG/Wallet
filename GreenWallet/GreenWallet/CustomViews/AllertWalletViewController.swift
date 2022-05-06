//
//  AllertWalletViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 04.05.2022.
//

import UIKit

class AllertWalletViewController: UIViewController {

    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    func setupUI(label: String, discription: String) {
        self.mainLabel.text = label
        self.descriptionLabel.text = discription
    }
  
    @IBAction func mainButtonPressed(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
}
