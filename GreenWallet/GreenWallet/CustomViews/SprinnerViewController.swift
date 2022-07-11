//
//  SprinnerViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 06.05.2022.
//

import UIKit

class SprinnerViewController: UIViewController {
    
    var isDeleting = false
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var mainDescription: UILabel!
    @IBOutlet weak var spinner: JTMaterialSpinner!
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        self.spinner.circleLayer.lineWidth = 5
        self.spinner.circleLayer.strokeColor = #colorLiteral(red: 0.2274509804, green: 0.6745098039, blue: 0.3490196078, alpha: 1)
        self.spinner.animationDuration = 2.5
        
        self.spinner.beginRefreshing()
        WalletManager.share.isUpdate = false
            NotificationCenter.default.post(name: NSNotification.Name("showPopUp"), object: nil)

    }
    
    private func localization() {
        if !self.isDeleting {
            self.mainTitle.text = LocalizationManager.share.translate?.result.list.all.loading_pop_up_title
            self.mainDescription.text = LocalizationManager.share.translate?.result.list.all.loading_pop_up_description
        } else {
            self.mainTitle.text = LocalizationManager.share.translate?.result.list.address_book.adress_book_loading_remove_title
            self.mainDescription.text = LocalizationManager.share.translate?.result.list.all.loading_pop_up_description
        }
    }
    
    func startSpinner() {
        self.spinner.beginRefreshing()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
