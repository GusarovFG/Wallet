//
//  SupportViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 17.05.2022.
//

import UIKit

class SupportViewController: UIViewController {
    
    
    let supports = [LocalizationManager.share.translate?.result.list.support.support_FAQ, LocalizationManager.share.translate?.result.list.support.support_ask_a_question, LocalizationManager.share.translate?.result.list.support.support_listing, LocalizationManager.share.translate?.result.list.support.support_about_app]
    
    @IBOutlet weak var supportTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)

    }

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension SupportViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.supports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "supportCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = self.supports[indexPath.row]
        cell.contentConfiguration = content
        cell.accessoryView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8470588235)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0,0]:
            let faqVC = storyboard?.instantiateViewController(withIdentifier: "FAQController") as! FAQController
            faqVC.modalPresentationStyle = .fullScreen
            self.present(faqVC, animated: true)
        case [0,1]:
            let askVC = storyboard?.instantiateViewController(withIdentifier: "AskAQuestionViewController") as! AskAQuestionViewController
            askVC.modalPresentationStyle = .fullScreen
            self.present(askVC, animated: true)
        case [0,2]:
            let listingVC = storyboard?.instantiateViewController(withIdentifier: "ListingViewController") as! ListingViewController
            listingVC.modalPresentationStyle = .fullScreen
            self.present(listingVC, animated: true)
        default:
            break
        }
    }
    
}
