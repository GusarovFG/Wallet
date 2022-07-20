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
    
    var notifications: [TransactionsCD] = []
    var filterNotifications: [TransactionsCD] = []
    var otherNotifications: [PushNotificationsCD] = []
    
    

    private var systems: [ListSystems] = []
    private var isAllFilter = true
    private var isInFilter = false
    private var isOutFilter = false
    private var isPendindFilter = false
    private var isOther = false
    
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var detailBackButton: UIButton!
    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailDate: UILabel!
    @IBOutlet weak var detailDateLabel: UILabel!
    @IBOutlet weak var detailAmount: UILabel!
    @IBOutlet weak var detailAmountLabel: UILabel!
    @IBOutlet weak var detailComission: UILabel!
    @IBOutlet weak var detailComissionLabel: UILabel!
    @IBOutlet weak var detailHeightLabel: UILabel!
    @IBOutlet weak var detailHeight: UILabel!
    
    @IBOutlet weak var filterTimeButton: UIButton!
    @IBOutlet weak var filterSystemButton: UIButton!

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var filterDateView: UIView!
    @IBOutlet weak var allDateButton: UIButton!
    @IBOutlet weak var todayDateButton: UIButton!
    @IBOutlet weak var yesterdayDayeButton: UIButton!
    @IBOutlet weak var lastWeekDateButton: UIButton!
    @IBOutlet weak var lastMonthButton: UIButton!
    

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !CoreDataManager.share.fetchTransactions().isEmpty {
            self.notifications = CoreDataManager.share.fetchTransactions()
            self.filterNotifications = CoreDataManager.share.fetchTransactions().reversed()
            self.otherNotifications = CoreDataManager.share.fetchPushNotifications().reversed()
        }
        
        print(filterNotifications)
        SystemsManager.share.filterSystems()
        self.systems = Array(Set(SystemsManager.share.listOfSystems))
        self.filterDateView.isHidden = true
        self.filterDateView.alpha = 0
        self.allDateButton.setTitle("Все", for: .normal)
        self.todayDateButton.setTitle("Сегодня", for: .normal)
        self.yesterdayDayeButton.setTitle("Вчера", for: .normal)
        self.lastWeekDateButton.setTitle("Последняя неделя", for: .normal)
        self.lastMonthButton.setTitle("Последний месяц", for: .normal)
        self.detailView.isHidden = true
        
        
        self.allDateButton.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        self.todayDateButton.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        self.yesterdayDayeButton.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        self.lastWeekDateButton.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        

        self.allDateButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.allDateButton.tintColor = .white
    
        
        
        localization()
        
        self.notificationTableView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
        self.notificationTableView.register(UINib(nibName: "OtherNotificationsTableViewCell", bundle: nil), forCellReuseIdentifier: "OtherNotificationsTableViewCell")
        
        self.filterCollectionView.register(UINib(nibName: "TransictionFilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TransictionFilterCollectionViewCell")
//
//        let tapGastureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        self.tableView.addGestureRecognizer(tapGastureRecognizer)

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self.otherNotifications.map({$0.message}))
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
        self.titleLabel.text = LocalizationManager.share.translate?.result.list.notifications.notifications_title
        self.searchBar.searchTextField.placeholder = LocalizationManager.share.translate?.result.list.all.search
        self.todayDateButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_today, for: .normal)
        self.yesterdayDayeButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_yesterday, for: .normal)
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
        self.allDateButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_all, for: .normal)
       
        self.allDateButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_all, for: .normal)
        
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
        self.lastWeekDateButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_last_week, for: .normal)
        self.lastMonthButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_last_month, for: .normal)
        self.detailHeight.text = LocalizationManager.share.translate?.result.list.notifications.notifications_transaction_info_block_height
        self.detailDate.text = LocalizationManager.share.translate?.result.list.notifications.notifications_transaction_info_data
        self.detailAmount.text = LocalizationManager.share.translate?.result.list.notifications.notifications_transaction_info_number_of_coins
        self.detailComission.text = LocalizationManager.share.translate?.result.list.notifications.notifications_transaction_info_commission
        self.detailTitle.text = LocalizationManager.share.translate?.result.list.notifications.notifications_transaction_info_title
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func dissmissDetail(_ sender: Any) {
        self.detailView.isHidden = true
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
        
        self.filterNotifications = self.notifications
        self.filterDateView.isHidden = true
        self.notificationTableView.reloadData()
    }
    
    @IBAction func todayDateButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        
        
        
        self.allDateButton.backgroundColor = .systemBackground
        self.yesterdayDayeButton.backgroundColor = .systemBackground
        self.lastWeekDateButton.backgroundColor = .systemBackground
        self.lastMonthButton.backgroundColor = .systemBackground
        
       
        
        self.filterDateView.isHidden = true
        self.notificationTableView.reloadData()
    }
    
    @IBAction func yesterdayDayeButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        
        
        self.todayDateButton.backgroundColor = .systemBackground
        self.allDateButton.backgroundColor = .systemBackground
        self.lastWeekDateButton.backgroundColor = .systemBackground
        self.lastMonthButton.backgroundColor = .systemBackground
        
        
        
        //        self.filterWalletsTransactions = self.walletsTransactions.reduce([], +).filter({Int(TimeManager.share.convertUnixTime(unix: $0.created_at_time, format: "dd.MM.yy").split(separator: ".")[0]) - Int(Date().string(format: "dd.MM.yy").split(separator: ".")[0]) == 1})
        self.filterDateView.isHidden = true
        self.notificationTableView.reloadData()
    }
    
    @IBAction func lastWeekDateButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        
        
        self.todayDateButton.backgroundColor = .systemBackground
        self.yesterdayDayeButton.backgroundColor = .systemBackground
        self.allDateButton.backgroundColor = .systemBackground
        self.lastMonthButton.backgroundColor = .systemBackground
        
        //        self.filterWalletsTransactions = self.walletsTransactions.filter({$0.date == "lastWeek"})
        self.filterDateView.isHidden = true
        self.notificationTableView.reloadData()
    }
    
    @IBAction func lastMonthButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        
        
        self.todayDateButton.backgroundColor = .systemBackground
        self.yesterdayDayeButton.backgroundColor = .systemBackground
        self.lastWeekDateButton.backgroundColor = .systemBackground
        self.allDateButton.backgroundColor = .systemBackground
        
//        self.filterWalletsTransactions = self.walletsTransactions.reduce([], +).filter({TimeManager.share.convertUnixTime(unix: $0.created_at_time, format: "dd.MM.yy").split(separator: ".")[1] == Date().string(format: "dd.MM.yy").split(separator: ".")[1] && TimeManager.share.convertUnixTime(unix: $0.created_at_time, format: "dd.MM.yy").split(separator: ".")[2] == Date().string(format: "dd.MM.yy").split(separator: ".")[2]})
        self.filterDateView.isHidden = true
        self.notificationTableView.reloadData()
        
    }
    
  
    

    
    @objc func hideKeyboard(_ sender: Any) {
        self.searchBar.resignFirstResponder()
    }
    
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !self.isOther {
            let qwe = self.filterNotifications.map({$0.create_at_time}).removingDuplicates()
            return self.filterNotifications.filter({$0.create_at_time == qwe[section]}).count
        } else {
            let ewq = self.otherNotifications.map({$0.created_at}).removingDuplicates()
            return self.otherNotifications.filter({$0.created_at == ewq[section]}).count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !self.isOther {
            return self.filterNotifications.map({$0.create_at_time}).removingDuplicates().count
        } else {
            return self.otherNotifications.map({$0.created_at}).removingDuplicates().count
        }
    }
                       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if !self.isOther {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
            let qwwe = self.filterNotifications.map({$0.create_at_time}).removingDuplicates()
            let transiction = self.filterNotifications.filter({$0.create_at_time == qwwe[indexPath.section]})[indexPath.row]
            
            if transiction.type == 1 {
                cell.amountLabel.textColor = .red
                cell.amountLabel.text = "- \((Double(transiction.amount) / 1000_000_000_000).avoidNotation) \(transiction.address?.prefix(3).uppercased() ?? "")"
                cell.descriptionLabel.text = LocalizationManager.share.translate?.result.list.notifications.notifications_withdrawn_from_chia_wallet
            } else {
                cell.amountLabel.text = "\((Double(transiction.amount) / 1000_000_000_000).avoidNotation)  \(transiction.address?.prefix(3).uppercased() ?? "")"
                cell.descriptionLabel.text = LocalizationManager.share.translate?.result.list.notifications.notifications_credited_to_chia_wallet
                cell.amountLabel.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            }
            cell.cellImage.image = UIImage(named: "LogoChia")!
            cell.ratesLabel.text = "\(ExchangeRatesManager.share.newRatePerDollar * (Double(transiction.amount))) USD"
            cell.timeLabel.text = transiction.create_at_time
            
            print(transiction)
            return cell
        } else {
            let otherCell = tableView.dequeueReusableCell(withIdentifier: "OtherNotificationsTableViewCell", for: indexPath) as! OtherNotificationsTableViewCell
            let ewq = self.otherNotifications.map({$0.created_at}).removingDuplicates()
            let otherNotification = self.otherNotifications.filter({$0.created_at == ewq[indexPath.section]})[indexPath.row]
            otherCell.cellsTitle.text = otherNotification.message
            return otherCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !self.isOther {
            return self.filterNotifications.map({$0.create_at_time}).removingDuplicates()[section]
        } else {
            return self.otherNotifications.map({$0.created_at}).removingDuplicates()[section]
        }
        
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView

        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = NSTextAlignment.center
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !self.isOther {
            
            let qwwe = self.filterNotifications.map({$0.create_at_time}).removingDuplicates()
            let transiction = self.filterNotifications.filter({$0.create_at_time == qwwe[indexPath.section]})[indexPath.row]
            self.detailView.isHidden = false
            self.detailDateLabel.text = "\(transiction.create_at_time ?? "")"
            self.detailAmountLabel.text = "\((Double(transiction.amount) / 1000_000_000_000).avoidNotation)  \(transiction.address?.prefix(3).uppercased() ?? "")"
            self.detailHeightLabel.text = "\(transiction.confirm_height)"
            self.detailComissionLabel.text = "\((Double(transiction.comission) / 1000_000_000_000).avoidNotation)  \(transiction.address?.prefix(3).uppercased() ?? "")"
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            return
        }
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
                    }
                    
                }
            }
            cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            cell.cellLabel.textColor = .white
            self.filterNotifications = self.notifications
            self.isAllFilter = true
            self.isInFilter = false
            self.isOutFilter = false
            self.isOther = false
            self.notificationTableView.reloadData()
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
            self.filterNotifications = self.notifications.filter({$0.type == 0})
            self.isAllFilter = false
            self.isInFilter = true
            self.isOutFilter = false
            self.isOther = false
            self.notificationTableView.reloadData()
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
            self.filterNotifications = self.notifications.filter({$0.type == 1})
            self.isAllFilter = false
            self.isInFilter = false
            self.isOutFilter = true
            self.isOther = false
            self.notificationTableView.reloadData()
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
            self.isAllFilter = false
            self.isInFilter = false
            self.isOutFilter = false
            self.isOther = true
            self.notificationTableView.reloadData()
        }
    }
}

extension NotificationsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filterNotifications = self.notifications
            self.notificationTableView.reloadData()
            return
        } else {
            self.filterNotifications = self.notifications.filter({String($0.amount).contains(searchText)})
            
            self.notificationTableView.reloadData()
            
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
