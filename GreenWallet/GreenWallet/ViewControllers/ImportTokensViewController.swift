//
//  ImportTokensViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 27.04.2022.
//

import UIKit

class ImportTokensViewController: UIViewController {

    private var tokens = [System(name: "Green App Development", token: "GAD", image: UIImage(named: "emptyLogo")!), System(name: "Marmot", token: "MRT", image: UIImage(named: "emptyLogo")!), System(name: "Chia MEM", token: "CMM", image: UIImage(named: "emptyLogo")!), System(name: "USD Stable", token: "USDS", image: UIImage(named: "emptyLogo")!), System(name: "Gem NTF", token: "GEM", image: UIImage(named: "emptyLogo")!),  System(name: "Gem NTF", token: "GEM", image: UIImage(named: "emptyLogo")!), System(name: "Gem NTF", token: "GEM", image: UIImage(named: "emptyLogo")!), System(name: "Gem NTF", token: "GEM", image: UIImage(named: "emptyLogo")!), System(name: "Gem NTF", token: "GEM", image: UIImage(named: "emptyLogo")!)]
    
    @IBOutlet weak var numberOFWalletLabel: UILabel!
    @IBOutlet weak var addedWalletButton: UILabel!
    @IBOutlet weak var searchSystemBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "ImportTokensTableViewCell", bundle: nil), forCellReuseIdentifier: "importTokenCell")
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ImportTokensViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tokens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "importTokenCell", for: indexPath) as! ImportTokensTableViewCell
        let token = self.tokens[indexPath.row]
        cell.nameOfSystemLabel.text = token.name
        cell.tokensLabel.text = token.token
        cell.systemImage.image = token.image
        
        if token.name == "Green App Development" {
            cell.choiceSwitch.isOn = true
            cell.choiceSwitch.isEnabled = false
        } else if token.name == "USD Stable" {
            cell.choiceSwitch.isOn = true
            cell.choiceSwitch.isEnabled = false
        }
        
        cell.switchPressed = { [unowned self] in
            
            UIView.animate(withDuration: 3) {
                self.addedWalletButton.alpha = 1
            }
            UIView.animate(withDuration: 3) {
                self.addedWalletButton.alpha = 0
            }
        }
        
        return cell
    }
}
