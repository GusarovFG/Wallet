//
//  FAQController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 05.06.2022.
//

import UIKit

class FAQController: UIViewController {
    
    var faqs: [[String]] = []
    var button = UIButton()
    
    @IBOutlet weak var faqsTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mainTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global().async {
            NetworkManager.share.getFAQ { questions in
                self.faqs = questions
                DispatchQueue.main.async {
                    self.faqsTableView.reloadData()
                }
            }
        }
        
        print(self.faqs)
        self.button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
        self.mainTitle.text = LocalizationManager.share.translate?.result.list.faq.faq_title
        
        
    }
    
    @IBAction func backBButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for i in 0..<self.faqsTableView.numberOfSections {
            self.button = UIButton(frame: CGRect(x: self.faqsTableView.headerView(forSection: i)!.frame.width - 30, y: self.faqsTableView.headerView(forSection: i)!.frame.height - 50, width:30, height:30))
            self.button.setImage(UIImage(named: "plus")!, for: .normal)
            self.button.addTarget(self.faqsTableView.visibleCells, action: #selector(handleTap), for: .touchUpInside)
            self.faqsTableView.headerView(forSection: i)?.addSubview(self.button)
        }
    }
}

extension FAQController: UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate {
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.faqs.isEmpty {
            return 0
        } else {
            return self.faqs[0].count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.faqs.isEmpty {
            return 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "faqCell", for: indexPath)
        if !self.faqs.isEmpty {
            cell.textLabel?.text = faqs[1][indexPath.section]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font.withSize(16)
        }
        return cell
            
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            return 90
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        if !self.faqs.isEmpty {
        header.setup(withTitle: faqs[0][section], section: section, delegate: self)
        header.textLabel?.font.withSize(18)
        if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
            header.textLabel?.textColor = .black
        } else {
            header.textLabel?.textColor = .white
        }
        }
        return header
    }
    
    @objc func handleTap(){
        if self.button.imageView?.image == UIImage(named: "plus")! {
            self.button.setImage(UIImage(named: "cross")!, for: .normal)
        } else {
            self.button.setImage(UIImage(named: "plus")!, for: .normal)
        }
    }
}

struct FAQs {
    let header: String
    let inCells: [String]
    var expanded: Bool
}
