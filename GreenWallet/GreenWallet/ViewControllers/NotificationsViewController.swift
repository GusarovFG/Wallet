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
    
    var notifications: [Notificationsss] = [Notificationsss(type: "in", height: "123123", summ: "500.000011000", token: "XCH", date: "27.06.22 21:00"), Notificationsss(type: "out", height: "123123", summ: "100.000011000", token: "XCH", date: "20.06.22 21:00"),Notificationsss(type: "in", height: "123123", summ: "100.000011000", token: "XCH", date: "25.06.22 21:00"),Notificationsss(type: "in", height: "123123", summ: "100.000011000", token: "XCH", date: "20.06.22 21:00"),Notificationsss(type: "in", height: "123123", summ: "110.000011000", token: "XCH", date: "20.06.22 21:00"),Notificationsss(type: "out", height: "123123", summ: "50.000011000", token: "XCH", date: "20.06.22 21:00"),Notificationsss(type: "in", height: "123123", summ: "20.000011000", token: "XCH", date: "20.06.22 21:00"),Notificationsss(type: "in", height: "123123", summ: "100.000011000", token: "XCH", date: "21.06.22 21:00"),Notificationsss(type: "in", height: "123123", summ: "100.000011000", token: "XCC", date: "20.06.22 21:00"),Notificationsss(type: "out", height: "123123", summ: "0.000011000", token: "XCH", date: "21.06.22 21:00"),Notificationsss(type: "out", height: "123123", summ: "100.000011000", token: "XCH", date: "20.06.22 21:00"),Notificationsss(type: "out", height: "123123", summ: "100.000011000", token: "XCH", date: "25.06.22 21:00"),Notificationsss(type: "in", height: "123123", summ: "100.000011000", token: "XCC", date: "20.06.22 21:00"),Notificationsss(type: "out", height: "123123", summ: "100.000011000", token: "XCH", date: "25.06.22 21:00")]
    var filterNotifications: [Notificationsss] = []
    
    

    private var systems: [ListSystems] = []
    private var isAllFilter = true
    private var isInFilter = false
    private var isOutFilter = false
    private var isPendindFilter = false
    
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var detailBackButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
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
    
    @IBOutlet weak var systemMenuView: UIView!
    @IBOutlet weak var systemsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var systemsStackView: UIStackView!
    
    @IBOutlet weak var allSystemButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.filterNotifications = self.notifications
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
        self.allSystemButton.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        
        self.systemMenuView.isHidden = true
        self.systemMenuView.alpha = 0
        
        self.allDateButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.allDateButton.tintColor = .white
    
        
        
        localization()
        
        self.tableView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
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
        self.filterSystemButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_all, for: .normal)
        self.allSystemButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_all, for: .normal)
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
    
    @IBAction func systemmenuOpen(_ sender: UIButton) {
        
        for i in 0..<self.systems.count {
            if self.systemsStackView.arrangedSubviews.count == (self.systems.count + 1){
                break
            } else {
                let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.systemsStackView.frame.width, height: 40))
                button.setTitle(self.systems[i].name, for: .normal)
                self.systemsStackView.addArrangedSubview(button)
                self.systemsViewHeightConstraint.constant += button.frame.height
                
                button.addTarget(self, action: #selector(setupSystemMenuButtons), for: .touchUpInside)
                
            }
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
                    self.filterNotifications = self.notifications.filter({$0.token.lowercased().contains("xch")})
                    print("filter chia")
                    self.tableView.reloadData()
                } else if sender.currentTitle == "Chives Network" {
                    self.filterNotifications = self.notifications.filter({$0.token.lowercased().contains("xcc")})
                    print("filter Chives")
                    self.tableView.reloadData()
                } else if sender.currentTitle == "Chia TestNet" {
                    self.filterNotifications = self.notifications.filter({$0.token.lowercased().contains("xch")})
                    print("filter Chia TestNet")
                    self.tableView.reloadData()
                } else if sender.currentTitle == "Chives TestNet" {
                    self.filterNotifications = self.notifications.filter({$0.token.lowercased().contains("xcc")})
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
        self.tableView.reloadData()
    }
    
    @IBAction func todayDateButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        
        
        
        self.allDateButton.backgroundColor = .systemBackground
        self.yesterdayDayeButton.backgroundColor = .systemBackground
        self.lastWeekDateButton.backgroundColor = .systemBackground
        self.lastMonthButton.backgroundColor = .systemBackground
        
       
        
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
        
//        self.filterWalletsTransactions = self.walletsTransactions.reduce([], +).filter({TimeManager.share.convertUnixTime(unix: $0.created_at_time, format: "dd.MM.yy").split(separator: ".")[1] == Date().string(format: "dd.MM.yy").split(separator: ".")[1] && TimeManager.share.convertUnixTime(unix: $0.created_at_time, format: "dd.MM.yy").split(separator: ".")[2] == Date().string(format: "dd.MM.yy").split(separator: ".")[2]})
        self.filterDateView.isHidden = true
        self.tableView.reloadData()
        
    }
    
  
    
    @IBAction func allSystemButtonPresed(_ sender: UIButton) {
        self.allSystemButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        UIView.animate(withDuration: 0.5) {
            self.systemMenuView.alpha = 0
            self.systemMenuView.isHidden = true
        }
        self.filterNotifications = self.notifications
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("dick")
        self.detailView.isHidden = false
        self.detailDateLabel.text = self.filterNotifications[indexPath.row].date
        self.detailAmountLabel.text = self.filterNotifications[indexPath.row].summ
        self.detailHeightLabel.text = self.filterNotifications[indexPath.row].height
        self.detailComissionLabel.text = self.filterNotifications[indexPath.row].summ
        tableView.deselectRow(at: indexPath, animated: true)
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
