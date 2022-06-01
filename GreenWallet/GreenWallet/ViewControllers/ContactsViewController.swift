//
//  ContactsViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 01.06.2022.
//

import UIKit

class ContactsViewController: UIViewController {
    
    var isNotTabbar = false
    private var contacts: [Contact] = []
    private var filterContacts: [Contact] = []

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var addContactButton: UIButton!
    @IBOutlet weak var contactsTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if !self.isNotTabbar {
            self.backButton.isEnabled = false
            self.backButton.alpha = 0
        }
        self.addContactButton.buttonStroke(#colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1))
        self.contactsTableView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactTableViewCell")
        self.contacts = CoreDataManager.share.fetchContacts()
        self.filterContacts = self.contacts
        localization()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.contactsTableView.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.contacts = CoreDataManager.share.fetchContacts()
        self.filterContacts = self.contacts
        self.contactsTableView.reloadData()
    }
    
    

    private func localization() {
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
        self.mainTitleLabel.text = LocalizationManager.share.translate?.result.list.address_book.address_book_title
        self.addContactButton.setTitle(LocalizationManager.share.translate?.result.list.address_book.address_book_add_adress, for: .normal)
        self.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: LocalizationManager.share.translate?.result.list.all.search ?? "", attributes: [:])
    }

    @IBAction func addContactButtonPressed(_ sender: Any) {
        let addContactVC = storyboard?.instantiateViewController(withIdentifier: "AddContactViewController") as! AddContactViewController
        addContactVC.modalPresentationStyle = .fullScreen
        self.present(addContactVC, animated: true)
    }
    
    @IBAction @objc func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.filterContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as!  ContactTableViewCell
        cell.contact = self.filterContacts[indexPath.row]
        cell.cellSetup()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
    
}

extension ContactsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filterContacts = self.contacts
            self.contactsTableView.reloadData()
            return
        } else {
            
            self.filterContacts = self.contacts.filter({$0.name?.lowercased().contains(searchText.lowercased()) ?? true})
            self.contactsTableView.reloadData()
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
