//
//  ViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 25.04.2022.
//

import UIKit

class SelectLanguageViewController: UIViewController {

    @IBOutlet weak var languageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.backButtonTitle = "Назад"
    }


}

extension SelectLanguageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        switch indexPath.row {
        case 0:
            content.text = "English"
        case 1:
            content.text = "Русский"
        default:
            break
        }
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let termsOfUseVC = storyboard?.instantiateViewController(withIdentifier: "TermsOfUseViewController") as! TermsOfUseViewController
            UserDefaultsManager.shared.userDefaults.set("Russian", forKey: UserDefaultsStringKeys.Language.rawValue)
            self.navigationController?.pushViewController(termsOfUseVC, animated: true)
        default:
            let termsOfUseVC = storyboard?.instantiateViewController(withIdentifier: "TermsOfUseViewController") as! TermsOfUseViewController
            UserDefaultsManager.shared.userDefaults.set("English", forKey: UserDefaultsStringKeys.Language.rawValue)
            self.navigationController?.pushViewController(termsOfUseVC, animated: true)
        }
    }
}



