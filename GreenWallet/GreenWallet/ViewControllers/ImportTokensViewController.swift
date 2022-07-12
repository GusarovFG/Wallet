//
//  ImportTokensViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 27.04.2022.
//

import UIKit

class ImportTokensViewController: UIViewController {
    
    var index = 0
    
    private var tokens: [TailsList] = []
    private var filteredTokens: [TailsList] = []
    private var prices: [TailsPricesResult] = []
    
    @IBOutlet weak var numberOFWalletLabel: UILabel!
    @IBOutlet weak var addedWalletLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "ImportTokensTableViewCell", bundle: nil), forCellReuseIdentifier: "importTokenCell")
        self.tokens = TailsManager.share.tails?.result.list ?? []
        self.prices = TailsManager.share.prices
        self.filteredTokens = self.tokens
        localization()
        NotificationCenter.default.addObserver(self, selector: #selector(localization), name: NSNotification.Name("localized"), object: nil)
        
    }
    
    
    @objc private func localization() {
        self.titleLabel.text = LocalizationManager.share.translate?.result.list.import_tokens.import_tokens_title
        self.addLabel.text = LocalizationManager.share.translate?.result.list.import_tokens.import_tokens_label_add
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func hideKeyBoard(_ sender: Any) {
        self.searchBar.resignFirstResponder()
    }
}

extension ImportTokensViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.filteredTokens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "importTokenCell", for: indexPath) as! ImportTokensTableViewCell
        let token = self.filteredTokens[indexPath.row]
        cell.setupCell(tail: token)
        
        if token.name == "Green App Development" {
            cell.choiceSwitch.isOn = true
            cell.choiceSwitch.isEnabled = false
            cell.choiceSwitch.onTintColor = #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)
        } else if token.name == "USD Stable" {
            cell.choiceSwitch.isOn = true
            cell.choiceSwitch.isEnabled = false
            cell.choiceSwitch.onTintColor = #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)
        } else {
            cell.choiceSwitch.isOn = false
            cell.choiceSwitch.isEnabled = true
            cell.choiceSwitch.onTintColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        }
        
        if CoreDataManager.share.fetchChiaWalletPrivateKey()[self.index].names!.contains(self.filteredTokens[indexPath.row].name) {
            
            cell.choiceSwitch.isOn = true
            
            if token.name == "Green App Development" {
                cell.choiceSwitch.isOn = true
                cell.choiceSwitch.isEnabled = false
                cell.choiceSwitch.onTintColor = #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)
            } else if token.name == "USD Stable" {
                cell.choiceSwitch.isOn = true
                cell.choiceSwitch.isEnabled = false
                cell.choiceSwitch.onTintColor = #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)
            }
        } else {
            cell.choiceSwitch.isOn = false
            
            if token.name == "Green App Development" {
                cell.choiceSwitch.isOn = true
                cell.choiceSwitch.isEnabled = false
                cell.choiceSwitch.onTintColor = #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)
            } else if token.name == "USD Stable" {
                cell.choiceSwitch.isOn = true
                cell.choiceSwitch.isEnabled = false
                cell.choiceSwitch.onTintColor = #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)
            }
        }
        
        cell.switchPressed = { [unowned self] in
            
            UIView.animate(withDuration: 3) {
                self.addedWalletLabel.alpha = 1
            }
            CoreDataManager.share.addTokenChiaWalletPrivateKey(index: self.index, balance: Double(self.prices.filter({$0.code == self.filteredTokens[indexPath.row].code}).first?.price ?? "0") ?? 0, name: self.filteredTokens[indexPath.row].name)
            NotificationCenter.default.post(name: NSNotification.Name("updateBalances"), object: nil)
            UIView.animate(withDuration: 3) {
                self.addedWalletLabel.alpha = 0
            }
        }
        
        cell.switchoff = { [unowned self] in
            
            CoreDataManager.share.deleteTokenChiaWalletPrivateKey(index: self.index, balance: Double(self.prices.filter({$0.code == self.filteredTokens[indexPath.row].code}).first?.price ?? "0") ?? 0, name: self.filteredTokens[indexPath.row].name)
            NotificationCenter.default.post(name: NSNotification.Name("updateBalances"), object: nil)

        }
        
        
        return cell
    }
}
extension ImportTokensViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            self.filteredTokens = self.tokens
            self.tableView.reloadData()
            return
        }
        self.filteredTokens = self.tokens.filter{$0.name.lowercased().contains(searchText.lowercased())}
        self.tableView.reloadData()
    }
    
    
}
