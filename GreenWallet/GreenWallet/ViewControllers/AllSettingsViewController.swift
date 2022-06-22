//
//  AllSettingsViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 28.04.2022.
//

import UIKit

class AllSettingsViewController: UIViewController {

    private var titlesOfCells = ["Скрыть баланс кошельков", "Push-уведомления", "Поддержка", "Уведомления", "Сменить язык", "О приложении"]
    private var detailOfCells = ["На главном экране", "Рекомендуется", "Ответим на вопросы"]

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
        self.tableView.register(UINib(nibName: "ThemesTableViewCell", bundle: nil), forCellReuseIdentifier: "themeCell")
        self.tableView.register(UINib(nibName: "SecureBalanceTableViewCell", bundle: nil), forCellReuseIdentifier: "secureAndPushCell")
        self.tableView.register(UINib(nibName: "SupportTableViewCell", bundle: nil), forCellReuseIdentifier: "supportCell")
        self.tableView.register(UINib(nibName: "PushAndAllSettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "pushAndAllSettingsCell")
        NotificationCenter.default.addObserver(self, selector: #selector(localization), name: NSNotification.Name("localized"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
      
    }
    
    @objc private func localization() {
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}

extension AllSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let themeCell = tableView.dequeueReusableCell(withIdentifier: "themeCell", for: indexPath) as! ThemesTableViewCell
        let secureAndPushCell = tableView.dequeueReusableCell(withIdentifier: "secureAndPushCell", for: indexPath) as! SecureAndPushTableViewCell
        let supportCell = tableView.dequeueReusableCell(withIdentifier: "supportCell", for: indexPath) as! SupportTableViewCell
        let pushAndAllSettingsCell = tableView.dequeueReusableCell(withIdentifier: "pushAndAllSettingsCell", for: indexPath) as! PushAndAllSettingsTableViewCell
        
        switch indexPath {
        case [0,0]:
            themeCell.localization()
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
        case [0,5]:
            pushAndAllSettingsCell.cellImage.image = UIImage(named: "Language")!
            pushAndAllSettingsCell.mainLabel.text = LocalizationManager.share.translate?.result.list.menu.menu_change_language
            return pushAndAllSettingsCell
        default:
            pushAndAllSettingsCell.cellImage.image = UIImage(named: "info")!
            pushAndAllSettingsCell.mainLabel.text = LocalizationManager.share.translate?.result.list.about_the_application.about_the_application_title
            return pushAndAllSettingsCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0,3]:
            let supportVC = storyboard?.instantiateViewController(withIdentifier: "SupportViewController") as! SupportViewController
            supportVC.modalPresentationStyle = .fullScreen
            
            self.present(supportVC, animated: true, completion: nil)
        case [0,5]:
            let languageVC = storyboard?.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
            languageVC.modalPresentationStyle = .fullScreen
            self.present(languageVC, animated: true, completion: nil)
        case [0,6]:
            let infoVC = storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
            infoVC.modalPresentationStyle = .fullScreen
            self.present(infoVC, animated: true, completion: nil)
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

