//
//  VerifyMnemonicViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 03.05.2022.
//
import MnemonicSwift
import UIKit
import CryptoSwift

class VerifyMnemonicViewController: UIViewController {
    
    var mnemonicPhrase: [String] = []
    var isChia = false
    var isChives = false
    var isChiaTest = false
    var isChivesTest = false
    var isMainScreen = false
    var spinnerVC = SprinnerViewController()
    
    private let indexes: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    private var verifyedMnemonicPhrase: [String] = []
    private var selectPhrase: [String] = []
    private var selectIndex = 6
    private var errorVarify = false
    private var firstWord = true
    private let alert = AlertService()
    
    
    @IBOutlet weak var pleaseLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var veryfyCollectionView: UICollectionView!
    @IBOutlet weak var selectCollectionView: UICollectionView!
    @IBOutlet weak var errorLabel: UIView!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var errorTitle: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        self.errorLabel.alpha = 0
        self.errorLabel.isHidden = true
        WalletManager.share.isUpdate = false
        let storyoard = UIStoryboard(name: "spinner", bundle: .main)
        self.spinnerVC = storyoard.instantiateViewController(withIdentifier: "spinner") as! SprinnerViewController
        
        self.veryfyCollectionView.register(UINib(nibName: "MnemonicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mnemonicCell")
        self.selectCollectionView.register(UINib(nibName: "MnemonicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mnemonicCell")
        self.continueButton.isEnabled = false
        
        if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
            self.continueButton.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1)
        } else {
            self.continueButton.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(alertErrorGerCodingKeysPresent), name: NSNotification.Name("alertErrorGerCodingKeys"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for i in 0..<self.mnemonicPhrase.count {
            if i < 6  {
                self.verifyedMnemonicPhrase.append(self.mnemonicPhrase[i])
            } else  if i >= 5 && i <= 11{
                self.verifyedMnemonicPhrase.append("")
                self.selectPhrase.append(self.mnemonicPhrase[i])
            }
        }
        self.selectPhrase.shuffle()
        
        print(verifyedMnemonicPhrase)
        print(selectPhrase)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @objc private func alertErrorGerCodingKeysPresent() {
        self.spinnerVC.dismiss(animated: false)
        AlertManager.share.serverError(self.spinnerVC)
    }
    
    private func localization() {
        self.titleLabel.text = LocalizationManager.share.translate?.result.list.mnemonic_phrase_verification.mnemonic_phrase_verification_title
        self.discriptionLabel.text = LocalizationManager.share.translate?.result.list.mnemonic_phrase_verification.mnemonic_phrase_verification_description
        self.pleaseLabel.text = LocalizationManager.share.translate?.result.list.mnemonic_phrase_verification.mnemonic_phrase_verification_task
        self.continueButton.setTitle(LocalizationManager.share.translate?.result.list.all.next_btn, for: .normal)
        self.errorTitle.text = LocalizationManager.share.translate?.result.list.mnemonic_phrase_verification.mnemonic_phrase_verification_error
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func mainButtonPressed(_ sender: Any) {
        if self.verifyedMnemonicPhrase == self.mnemonicPhrase {
  
            print(self.mnemonicPhrase)
            var name = ""
            var newbalance = ""
            var id = ""
            var adreses = ""
            var token: [String] = []
            var tokens: [[String]] = []
            var privateKey = ChiaPrivate(private_key: ChiaPrivateKey(farmer_pk: "", fingerprint: 0, pk: "", pool_pk: "", seed: "", sk: ""), success: true)


          
            let dispatchGroup = DispatchGroup()
            if CoreDataManager.share.fetchChiaWalletPrivateKey().count == 10 {
                AlertManager.share.errorCountOfWallet(self)
            } else {
                self.present(self.spinnerVC, animated: true)
                if isChia {
                    
                    DispatchQueue.global().sync {
                        
                        
                        
                        dispatchGroup.enter()
                        ChiaBlockchainManager.share.addKey(self.mnemonicPhrase, self) { fingerpring in
                            print(fingerpring.fingerprint)
                            dispatchGroup.leave()
                            dispatchGroup.enter()
                            CoreDataManager.share.saveChiaWaletFingerpring(fingerpring.fingerprint)
                            dispatchGroup.leave()
                            dispatchGroup.enter()
                            ChiaBlockchainManager.share.logIn(fingerpring.fingerprint) { log in
                                if log.success {
                                    dispatchGroup.leave()
                                }
                            }
                            dispatchGroup.enter()
                            ChiaBlockchainManager.share.getSyncStatus(1) { status in
                                DispatchQueue.global().asyncAfter(deadline: .now() + 10) {
                                    ChiaBlockchainManager.share.addCat(tailHash: "1dd54162ec6423211556155fa455d4ed1a52ad305e6b5249eba50c91c8428dfb", self) { newCat in
                                        print(newCat.success)
                                        dispatchGroup.leave()
                                    }
                                }
                            }
                            
                            dispatchGroup.enter()
                            ChiaBlockchainManager.share.getNextAddress(walletID: Int64(1)) { adres in
                                adreses = adres.address
                                print(adreses)
                                dispatchGroup.leave()
                            }
                            
                            ChiaBlockchainManager.share.getWallets { wallets in
                                dispatchGroup.enter()
                                for wallet in wallets.wallets {
                                    dispatchGroup.enter()
                                    name = wallet.name
                                    id = "\(wallet.id)"
                                    
                                    dispatchGroup.leave()
                                    dispatchGroup.enter()
                                    dispatchGroup.leave()
                                    dispatchGroup.enter()
                                    ChiaBlockchainManager.share.getWalletBalance(wallet.id) { balance in
                                        newbalance = "\(balance.wallet_balance.confirmed_wallet_balance)"
                                        token.insert(name, at: 0)
                                        token.insert(id, at: 1)
                                        token.insert(newbalance, at: 2)
                                        token.insert("show", at: 3)
                                        tokens.append(token)
                                    }
                                    dispatchGroup.leave()
                                    
                                }
                                dispatchGroup.enter()
                                ChiaBlockchainManager.share.getPrivateKey(fingerpring.fingerprint) { privateKeys in
                                    privateKey = privateKeys
                                    print(privateKey)
                                    dispatchGroup.leave()
                                    dispatchGroup.enter()
                                    
                                    let value = privateKey.private_key.seed
                                    let encryptedValue = try! value.aesEncrypt(key: KeyChainManager.share.loadPassword())
                                    
                                    UserDefaultsManager.shared.userDefaults.set("Exist", forKey: UserDefaultsStringKeys.walletExist.rawValue )
                                    CoreDataManager.share.saveChiaWalletPrivateKey(name: "Chia Wallet", fingerprint: privateKey.private_key.fingerprint, pk: privateKey.private_key.pk, seed: encryptedValue, sk: encryptedValue, adress: adreses, tokens: tokens)
                                    
                                    dispatchGroup.leave()
                                    dispatchGroup.enter()
                                    guard let newWallet = CoreDataManager.share.fetchChiaWalletPrivateKey().last else { return }
                                    WalletManager.share.favoritesWallets.append(newWallet)
                                    dispatchGroup.leave()
                                }
                                dispatchGroup.notify(queue: .main) {
                                    print("Downloading complition")
                                }
                                
                            }
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                                print(CoreDataManager.share.fetchChiaWalletPrivateKey())
                                self.spinnerVC.dismiss(animated: true, completion: nil)
                                AlertManager.share.seccessNewWallet(self)
                            }
                        }
                    }
                } else if self.isChives {
                    DispatchQueue.global().sync {
                        
                        
                        
                        dispatchGroup.enter()
                        ChivesBlockchainManager.share.addKey(self.mnemonicPhrase, self) { fingerpring in
                            print(fingerpring.fingerprint)
                            dispatchGroup.leave()
                            dispatchGroup.enter()
                            CoreDataManager.share.saveChiaWaletFingerpring(fingerpring.fingerprint)
                            dispatchGroup.leave()
                            dispatchGroup.enter()
                            ChivesBlockchainManager.share.logIn(fingerpring.fingerprint) { log in
                                if log.success {
                                    dispatchGroup.leave()
                                }
                            }
                            dispatchGroup.enter()
                            ChivesBlockchainManager.share.getNextAddress(walletID: Int64(1)) { adres in
                                adreses = adres.address
                                print(adreses)
                                dispatchGroup.leave()
                            }
                            
                            ChivesBlockchainManager.share.getWallets { wallets in
                                dispatchGroup.enter()
                                for wallet in wallets.wallets {
                                    dispatchGroup.enter()
                                    name = wallet.name
                                    id = "\(wallet.id)"
                                    dispatchGroup.leave()
                                    dispatchGroup.enter()
                                    dispatchGroup.leave()
                                    dispatchGroup.enter()
                                    ChivesBlockchainManager.share.getWalletBalance(wallet.id) { balance in
                                        newbalance = "\(balance.wallet_balance.confirmed_wallet_balance)"
                                        token.insert(name, at: 0)
                                        token.insert(id, at: 1)
                                        token.insert(newbalance, at: 2)
                                        token.insert("show", at: 3)
                                        tokens.append(token)
                                    }
                                    dispatchGroup.leave()
                                    
                                }
                                dispatchGroup.enter()
                                ChivesBlockchainManager.share.getPrivateKey(fingerpring.fingerprint) { privateKeys in
                                    privateKey = privateKeys
                                    print(privateKey)
                                    dispatchGroup.leave()
                                    dispatchGroup.enter()
                                    
                                    let value = privateKey.private_key.seed
                                    let encryptedValue = try! value.aesEncrypt(key: KeyChainManager.share.loadPassword())
                                    
                                    UserDefaultsManager.shared.userDefaults.set("Exist", forKey: UserDefaultsStringKeys.walletExist.rawValue )
                                    CoreDataManager.share.saveChiaWalletPrivateKey(name: "Chives Wallet", fingerprint: privateKey.private_key.fingerprint, pk: privateKey.private_key.pk, seed: encryptedValue, sk: encryptedValue, adress: adreses, tokens: tokens)
                                    dispatchGroup.leave()
                                    dispatchGroup.enter()
                                    guard let newWallet = CoreDataManager.share.fetchChiaWalletPrivateKey().last else { return }
                                    WalletManager.share.favoritesWallets.append(newWallet)
                                    dispatchGroup.leave()
                                }
                                dispatchGroup.notify(queue: .main) {
                                    print("Downloading complition")
                                }
                                
                            }
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                                print(CoreDataManager.share.fetchChiaWalletPrivateKey())
                                self.spinnerVC.dismiss(animated: true, completion: nil)
                                AlertManager.share.seccessNewWallet(self)
                            }
                        }
                    }
                } else if self.isChiaTest {
                    DispatchQueue.global().sync {
                        
                        
                        
                        dispatchGroup.enter()
                        ChiaTestBlockchainManager.share.addKey(self.mnemonicPhrase, self) { fingerpring in
                            print(fingerpring.fingerprint)
                            dispatchGroup.leave()
                            dispatchGroup.enter()
                            CoreDataManager.share.saveChiaWaletFingerpring(fingerpring.fingerprint)
                            dispatchGroup.leave()
                            dispatchGroup.enter()
                            ChiaTestBlockchainManager.share.logIn(fingerpring.fingerprint) { log in
                                if log.success {
                                    dispatchGroup.leave()
                                }
                            }
                            dispatchGroup.enter()
                            ChiaTestBlockchainManager.share.getNextAddress(walletID: Int64(1)) { adres in
                                adreses = adres.address
                                
                                print(adreses)
                                dispatchGroup.leave()
                            }
                            
                            ChiaTestBlockchainManager.share.getWallets { wallets in
                                dispatchGroup.enter()
                                for wallet in wallets.wallets {
                                    dispatchGroup.enter()
                                    name = wallet.name
                                    id = "\(wallet.id)"
                                    dispatchGroup.leave()
                                    dispatchGroup.enter()
                                    dispatchGroup.leave()
                                    dispatchGroup.enter()
                                    ChiaTestBlockchainManager.share.getWalletBalance(wallet.id) { balance in
                                        newbalance = "\(balance.wallet_balance.confirmed_wallet_balance)"
                                        token.insert(name, at: 0)
                                        token.insert(id, at: 1)
                                        token.insert(newbalance, at: 2)
                                        token.insert("show", at: 3)
                                        tokens.append(token)
                                    }
                                    dispatchGroup.leave()
                                    
                                }
                                dispatchGroup.enter()
                                ChiaTestBlockchainManager.share.getPrivateKey(fingerpring.fingerprint) { privateKeys in
                                    privateKey = privateKeys
                                    print(privateKey)
                                    dispatchGroup.leave()
                                    dispatchGroup.enter()
                                    
                                    let value = privateKey.private_key.seed
                                    let encryptedValue = try! value.aesEncrypt(key: KeyChainManager.share.loadPassword())
                                    
                                    UserDefaultsManager.shared.userDefaults.set("Exist", forKey: UserDefaultsStringKeys.walletExist.rawValue )
                                    CoreDataManager.share.saveChiaWalletPrivateKey(name: "Chia TestNet", fingerprint: privateKey.private_key.fingerprint, pk: privateKey.private_key.pk, seed: encryptedValue, sk: encryptedValue, adress: adreses, tokens: tokens)
                                    dispatchGroup.leave()
                                    dispatchGroup.enter()
                                    guard let newWallet = CoreDataManager.share.fetchChiaWalletPrivateKey().last else { return }
                                    WalletManager.share.favoritesWallets.append(newWallet)
                                    dispatchGroup.leave()
                                }
                                dispatchGroup.notify(queue: .main) {
                                    print("Downloading complition")
                                }
                                
                            }
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                                print(CoreDataManager.share.fetchChiaWalletPrivateKey())
                                self.spinnerVC.dismiss(animated: true, completion: nil)
                                AlertManager.share.seccessNewWallet(self)
                            }
                        }
                    }
                } else if self.isChivesTest {
                    DispatchQueue.global().sync {
                        
                        
                        
                        dispatchGroup.enter()
                        ChivesTestBlockchainManager.share.addKey(self.mnemonicPhrase, self) { fingerpring in
                            print(fingerpring.fingerprint)
                            dispatchGroup.leave()
                            dispatchGroup.enter()
                            CoreDataManager.share.saveChiaWaletFingerpring(fingerpring.fingerprint)
                            dispatchGroup.leave()
                            dispatchGroup.enter()
                            ChivesTestBlockchainManager.share.logIn(fingerpring.fingerprint) { log in
                                if log.success {
                                    dispatchGroup.leave()
                                }
                            }
                            dispatchGroup.enter()
                            
                            ChivesTestBlockchainManager.share.getNextAddress(walletID: Int64(1)) { adres in
                                adreses = adres.address
                                print(adreses)
                                dispatchGroup.leave()
                            }
                            
                            ChivesTestBlockchainManager.share.getWallets { wallets in
                                dispatchGroup.enter()
                                for wallet in wallets.wallets {
                                    dispatchGroup.enter()
                                    name = wallet.name
                                    id = "\(wallet.id)"
                                    dispatchGroup.leave()
                                    dispatchGroup.enter()
                                    dispatchGroup.leave()
                                    dispatchGroup.enter()
                                    ChivesTestBlockchainManager.share.getWalletBalance(wallet.id) { balance in
                                        newbalance = "\(balance.wallet_balance.confirmed_wallet_balance)"
                                        token.insert(name, at: 0)
                                        token.insert(id, at: 1)
                                        token.insert(newbalance, at: 2)
                                        token.insert("show", at: 3)
                                        tokens.append(token)
                                    }
                                    dispatchGroup.leave()
                                    
                                }
                                dispatchGroup.enter()
                                ChivesTestBlockchainManager.share.getPrivateKey(fingerpring.fingerprint) { privateKeys in
                                    privateKey = privateKeys
                                    print(privateKey)
                                    dispatchGroup.leave()
                                    dispatchGroup.enter()
                                    
                                    let value = privateKey.private_key.seed
                                    let encryptedValue = try! value.aesEncrypt(key: KeyChainManager.share.loadPassword())
                                    
                                    UserDefaultsManager.shared.userDefaults.set("Exist", forKey: UserDefaultsStringKeys.walletExist.rawValue )
                                    CoreDataManager.share.saveChiaWalletPrivateKey(name: "Chives TestNet", fingerprint: privateKey.private_key.fingerprint, pk: privateKey.private_key.pk, seed: encryptedValue, sk: encryptedValue, adress: adreses, tokens: tokens)
                                    dispatchGroup.leave()
                                    dispatchGroup.enter()
                                    guard let newWallet = CoreDataManager.share.fetchChiaWalletPrivateKey().last else { return }
                                    WalletManager.share.favoritesWallets.append(newWallet)
                                    dispatchGroup.leave()
                                }
                                dispatchGroup.notify(queue: .main) {
                                    print("Downloading complition")
                                }
                                
                            }
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                                print(CoreDataManager.share.fetchChiaWalletPrivateKey())
                                self.spinnerVC.dismiss(animated: true, completion: nil)
                                AlertManager.share.seccessNewWallet(self)
                            }
                        }
                    }
                }
            }
                
                } else {
            self.errorLabel.isHidden = false
            UIView.animate(withDuration: 1) {
                self.errorLabel.alpha = 1
                self.errorVarify = true
                self.veryfyCollectionView.visibleCells.forEach({$0.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157) })
                self.veryfyCollectionView.visibleCells.forEach({$0.backgroundColor = .systemBackground })
                self.veryfyCollectionView.reloadData()
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                UIView.animate(withDuration: 1) {
                    self.errorLabel.alpha = 0
                    self.veryfyCollectionView.visibleCells.forEach({$0.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1) })
                    
                    self.verifyedMnemonicPhrase.removeAll()
                    self.selectPhrase.removeAll()
                    for i in 0..<self.mnemonicPhrase.count {
                        if i < 6 {
                            self.verifyedMnemonicPhrase.append(self.mnemonicPhrase[i])
                        } else {
                            
                            self.verifyedMnemonicPhrase.append("")
                            self.selectPhrase.append(self.mnemonicPhrase[i])
                            self.selectPhrase.shuffle()
                            self.errorVarify = false
                            self.veryfyCollectionView.reloadData()
                            self.selectCollectionView.reloadData()
                        }
                    }
                    self.selectIndex = 6
                }
            }
        }
    }
    
    @IBAction func clouseErrorLabel(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.errorLabel.alpha = 0
        }
        self.errorLabel.isHidden = true
    }
    
}

extension VerifyMnemonicViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.veryfyCollectionView:
            return 12
        case self.selectCollectionView:
            return self.selectPhrase.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mnemonicCell", for: indexPath) as! MnemonicCollectionViewCell
        cell.tag = indexPath.row
        
        print(self.verifyedMnemonicPhrase)
        print(self.mnemonicPhrase)
        switch collectionView {
        case self.veryfyCollectionView:
            cell.mnemonicWord.text = "\(self.indexes[indexPath.row]). \(self.verifyedMnemonicPhrase[indexPath.row])"
            if self.errorVarify {
                cell.mnemonicWord.textColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
                
            } else {
                cell.mnemonicWord.textColor = .white
            }
            
            if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                cell.mnemonicWord.textColor = .black
            } else {
                cell.mnemonicWord.textColor = .white
            }
            
            if indexPath > [0,5] && cell.mnemonicWord.text != "\(self.indexes[indexPath.row]). " {
                
                cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                cell.mnemonicWord.tintColor = .white
            } else if indexPath == [0,self.selectIndex] && self.firstWord && cell.mnemonicWord.text == "\(self.indexes[indexPath.row]). " {
                cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                cell.mnemonicWord.tintColor = .white
            } else {
                cell.backgroundColor = .systemBackground
            }
            
            
            
            return cell
        case self.selectCollectionView:
            cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            cell.mnemonicWord.text = "\(self.selectPhrase[indexPath.row])"
            if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                cell.mnemonicWord.textColor = .black
            } else {
                cell.mnemonicWord.textColor = .white
            }
            
            return cell
        default:
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case self.veryfyCollectionView:
            if indexPath == [0,self.verifyedMnemonicPhrase.filter({$0 != ""}).count - 1] {
                let cell = self.veryfyCollectionView.cellForItem(at: indexPath) as! MnemonicCollectionViewCell
                cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                self.selectIndex = indexPath.row
                if self.verifyedMnemonicPhrase[indexPath.row] != "" {
                    self.selectPhrase.append(self.verifyedMnemonicPhrase[indexPath.row])
                    self.verifyedMnemonicPhrase.remove(at: indexPath.row)
                    self.verifyedMnemonicPhrase.insert("", at: indexPath.row)
                    self.veryfyCollectionView.reloadData()
                    self.selectCollectionView.reloadData()
                    
                    if !self.selectPhrase.isEmpty {
                        self.continueButton.isEnabled = false
                        self.continueButton.backgroundColor = #colorLiteral(red: 0.246493727, green: 0.246493727, blue: 0.246493727, alpha: 1)
                        self.pleaseLabel.alpha = 1
                    }
                }
                
            }
        case self.selectCollectionView:
            let cell = self.veryfyCollectionView.cellForItem(at: indexPath) as! MnemonicCollectionViewCell
            if self.selectIndex >= 6 {
                
                
                self.verifyedMnemonicPhrase.remove(at: self.selectIndex)
                self.verifyedMnemonicPhrase.insert(self.selectPhrase[indexPath.row], at: self.selectIndex)
                
                self.selectPhrase.remove(at: indexPath.row)
                if self.selectIndex < 12 {
                    self.selectIndex += 1
                    
                } else {
                    self.selectIndex = 6
                }
                
                self.veryfyCollectionView.reloadData()
                self.selectCollectionView.reloadData()
                if self.selectPhrase.isEmpty {
                    self.continueButton.isEnabled = true
                    self.continueButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                    self.pleaseLabel.alpha = 0
                }
                
            }
            
        default:
            break
        }
        
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            switch collectionView {
            case self.veryfyCollectionView:
                return CGSize(width: (collectionView.frame.width / 2) - 15, height: (collectionView.frame.height / 6) - 10)
                
            case self.selectCollectionView:
                return CGSize(width: (collectionView.frame.width / 2) - 15, height: (collectionView.frame.height / 3) - 12)
            default:
                return CGSize(width: 178, height: 50)
            }
        }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        10
    //    }
}
