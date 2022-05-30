//
//  TransactionHistoryViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 19.05.2022.
//

import UIKit

class TransactionHistoryViewController: UIViewController {
    
    var isHistoryWallet = false
    
    private var walletsTransactions: [Transaction] = [Transaction(type: LocalizationManager.share.translate?.result.list.transactions.transactions_incoming ?? "", height: 1098726, summ: "4,555", token: "XCH", date: "today"),
                                                      Transaction(type: LocalizationManager.share.translate?.result.list.transactions.transactions_incoming ?? "", height: 1098726, summ: "4,555", token: "XCH", date: "yesterday"),
                                                      Transaction(type: LocalizationManager.share.translate?.result.list.transactions.incoming_outgoing ?? "", height: 1098726, summ: "4,555", token: "XCC", date: "yesterday"),
                                                      Transaction(type: LocalizationManager.share.translate?.result.list.transactions.transactions_pendind ?? "", height: 1098726, summ: "4,555", token: "XCH", date: "lastMonth"),
                                                      Transaction(type: LocalizationManager.share.translate?.result.list.transactions.transactions_pendind ?? "", height: 1098726, summ: "4,555", token: "XCC", date: "today"),
                                                      Transaction(type: LocalizationManager.share.translate?.result.list.transactions.incoming_outgoing ?? "", height: 1098726, summ: "4,555", token: "XCC", date: "lastWeek"),
                                                      Transaction(type: LocalizationManager.share.translate?.result.list.transactions.transactions_pendind ?? "", height: 1098726, summ: "4,555", token: "XCC", date: "yesterday"),
                                                      Transaction(type: LocalizationManager.share.translate?.result.list.transactions.transactions_pendind ?? "", height: 1098726, summ: "4,555", token: "XCH", date: "lastMonth"),
                                                      Transaction(type: LocalizationManager.share.translate?.result.list.transactions.incoming_outgoing ?? "", height: 1098726, summ: "4,555", token: "XCH", date: "lastMonth")]
    private var filterWalletsTransactions: [Transaction] = []
    private var isAllFilter = true
    private var isInFilter = false
    private var isOutFilter = false
    private var isPendindFilter = false
    
    
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
    @IBOutlet weak var chiaSystemButton: UIButton!
    @IBOutlet weak var chivesSystemButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.isHistoryWallet {
            self.backButton.alpha = 1
            self.backButton.isEnabled = true
        } else {
            self.backButton.alpha = 0
            self.backButton.isEnabled = false
        }
        
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
        
        self.allDateButton.buttonStroke()
        self.todayDateButton.buttonStroke()
        self.yesterdayDayeButton.buttonStroke()
        self.lastWeekDateButton.buttonStroke()
        
        self.systemMenuView.isHidden = true
        self.systemMenuView.alpha = 0
        
        self.chivesSystemButton.buttonStroke()
        self.chiaSystemButton.buttonStroke()
        
        self.chiaSystemButton.setTitle("Chia Network", for: .normal)
        self.chivesSystemButton.setTitle("Chives Network", for: .normal)
        
        self.allDateButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.allDateButton.tintColor = .white
        
        localization()
        
        self.filterWalletsTransactions = self.walletsTransactions
        self.tableView.register(UINib(nibName: "TransitionsTableViewCell", bundle: nil), forCellReuseIdentifier: "TransitionsTableViewCell")
        self.filterCollectionView.register(UINib(nibName: "TransictionFilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TransictionFilterCollectionViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    private func localization() {
        self.titleLabel.text = LocalizationManager.share.translate?.result.list.transactions.transactions_title
        self.searchBar.searchTextField.placeholder = LocalizationManager.share.translate?.result.list.all.search
        self.todayDateButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_today, for: .normal)
        self.yesterdayDayeButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_yesterday, for: .normal)
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
        self.allDateButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_all, for: .normal)
//        self.heightLabel.text = LocalizationManager.share.translate?.result.list.transactions.transactions_height
//        self.statusLabel.text = LocalizationManager.share.translate?.result.list.transactions.transactions_status
//        self.summLabel.text = LocalizationManager.share.translate?.result.list.transactions.transactions_amoun
        self.allDateButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_all, for: .normal)

        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
        self.filterSystemButton.setTitle(LocalizationManager.share.translate?.result.list.transactions.transactions_all, for: .normal)
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
            self.filterTimeButton.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
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
        
        self.filterWalletsTransactions = self.walletsTransactions
        self.filterDateView.isHidden = true
        self.tableView.reloadData()
    }
    
    @IBAction func todayDateButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
  

        self.allDateButton.backgroundColor = .systemBackground
        self.yesterdayDayeButton.backgroundColor = .systemBackground
        self.lastWeekDateButton.backgroundColor = .systemBackground
        self.lastMonthButton.backgroundColor = .systemBackground
        
        self.filterWalletsTransactions = self.walletsTransactions.filter({$0.date == "today"})
        self.filterDateView.isHidden = true
        self.tableView.reloadData()
    }
    
    @IBAction func yesterdayDayeButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)


        self.todayDateButton.backgroundColor = .systemBackground
        self.allDateButton.backgroundColor = .systemBackground
        self.lastWeekDateButton.backgroundColor = .systemBackground
        self.lastMonthButton.backgroundColor = .systemBackground
        
        self.filterWalletsTransactions = self.walletsTransactions.filter({$0.date == "yesterday"})
        self.filterDateView.isHidden = true
        self.tableView.reloadData()
    }
    
    @IBAction func lastWeekDateButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)


        self.todayDateButton.backgroundColor = .systemBackground
        self.yesterdayDayeButton.backgroundColor = .systemBackground
        self.allDateButton.backgroundColor = .systemBackground
        self.lastMonthButton.backgroundColor = .systemBackground
        
        self.filterWalletsTransactions = self.walletsTransactions.filter({$0.date == "lastWeek"})
        self.filterDateView.isHidden = true
        self.tableView.reloadData()
    }
    
    @IBAction func lastMonthButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)


        self.todayDateButton.backgroundColor = .systemBackground
        self.yesterdayDayeButton.backgroundColor = .systemBackground
        self.lastWeekDateButton.backgroundColor = .systemBackground
        self.allDateButton.backgroundColor = .systemBackground
        
        self.filterWalletsTransactions = self.walletsTransactions.filter({$0.date == "lastMonth"})
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
        self.filterWalletsTransactions = self.walletsTransactions.filter({$0.token == "XCH"})
        self.tableView.reloadData()
    }
    @IBAction func chivesButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        
        self.filterWalletsTransactions = self.walletsTransactions.filter({$0.token == "XCC"})
        self.chiaSystemButton.backgroundColor = .systemBackground
        self.tableView.reloadData()
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
            
        case LocalizationManager.share.translate?.result.list.transactions.transactions_incoming :
            cell.typeOfTransitionLabel.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        case LocalizationManager.share.translate?.result.list.transactions.incoming_outgoing :
            cell.typeOfTransitionLabel.textColor = #colorLiteral(red: 1, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        case LocalizationManager.share.translate?.result.list.transactions.transactions_pendind :
            cell.typeOfTransitionLabel.textColor = #colorLiteral(red: 0.1176470588, green: 0.5764705882, blue: 1, alpha: 1)
        default:
            break
        }
        cell.heightLabel.text = "\(transiction.height)"
        cell.typeOfTransitionLabel.text = transiction.type
        cell.summLabel.text = transiction.summ + " " + transiction.token
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
                cell.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
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
                cell.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
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
                cell.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
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
                cell.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
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
                    cell.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
                }
            }
            cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            cell.cellLabel.textColor = .white
            self.filterWalletsTransactions = self.walletsTransactions
            self.isAllFilter = true
            self.isInFilter = false
            self.isOutFilter = false
            self.isPendindFilter = false
            self.tableView.reloadData()
        case [0,1]:
            self.filterCollectionView.visibleCells.forEach { cell in
                if cell is TransictionFilterCollectionViewCell {
                    (cell.viewWithTag(1) as! UILabel).textColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
                    cell.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
                }
            }
            cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            cell.cellLabel.textColor = .white
            self.filterWalletsTransactions = self.walletsTransactions.filter({$0.type == LocalizationManager.share.translate?.result.list.transactions.transactions_incoming})
            self.isAllFilter = false
            self.isInFilter = true
            self.isOutFilter = false
            self.isPendindFilter = false
            self.tableView.reloadData()
        case [0,2]:
            self.filterCollectionView.visibleCells.forEach { cell in
                if cell is TransictionFilterCollectionViewCell {
                    (cell.viewWithTag(1) as! UILabel).textColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
                    cell.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
                }
            }
            cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            cell.cellLabel.textColor = .white
            self.filterWalletsTransactions = self.walletsTransactions.filter({$0.type == LocalizationManager.share.translate?.result.list.transactions.incoming_outgoing})
            self.isAllFilter = false
            self.isInFilter = false
            self.isOutFilter = true
            self.isPendindFilter = false
            self.tableView.reloadData()
        default:
            self.filterCollectionView.visibleCells.forEach { cell in
                if cell is TransictionFilterCollectionViewCell {
                    (cell.viewWithTag(1) as! UILabel).textColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
                    cell.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
                }
            }
            cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            cell.cellLabel.textColor = .white
            self.filterWalletsTransactions = self.walletsTransactions.filter({$0.type == LocalizationManager.share.translate?.result.list.transactions.transactions_pendind})
            self.isAllFilter = false
            self.isInFilter = false
            self.isOutFilter = false
            self.isPendindFilter = true
            self.tableView.reloadData()
        }
    }
}



struct Transaction {
    var type: String
    var height: Int
    var summ: String
    var token: String
    var date: String
}

