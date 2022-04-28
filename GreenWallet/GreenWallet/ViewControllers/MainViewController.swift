//
//  MainViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 26.04.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var riseLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var walletsTableView: UITableView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.walletsTableView.register(UINib(nibName: "BalanceTableViewCell", bundle: nil), forCellReuseIdentifier: "walletCell")
        self.walletsTableView.register(UINib(nibName: "ImportTableViewCell", bundle: nil), forCellReuseIdentifier: "importCell")
        self.stackView.removeArrangedSubview(self.walletsTableView)
        
        self.headerView.layer.cornerRadius = 15
        self.headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.footerView.layer.cornerRadius = 15
        self.footerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        

        
        let navigationItem = UINavigationItem()
        let settingsItem = UIBarButtonItem(image: UIImage(named: "Menu")!, style: .done, target: self, action: #selector(pushSettingsController))
        settingsItem.tintColor = .white
        navigationItem.rightBarButtonItem = settingsItem
        self.navigationController?.navigationBar.setItems([navigationItem], animated: false)
        
    }
    
    private func presentModal() {
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "SelectSystemViewController") as! SelectSystemViewController
        let nav = UINavigationController(rootViewController: detailViewController)
        nav.navigationBar.isHidden = true

        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
        }

        present(nav, animated: true, completion: nil)
    }
    
    @objc private func pushSettingsController() {
        
    }
    
    @IBAction func qwe(_ sender: Any) {
        
        presentModal()
        
//        self.stackView.insertArrangedSubview(self.walletsTableView, at: 1)
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let importCell = tableView.dequeueReusableCell(withIdentifier: "importCell", for: indexPath) as! ImportTableViewCell
        let walletCell = tableView.dequeueReusableCell(withIdentifier: "walletCell", for: indexPath) as! BalanceTableViewCell
        switch indexPath {
        case [0,9]:
            return importCell
        default:
            return walletCell
        }
    } 
}
