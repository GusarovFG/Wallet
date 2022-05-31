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
        LanguageManager.share.language?.result.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
            content.text = LanguageManager.share.language?.result.list[indexPath.row].nameBtn

        print(LanguageManager.share.language?.result.list[indexPath.row].nameBtn ?? "блябля")
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let termsOfUseVC = storyboard?.instantiateViewController(withIdentifier: "TermsOfUseViewController") as! TermsOfUseViewController
        termsOfUseVC.modalPresentationStyle = .fullScreen
            let language = LanguageManager.share.language?.result.list[indexPath.row]
            NetworkManager.share.getTranslate(from: MainURLS.API.rawValue, languageCode: language?.code ?? "" ) { TranslateManager in
                
                LocalizationManager.share.translate = TranslateManager
                CoreDataManager.share.saveLanguage(language?.code ?? "", version: LanguageManager.share.language?.result.version ?? "" )
                print(TranslateManager)
                self.present(termsOfUseVC, animated: true)
            }
            

        
    }
}



