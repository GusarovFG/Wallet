//
//  SettingsViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 28.04.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "ThemesTableViewCell", bundle: nil), forCellReuseIdentifier: "themeCell")
        self.tableView.register(UINib(nibName: "SecureBalanceTableViewCell", bundle: nil), forCellReuseIdentifier: "secureAndPushCell")
        self.tableView.register(UINib(nibName: "SupportTableViewCell", bundle: nil), forCellReuseIdentifier: "supportCell")
        self.tableView.register(UINib(nibName: "PushAndAllSettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "pushAndAllSettingsCell")
        NotificationCenter.default.addObserver(self, selector: #selector(localization), name: NSNotification.Name("localized"), object: nil)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    @objc private func localization() {
        self.tableView.reloadData()
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let themeCell = tableView.dequeueReusableCell(withIdentifier: "themeCell", for: indexPath) as! ThemesTableViewCell
        let secureAndPushCell = tableView.dequeueReusableCell(withIdentifier: "secureAndPushCell", for: indexPath) as! SecureAndPushTableViewCell
        let supportCell = tableView.dequeueReusableCell(withIdentifier: "supportCell", for: indexPath) as! SupportTableViewCell
        let pushAndAllSettingsCell = tableView.dequeueReusableCell(withIdentifier: "pushAndAllSettingsCell", for: indexPath) as! PushAndAllSettingsTableViewCell
        
        switch indexPath {
        case [0,0]:
            return themeCell
        case [0,1]:
            secureAndPushCell.eyeImageView?.image = UIImage(named: "Eye")!
            secureAndPushCell.mainLabel?.text = LocalizationManager.share.translate?.result.list.menu.menu_hide_wallet_balance_title
            secureAndPushCell.detailLabel?.text = LocalizationManager.share.translate?.result.list.menu.menu_hide_wallet_balance_description
            secureAndPushCell.cellSwitch?.isOn = false
            secureAndPushCell.secure = true
            if UserDefaultsManager.shared.userDefaults.bool(forKey: UserDefaultsStringKeys.hideWalletsBalance.rawValue) {
                secureAndPushCell.cellSwitch?.isOn = true
            } else {
                secureAndPushCell.cellSwitch?.isOn = false
            }
            return secureAndPushCell
        case [0,2]:
            secureAndPushCell.eyeImageView?.image = UIImage(named: "Notification")!
            secureAndPushCell.detailLabel?.text = LocalizationManager.share.translate?.result.list.menu.menu_push_notifications_description
            secureAndPushCell.mainLabel?.text = LocalizationManager.share.translate?.result.list.menu.menu_push_notifications_title
            secureAndPushCell.cellSwitch?.isOn = true
            return secureAndPushCell
        case [0,3]:
            supportCell.mainLabel?.text = LocalizationManager.share.translate?.result.list.menu.menu_support_title
            supportCell.detailLabel?.text = LocalizationManager.share.translate?.result.list.menu.menu_push_notifications_description
            supportCell.cellImage?.image = UIImage(named: "support")!
            return supportCell
        case [0,4]:
            pushAndAllSettingsCell.cellImage.image = UIImage(named: "Notification")!
            pushAndAllSettingsCell.mainLabel.text = LocalizationManager.share.translate?.result.list.menu.menu_notifications
            return pushAndAllSettingsCell
        default:
            pushAndAllSettingsCell.cellImage.image = UIImage(named: "settings")!
            pushAndAllSettingsCell.mainLabel.text = LocalizationManager.share.translate?.result.list.menu.menu_show_more_title
            return pushAndAllSettingsCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == [0,5] {
            let allSettingsVC = storyboard?.instantiateViewController(withIdentifier: "AllSettingsViewController") as! AllSettingsViewController
            allSettingsVC.modalPresentationStyle = .overFullScreen
            
            self.present(allSettingsVC, animated: true, completion: nil)
            self.navigationController?.navigationBar.isHidden = false
        }
        if indexPath == [0,3] {
            let supportVC = storyboard?.instantiateViewController(withIdentifier: "SupportViewController") as! SupportViewController
            supportVC.modalPresentationStyle = .overFullScreen
            
            self.present(supportVC, animated: true, completion: nil)
            self.navigationController?.navigationBar.isHidden = false
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
