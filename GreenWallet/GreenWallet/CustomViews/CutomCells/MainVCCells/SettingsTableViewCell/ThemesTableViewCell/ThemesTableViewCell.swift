//
//  SettingsTableViewCell.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 28.04.2022.
//

import UIKit

class ThemesTableViewCell: UITableViewCell {

    @IBOutlet weak var lightThemeButton: UIButton!
    @IBOutlet weak var darkThemeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    @IBAction func darkThemeButtonPressed(_ sender: Any) {
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .dark
        }
        UserDefaultsManager.shared.userDefaults.set("dark", forKey: UserDefaultsStringKeys.theme.rawValue)
    }
    
    @IBAction func lightThemeButtonPressed(_ sender: Any) {
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .light
        }
        UserDefaultsManager.shared.userDefaults.set("light", forKey: UserDefaultsStringKeys.theme.rawValue)
    }
    
}
