//
//  MyWalletsViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 19.05.2022.
//

import UIKit

class MyWalletsViewController: UIViewController {
    
    var wallets: [ChiaWalletPrivateKey] = []
    private var actionButtons: [MyWalletsButtons] = [MyWalletsButtons(image: UIImage(named: "getArrow")!,
                                                                      title: "Send",
                                                                      discription: "Send coins and tokens at any time from your mobile phone"),
                                                     MyWalletsButtons(image: UIImage(named: "share")!,
                                                                      title: "Share",
                                                                      discription: "Share your wallet with friends on social networks and instant messengers"),
                                                     MyWalletsButtons(image: UIImage(named: "recive")!,
                                                                      title: "Recieve",
                                                                      discription: "Here you will find everything you need to get green tokens and coins"),
                                                     MyWalletsButtons(image: UIImage(named: "qr")!,
                                                                      title: "Scan address",
                                                                      discription: "Scan the QR code from the screen of your computer or smartphone for a quick transaction")]
    
    var isShowDetail = false
    var isScrolling = true
    var index = 0
    private var wallet: ChiaWalletPrivateKey?
    
    
    @IBOutlet weak var titleLabel: UILabel!
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
        
        
        self.copyLabel.alpha = 0
        self.copyLabel.text = "   Скопировано"
        
        self.walletCollectionView.register(UINib(nibName: "MyWalletCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyWalletCollectionViewCell")
        self.walletCollectionView.register(UINib(nibName: "MyWalletDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyWalletDetailCollectionViewCell")
        self.actionCollectionView.register(UINib(nibName: "MyWalletsButtonsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyWalletsButtonsCollectionViewCell")
                
        NotificationCenter.default.addObserver(self, selector: #selector(showDetail), name: NSNotification.Name("showDetail"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteWalletAtIntex), name: NSNotification.Name("deleteWallet"), object: nil)
        localization()
        self.pageControl.numberOfPages = CoreDataManager.share.fetchChiaWalletPrivateKey().count
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
            self.dismiss(animated: true)
        } else {
            self.wallets = CoreDataManager.share.fetchChiaWalletPrivateKey()
            print(self.index)
            
            self.walletCollectionView.reloadData()
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.scrollView.contentSize = self.view.bounds.size
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.scrollToNextCell()
        
        print(self.index)
        
        
    }
    
    private func localization() {
        self.titleLabel.text = LocalizationManager.share.translate?.result.list.wallet.wallet_title
        self.copyLabel.text = LocalizationManager.share.translate?.result.list.all.lable_copied
        self.transactionButton.setTitle(LocalizationManager.share.translate?.result.list.wallet.wallet_transaction_history_btn, for: .normal)
        self.deleteButton.setTitle(LocalizationManager.share.translate?.result.list.wallet.wallet_delete_wallet_btn, for: .normal)
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
    }
    
    @objc func deleteWalletAtIntex() {
        self.wallets = CoreDataManager.share.fetchChiaWalletPrivateKey()
        let storyBoard = UIStoryboard(name: "Alert", bundle: .main)
        let alertVC = storyBoard.instantiateViewController(withIdentifier: "DeletingAlert") as! AllertWalletViewController
        alertVC.isInMyWallet = true
        alertVC.index = self.index
        self.present(alertVC, animated: true)

        self.walletCollectionView.reloadData()
    }
    
    @objc func showDetail(notification: Notification) {
        self.isShowDetail = true
        self.walletCollectionView.reloadItems(at: [[0,self.index]])
        self.isScrolling = false
        self.isShowDetail = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            self.isShowDetail = false
            self.walletCollectionView.reloadData()
            
        }
    }

    

    
    private func scrollToNextCell(){
        if !self.isShowDetail && self.isScrolling {
            self.walletCollectionView.isPagingEnabled = false
            self.walletCollectionView.scrollToItem(at: [0,self.index], at: .right, animated: true)
            self.walletCollectionView.isPagingEnabled = true
        }
        
    }

    @IBAction func backButtomPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func transactionButtonPressed(_ sender: Any) {
        guard let transactionHistoryVC = storyboard?.instantiateViewController(withIdentifier: "TransactionHistoryVC") as? TransactionHistoryViewController  else { return }
        transactionHistoryVC.modalPresentationStyle = .fullScreen
        transactionHistoryVC.isHistoryWallet = true
        transactionHistoryVC.wallet = self.wallets[self.index]
        transactionHistoryVC.isChia = (self.wallets[self.index].name == "Chia Wallet")
        self.present(transactionHistoryVC, animated: true)
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Alert", bundle: .main)
        let alertVC = storyBoard.instantiateViewController(withIdentifier: "DeleteWallet") as! AllertWalletViewController
        alertVC.controller = self
        self.present(alertVC, animated: true)
    }
    
}

extension MyWalletsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.walletCollectionView:
            if wallets.isEmpty {
                return 0
            } else {
                
                return self.wallets.count
            }
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
                
                mainCell.walletImage.image = UIImage(named: "LogoChia")!
                mainCell.balanceLabel.text = "\((((wallet.balances as? [Double])?.reduce(0, +) ?? 0) / 1000000000000)) XCH"
                mainCell.publicKeyLabel.text = "\(LocalizationManager.share.translate?.result.list.wallet.wallet_data_public_key ?? "") \(wallets[indexPath.row].fingerprint )"
                if ((wallet.name?.contains("Chia")) != nil) {
                    mainCell.usdLabel.text = "XCH price: \(ExchangeRatesManager.share.newRatePerDollar) $"
                    
                } else {
                    mainCell.usdLabel.text = "XCC price: \(ExchangeRatesManager.share.newChivesRatePerDollar) $"
                }
                mainCell.walletSystemLabel.text = (wallet.name?.split(separator: " ").first ?? "") + " Network"
                mainCell.complitionHandler = { [unowned self] in
                    let passwordStoryboard = UIStoryboard(name: "PasswordStoryboard", bundle: .main)
                    let passwordVC = passwordStoryboard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
                    passwordVC.modalPresentationStyle = .fullScreen
                    passwordVC.isShowDetail = true
                    self.present(passwordVC, animated: true)
                     
                }
                return mainCell
            default:
                detailCell.wallet = self.wallets[self.index]
                detailCell.linkLabel.text = self.wallets[indexPath.row].adres
                detailCell.publicKeyDetailLabel.text = self.wallets[indexPath.row].pk
                print(self.wallet?.seed)
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
            switch indexPath {
            case [0,0]:
                actionsCell.actionImage.image = UIImage(named: "getArrow")!
                actionsCell.actionTitleLabel.text = LocalizationManager.share.translate?.result.list.wallet.wallet_send_title
                actionsCell.actionDiscriptionLabel.text = LocalizationManager.share.translate?.result.list.wallet.wallet_send_description
                return actionsCell
            case [0,1]:
                actionsCell.actionImage.image = UIImage(named: "share")!
                actionsCell.actionTitleLabel.text = LocalizationManager.share.translate?.result.list.wallet.wallet_share_title
                actionsCell.actionDiscriptionLabel.text = LocalizationManager.share.translate?.result.list.wallet.wallet_receive_description
                return actionsCell
            case [0,2]:
                actionsCell.actionImage.image = UIImage(named: "recive")!
                actionsCell.actionTitleLabel.text = LocalizationManager.share.translate?.result.list.wallet.wallet_receive_title
                actionsCell.actionDiscriptionLabel.text = LocalizationManager.share.translate?.result.list.wallet.wallet_share_description
                return actionsCell
            default:
                actionsCell.actionImage.image = UIImage(named: "qr")!
                actionsCell.actionTitleLabel.text = LocalizationManager.share.translate?.result.list.wallet.wallet_scan_address_title
                actionsCell.actionDiscriptionLabel.text = LocalizationManager.share.translate?.result.list.wallet.wallet_scan_address_description
                return actionsCell
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case self.walletCollectionView:
            return CGSize(width: 360, height: 220)
        case self.actionCollectionView:
            return CGSize(width: 190, height: 190)
        default:
            return CGSize.zero
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedWallet = self.wallet
        switch collectionView {
        case self.walletCollectionView:
            return
        case self.actionCollectionView:
            switch indexPath {
            case [0,0]:
                let pushVC = storyboard?.instantiateViewController(withIdentifier: "PushTokensViewController") as! PushTokensViewController
                pushVC.wallet = self.wallets[self.index]
                pushVC.isInMyWallet = true
                pushVC.isChia = self.wallet?.name == "Chia Wallet"
                pushVC.isChiaTest = self.wallet?.name == "Chia TestNet"
                pushVC.isChives = self.wallet?.name == "Chives Wallet"
                pushVC.isChivesTest = self.wallet?.name == "Chives TestNet"
                pushVC.modalPresentationStyle = .overFullScreen
                self.present(pushVC, animated: true)
            case [0,2]:
                let getTokenViewController = storyboard?.instantiateViewController(withIdentifier: "GetTokenViewController") as! GetTokenViewController
                getTokenViewController.isChia = self.wallet?.name == "Chia Wallet"
                getTokenViewController.isChiaTest = self.wallet?.name == "Chia TestNet"
                getTokenViewController.isChives = self.wallet?.name == "Chives Wallet"
                getTokenViewController.isChivesTest = self.wallet?.name == "Chives TestNet"
                getTokenViewController.modalPresentationStyle = .fullScreen
                self.present(getTokenViewController, animated: true)
                
            case [0,1]:
                let shareController = UIActivityViewController(activityItems: [self.wallets[index].adres], applicationActivities: nil)
                self.present(shareController, animated: true, completion: nil)
           
            default:
                let qrScanVC = storyboard?.instantiateViewController(withIdentifier: "QRScanViewController") as! QRScanViewController
                qrScanVC.modalPresentationStyle = .fullScreen
                self.present(qrScanVC, animated: true)
            
            
            }
        default:
            break
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.walletCollectionView.reloadData()
    }
    
}

struct MyWalletsButtons {
    var image: UIImage
    var title: String
    var discription: String
}
