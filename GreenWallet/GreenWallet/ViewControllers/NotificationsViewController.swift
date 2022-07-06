//
//  NotificationsViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 30.06.2022.
//

import UIKit

class NotificationsViewController: UIViewController {

    var wallet: ChiaWalletPrivateKey?
    var dates: [String] = []
    
    var notifications: [Notificationsss] = [Notificationsss(type: "in", height: "123123", summ: "500.000011000", token: "XCH", date: "27.06.22 21:00"), Notificationsss(type: "out", height: "123123", summ: "100.000011000", token: "XCH", date: "20.06.22 21:00"),Notificationsss(type: "in", height: "123123", summ: "100.000011000", token: "XCH", date: "25.06.22 21:00"),Notificationsss(type: "in", height: "123123", summ: "100.000011000", token: "XCH", date: "20.06.22 21:00"),Notificationsss(type: "in", height: "123123", summ: "110.000011000", token: "XCH", date: "20.06.22 21:00"),Notificationsss(type: "out", height: "123123", summ: "50.000011000", token: "XCH", date: "20.06.22 21:00"),Notificationsss(type: "in", height: "123123", summ: "20.000011000", token: "XCH", date: "20.06.22 21:00"),Notificationsss(type: "in", height: "123123", summ: "100.000011000", token: "XCH", date: "21.06.22 21:00"),Notificationsss(type: "in", height: "123123", summ: "100.000011000", token: "XCH", date: "20.06.22 21:00"),Notificationsss(type: "out", height: "123123", summ: "0.000011000", token: "XCH", date: "21.06.22 21:00"),Notificationsss(type: "out", height: "123123", summ: "100.000011000", token: "XCH", date: "20.06.22 21:00"),Notificationsss(type: "out", height: "123123", summ: "100.000011000", token: "XCH", date: "25.06.22 21:00"),Notificationsss(type: "in", height: "123123", summ: "100.000011000", token: "XCH", date: "20.06.22 21:00"),Notificationsss(type: "out", height: "123123", summ: "100.000011000", token: "XCH", date: "25.06.22 21:00")]
    var filterNotifications: [Notificationsss] = []
    
    
    private var walletsTransactions: [[ChiaTransaction]] = []
    private var filterWalletsTransactions: [ChiaTransaction] = []
    private var isAllFilter = true
    private var isInFilter = false
    private var isOutFilter = false
    private var isPendindFilter = false
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var filterTimeButton: UIButton!
    @IBOutlet weak var filterSystemButton: UIButton!

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var filterDateView: UIView!
    @IBOutlet weak var allDateButton: UIButton!
    @IBOutlet weak var todayDateButton: UIButton!
    @IBOutlet weak var yesterdayDayeButton: UIButton!
    @IBOutlet weak var lastWeekDateButton: UIButton!
    @IBOutlet weak var lastMonthButton: UIButton!
    
    @IBOutlet weak var systemMenuView: UIView!
    @IBOutlet weak var chiaSystemButton: UIButton!
    @IBOutlet weak var chivesSystemButton: UIButton!
    @IBOutlet weak var allSystemButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.filterNotifications = self.notifications
        
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
        
        self.chivesSystemButton.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        self.chiaSystemButton.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        
        self.chiaSystemButton.setTitle("Chia Network", for: .normal)
        self.chivesSystemButton.setTitle("Chives Network", for: .normal)
        
        self.allDateButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.allDateButton.tintColor = .white
        
        localization()
        
        self.tableView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
        self.filterCollectionView.register(UINib(nibName: "TransictionFilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TransictionFilterCollectionViewCell")
        
        let tapGastureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.tableView.addGestureRecognizer(tapGastureRecognizer)

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let storyoard = UIStoryboard(name: "spinner", bundle: .main)
        let spinnerVC = storyoard.instantiateViewController(withIdentifier: "spinner") as! SprinnerViewController
        let queue = DispatchQueue.global(qos: .userInteractive)
        
//        if self.filterWalletsTransactions.isEmpty  {
//            self.present(spinnerVC, animated: true)
//            queue.sync {
//                for i in CoreDataManager.share.fetchChiaWalletPrivateKey() {
//
//                    ChiaBlockchainManager.share.logIn(Int(i.fingerprint)) { log in
//
//                        if log.success {
//                            ChiaBlockchainManager.share.getWallets { wallet in
//
//                                for iwallet in wallet.wallets {
//
//                                    ChiaBlockchainManager.share.getTransactions(iwallet.id) { transact in
//
//                                        self.walletsTransactions.append(transact.transactions)
//
//                                        DispatchQueue.main.async {
//
//                                            self.filterWalletsTransactions = self.walletsTransactions.reduce([], +)
//                                            self.tableView.reloadData()
//                                            spinnerVC.dismiss(animated: true)
//                                        }
//                                    }
//
//                                }
//                            }
//                        }
//
//                    }
//                }
//            }
//        } else if self.filterWalletsTransactions.isEmpty  {
//            self.present(spinnerVC, animated: true)
//            queue.sync {
//
//                ChiaBlockchainManager.share.logIn(Int(self.wallet!.fingerprint)) { log in
//                    print(log.success)
//                    ChiaBlockchainManager.share.getWallets { wallets in
//                        for i in wallets.wallets {
//                            ChiaBlockchainManager.share.getTransactions(i.id) { trans in
//                                self.walletsTransactions.append(trans.transactions)
//
//                                DispatchQueue.main.async {
//                                    self.filterWalletsTransactions = self.walletsTransactions.reduce([], +)
//                                    self.tableView.reloadData()
//                                    spinnerVC.dismiss(animated: true)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: LocalizationManager.share.translate?.result.list.all.search ?? "", attributes: [:])
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.searchBar.searchTextField.layer.cornerRadius = 15
        self.searchBar.searchTextField.textAlignment = NSTextAlignment.left
        let image:UIImage = UIImage(systemName: "magnifyingglass")!
        let imageView:UIImageView = UIImageView.init(image: image)
        imageView.tintColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
        self.searchBar.searchTextField.leftView = nil
        self.searchBar.searchTextField.rightView = imageView
        self.searchBar.searchTextField.rightViewMode = .always
        self.searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 0)
    }
    
    @objc private func localization() {
        self.titleLabel.text = LocalizationManager.share.translate?.result.list.transactions.transactions_title
        self.searchBar.searchTextField.placeholder = LocalizationManager.share.translate?.result.list.all.search
        self.todayDateButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_today, for: .normal)
        self.yesterdayDayeButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_yesterday, for: .normal)
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
        self.allDateButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_all, for: .normal)
       
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
        
        if self.systemMenuView.isHidden {
            self.systemMenuView.isHidden = false
            self.systemMenuView.alpha = 1
        } else {
            self.systemMenuView.alpha = 0
            self.systemMenuView.isHidden = true
        }
    }
    @IBAction func chiaButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.chivesSystemButton.backgroundColor = .systemBackground
        self.allSystemButton.backgroundColor = .systemBackground
        //        self.filterWalletsTransactions = self.walletsTransactions.filter({$0.token == "XCH"})
        self.tableView.reloadData()
    }
    @IBAction func chivesButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        
        //        self.filterWalletsTransactions = self.walletsTransactions.filter({$0.token == "XCC"})
        self.chiaSystemButton.backgroundColor = .systemBackground
        self.allSystemButton.backgroundColor = .systemBackground
        self.tableView.reloadData()
    }
    
    @IBAction func allSystemButtonPresed(_ sender: UIButton) {
        self.allSystemButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        
        self.filterWalletsTransactions = self.walletsTransactions.reduce([], +)
        self.chivesSystemButton.backgroundColor = .systemBackground
        self.chiaSystemButton.backgroundColor = .systemBackground
        self.tableView.reloadData()
    }
    
    @objc func hideKeyboard(_ sender: Any) {
        self.searchBar.resignFirstResponder()
    }
    
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.filterNotifications.filter({$0.date == self.filterNotifications.map{$0.date}[section]}).count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Set(self.filterNotifications.map{$0.date}).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        let transiction = self.filterNotifications[indexPath.row]
        if transiction.type == "out" {
            cell.amountLabel.textColor = .red
            cell.amountLabel.text = "- \(transiction.summ)"
            cell.descriptionLabel.text = LocalizationManager.share.translate?.result.list.notifications.notifications_withdrawn_from_chia_wallet
        } else {
            cell.amountLabel.text = transiction.summ
            cell.descriptionLabel.text = LocalizationManager.share.translate?.result.list.notifications.notifications_credited_to_chia_wallet
            cell.amountLabel.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        }
        cell.cellImage.image = UIImage(named: "LogoChia")!
        cell.ratesLabel.text = "\(ExchangeRatesManager.share.newRatePerDollar * (Double(transiction.summ) ?? 0)) \(transiction.token)"
        cell.timeLabel.text = String(transiction.date.suffix(5))
       
        
//        cell.heightLabel.text = "\(transiction.confirmed_at_height )"
//
//        cell.summLabel.text = "\((Double(transiction.amount) / 1000000000000).avoidNotation) XCH"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self.filterNotifications.map{$0.date}[section]
    }
}

extension NotificationsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransictionFilterCollectionViewCell", for: indexPath) as! TransictionFilterCollectionViewCell
        switch indexPath {
        case [0,0]:
            if self.isAllFilter {
                cell.cellLabel.text = LocalizationManager.share.translate?.result.list.notifications.notifications_all
                cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                cell.cellLabel.textColor = .white
            } else {
                
                cell.cellLabel.text = LocalizationManager.share.translate?.result.list.notifications.notifications_all
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
                cell.cellLabel.text = LocalizationManager.share.translate?.result.list.notifications.notifications_enrollments
                cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                cell.cellLabel.textColor = .white
            } else {
                
                cell.cellLabel.text = LocalizationManager.share.translate?.result.list.notifications.notifications_enrollments
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
                cell.cellLabel.text = LocalizationManager.share.translate?.result.list.notifications.notifications_write_off
                cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                cell.cellLabel.textColor = .white
            } else {
                
                cell.cellLabel.text = LocalizationManager.share.translate?.result.list.notifications.notifications_write_off
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
                cell.cellLabel.text = LocalizationManager.share.translate?.result.list.notifications.notifications_other
                cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                cell.cellLabel.textColor = .white
            } else {
                cell.cellLabel.text = LocalizationManager.share.translate?.result.list.notifications.notifications_other
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
            self.filterNotifications = self.notifications
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
            self.filterNotifications = self.notifications.filter({$0.type == "in"})
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
            self.filterNotifications = self.notifications.filter({$0.type == "out"})
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
            self.filterNotifications = self.notifications.filter({$0.type == "other"})
            self.isAllFilter = false
            self.isInFilter = false
            self.isOutFilter = false
            self.isPendindFilter = true
            self.tableView.reloadData()
        }
    }
}

extension NotificationsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filterNotifications = self.notifications
            self.tableView.reloadData()
            return
        } else {
            self.filterNotifications = self.notifications.filter({$0.summ.contains(searchText)})
            
            self.tableView.reloadData()
            
        }
    }
    
    
}

struct Notificationsss {
    var type: String
    var height: String
    var summ: String
    var token: String
    var date: String
}
