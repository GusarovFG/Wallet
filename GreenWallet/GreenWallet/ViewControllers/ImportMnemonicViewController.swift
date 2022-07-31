//
//  ImportMnemonicViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 05.05.2022.
//
import UIKit

class ImportMnemonicViewController: UIViewController {
    
    var isChia = false
    var isChives = false
    var isChiaTest = false
    var isChivesTest = false
    var isMainScreen = false
    var spinnerVC = SprinnerViewController()
    
    private var isImporting = false
    private let nf = NumberFormatter()
    private var duplicates: [String] = []
    private var mnemonicPhrase: [String] = []
    private var countOfItems = 12
    private var checkBoxPress = false
    private var frameY: CGFloat = 0
    private var mnemonicIsOK = false
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        for _ in 0..<countOfItems {
            self.mnemonicPhrase.append("")
        }
        WalletManager.share.isUpdate = false
        self.collectionView.register(UINib(nibName: "ImportMnemonicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImportMnemonicCollectionViewCell")
        
        setuptermsLabel()
        registerFromKeyBoardNotifications()
        
        let spinStoryoard = UIStoryboard(name: "spinner", bundle: .main)
        self.spinnerVC = spinStoryoard.instantiateViewController(withIdentifier: "spinner") as! SprinnerViewController
        
        self.scrollView.isScrollEnabled = false
        
        self.continueButton.isEnabled = false
        self.segmentedControl.setTitleTextAttributes([.foregroundColor: #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1), .font: UIFont(name: "Helvetica-Bold", size: 18.0) ], for: .selected)
        self.segmentedControl.setTitleTextAttributes([.foregroundColor: #colorLiteral(red: 0.2784313725, green: 0.2784313725, blue: 0.2784313725, alpha: 1) ], for: .normal)
        
        if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
            self.continueButton.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1)
        } else {
            self.continueButton.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        }
        self.termsLabel.addRangeGesture(stringRange: "условиями пользования") {
            let termsVC = self.storyboard?.instantiateViewController(withIdentifier: "NewWalletViewController") as! NewWalletViewController
            termsVC.isChia = self.isChia
            termsVC.isChives = self.isChives
            termsVC.isChiaTest = self.isChiaTest
            termsVC.isChivesTest = self.isChivesTest
            termsVC.isFromImport = true
            termsVC.modalPresentationStyle = .fullScreen
            self.present(termsVC, animated: true)
            
        }
        if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
            let font = UIFont.systemFont(ofSize: 16)
            self.segmentedControl.selectedSegmentTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .selected)
            self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        } else {
            let font = UIFont.systemFont(ofSize: 16)
            self.segmentedControl.selectedSegmentTintColor = #colorLiteral(red: 0.246493727, green: 0.246493727, blue: 0.246493727, alpha: 1)
            self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)], for: .selected)
            self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2784313725, green: 0.2784313725, blue: 0.2784313725, alpha: 1)], for: .normal)
        }
        
        
        
        
        if UIDevice.modelName.contains("iPhone 8") || UIDevice.modelName.contains("iPhone 12") || UIDevice.modelName.contains("iPhone 13") {
            self.scrollView.isScrollEnabled = true
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(alertErrorGerCodingKeysPresent), name: NSNotification.Name("alertErrorGerCodingKeys"), object: nil)
    }
    
    @objc private func alertErrorGerCodingKeysPresent() {
        if self.isImporting {
            self.spinnerVC.dismiss(animated: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                AlertManager.share.errorBlockchainConnect(self)
            }
        } else {
            return
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    private func localization() {
        self.titleLabel.text = LocalizationManager.share.translate?.result.list.import_mnemonics.import_mnemonics_title
        self.descriptionLabel.text = LocalizationManager.share.translate?.result.list.import_mnemonics.import_mnemonics_description
        self.alertLabel.text = LocalizationManager.share.translate?.result.list.import_mnemonics.import_mnemonics_warning
        self.continueButton.setTitle(LocalizationManager.share.translate?.result.list.all.next_btn, for: .normal)
        self.errorLabel.text = LocalizationManager.share.translate?.result.list.import_mnemonics.import_mnemonics_same_words_error
        self.termsLabel.text = LocalizationManager.share.translate?.result.list.all.agreement_with_terms_of_use_chekbox
        self.segmentedControl.setTitle("12 \(LocalizationManager.share.translate?.result.list.import_mnemonics.import_mnemonics_twelve_words_btn ?? "")", forSegmentAt: 0)
        self.segmentedControl.setTitle("24 \(LocalizationManager.share.translate?.result.list.import_mnemonics.import_mnemonics_twenty_four_words_btn ?? "")", forSegmentAt: 1)
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
        
    }
    
    
    
    private func registerFromKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom)
        self.scrollView.setContentOffset(bottomOffset, animated: false)
        self.scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrame.height - 100)
        self.scrollView.isScrollEnabled = true
    }
    
    @objc private func keyboardWillHide() {
        self.scrollView.contentOffset = CGPoint.zero
        if self.countOfItems == 12 {
            if UIDevice.modelName.contains("iPhone 8") || UIDevice.modelName.contains("iPhone 12") || UIDevice.modelName.contains("iPhone 13") {
                self.scrollView.isScrollEnabled = true
            } else {
                self.scrollView.isScrollEnabled = false
                
            }
        }
    }
    
    func doubleToString(number: Double, numberOfDecimalPlaces: Int) -> String {
        return String(format:"%.*f", numberOfDecimalPlaces, number)
    }
    
    private func setuptermsLabel() {
        let split = self.termsLabel.text?.split(separator: " ")
        var first = ""
        var second = ""
        
        for i in 0..<(split?.count ?? 0){
            if i + 1 == split?.count || i + 2 == split?.count || i + 3 == split?.count {
                second += " \(split?[i] ?? "")"
            } else {
                first += "\(split?[i] ?? "") "
            }
            
        }
        let prefixString = first
        let infixAttributedString = NSAttributedString(
            string: second,
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)]
        )
        
        let attributedString = NSMutableAttributedString(string: prefixString)
        attributedString.append(infixAttributedString)
        
        self.termsLabel.attributedText = attributedString
        
        self.termsLabel.addRangeGesture(stringRange: second) {
            let url = URL(string: "https://devushka.ru/upload/posts/a1797083197722a6b1ab8e2f4beb2b08.jpg")
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!, options: [:])
            }
        }
    }
    
    @IBAction func segmentedControlIsChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.errorLabel.isHidden = true
            self.checkBoxPress = false
            self.checkBoxButton.setImage(UIImage(systemName: "squareshape.fill"), for: .normal)
            self.checkBoxButton.imageView?.layer.cornerRadius = 5
            self.checkBoxButton.tintColor = .white
            
            
            if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                self.continueButton.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1)
            } else {
                self.continueButton.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
            }
            self.continueButton.isEnabled = false
            
            self.countOfItems = 12
            
            for _ in 0...11 {
                self.mnemonicPhrase.removeLast()
            }
            
            
            self.scrollView.isScrollEnabled = true
            self.scrollView.setContentOffset(.zero, animated: true)
            self.collectionView.reloadData()
            self.bottomConstraint.constant = self.bottomConstraint.constant - (55 * 6)
        } else {
            self.errorLabel.isHidden = true
            self.checkBoxPress = false
            self.checkBoxButton.setImage(UIImage(systemName: "squareshape.fill"), for: .normal)
            self.checkBoxButton.imageView?.layer.cornerRadius = 5
            self.checkBoxButton.tintColor = .white
            
            
            if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                self.continueButton.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1)
            } else {
                self.continueButton.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
            }
            self.continueButton.isEnabled = false
            self.countOfItems = 24
            
            for _ in 0...11 {
                self.mnemonicPhrase.insert("", at: 12)
            }
            
            
            self.scrollView.isScrollEnabled = true
            
            self.collectionView.reloadData()
            self.bottomConstraint.constant = self.bottomConstraint.constant + (55 * 6)
        }
    }
    
    @IBAction func checkBoxButtonPressed(_ sender: UIButton) {
        if sender.imageView?.image != UIImage(systemName: "checkmark.square.fill") {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            sender.tintColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            sender.backgroundColor = .white
            sender.imageView?.layer.cornerRadius = 5
            
            self.checkBoxPress = true
            
            if self.mnemonicPhrase.filter({$0 == ""}).count == 0 {
                self.continueButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                self.continueButton.isEnabled = true
            }
            
        } else {
            sender.setImage(UIImage(systemName: "squareshape.fill"), for: .normal)
            sender.imageView?.layer.cornerRadius = 5
            sender.tintColor = .white
            
            self.checkBoxPress = false
            
            if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                self.continueButton.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1)
            } else {
                self.continueButton.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
            }
            self.continueButton.isEnabled = false
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        
        
        var duplicateWords: [String] = []
        var duplicateCount = 0
        var adreses = ""
        var name = ""
        
        var newbalance = ""
        var wallets: [ChiaWallet] = []
        var id = ""
        var token : [String] = []
        var tokens: [[String]] = []
        var privateKey = ChiaPrivate(private_key: ChiaPrivateKey(farmer_pk: "", fingerprint: 0, pk: "", pool_pk: "", seed: "", sk: ""), success: true)
        
        for i in 0..<self.mnemonicPhrase.count {
            if self.mnemonicPhrase.filter({$0 == self.mnemonicPhrase[i]}).count >= 2 && !duplicateWords.contains(self.mnemonicPhrase[i]){
                duplicateWords.append(self.mnemonicPhrase[i])
                print(duplicateWords)
            }
        }
        
        for i in 0..<self.collectionView.visibleCells.count {
            for duplicate in duplicateWords {
                if (self.collectionView.visibleCells[i] as! ImportMnemonicCollectionViewCell).cellTextLabel.text == duplicate {
                    (self.collectionView.visibleCells[i] as! ImportMnemonicCollectionViewCell).cellTextLabel.textColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
                    (self.collectionView.visibleCells[i] as! ImportMnemonicCollectionViewCell).layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
                    self.errorLabel.isHidden = false
                }
            }
        }
        
        for word in self.mnemonicPhrase {
            if self.mnemonicPhrase.filter({$0 == word}).count >= 2 {
                duplicateCount += 1
                print(duplicateCount)
            }
        }
        
        self.duplicates = duplicateWords
        
        if duplicateCount == 0 {
            if CoreDataManager.share.fetchChiaWalletPrivateKey().count == 10 {
                AlertManager.share.errorCountOfWallet(self)
            } else {
                
                self.present(spinnerVC, animated: true)
                self.isImporting = true
                if self.isChia {
                    
                    
                    DispatchQueue.global().async {
                        
                        
                        
                        ChiaBlockchainManager.share.importMnemonic(self.mnemonicPhrase) { fingerpring in
                            print(fingerpring.fingerprint)
                            if CoreDataManager.share.fetchChiaWalletPrivateKey().filter({$0.fingerprint == fingerpring.fingerprint}).isEmpty {
                                
                                CoreDataManager.share.saveChiaWaletFingerpring(fingerpring.fingerprint)
                                ChiaBlockchainManager.share.getNextAddress(walletID: Int64(1)) { adres in
                                    adreses = adres.address
                                    
                                    print(adreses)
                                    
                                }
                                
                                ChiaBlockchainManager.share.logIn(fingerpring.fingerprint) { log in
                                    if log.success {
                                        print(log.success)
                                    }
                                }
//                                    DispatchQueue.global().asyncAfter(deadline: .now() + 15) {
//                                        
//                                        ChiaBlockchainManager.share.getSyncStatus(1) { status in
//                                            DispatchQueue.global().asyncAfter(deadline: .now() + 15) {
//                                                ChiaBlockchainManager.share.addCat(tailHash: "1dd54162ec6423211556155fa455d4ed1a52ad305e6b5249eba50c91c8428dfb") { newCat in
//                                                    print(newCat.success)
//                                                }
//                                            }
//                                        }
//                                        ChiaBlockchainManager.share.getSyncStatus(1) { status in
//                                            DispatchQueue.global().asyncAfter(deadline: .now() + 15) {
//                                                ChiaBlockchainManager.share.addCat(tailHash: "6d95dae356e32a71db5ddcb42224754a02524c615c5fc35f568c2af04774e589") { newCat in
//                                                    print(newCat.success)
//                                                }
//                                            }
//                                        }
//                                    }
                                    
                                    ChiaBlockchainManager.share.getWallets { wallets in
                                        for wallet in wallets.wallets {
                                            
                                            
                                            
                                            ChiaBlockchainManager.share.getWalletBalance(wallet.id) { balance in
                                                newbalance = "\(balance.wallet_balance.confirmed_wallet_balance)"
                                                id = "\(wallet.id)"
                                                name = wallet.name
                                                token.append(name)
                                                token.append(id)
                                                token.append("\(balance.wallet_balance.confirmed_wallet_balance)")
                                                token.append("show")
                                                tokens.append(token)
                                                token.removeAll()
                                            }
                                        }
                                        ChiaBlockchainManager.share.getPrivateKey(fingerpring.fingerprint) { privateKeys in
                                            privateKey = privateKeys
                                            print(privateKey)
                                            
                                            
                                            
                                            UserDefaultsManager.shared.userDefaults.set("Exist", forKey: UserDefaultsStringKeys.walletExist.rawValue )
                                            CoreDataManager.share.saveChiaWalletPrivateKey(name: "Chia Wallet", fingerprint: privateKey.private_key.fingerprint, pk: privateKey.private_key.pk, seed: privateKey.private_key.seed, sk: privateKey.private_key.seed, adress: adreses, tokens: tokens)
                                            guard let newWallet = CoreDataManager.share.fetchChiaWalletPrivateKey().last else { return }
                                            WalletManager.share.favoritesWallets.append(newWallet)
                                            DispatchQueue.main.async {
                                                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                                                print(CoreDataManager.share.fetchChiaWalletPrivateKey())
                                                self.spinnerVC.dismiss(animated: true, completion: nil)
                                                AlertManager.share.seccessImportWallet(self)
                                            }
                                        }
                                        
                                        
                                    }
                                
                            } else {
                                DispatchQueue.main.async {
                                    self.spinnerVC.dismiss(animated: true)
                                    AlertManager.share.dulpicateWalletError(self)
                                }
                            }
                        }
                    }
                    
                    
                } else if self.isChives {
                    DispatchQueue.global().sync {
                        
                        
                        
                        ChivesBlockchainManager.share.importMnemonic(self.mnemonicPhrase) { fingerpring in
                            print(fingerpring.fingerprint)
                            if CoreDataManager.share.fetchChiaWalletPrivateKey().filter({$0.fingerprint == fingerpring.fingerprint}).isEmpty {
                                
                                CoreDataManager.share.saveChiaWaletFingerpring(fingerpring.fingerprint)
                                
                                ChivesBlockchainManager.share.logIn(fingerpring.fingerprint) { log in
                                    if log.success {
                                        ChivesBlockchainManager.share.getWallets { wallets in
                                            for wallet in wallets.wallets {
                                                name = wallet.name
                                                id = "\(wallet.id)"
                                                ChivesBlockchainManager.share.getNextAddress(walletID: Int64(wallet.id)) { adres in
                                                    adreses = adres.address
                                                    print(adreses)
                                                    
                                                }
                                                ChivesBlockchainManager.share.getWalletBalance(wallet.id) { balance in
                                                    newbalance = "\(balance.wallet_balance.confirmed_wallet_balance)"
                                                    token.insert(name, at: 0)
                                                    token.insert(id, at: 1)
                                                    token.insert(newbalance, at: 2)
                                                    token.insert("show", at: 3)
                                                    tokens.append(token)
                                                    
                                                }
                                                
                                            }
                                            ChivesBlockchainManager.share.getPrivateKey(fingerpring.fingerprint) { privateKeys in
                                                privateKey = privateKeys
                                                print(privateKey)
                                                
                                                
                                                UserDefaultsManager.shared.userDefaults.set("Exist", forKey: UserDefaultsStringKeys.walletExist.rawValue )
                                                CoreDataManager.share.saveChiaWalletPrivateKey(name: "Chives Wallet", fingerprint: privateKey.private_key.fingerprint, pk: privateKey.private_key.pk, seed: privateKey.private_key.seed, sk: privateKey.private_key.seed, adress: adreses, tokens: tokens)
                                                guard let newWallet = CoreDataManager.share.fetchChiaWalletPrivateKey().last else { return }
                                                WalletManager.share.favoritesWallets.append(newWallet)
                                                DispatchQueue.main.async {
                                                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                                                    print(CoreDataManager.share.fetchChiaWalletPrivateKey())
                                                    self.spinnerVC.dismiss(animated: true, completion: nil)
                                                    AlertManager.share.seccessImportWallet(self)
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.spinnerVC.dismiss(animated: true)
                                    AlertManager.share.dulpicateWalletError(self)
                                }
                            }
                        }
                    }
                } else if self.isChiaTest {
                    DispatchQueue.global().sync {
                        
                        
                        
                        ChiaTestBlockchainManager.share.importMnemonic(self.mnemonicPhrase) { fingerpring in
                            print(fingerpring.fingerprint)
                            if CoreDataManager.share.fetchChiaWalletPrivateKey().filter({$0.fingerprint == fingerpring.fingerprint}).isEmpty {
                                
                                CoreDataManager.share.saveChiaWaletFingerpring(fingerpring.fingerprint)
                                
                                ChiaTestBlockchainManager.share.logIn(fingerpring.fingerprint) { log in
                                    if log.success {
                                        ChiaTestBlockchainManager.share.getWallets { wallets in
                                            for wallet in wallets.wallets {
                                                name = wallet.name
                                                id = "\(wallet.id)"
                                                
                                                ChiaTestBlockchainManager.share.getNextAddress(walletID: Int64(wallet.id)) { adres in
                                                    adreses = adres.address
                                                    print(adreses)
                                                    
                                                }
                                                ChiaTestBlockchainManager.share.getWalletBalance(wallet.id) { balance in
                                                    newbalance = "\(balance.wallet_balance.confirmed_wallet_balance)"
                                                    token.append(name)
                                                    token.append(id)
                                                    token.append(newbalance)
                                                    token.append("show")
                                                    tokens.append(token)
                                                    
                                                }
                                                
                                            }
                                            ChiaTestBlockchainManager.share.getPrivateKey(fingerpring.fingerprint) { privateKeys in
                                                privateKey = privateKeys
                                                print(privateKey)
                                                
                                                
                                                UserDefaultsManager.shared.userDefaults.set("Exist", forKey: UserDefaultsStringKeys.walletExist.rawValue )
                                                CoreDataManager.share.saveChiaWalletPrivateKey(name: "Chia TestNet", fingerprint: privateKey.private_key.fingerprint, pk: privateKey.private_key.pk, seed: privateKey.private_key.seed, sk: privateKey.private_key.seed, adress: adreses, tokens: tokens)
                                                guard let newWallet = CoreDataManager.share.fetchChiaWalletPrivateKey().last else { return }
                                                WalletManager.share.favoritesWallets.append(newWallet)
                                                DispatchQueue.main.async {
                                                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                                                    print(CoreDataManager.share.fetchChiaWalletPrivateKey())
                                                    self.spinnerVC.dismiss(animated: true, completion: nil)
                                                    AlertManager.share.seccessImportWallet(self)
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.spinnerVC.dismiss(animated: true)
                                    AlertManager.share.dulpicateWalletError(self)
                                }
                            }
                        }
                    }
                } else if self.isChivesTest {
                    DispatchQueue.global().sync {
                        
                        
                        
                        ChivesTestBlockchainManager.share.importMnemonic(self.mnemonicPhrase) { fingerpring in
                            print(fingerpring.fingerprint)
                            if CoreDataManager.share.fetchChiaWalletPrivateKey().filter({$0.fingerprint == fingerpring.fingerprint}).isEmpty {
                                
                                CoreDataManager.share.saveChiaWaletFingerpring(fingerpring.fingerprint)
                                
                                ChivesTestBlockchainManager.share.logIn(fingerpring.fingerprint) { log in
                                    if log.success {
                                        ChivesTestBlockchainManager.share.getWallets { wallets in
                                            for wallet in wallets.wallets {
                                                name = wallet.name
                                                id = "\(wallet.id)"
                                                ChivesTestBlockchainManager.share.getNextAddress(walletID: Int64(wallet.id)) { adres in
                                                    adreses = adres.address
                                                    print(adreses)
                                                    
                                                }
                                                ChivesTestBlockchainManager.share.getWalletBalance(wallet.id) { balance in
                                                    newbalance = "\(balance.wallet_balance.confirmed_wallet_balance)"
                                                    token.insert(name, at: 0)
                                                    token.insert(id, at: 1)
                                                    token.insert(newbalance, at: 2)
                                                    token.insert("show", at: 3)
                                                    tokens.append(token)
                                                    
                                                    
                                                }
                                                
                                            }
                                            ChivesTestBlockchainManager.share.getPrivateKey(fingerpring.fingerprint) { privateKeys in
                                                privateKey = privateKeys
                                                print(privateKey)
                                                
                                                
                                                UserDefaultsManager.shared.userDefaults.set("Exist", forKey: UserDefaultsStringKeys.walletExist.rawValue )
                                                CoreDataManager.share.saveChiaWalletPrivateKey(name: "Chives TestNet", fingerprint: privateKey.private_key.fingerprint, pk: privateKey.private_key.pk, seed: privateKey.private_key.seed, sk: privateKey.private_key.seed, adress: adreses, tokens: tokens)
                                                guard let newWallet = CoreDataManager.share.fetchChiaWalletPrivateKey().last else { return }
                                                WalletManager.share.favoritesWallets.append(newWallet)
                                                DispatchQueue.main.async {
                                                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                                                    print(CoreDataManager.share.fetchChiaWalletPrivateKey())
                                                    self.spinnerVC.dismiss(animated: true, completion: nil)
                                                    AlertManager.share.seccessImportWallet(self)
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.spinnerVC.dismiss(animated: true)
                                    AlertManager.share.dulpicateWalletError(self)
                                }
                            }
                        }
                    }
                }
            }
            
        }
    }
    
    @IBAction func tapHideKeyBoard(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("HideCellKeyboard"), object: nil)
        self.view.frame.origin.y = 0
    }
}

extension ImportMnemonicViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.countOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImportMnemonicCollectionViewCell", for: indexPath) as! ImportMnemonicCollectionViewCell
        
        cell.cellTextLabel.tag = indexPath.row
        cell.cellTextLabel.delegate = self
        cell.controller = self
        
        
        if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
            cell.cellTextLabel.textColor = .black
        } else {
            cell.cellTextLabel.textColor = .white
        }
        
        
        
        let mnemonicWord = self.mnemonicPhrase[indexPath.row]
        if mnemonicWord == "" {
            cell.cellTextLabel.placeholder = "\(indexPath.row + 1)."
            cell.cellTextLabel.text = mnemonicWord
            cell.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        } else {
            cell.cellTextLabel.text = mnemonicWord
        }
        
        if cell.cellTextLabel.text == "" && self.checkBoxPress  {
            cell.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
        } else {
            cell.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        }
        
        if self.mnemonicPhrase.count == 24 && self.mnemonicPhrase.filter({$0 != ""}).count == 12 {
            if indexPath >= [0,6], indexPath <= [0,11] {
                cell.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
            } else if indexPath >= [0,18], indexPath <= [0,23] {
                cell.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
            }
        }
        
        
        cell.appendInPhrase = { [unowned self] in
            
            if cell.cellTextLabel.text != "" {
                self.errorLabel.isHidden = true
                
                if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                    cell.cellTextLabel.textColor = .black
                    cell.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                } else {
                    cell.cellTextLabel.textColor = .white
                    cell.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                }
                
                for i in 0..<self.collectionView.visibleCells.count {
                    for duplicate in self.duplicates {
                        if (self.collectionView.visibleCells[i] as! ImportMnemonicCollectionViewCell).cellTextLabel.text == duplicate {
                            if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                                (self.collectionView.visibleCells[i] as! ImportMnemonicCollectionViewCell).cellTextLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                            } else {
                                (self.collectionView.visibleCells[i] as! ImportMnemonicCollectionViewCell).cellTextLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                            }
                            (self.collectionView.visibleCells[i] as! ImportMnemonicCollectionViewCell).layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                            
                        }
                    }
                }
                
                
                if self.countOfItems == 12 || self.countOfItems == 24 {
                    if self.mnemonicPhrase.filter({$0 == ""}).count == 0 && self.checkBoxPress {
                        self.continueButton.isEnabled = true
                        self.continueButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                    } else {
                        self.continueButton.isEnabled = false
                        if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                            self.continueButton.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1)
                        } else {
                            self.continueButton.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
                        }
                    }
                }
                
                
                self.mnemonicPhrase.remove(at: indexPath.row)
                self.mnemonicPhrase.insert(cell.cellTextLabel.text ?? "", at: indexPath.row)
            } else {
                self.mnemonicPhrase.remove(at: indexPath.row)
                self.mnemonicPhrase.insert("", at: indexPath.row)
                cell.cellTextLabel.placeholder = "\(indexPath.row + 1)."
                cell.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            }
        }
        
        cell.endEditing = { [unowned self] in
            if self.countOfItems == 12 || self.countOfItems == 24 {
                if self.mnemonicPhrase.filter({$0 == ""}).count == 0 && self.checkBoxPress && cell.cellTextLabel.text != "" && cell.cellTextLabel.text != " " {
                    self.continueButton.isEnabled = true
                    self.continueButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                } else {
                    self.continueButton.isEnabled = false
                    if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                        self.continueButton.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1)
                    } else {
                        self.continueButton.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
                    }
                }
            }
        }
        
        if self.countOfItems == 24  {
            if cell.cellTextLabel.text!.isEmpty && self.mnemonicPhrase.filter({$0.isEmpty}).count != 24 {
                cell.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
            } else {
                
                cell.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            }
        }
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: (collectionView.frame.width / 2) - 15, height: 50)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
}

extension ImportMnemonicViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        if textField.tag == (self.countOfItems - 1) {
            textField.resignFirstResponder()
            self.view.frame.origin.y = 0
        } else {
            let nextCell = self.collectionView?.cellForItem(at: IndexPath.init(row: textField.tag + 1, section: 0)) as! ImportMnemonicCollectionViewCell
            if let nextField = nextCell.cellTextLabel {
                nextField.becomeFirstResponder()
                if self.countOfItems == 24 {
                    if textField.tag >= 5 && textField.tag <= 10 || textField.tag > 16 {
                        self.view.frame.origin.y -= nextCell.frame.height
                        
                    } else if textField.tag == 11 {
                        self.view.frame.origin.y = 0
                    }
                    
                } else {
                    return true
                }
            }
        }
        
        return true
    }
}

