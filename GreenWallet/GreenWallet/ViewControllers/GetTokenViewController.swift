//
//  GetTokenViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 11.05.2022.
//

import UIKit

class GetTokenViewController: UIViewController {
    
    var wallets: [ChiaWalletPrivateKey] = []
    var isChia = false
    var isChives = false
    var isChiaTest = false
    var isChivesTest = false

    private var qrs = [UIImage(named: "qrwallet")!,UIImage(named: "qrwallet")!,UIImage(named: "qrwallet")!]
    private var systems: [ListSystems] = []
    
    @IBOutlet weak var qrCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var shareBatton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var systemViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var systemStackView: UIStackView!
    
    @IBOutlet weak var copyLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var adresOfWalletLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        
        SystemsManager.share.filterSystems()
        self.systems = Array(Set(SystemsManager.share.listOfSystems))
        self.qrCollectionView.register(UINib(nibName: "qrCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "qrCell")
        
        if self.isChia {
            self.wallets = CoreDataManager.share.fetchChiaWalletPrivateKey().filter({$0.name! == "Chia Wallet"})
            self.titleLabel.text = "Chia Network"
            self.menuButton.setTitle("• Chia Network", for: .normal)

        } else if self.isChives {
            self.wallets = CoreDataManager.share.fetchChiaWalletPrivateKey().filter({$0.name! == "Chives Wallet"})
            self.titleLabel.text = "Chives Network"
            self.menuButton.setTitle("• Chives Network", for: .normal)
        } else if self.isChiaTest {
            self.wallets = CoreDataManager.share.fetchChiaWalletPrivateKey().filter({$0.name! == "TestNet Chia Wallet"})
            self.titleLabel.text = "Chia TestNet"
            self.menuButton.setTitle("• Chia TestNet", for: .normal)
        } else if self.isChivesTest {
            self.wallets = CoreDataManager.share.fetchChiaWalletPrivateKey().filter({$0.name! == "TestNet Chives Wallet"})
            self.titleLabel.text = "Chives TestNet"
            self.menuButton.setTitle("• Chives TestNet", for: .normal)
        }
        self.menuView.alpha = 0
        self.menuView.isHidden = true

        
        setupLabel(index: self.pageControl.currentPage)
        self.pageControl.numberOfPages = self.wallets.count

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
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
    }
    
    private func setupLabel(index: Int) {
        
         let numbers = "\(self.wallets[index].fingerprint)"
        var numberOfWallet = ""
        for numb in numbers {
            
            if numberOfWallet.count < numbers.count - 4 {
                numberOfWallet += "*"
            } else {
                numberOfWallet.append(numb)
            }
        }
        self.walletLabel.text = "\(self.wallets[index].name ?? "")" + numberOfWallet
    }
    
    private func generateQRImage(stringQR: NSString) -> UIImage {
        let filter:CIFilter = CIFilter(name:"CIQRCodeGenerator")!
        filter.setDefaults()

        let data:NSData = stringQR.data(using: String.Encoding.utf8.rawValue)! as NSData
        filter.setValue(data, forKey: "inputMessage")

        let outputImg:CIImage = filter.outputImage!

        let context:CIContext = CIContext(options: nil)
        let cgimg:CGImage = context.createCGImage(outputImg, from: outputImg.extent)!

        var img:UIImage = UIImage(cgImage: cgimg, scale: 1.0, orientation: UIImage.Orientation.up)

        let width  = 190
        let height = 190

        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        let cgContxt:CGContext = UIGraphicsGetCurrentContext()!
        cgContxt.interpolationQuality = .none
        img.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return img
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {

        print(self.systems.count)
        for i in 0..<self.systems.count {
            if self.systemStackView.arrangedSubviews.count == self.systems.count {
                break
            } else {
                let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.systemStackView.frame.width, height: 40))
                button.setTitle(self.systems[i].name, for: .normal)
                self.systemStackView.addArrangedSubview(button)
                self.systemViewHeightConstraint.constant += button.frame.height
                
                button.addTarget(self, action: #selector(setupSystemMenuButtons), for: .touchUpInside)
                
            }
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
    
    @objc private func setupSystemMenuButtons(_ sender: UIButton) {
        
        for i in 0..<self.systemStackView.arrangedSubviews.count {
            self.systemStackView.arrangedSubviews[i].backgroundColor = .systemBackground
            if sender == self.systemStackView.arrangedSubviews[i] {
                self.menuButton.setTitle("• \(self.systems[i].name)", for: .normal)
                sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                self.titleLabel.text = self.systems[i].name
                
                if self.systems[i].name == "Chia Network" {
                    self.wallets = CoreDataManager.share.fetchChiaWalletPrivateKey().filter({$0.name == "Chia Wallet"})
                    
                    self.qrCollectionView.reloadData()
                    self.pageControl.numberOfPages = self.wallets.count
                } else if self.systems[i].name == "Chives Network" {
                    self.wallets = CoreDataManager.share.fetchChiaWalletPrivateKey().filter({$0.name == "Chives Wallet"})
                    self.qrCollectionView.reloadData()
                    self.pageControl.numberOfPages = self.wallets.count
                } else if self.systems[i].name == "Chia TestNet" {
                    self.wallets = CoreDataManager.share.fetchChiaWalletPrivateKey().filter({$0.name == "Chia TestNet"})
                    self.qrCollectionView.reloadData()
                    self.pageControl.numberOfPages = self.wallets.count
                } else if self.systems[i].name == "Chives TestNet" {
                    self.wallets = CoreDataManager.share.fetchChiaWalletPrivateKey().filter({$0.name == "Chives TestNet"})
                    self.qrCollectionView.reloadData()
                    self.pageControl.numberOfPages = self.wallets.count
                }
            }
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
        self.wallets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "qrCell", for: indexPath) as! qrCollectionViewCell
        cell.imageCell.image = self.generateQRImage(stringQR: self.wallets[indexPath.row].adres! as NSString)
        self.linkLabel.text = self.wallets[indexPath.row].adres
        setupLabel(index: indexPath.row)
       
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.qrCollectionView.contentOffset, size: self.qrCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.qrCollectionView.indexPathForItem(at: visiblePoint) {
            self.pageControl.currentPage = visibleIndexPath.row
            self.linkLabel.text = self.wallets[visibleIndexPath.row].adres
            self.walletLabel.text = "\(self.wallets[visibleIndexPath.row].name ?? "") ****\(String(self.wallets[visibleIndexPath.row].fingerprint).suffix(4))"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 190, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 55, bottom: 0, right: 55)
    }
    
}
