//
//  MyWalletsViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 19.05.2022.
//

import UIKit

class MyWalletsViewController: UIViewController {
    
    private var wallets: [Wallet] = []
    private var actionButtons: [MyWalletsButtons] = [MyWalletsButtons(image: UIImage(named: "wallet")!,
                                                                      title: "Send",
                                                                      discription: "Send coins and tokens at any time from your mobile phone"),
                                                     MyWalletsButtons(image: UIImage(named: "recive")!,
                                                                      title: "Recieve",
                                                                      discription: "Here you will find everything you need to get green tokens and coins"),
                                                     MyWalletsButtons(image: UIImage(named: "share")!,
                                                                      title: "Share",
                                                                      discription: "Share your wallet with friends on social networks and instant messengers"),
                                                     MyWalletsButtons(image: UIImage(named: "qr")!,
                                                                      title: "Scan address",
                                                                      discription: "Scan the QR code from the screen of your computer or smartphone for a quick transaction")]
    
    var isShowDetail = false
    var index = 0
    private var wallet: Wallet?
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var walletCollectionView: UICollectionView!
    @IBOutlet weak var actionCollectionView: UICollectionView!
    @IBOutlet weak var transactionButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var copyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.wallets = WalletManager.share.vallets
        
        self.copyLabel.alpha = 0
        self.copyLabel.text = "   Скопировано"
        
        self.walletCollectionView.register(UINib(nibName: "MyWalletCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyWalletCollectionViewCell")
        self.walletCollectionView.register(UINib(nibName: "MyWalletDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyWalletDetailCollectionViewCell")
        self.actionCollectionView.register(UINib(nibName: "MyWalletsButtonsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyWalletsButtonsCollectionViewCell")
        
        self.walletCollectionView.presentationIndexPath(forDataSourceIndexPath: [0,self.index])
        
        NotificationCenter.default.addObserver(self, selector: #selector(showDetailCell), name: NSNotification.Name("Seccess"), object: nil)
        
    }
    
    @objc func showDetailCell(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        self.index = userInfo["index"] as! Int
        self.isShowDetail = true
        self.walletCollectionView.reloadData()
        print(self.index)
    }
    
    override func viewWillLayoutSubviews() {
        self.scrollView.contentSize = self.view.bounds.size
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.scrollToNextCell()
        print(self.index)
    }
    
    private func scrollToNextCell(){
        self.walletCollectionView.scrollToItem(at: [0,self.index], at: .right, animated: true)
    }

    @IBAction func backButtomPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func transactionButtonPressed(_ sender: Any) {
        guard let transactionHistoryVC = storyboard?.instantiateViewController(withIdentifier: "TransactionHistoryVC") else { return }
        transactionHistoryVC.modalPresentationStyle = .fullScreen
        self.present(transactionHistoryVC, animated: true)
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
    }
    
}

extension MyWalletsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.walletCollectionView:
            return self.wallets.count
        default:
            return self.actionButtons.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mainCell = self.walletCollectionView.dequeueReusableCell(withReuseIdentifier: "MyWalletCollectionViewCell", for: indexPath) as! MyWalletCollectionViewCell
        let detailCell = self.walletCollectionView.dequeueReusableCell(withReuseIdentifier: "MyWalletDetailCollectionViewCell", for: indexPath) as! MyWalletDetailCollectionViewCell
        let actionsCell = self.actionCollectionView.dequeueReusableCell(withReuseIdentifier: "MyWalletsButtonsCollectionViewCell", for: indexPath) as! MyWalletsButtonsCollectionViewCell
        
        
        switch collectionView {
        case self.walletCollectionView:
            switch self.isShowDetail {
            case false:
                let wallet = self.wallets[indexPath.row]
                self.wallet = wallet
                mainCell.walletImage.image = wallet.image
                mainCell.balanceLabel.text = "8,5478614578 XCH"
                mainCell.balanceTitleLabel.text = "Баланс"
                mainCell.usdLabel.text = "⁓762,14 USDT"
                mainCell.detailButton.setTitle("Показать данные", for: .normal)
                mainCell.walletSystemLabel.text = wallet.name + " Network"
                mainCell.publicKeyLabel.text = "Приватный ключ с публичным отпечатком 8745635630"
                mainCell.complitionHandler = { [unowned self] in
                    let passwordVC = storyboard?.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
                    passwordVC.index = self.index
                    self.present(passwordVC, animated: true)
                    
                }
                return mainCell
            default:
                detailCell.linkTitleLabel.text = "Адрес"
                detailCell.linkLabel.text = "xch1gju63fm8tv00sk6gj44kr8chp02lngk473cjcug593wquuej9qzqwhpyen"
                detailCell.publicTitleLabel.text = "Публичный ключ"
                detailCell.publicKeyDetailLabel.text = "b7dafa7a6036dc58b1798932ff941716b3fca4315e1af01e5b0bf500acb7a66d59d8d9b342b4b047e8fcf0d6f8873d1a"
                detailCell.mnemonicTitleLabel.text = "Мнемоника"
                detailCell.mnemonicLabel.text = "************"
                detailCell.complitionHandler = { [unowned self] in
                    UIView.animate(withDuration: 1, delay: 0) {
                        self.copyLabel.alpha = 1
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        UIView.animate(withDuration: 1, delay: 0) {
                            self.copyLabel.alpha = 0
                        }
                    }
                }
                return detailCell
            }
            
        default:
            let actionButton = self.actionButtons[indexPath.row]
            actionsCell.actionDiscriptionLabel.text = actionButton.discription
            actionsCell.actionImage.image = actionButton.image
            actionsCell.actionTitleLabel.text = actionButton.title
            return actionsCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case self.walletCollectionView:
            return CGSize(width: 350, height: 220)
        case self.actionCollectionView:
            return CGSize(width: 190, height: 190)
        default:
            return CGSize.zero
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.walletCollectionView.contentOffset, size: self.walletCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.walletCollectionView.indexPathForItem(at: visiblePoint) {
            self.pageControl.currentPage = visibleIndexPath.row
            self.wallet = self.wallets[visibleIndexPath.row]
            self.index = visibleIndexPath.row
        }
    }
    
}

struct MyWalletsButtons {
    var image: UIImage
    var title: String
    var discription: String
}
