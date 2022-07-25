//
//  TransactionHistoryViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 19.05.2022.
//

import UIKit

class TransactionHistoryViewController: UIViewController {
    
    var isHistoryWallet = false
    var wallet: ChiaWalletPrivateKey?
    var dates: [String] = []
    var isChia = false
    
    
    
    private var walletsTransactions: [[ChiaTransaction]] = []
    private var filterWalletsTransactions: [ChiaTransaction] = []
    private var systems: [ListSystems] = []
    
    private var isAllFilter = true
    private var isInFilter = false
    private var isOutFilter = false
    private var isPendindFilter = false
    var spinnerVC = SprinnerViewController()
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var filterTimeButton: UIButton!
    @IBOutlet weak var filterSystemButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var summLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var filterDateView: UIView!
    @IBOutlet weak var allDateButton: UIButton!
    @IBOutlet weak var todayDateButton: UIButton!
    @IBOutlet weak var yesterdayDayeButton: UIButton!
    @IBOutlet weak var lastWeekDateButton: UIButton!
    @IBOutlet weak var lastMonthButton: UIButton!
    
    @IBOutlet weak var systemMenuView: UIView!
    @IBOutlet weak var ststemViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var systemsStackView: UIStackView!
    @IBOutlet weak var allSystemButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let storyoard = UIStoryboard(name: "spinner", bundle: .main)
        self.spinnerVC = storyoard.instantiateViewController(withIdentifier: "spinner") as! SprinnerViewController
        
        WalletManager.share.isUpdate = false
        SystemsManager.share.filterSystems()
        self.systems = Array(Set(SystemsManager.share.listOfSystems))
        if self.isHistoryWallet {
            self.backButton.alpha = 1
            self.backButton.isEnabled = true
        } else {
            self.backButton.alpha = 0
            self.backButton.isEnabled = false
        }
        
        
        self.systemsStackView.alignment = .fill
        
        self.statusLabel.text = "Статус"
        self.heightLabel.text = "Высота"
        self.summLabel.text = "Сумма"
        
        self.filterDateView.isHidden = true
        self.filterDateView.alpha = 0
        self.allDateButton.setTitle("Все", for: .normal)
        self.todayDateButton.setTitle("Сегодня", for: .normal)
        self.yesterdayDayeButton.setTitle("Вчера", for: .normal)
        self.lastWeekDateButton.setTitle("Последняя неделя", for: .normal)
        self.lastMonthButton.setTitle("Последний месяц", for: .normal)
        
        self.allDateButton.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        self.todayDateButton.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        self.yesterdayDayeButton.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        self.lastWeekDateButton.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        self.allSystemButton.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        
        self.systemMenuView.isHidden = true
        self.systemMenuView.alpha = 0
        
        
        self.allDateButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
            self.allDateButton.tintColor = .black
        } else {
            self.allDateButton.tintColor = .white
        }
        
        localization()
        
        self.tableView.register(UINib(nibName: "TransitionsTableViewCell", bundle: nil), forCellReuseIdentifier: "TransitionsTableViewCell")
        self.filterCollectionView.register(UINib(nibName: "TransictionFilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TransictionFilterCollectionViewCell")
        
        let tapGastureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.tableView.addGestureRecognizer(tapGastureRecognizer)
        NotificationCenter.default.addObserver(self, selector: #selector(localization), name: NSNotification.Name("localized"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(alertErrorGerCodingKeysPresent), name: NSNotification.Name("alertErrorGerCodingKeys"), object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: LocalizationManager.share.translate?.result.list.all.search ?? "", attributes: [:])

        
        let queue = DispatchQueue.global(qos: .userInteractive)
        
        if self.filterWalletsTransactions.isEmpty && !self.isHistoryWallet && !CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
            self.present(self.spinnerVC, animated: true)
            queue.async {
                for i in CoreDataManager.share.fetchChiaWalletPrivateKey() {
                    if i.name == "Chia Wallet" {
                        ChiaBlockchainManager.share.logIn(Int(i.fingerprint)) { log in

                            if log.success {
                                ChiaBlockchainManager.share.getWallets { wallet in

                                    for iwallet in wallet.wallets {

                                        ChiaBlockchainManager.share.getTransactions(iwallet.id) { transact in

                                            self.walletsTransactions.append(transact.transactions)


                                            DispatchQueue.main.async {

                                                self.filterWalletsTransactions = self.walletsTransactions.reduce([], +)
                                                if CoreDataManager.share.fetchTransactions().isEmpty{
                                                    self.filterWalletsTransactions.forEach({CoreDataManager.share.saveTransactions(newTransactions: $0)})
                                                    print(CoreDataManager.share.fetchTransactions())
                                                } else {
                                                    CoreDataManager.share.deleteTransactions()
                                                    self.filterWalletsTransactions.forEach({CoreDataManager.share.saveTransactions(newTransactions: $0)})
                                                }
                                                self.tableView.reloadData()
                                                self.spinnerVC.dismiss(animated: true)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                    } else if i.name == "Chives Wallet"{
                        ChivesBlockchainManager.share.logIn(Int(i.fingerprint)) { log in
                            
                            if log.success {
                                ChivesBlockchainManager.share.getWallets { wallet in
                                    
                                    for iwallet in wallet.wallets {
                                        
                                        ChivesBlockchainManager.share.getTransactions(iwallet.id) { transact in
                                            
                                            self.walletsTransactions.append(transact.transactions)
                                            
                                            DispatchQueue.main.async {
                                                
                                                self.filterWalletsTransactions = self.walletsTransactions.reduce([], +)
                                                self.tableView.reloadData()
                                                self.spinnerVC.dismiss(animated: true)
                                            }
                                        }
                                        
                                    }
                                }
                            }
                        }
                    } else if i.name == "Chives TestNet"{
                        ChivesTestBlockchainManager.share.logIn(Int(i.fingerprint)) { log in
                            
                            if log.success {
                                ChivesTestBlockchainManager.share.getWallets { wallet in
                                    
                                    for iwallet in wallet.wallets {
                                        
                                        ChivesTestBlockchainManager.share.getTransactions(iwallet.id) { transact in
                                            
                                            self.walletsTransactions.append(transact.transactions)
                                            
                                            DispatchQueue.main.async {
                                                
                                                self.filterWalletsTransactions = self.walletsTransactions.reduce([], +)
                                                self.tableView.reloadData()
                                                self.spinnerVC.dismiss(animated: true)
                                            }
                                        }
                                        
                                    }
                                }
                            }
                        }
                    } else if i.name == "Chia TestNet"{
                        ChiaTestBlockchainManager.share.logIn(Int(i.fingerprint)) { log in
                            
                            if log.success {
                                ChiaTestBlockchainManager.share.getWallets { wallet in
                                    
                                    for iwallet in wallet.wallets {
                                        
                                        ChiaTestBlockchainManager.share.getTransactions(iwallet.id) { transact in
                                            
                                            self.walletsTransactions.append(transact.transactions)
                                            
                                            DispatchQueue.main.async {
                                                
                                                self.filterWalletsTransactions = self.walletsTransactions.reduce([], +)
                                                self.tableView.reloadData()
                                                self.spinnerVC.dismiss(animated: true)
                                            }
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else if self.filterWalletsTransactions.isEmpty && self.isHistoryWallet && !CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
            self.present(spinnerVC, animated: true)
            queue.sync {
                if self.wallet?.name == "Chia Wallet" {
                    ChiaBlockchainManager.share.logIn(Int(self.wallet?.fingerprint ?? 0)) { log in
                        
                        if log.success {
                            ChiaBlockchainManager.share.getWallets { wallet in
                                
                                for iwallet in wallet.wallets {
                                    
                                    ChiaBlockchainManager.share.getTransactions(iwallet.id) { transact in
                                        
                                        self.walletsTransactions.append(transact.transactions)
                                        
                                        DispatchQueue.main.async {
                                            
                                            self.filterWalletsTransactions = self.walletsTransactions.reduce([], +)
                                            self.tableView.reloadData()
                                            self.spinnerVC.dismiss(animated: true)
                                        }
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                    
                } else if self.wallet?.name == "Chives Wallet"{
                    ChivesBlockchainManager.share.logIn(Int(self.wallet?.fingerprint ?? 0)) { log in
                        
                        if log.success {
                            ChivesBlockchainManager.share.getWallets { wallet in
                                
                                for iwallet in wallet.wallets {
                                    
                                    ChivesBlockchainManager.share.getTransactions(iwallet.id) { transact in
                                        
                                        self.walletsTransactions.append(transact.transactions)
                                        
                                        DispatchQueue.main.async {
                                            
                                            self.filterWalletsTransactions = self.walletsTransactions.reduce([], +)
                                            self.tableView.reloadData()
                                            self.spinnerVC.dismiss(animated: true)
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                } else if self.wallet?.name == "Chives TestNet"{
                    ChivesTestBlockchainManager.share.logIn(Int(self.wallet?.fingerprint ?? 0)) { log in
                        
                        if log.success {
                            ChivesTestBlockchainManager.share.getWallets { wallet in
                                
                                for iwallet in wallet.wallets {
                                    
                                    ChivesTestBlockchainManager.share.getTransactions(iwallet.id) { transact in
                                        
                                        self.walletsTransactions.append(transact.transactions)
                                        
                                        DispatchQueue.main.async {
                                            
                                            self.filterWalletsTransactions = self.walletsTransactions.reduce([], +)
                                            self.tableView.reloadData()
                                            self.spinnerVC.dismiss(animated: true)
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                } else if self.wallet?.name == "Chia TestNet"{
                    ChiaTestBlockchainManager.share.logIn(Int(self.wallet?.fingerprint ?? 0)) { log in
                        
                        if log.success {
                            ChiaTestBlockchainManager.share.getWallets { wallet in
                                
                                for iwallet in wallet.wallets {
                                    
                                    ChiaTestBlockchainManager.share.getTransactions(iwallet.id) { transact in
                                        
                                        self.walletsTransactions.append(transact.transactions)
                                        
                                        DispatchQueue.main.async {
                                            
                                            self.filterWalletsTransactions = self.walletsTransactions.reduce([], +)
                                            self.tableView.reloadData()
                                            self.spinnerVC.dismiss(animated: true)
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                }
                
            }
            
        }
    }
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.searchBar.searchTextField.layer.cornerRadius = 15
        self.searchBar.searchTextField.textAlignment = NSTextAlignment.left
        let image:UIImage = UIImage(systemName: "magnifyingglass")!
        let imageView:UIImageView = UIImageView.init(image: image)
        imageView.tintColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
        self.searchBar.searchTextField.leftView = nil
        self.searchBar.searchTextField.placeholder = "Поиск"
        self.searchBar.searchTextField.rightView = imageView
        self.searchBar.searchTextField.rightViewMode = .always
        self.searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 0)
    }
    
    @objc private func alertErrorGerCodingKeysPresent() {
        self.spinnerVC.dismiss(animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
            AlertManager.share.serverError(self)
        }
    }
    
    
    
    
    @objc private func localization() {
        self.titleLabel.text = LocalizationManager.share.translate?.result.list.transactions.transactions_title
        self.searchBar.searchTextField.placeholder = LocalizationManager.share.translate?.result.list.all.search
        self.todayDateButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_today, for: .normal)
        self.yesterdayDayeButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_yesterday, for: .normal)
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
        self.allDateButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_all, for: .normal)
        self.heightLabel.text = LocalizationManager.share.translate?.result.list.transactions.transactions_height
        self.statusLabel.text = LocalizationManager.share.translate?.result.list.transactions.transactions_status
        self.summLabel.text = LocalizationManager.share.translate?.result.list.transactions.transactions_amount
        self.allDateButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_all, for: .normal)
        
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
        self.filterSystemButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_all, for: .normal)
        self.allSystemButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_all, for: .normal)
        self.lastWeekDateButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_last_week, for: .normal)
        self.lastMonthButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_last_month, for: .normal)
        
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func filetrDateMenuOpen(_ sender: UIButton) {
        if self.filterDateView.isHidden {
            self.filterTimeButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            self.filterTimeButton.setImage(UIImage(named: "filterWhite")!, for: .normal)
            self.filterDateView.isHidden = false
            self.filterDateView.alpha = 1
        } else {
            if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                self.filterTimeButton.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
            } else {
                self.filterTimeButton.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
            }
            self.filterTimeButton.setImage(UIImage(named: "filter")!, for: .normal)
            self.filterDateView.alpha = 0
            self.filterDateView.isHidden = true
        }
    }
    
    @IBAction func allDateButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        
        
        
        self.todayDateButton.backgroundColor = .systemBackground
        self.yesterdayDayeButton.backgroundColor = .systemBackground
        self.lastWeekDateButton.backgroundColor = .systemBackground
        self.lastMonthButton.backgroundColor = .systemBackground
        
        self.filterWalletsTransactions = self.walletsTransactions.reduce([], +)
        self.filterDateView.isHidden = true
        self.tableView.reloadData()
    }
    
    @IBAction func todayDateButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        
        
        
        self.allDateButton.backgroundColor = .systemBackground
        self.yesterdayDayeButton.backgroundColor = .systemBackground
        self.lastWeekDateButton.backgroundColor = .systemBackground
        self.lastMonthButton.backgroundColor = .systemBackground
        
        self.filterWalletsTransactions = self.walletsTransactions.reduce([], +).filter({TimeManager.share.convertUnixTime(unix: $0.created_at_time, format: "dd.MM.yy") == Date().string( format: "dd.MM.yy")})
        
        self.filterDateView.isHidden = true
        self.tableView.reloadData()
    }
    
    @IBAction func yesterdayDayeButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        
        
        self.todayDateButton.backgroundColor = .systemBackground
        self.allDateButton.backgroundColor = .systemBackground
        self.lastWeekDateButton.backgroundColor = .systemBackground
        self.lastMonthButton.backgroundColor = .systemBackground
        
        
        
        //        self.filterWalletsTransactions = self.walletsTransactions.reduce([], +).filter({Int(TimeManager.share.convertUnixTime(unix: $0.created_at_time, format: "dd.MM.yy").split(separator: ".")[0]) - Int(Date().string(format: "dd.MM.yy").split(separator: ".")[0]) == 1})
        self.filterDateView.isHidden = true
        self.tableView.reloadData()
    }
    
    @IBAction func lastWeekDateButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        
        
        self.todayDateButton.backgroundColor = .systemBackground
        self.yesterdayDayeButton.backgroundColor = .systemBackground
        self.allDateButton.backgroundColor = .systemBackground
        self.lastMonthButton.backgroundColor = .systemBackground
        
        //        self.filterWalletsTransactions = self.walletsTransactions.filter({$0.date == "lastWeek"})
        self.filterDateView.isHidden = true
        self.tableView.reloadData()
    }
    
    @IBAction func lastMonthButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        
        
        self.todayDateButton.backgroundColor = .systemBackground
        self.yesterdayDayeButton.backgroundColor = .systemBackground
        self.lastWeekDateButton.backgroundColor = .systemBackground
        self.allDateButton.backgroundColor = .systemBackground
        
        self.filterWalletsTransactions = self.walletsTransactions.reduce([], +).filter({TimeManager.share.convertUnixTime(unix: $0.created_at_time, format: "dd.MM.yy").split(separator: ".")[1] == Date().string(format: "dd.MM.yy").split(separator: ".")[1] && TimeManager.share.convertUnixTime(unix: $0.created_at_time, format: "dd.MM.yy").split(separator: ".")[2] == Date().string(format: "dd.MM.yy").split(separator: ".")[2]})
        self.filterDateView.isHidden = true
        self.tableView.reloadData()
        
    }
    
    @IBAction func systemmenuOpen(_ sender: UIButton) {
        
        if !CoreDataManager.share.fetchChiaWalletPrivateKey().isEmpty {
            for i in 0..<self.systems.count {
                if self.systemsStackView.arrangedSubviews.count == (self.systems.count + 1){
                    break
                } else {
                    
                    let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.systemsStackView.frame.width, height: 40))
                    button.setTitle(self.systems[i].name, for: .normal)
                    if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                        button.setTitleColor(.black, for: .normal)
                    } else {
                        button.setTitleColor(.white, for: .normal)
                    }
                    self.systemsStackView.addArrangedSubview(button)
                    self.ststemViewHeightConstraint.constant += button.frame.height
                    
                    
                    
                    
                    button.addTarget(self, action: #selector(setupSystemMenuButtons), for: .touchUpInside)
                    
                }
            }
        } else {
            return
        }
        
        
        if self.systemMenuView.isHidden {
            self.systemMenuView.isHidden = false
            self.systemMenuView.alpha = 1
        } else {
            self.systemMenuView.alpha = 0
            self.systemMenuView.isHidden = true
        }
    }
    
    @objc private func setupSystemMenuButtons(_ sender: UIButton) {
        
        for i in 0..<systemsStackView.arrangedSubviews.count {
            self.systemsStackView.arrangedSubviews[i].backgroundColor = .systemBackground
            
            if sender == self.systemsStackView.arrangedSubviews[i] && sender != self.allSystemButton {
                self.filterSystemButton.setTitle("\(sender.currentTitle?.split(separator: " ").first ?? "")", for: .normal)
                sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                
                
                
                if sender.currentTitle == "Chia Network" {
                    self.filterWalletsTransactions = self.walletsTransactions.reduce([], +).filter({$0.to_address.contains("xch")})
                    print("filter chia")
                    self.tableView.reloadData()
                } else if sender.currentTitle == "Chives Network" {
                    self.filterWalletsTransactions = self.walletsTransactions.reduce([], +).filter({$0.to_address.contains("xcc")})
                    print("filter Chives")
                    self.tableView.reloadData()
                } else if sender.currentTitle == "Chia TestNet" {
                    self.filterWalletsTransactions = self.walletsTransactions.reduce([], +).filter({$0.to_address.contains("txch")})
                    print("filter Chia TestNet")
                    self.tableView.reloadData()
                } else if sender.currentTitle == "Chives TestNet" {
                    self.filterWalletsTransactions = self.walletsTransactions.reduce([], +).filter({$0.to_address.contains("txcc")})
                    print("filter Chives TestNet")
                    self.tableView.reloadData()
                }
            }
        }
        if self.systemMenuView.alpha == 0 {
            UIView.animate(withDuration: 0.5) {
                self.systemMenuView.isHidden = false
                self.systemMenuView.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.systemMenuView.alpha = 0
                self.systemMenuView.isHidden = true
            }
        }
    }
    
    
    
    
    
    @IBAction func allSystemButtonPresed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.filterSystemButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_all, for: .normal)
        
        if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
            self.systemsStackView.arrangedSubviews.forEach({$0.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)})
        } else {
            self.systemsStackView.arrangedSubviews.forEach({$0.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)})
        }
        self.filterWalletsTransactions = self.walletsTransactions.reduce([], +)
        UIView.animate(withDuration: 0.5) {
            self.systemMenuView.alpha = 0
            self.systemMenuView.isHidden = true
        }
        self.tableView.reloadData()
    }
    
    @objc func hideKeyboard(_ sender: Any) {
        self.searchBar.resignFirstResponder()
    }
    
}

extension TransactionHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.filterWalletsTransactions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransitionsTableViewCell", for: indexPath) as! TransitionsTableViewCell
        let transiction = self.filterWalletsTransactions[indexPath.row]
        switch transiction.type {
            
        case 0:
            cell.typeOfTransitionLabel.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            cell.typeOfTransitionLabel.text = LocalizationManager.share.translate?.result.list.transactions.transactions_incoming
        case 1:
            cell.typeOfTransitionLabel.textColor = #colorLiteral(red: 1, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
            cell.typeOfTransitionLabel.text = LocalizationManager.share.translate?.result.list.transactions.incoming_outgoing
        default:
            break
        }
        if !(transiction.confirmed ) {
            cell.typeOfTransitionLabel.textColor = #colorLiteral(red: 0.1176470588, green: 0.5764705882, blue: 1, alpha: 1)
            cell.typeOfTransitionLabel.text = LocalizationManager.share.translate?.result.list.transactions.transactions_pendind
        }
        
        cell.heightLabel.text = "\(transiction.confirmed_at_height )"
        
        if transiction.to_address.contains("xch") {
            cell.summLabel.text = "\((Double(transiction.amount) / 1000000000000).avoidNotation) XCH"
        } else if transiction.to_address.contains("xcc") {
            cell.summLabel.text = "\((Double(transiction.amount) / 1000000000000).avoidNotation) XCC"
        } else if transiction.to_address.contains("txch") {
            cell.summLabel.text = "\((Double(transiction.amount) / 1000000000000).avoidNotation) TXCH"
        } else if transiction.to_address.contains("txcc") {
            cell.summLabel.text = "\((Double(transiction.amount) / 1000000000000).avoidNotation) TXCC"
        }
        
        
        
        
        return cell
    }
}

extension TransactionHistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransictionFilterCollectionViewCell", for: indexPath) as! TransictionFilterCollectionViewCell
        switch indexPath {
        case [0,0]:
            if self.isAllFilter {
                cell.cellLabel.text = LocalizationManager.share.translate?.result.list.transactions.transactions_all
                cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                cell.cellLabel.textColor = .white
            } else {
                
                cell.cellLabel.text = LocalizationManager.share.translate?.result.list.transactions.transactions_all
                if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                    cell.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1)
                } else {
                    cell.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
                }
                cell.cellLabel.textColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
            }
            
            return cell
        case [0,1]:
            if self.isInFilter {
                cell.cellLabel.text = LocalizationManager.share.translate?.result.list.transactions.transactions_incoming
                cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                cell.cellLabel.textColor = .white
            } else {
                
                cell.cellLabel.text = LocalizationManager.share.translate?.result.list.transactions.transactions_incoming
                if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                    cell.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1)
                } else {
                    cell.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
                }
                cell.cellLabel.textColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
            }
            return cell
        case [0,2]:
            if self.isOutFilter {
                cell.cellLabel.text = LocalizationManager.share.translate?.result.list.transactions.incoming_outgoing
                cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                cell.cellLabel.textColor = .white
            } else {
                
                cell.cellLabel.text = LocalizationManager.share.translate?.result.list.transactions.incoming_outgoing
                if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                    cell.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1)
                } else {
                    cell.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
                }
                cell.cellLabel.textColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
            }
            return cell
        default:
            if self.isPendindFilter {
                cell.cellLabel.text = LocalizationManager.share.translate?.result.list.transactions.transactions_pendind
                cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                cell.cellLabel.textColor = .white
            } else {
                cell.cellLabel.text = LocalizationManager.share.translate?.result.list.transactions.transactions_pendind
                if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                    cell.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1)
                } else {
                    cell.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
                }
                cell.cellLabel.textColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
                
            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.filterCollectionView.cellForItem(at: indexPath) as! TransictionFilterCollectionViewCell
        
        switch indexPath {
        case [0,0]:
            
            self.filterCollectionView.visibleCells.forEach { cell in
                if cell is TransictionFilterCollectionViewCell {
                    (cell.viewWithTag(1) as! UILabel).textColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
                    if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                        cell.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1)
                    } else {
                        cell.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
                    }                }
            }
            cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            cell.cellLabel.textColor = .white
            self.filterWalletsTransactions = self.walletsTransactions.reduce([], +)
            self.isAllFilter = true
            self.isInFilter = false
            self.isOutFilter = false
            self.isPendindFilter = false
            self.tableView.reloadData()
        case [0,1]:
            self.filterCollectionView.visibleCells.forEach { cell in
                if cell is TransictionFilterCollectionViewCell {
                    (cell.viewWithTag(1) as! UILabel).textColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
                    if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                        cell.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1)
                    } else {
                        cell.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
                    }                }
            }
            cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            cell.cellLabel.textColor = .white
            self.filterWalletsTransactions = self.walletsTransactions.reduce([], +).filter({$0.type == 0})
            self.isAllFilter = false
            self.isInFilter = true
            self.isOutFilter = false
            self.isPendindFilter = false
            self.tableView.reloadData()
        case [0,2]:
            self.filterCollectionView.visibleCells.forEach { cell in
                if cell is TransictionFilterCollectionViewCell {
                    (cell.viewWithTag(1) as! UILabel).textColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
                    if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                        cell.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1)
                    } else {
                        cell.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
                    }                }
            }
            cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            cell.cellLabel.textColor = .white
            self.filterWalletsTransactions = self.walletsTransactions.reduce([], +).filter({$0.type == 1})
            self.isAllFilter = false
            self.isInFilter = false
            self.isOutFilter = true
            self.isPendindFilter = false
            self.tableView.reloadData()
        default:
            self.filterCollectionView.visibleCells.forEach { cell in
                if cell is TransictionFilterCollectionViewCell {
                    (cell.viewWithTag(1) as! UILabel).textColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
                    if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
                        cell.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1)
                    } else {
                        cell.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
                    }                }
            }
            cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            cell.cellLabel.textColor = .white
            self.filterWalletsTransactions = self.walletsTransactions.reduce([], +).filter({$0.confirmed == false})
            self.isAllFilter = false
            self.isInFilter = false
            self.isOutFilter = false
            self.isPendindFilter = true
            self.tableView.reloadData()
        }
    }
}

extension TransactionHistoryViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filterWalletsTransactions = self.walletsTransactions.reduce([], +)
            self.tableView.reloadData()
            return
        } else {
            self.filterWalletsTransactions = self.walletsTransactions.reduce([], +).filter{(String($0.confirmed_at_height ).contains(searchText)) || (String($0.amount ).contains(searchText))}
            
            self.tableView.reloadData()
            
        }
    }
    
    
}




