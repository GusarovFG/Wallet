//
//  LanguageViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 28.04.2022.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBOutlet weak var backButtonItem: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = LocalizationManager.share.translate?.result.list.select_language.select_language_title
        self.tableView.register(UINib(nibName: "LanguageTableViewCell", bundle: nil), forCellReuseIdentifier: "languageCell")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        LanguageManager.share.language?.result.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath) as! LanguageTableViewCell
        let language = LanguageManager.share.language?.result.list[indexPath.row]
        cell.titleLabel.text = language?.nameBtn
        
        if language?.code == "ru" {
            cell.cellImage.image = UIImage(named: "RussianLanguage")!
        } else if language?.code == "en" {
            cell.cellImage.image = UIImage(named: "EnglishLanguage")!
        }
        
        if CoreDataManager.share.fetchLanguage()[0].languageCode == language?.code {
                cell.titleLabel.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let language = LanguageManager.share.language?.result.list[indexPath.row]
        NetworkManager.share.getTranslate(from: MainURLS.API.rawValue, languageCode: language?.code ?? "") { translate in
            LocalizationManager.share.translate = translate
            CoreDataManager.share.changeLanguage(LanguageManager.share.language?.result.list[indexPath.row].code ?? "", version: LanguageManager.share.language?.result.version ?? "")
            self.viewDidLoad()
        }
    }
}
