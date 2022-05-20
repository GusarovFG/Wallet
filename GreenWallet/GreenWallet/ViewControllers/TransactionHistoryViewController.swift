//
//  TransactionHistoryViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 19.05.2022.
//

import UIKit

class TransactionHistoryViewController: UIViewController {
    
    private var walletsTransactions: [Transaction] = [Transaction(type: .input, height: 1098726, summ: "4,555", token: "XCH", date: "today"),
                                                      Transaction(type: .output, height: 1098726, summ: "4,555", token: "XCH", date: "yesterday"),
                                                      Transaction(type: .output, height: 1098726, summ: "4,555", token: "XCC", date: "yesterday"),
                                                      Transaction(type: .output, height: 1098726, summ: "4,555", token: "XCH", date: "lastMonth"),
                                                      Transaction(type: .input, height: 1098726, summ: "4,555", token: "XCC", date: "today"),
                                                      Transaction(type: .input, height: 1098726, summ: "4,555", token: "XCC", date: "lastWeek"),
                                                      Transaction(type: .waiting, height: 1098726, summ: "4,555", token: "XCC", date: "yesterday"),
                                                      Transaction(type: .input, height: 1098726, summ: "4,555", token: "XCH", date: "lastMonth"),
                                                      Transaction(type: .input, height: 1098726, summ: "4,555", token: "XCH", date: "lastMonth")]
    private var filterWalletsTransactions: [Transaction] = []
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterAllButton: UIButton!
    @IBOutlet weak var filterInButton: UIButton!
    @IBOutlet weak var filterOutButton: UIButton!
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.filterAllButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        self.filterInButton.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        self.filterOutButton.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        self.filterAllButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.filterInButton.tintColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
        self.filterOutButton.tintColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
        
        self.filterAllButton.setTitle("Все", for: .normal)
        self.filterInButton.setTitle("Входящие", for: .normal)
        self.filterOutButton.setTitle("Исходящие", for: .normal)
        
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
        
        
        
        self.filterWalletsTransactions = self.walletsTransactions
        self.tableView.register(UINib(nibName: "TransitionsTableViewCell", bundle: nil), forCellReuseIdentifier: "TransitionsTableViewCell")
        
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
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func filterAllButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        sender.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.filterInButton.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        self.filterOutButton.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        self.filterAllButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.filterInButton.tintColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
        self.filterOutButton.tintColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
        self.filterWalletsTransactions = self.walletsTransactions
        self.tableView.reloadData()
    }
    
    @IBAction func filterInButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        sender.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.filterAllButton.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        self.filterOutButton.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        self.filterAllButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.filterAllButton.tintColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
        self.filterOutButton.tintColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
        self.filterWalletsTransactions = self.walletsTransactions.filter({$0.type == TransactionType.input})
        self.tableView.reloadData()
    }
    
    @IBAction func filterOutButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        sender.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.filterAllButton.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        self.filterInButton.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        self.filterInButton.tintColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
        self.filterAllButton.tintColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
        self.filterWalletsTransactions = self.walletsTransactions.filter({$0.type == TransactionType.output})
        self.tableView.reloadData()
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
            
        case .input:
            cell.typeOfTransitionLabel.textColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        case .output:
            cell.typeOfTransitionLabel.textColor = #colorLiteral(red: 1, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        case .waiting:
            cell.typeOfTransitionLabel.textColor = #colorLiteral(red: 0.1176470588, green: 0.5764705882, blue: 1, alpha: 1)
        }
        cell.heightLabel.text = "\(transiction.height)"
        cell.typeOfTransitionLabel.text = transiction.type.rawValue
        cell.summLabel.text = transiction.summ + " " + transiction.token
        return cell
    }
}



struct Transaction {
    var type: TransactionType
    var height: Int
    var summ: String
    var token: String
    var date: String
}

enum TransactionType: String {
    case input = "Входящие"
    case output = "Исходящие"
    case waiting = "В обработке"
    
}
