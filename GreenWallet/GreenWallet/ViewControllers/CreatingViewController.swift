//
//  CreatingViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 03.05.2022.
//

import UIKit

class CreatingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mnemonicVC = storyboard?.instantiateViewController(withIdentifier: "MnemonicViewController") as! MnemonicViewController
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.present(mnemonicVC, animated: true, completion: nil)
            
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
