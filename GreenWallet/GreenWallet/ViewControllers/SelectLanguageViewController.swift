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
        self.languageTableView.register(UINib(nibName: "LanguageTableViewCell", bundle: nil), forCellReuseIdentifier: "LanguageTableViewCell")
    }


}

extension SelectLanguageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        LanguageManager.share.language?.result.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableViewCell", for: indexPath) as! LanguageTableViewCell
        cell.titleLabel.text = LanguageManager.share.language?.result.list[indexPath.row].nameBtn
        switch LanguageManager.share.language?.result.list[indexPath.row].code {
        case "ru":
            cell.cellImage.image = UIImage(named: "russia")!
            return cell
        case "en":
            cell.cellImage.image = UIImage(named: "english")!
            return cell
        default:
            cell.cellImage.image = UIImage(named: "germany")!
            return cell
            
        }

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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        54
    }
}



