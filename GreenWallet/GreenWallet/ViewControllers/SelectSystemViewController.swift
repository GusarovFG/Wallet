//
//  SelectSystemView.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 27.04.2022.
//

import UIKit

class SelectSystemViewController: UIViewController {
    
    private let systems: [System] = [System(name: "Chia", token: "XCH", image: UIImage(named: "LogoChia")!, balance: 0), System(name: "Chives", token: "XCC", image: UIImage(named: "ChivesLogo")!, balance: 0)]
    private var typseOfNewWallet: [String] = []
    var isSelectedSystem = false
    var isGetToken = false
    var isPushToken = false
    var isNewWallet = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.window?.frame.size = CGSize(width: 414, height: 238)
        self.tableView.register(UINib(nibName: "SelectSystemTableViewCell", bundle: nil), forCellReuseIdentifier: "systemCell")
        self.navigationController?.navigationBar.isHidden = true
        self.headerView.layer.cornerRadius = 15
        self.headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        localization()
        if self.isNewWallet {
            self.titleLabel.text = LocalizationManager.share.translate?.result.list.all.add_wallet_title
        }
        self.typseOfNewWallet = [LocalizationManager.share.translate?.result.list.all.add_wallet_new ?? "", LocalizationManager.share.translate?.result.list.all.add_wallet_import ?? ""]
        let swipeGasture = UISwipeGestureRecognizer(target: self, action: #selector(dismissSwipe))
        swipeGasture.direction = .down
        self.view.addGestureRecognizer(swipeGasture)
        NotificationCenter.default.addObserver(self, selector: #selector(localization), name: NSNotification.Name("localized"), object: nil)

    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.1, delay: 0) {
            self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3481637311)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("ChangeIndex"), object: nil)
    }


    @objc private func localization() {
        self.titleLabel.text = LocalizationManager.share.translate?.result.list.all.select_network
    }
    
    @objc func dismissSwipe() {
        UIView.animate(withDuration: 0.1, delay: 0) {
            self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
        self.dismiss(animated: true)
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
        if self.isSelectedSystem && !self.isGetToken && !self.isPushToken {
            switch indexPath {
            case [0,0]:
                guard let newWalletVC = storyboard?.instantiateViewController(withIdentifier: "NewWalletViewController") else { return }
                self.present(newWalletVC, animated: true, completion: nil)
            case [0,1]:
                guard let newWalletVC = storyboard?.instantiateViewController(withIdentifier: "qwes") else { return }
                self.present(newWalletVC, animated: true, completion: nil)
            default:
                break
            }
        } else if !self.isSelectedSystem && self.isGetToken && !self.isPushToken  {
            switch indexPath  {
            case [0,0]:
                let gettVC = storyboard?.instantiateViewController(withIdentifier: "GetTokenViewController") as! GetTokenViewController
                gettVC.modalPresentationStyle = .fullScreen
                self.present(gettVC, animated: true, completion: nil)
            case [0,1]:
                let gettVC = storyboard?.instantiateViewController(withIdentifier: "GetTokenViewController") as! GetTokenViewController
                gettVC.modalPresentationStyle = .fullScreen
                self.present(gettVC, animated: true, completion: nil)
            default:
                break
            }
        } else if !self.isSelectedSystem && !self.isGetToken && self.isPushToken  {
            switch indexPath  {
            case [0,0]:
                let gettVC = storyboard?.instantiateViewController(withIdentifier: "PushTokensViewController") as! PushTokensViewController
                gettVC.modalPresentationStyle = .fullScreen
                self.present(gettVC, animated: true, completion: nil)
            case [0,1]:
                let gettVC = storyboard?.instantiateViewController(withIdentifier: "PushTokensViewController") as! PushTokensViewController
                gettVC.modalPresentationStyle = .fullScreen
                self.present(gettVC, animated: true, completion: nil)
            default:
                break
            }
        } else {
            self.isSelectedSystem = true
            self.tableView.reloadData()
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
