//
//  SelectSystemView.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 27.04.2022.
//

import UIKit

class SelectSystemViewController: UIViewController {

    private let systems: [System] = [System(name: "Chia", token: "XCH", image: UIImage(named: "LogoChia")!), System(name: "Chives", token: "XCC", image: UIImage(named: "ChivesLogo")!)]
    private let typseOfNewWallet = ["Новый", "Импорт мнемоники"]
    private var isSelectedSystem = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "SelectSystemTableViewCell", bundle: nil), forCellReuseIdentifier: "systemCell")
    }

}

extension SelectSystemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSelectedSystem {
            return self.typseOfNewWallet.count
        } else {
            return self.systems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedSystemCell = tableView.dequeueReusableCell(withIdentifier: "systemCell", for: indexPath) as! SelectSystemTableViewCell
        
        selectedSystemCell.nameOfSystemLabel.text = self.systems[indexPath.row].name
        selectedSystemCell.tokensLabel.text = self.systems[indexPath.row].token
        selectedSystemCell.systemImage.image = self.systems[indexPath.row].image
        
        let selectTypeOfWalletCell = tableView.dequeueReusableCell(withIdentifier: "typeOfWalletCell", for: indexPath)
        
        selectTypeOfWalletCell.accessoryType = .disclosureIndicator
        var content = selectTypeOfWalletCell.defaultContentConfiguration()
        content.text = self.typseOfNewWallet[indexPath.row]
        selectTypeOfWalletCell.contentConfiguration = content
        
        switch self.isSelectedSystem {
        case false:
            return selectedSystemCell
        case true:
            return selectTypeOfWalletCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isSelectedSystem {
            let importTokensVC = storyboard?.instantiateViewController(withIdentifier: "ImportTokensViewController") as! ImportTokensViewController
//            importTokensVC.modalPresentationStyle = .fullScreen
//            self.navigationController?.present(importTokensVC, animated: true)
//            self.navigationController?.navigationBar.isHidden = false
            let vc = ImportTokensViewController()
            
            
            present(vc, animated: true)
            
        } else {
            self.isSelectedSystem = true
            tableView.reloadData()
        }
        
      
        
    }
    
}