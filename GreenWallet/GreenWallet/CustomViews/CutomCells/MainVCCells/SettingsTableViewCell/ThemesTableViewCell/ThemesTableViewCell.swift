//
//  SettingsTableViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 28.04.2022.
//

import UIKit

class ThemesTableViewCell: UITableViewCell {
    
    var reload: (() -> ())?

    @IBOutlet weak var lightThemeButton: UIButton!
    @IBOutlet weak var darkThemeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lightThemeButton.setTitle(LocalizationManager.share.translate?.result.list.menu.menu_light_theme, for: .normal)
        self.darkThemeButton.setTitle(LocalizationManager.share.translate?.result.list.menu.menu_dark_theme, for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(localization), name: NSNotification.Name("localized"), object: nil)

    }
    
    @objc func localization() {
        self.lightThemeButton.setTitle(LocalizationManager.share.translate?.result.list.menu.menu_light_theme, for: .normal)
        self.darkThemeButton.setTitle(LocalizationManager.share.translate?.result.list.menu.menu_dark_theme, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    @IBAction func darkThemeButtonPressed(_ sender: Any) {
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .dark
        }
        UserDefaultsManager.shared.userDefaults.set("dark", forKey: UserDefaultsStringKeys.theme.rawValue)
        NotificationCenter.default.post(name: NSNotification.Name("localized"), object: nil)
        self.reload?()
    }
    
    @IBAction func lightThemeButtonPressed(_ sender: Any) {
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .light
        }
        UserDefaultsManager.shared.userDefaults.set("light", forKey: UserDefaultsStringKeys.theme.rawValue)
        NotificationCenter.default.post(name: NSNotification.Name("localized"), object: nil)
        self.reload?()
    }
    
}
