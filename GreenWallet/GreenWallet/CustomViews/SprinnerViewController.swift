//
//  SprinnerViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 06.05.2022.
//

import UIKit

class SprinnerViewController: UIViewController {

    @IBOutlet weak var spinner: JTMaterialSpinner!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.spinner.circleLayer.lineWidth = 5
        self.spinner.circleLayer.strokeColor = #colorLiteral(red: 0.2274509804, green: 0.6745098039, blue: 0.3490196078, alpha: 1)
        self.spinner.animationDuration = 2.5
        
        self.spinner.beginRefreshing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name("showPopUp"), object: nil)
        }
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
