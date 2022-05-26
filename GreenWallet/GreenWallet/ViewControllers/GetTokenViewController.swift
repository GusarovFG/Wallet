//
//  GetTokenViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 11.05.2022.
//

import UIKit

class GetTokenViewController: UIViewController {
    
    private var qrs = [UIImage(named: "qrwallet")!,UIImage(named: "qrwallet")!,UIImage(named: "qrwallet")!]
    private var wallets: [WalletModel] = []

    @IBOutlet weak var qrCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var shareBatton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var chiaMenuButton: UIButton!
    @IBOutlet weak var chivesMenuButton: UIButton!
    @IBOutlet weak var copyLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var adresOfWalletLabel: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        self.qrCollectionView.register(UINib(nibName: "qrCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "qrCell")
        
        self.wallets = WalletManager.share.vallets
        self.menuView.alpha = 0
        self.menuView.isHidden = true
        self.titleLabel.text = "Chia Network"
        
        setupLabel(index: self.pageControl.currentPage)
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
    
    private func localization() {
        self.titleLabel.text = LocalizationManager.share.translate?.result.list.import_tokens.import_tokens_title
        self.adresOfWalletLabel.text = LocalizationManager.share.translate?.result.list.receive_a_token.receive_a_token_adress
        self.copyLabel.text = LocalizationManager.share.translate?.result.list.all.lable_copied
        self.copyButton.setTitle(LocalizationManager.share.translate?.result.list.receive_a_token.receive_a_token_copy, for: .normal)
        self.shareBatton.setTitle(LocalizationManager.share.translate?.result.list.all.share_btn, for: .normal)
    }
    
    private func setupLabel(index: Int) {
        
        let numbers = "\(self.wallets[index].number )"
        var numberOfWallet = ""
        for numb in numbers {
            
            if numberOfWallet.count < numbers.count - 4 {
                numberOfWallet += "*"
            } else {
                numberOfWallet.append(numb)
            }
        }
        self.walletLabel.text = "\(self.wallets[index].name )" + numberOfWallet
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
            self.chivesMenuButton.backgroundColor = .systemBackground
            self.chivesMenuButton.titleLabel?.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        } else {
            self.chivesMenuButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            self.menuButton.setTitle("• Chives Network", for: .normal)
            self.chivesMenuButton.titleLabel?.textColor = .white
            self.menuButton.titleLabel?.text = "Chives Network"
            self.titleLabel.text = "Chives Network"
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
        self.chivesMenuButton.backgroundColor = .systemBackground
        self.chivesMenuButton.titleLabel?.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.menuView.alpha = 0
    }
    
    @IBAction func chivesButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.menuButton.setTitle("• Chives Network", for: .normal)
        self.chivesMenuButton.titleLabel?.textColor = .white
        self.menuButton.titleLabel?.text = "Chives Network"
        self.titleLabel.text = "Chives Network"
        self.chiaMenuButton.backgroundColor = .systemBackground
        self.chiaMenuButton.titleLabel?.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.menuView.alpha = 0
    }
    
    @IBAction func copyButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.copyLabel.alpha = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            UIPasteboard.general.string = self.linkLabel.text
            UIView.animate(withDuration: 1) {
                self.copyLabel.alpha = 0
            }
            
        }
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        let shareController = UIActivityViewController(activityItems: [self.linkLabel.text ?? ""], applicationActivities: nil)
        self.present(shareController, animated: true, completion: nil)
    }
}

extension GetTokenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.qrs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "qrCell", for: indexPath) as! qrCollectionViewCell
        cell.imageCell.image = self.qrs[indexPath.row]
        setupLabel(index: indexPath.row)
       
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.qrCollectionView.contentOffset, size: self.qrCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.qrCollectionView.indexPathForItem(at: visiblePoint) {
            self.pageControl.currentPage = visibleIndexPath.row
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 190, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 55, bottom: 0, right: 55)
    }
    
}
