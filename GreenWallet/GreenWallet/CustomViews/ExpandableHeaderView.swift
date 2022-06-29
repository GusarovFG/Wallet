//
//  ExpandableHeaderView.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 05.06.2022.
//

import UIKit

protocol ExpandableHeaderViewDelegate: class {
    func toggleSection(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {
    
    weak var delegate: ExpandableHeaderViewDelegate?
    var section: Int?
    var button = UIButton(frame: CGRect(x: 0, y: 0, width:30, height:30))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
            self.textLabel?.textColor = .black
        } else {
            self.textLabel?.textColor = .white
        }
    }
    
    func setup(withTitle title: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        
        self.delegate = delegate
        self.section = section
        self.textLabel?.text = title
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.textColor = .white
        contentView.backgroundColor = .systemBackground
        self.button = UIButton(frame: CGRect(x: self.frame.width - 30, y: self.frame.height - 50, width:30, height:30))
        self.button.imageView?.image = UIImage(named: "plus")!
//            self.button.setImage(UIImage(named: "cross")!, for: .normal)
//        } else {
//            self.button.setImage(UIImage(named: "plus")!, for: .normal)
//        }
        if UserDefaultsManager.shared.userDefaults.string(forKey: "Theme") == "light" {
            self.textLabel?.textColor = .black
        } else {
            self.textLabel?.textColor = .white
        }
        self.addSubview(self.button)
    }
    
    override func layoutIfNeeded() {

    }
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectHeaderAction(gesterRecognizer: UITapGestureRecognizer) {
        let cell = gesterRecognizer.view as! ExpandableHeaderView
        delegate?.toggleSection(header: self, section: cell.section!)
        
    }
}
