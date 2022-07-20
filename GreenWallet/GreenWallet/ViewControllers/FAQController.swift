//
//  FAQController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 05.06.2022.
//

import UIKit

class FAQController: UIViewController, CollapsibleTableViewHeaderDelegate {
    
    
    
    var faqs: [[String]] = []
    var sections: [Section] = []
    var button = UIButton()
    
    @IBOutlet weak var faqsTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mainTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global().async {
            NetworkManager.share.getFAQ { questions in
                self.faqs = questions
                
                
                
                for i in 0..<self.faqs[1].count {
                    let section = Section(question: self.faqs[0][i], answer: self.faqs[1][i])
                    self.sections.append(section)
                }
                DispatchQueue.main.async {
                    self.faqsTableView.reloadData()
                }
            }
        }
        self.faqsTableView.estimatedRowHeight = 90
        self.faqsTableView.rowHeight = UITableView.automaticDimension
        print(self.faqs)
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
    }
}

extension FAQController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.faqs.isEmpty {
            return 0
        } else {
            return self.sections.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.faqs.isEmpty {
            return 0
        } else {
            return sections[section].collapsed ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "faqCell", for: indexPath)
        if !self.faqs.isEmpty {
            cell.textLabel?.text = self.sections[indexPath.section].answer
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
            cell.textLabel?.textColor = .lightGray
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = self.sections[section].question
        header.arrowLabel.text = "×"
        header.setCollapsed(self.sections[section].collapsed)
        header.arrowLabel.font = UIFont.systemFont(ofSize: 25)
        header.titleLabel.font = UIFont.systemFont(ofSize: 17)
        header.arrowLabel.textColor = #colorLiteral(red: 0.2269999981, green: 0.6750000119, blue: 0.3490000069, alpha: 1)
        header.section = section
        header.delegate = self
        
        if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
            header.titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            header.titleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        return header
    }
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        
//        let collapsed = !sections[section].collapsed
//        sections[section].collapsed = collapsed
//        header.setCollapsed(collapsed)
        
        for i in 0..<self.sections.count {
            if self.sections[i].question == self.sections[section].question {
                let collapsed = !sections[section].collapsed
                sections[section].collapsed = collapsed
                header.setCollapsed(collapsed)
                self.faqsTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .none)
            } else {
                self.sections[i].collapsed = false
                self.faqsTableView.reloadSections(NSIndexSet(index: i) as IndexSet, with: .none)
            }
        }
        
        
        // Reload the whole section
        
        
    }
    

}

struct Section {
    var question: String
    var answer: String
    var collapsed: Bool
    
    init(question: String, answer: String, collapsed: Bool = false) {
        self.question = question
        self.answer = answer
        self.collapsed = collapsed
    }
}

protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
}

class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    let titleLabel = UILabel()
    let arrowLabel = UILabel()
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowLabel)
        contentView.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        
        
        let marginGuide = contentView.layoutMarginsGuide
        
        // Arrow label
        contentView.addSubview(arrowLabel)
        arrowLabel.textColor = UIColor.white
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        arrowLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        arrowLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        arrowLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        
        // Title label
        contentView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    }
    
    func setCollapsed(_ collapsed: Bool) {
        // Animate the arrow rotation (see Extensions.swf)
        arrowLabel.rotate(collapsed ? 0.0 : .pi / 4)
    }
    
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }
        delegate?.toggleSection(self, section: cell.section)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
