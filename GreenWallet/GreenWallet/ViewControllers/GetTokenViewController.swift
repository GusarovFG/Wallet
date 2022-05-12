//
//  GetTokenViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 11.05.2022.
//

import UIKit

class GetTokenViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var qrImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var shareBatton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var chiaMenuButton: UIButton!
    @IBOutlet weak var chivesMenuButton: UIButton!
    @IBOutlet weak var copyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuView.alpha = 0
        self.menuView.isHidden = true
        self.titleLabel.text = "Chia Network"
        self.walletLabel.text = "Chia ******5630"
        self.qrImage.image = UIImage(named: "qrwallet")!
        
        self.chiaMenuButton.setTitle("Chia Network", for: .normal)
        self.chivesMenuButton.setTitle("Chives Network", for: .normal)
        
        self.menuButton.setTitle("• Chia Network", for: .normal)
        self.menuButton.titleLabel?.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.menuButton.titleLabel?.numberOfLines = 1
        self.menuButton.titleLabel?.font.withSize(14)
        self.menuButton.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        
        self.menuButton.layer.borderWidth = 1
        self.menuButton.layer.borderColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        
        self.menuView.layer.borderWidth = 1
        self.menuView.layer.borderColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        
        self.copyLabel.alpha = 0
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        
        if self.titleLabel.text == "Chia Network" {
            self.chiaMenuButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            self.chiaMenuButton.titleLabel?.textColor = .white
            self.menuButton.setTitle("• Chia Network", for: .normal)
            self.titleLabel.text = "Chia Network"
            self.walletLabel.text = "Chia ******5630"
            self.chivesMenuButton.backgroundColor = .systemBackground
            self.chivesMenuButton.titleLabel?.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        } else {
            self.chivesMenuButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            self.menuButton.setTitle("• Chives Network", for: .normal)
            self.chivesMenuButton.titleLabel?.textColor = .white
            self.menuButton.titleLabel?.text = "Chives Network"
            self.titleLabel.text = "Chives Network"
            self.walletLabel.text = "Chives ******5630"
            self.chiaMenuButton.backgroundColor = .systemBackground
            self.chiaMenuButton.titleLabel?.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        }
       
        
        if self.menuView.alpha == 0 {
            UIView.animate(withDuration: 0.5) {
                self.menuView.isHidden = false
                self.menuView.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.menuView.alpha = 0
                self.menuView.isHidden = true
            }
        }
    }

    
    @IBAction func chiaButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.chiaMenuButton.titleLabel?.textColor = .white
        self.menuButton.setTitle("• Chia Network", for: .normal)
        self.titleLabel.text = "Chia Network"
        self.walletLabel.text = "Chia ******5630"
        self.chivesMenuButton.backgroundColor = .systemBackground
        self.chivesMenuButton.titleLabel?.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
    }
    
    @IBAction func chivesButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.menuButton.setTitle("• Chives Network", for: .normal)
        self.chivesMenuButton.titleLabel?.textColor = .white
        self.menuButton.titleLabel?.text = "Chives Network"
        self.titleLabel.text = "Chives Network"
        self.walletLabel.text = "Chives ******5630"
        self.chiaMenuButton.backgroundColor = .systemBackground
        self.chiaMenuButton.titleLabel?.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
    }
    @IBAction func copyButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.copyLabel.alpha = 1
        }
        UIPasteboard.general.string = self.linkLabel.text
        UIView.animate(withDuration: 2) {
            self.copyLabel.alpha = 0

        }
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        let shareController = UIActivityViewController(activityItems: [self.linkLabel.text ?? ""], applicationActivities: nil)
        self.present(shareController, animated: true, completion: nil)
    }
}
