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
        NotificationCenter.default.addObserver(self, selector: #selector(localization), name: NSNotification.Name("localized"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showPopUp), name: NSNotification.Name("showPopUp"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showSpinner), name: NSNotification.Name("showSpinner"), object: nil)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    @objc private func localization() {
        self.backButton.setTitle(LocalizationManager.share.translate?.result.list.all.back_btn, for: .normal)
        self.mainTitleLabel.text = LocalizationManager.share.translate?.result.list.address_book.address_book_title
        self.addContactButton.setTitle(LocalizationManager.share.translate?.result.list.address_book.address_book_add_adress, for: .normal)
        self.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: LocalizationManager.share.translate?.result.list.all.search ?? "", attributes: [:])
    }
    
    @objc private func showSpinner() {
        AlertManager.share.showSpinner(self, true)
        self.contacts = CoreDataManager.share.fetchContacts()
        self.filterContacts = self.contacts
        self.contactsTableView.reloadData()
    }
    
    @objc func showPopUp() {

        self.contacts = CoreDataManager.share.fetchContacts()
        self.filterContacts = self.contacts
        self.contactsTableView.reloadData()
        AlertManager.share.successDeletingContact(self)
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
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contact = self.contacts[indexPath.row]
        let edit = UIContextualAction(style: .normal,
                                         title: "") { [weak self] (action, view, completionHandler) in
            let addContactVC = self?.storyboard?.instantiateViewController(withIdentifier: "AddContactViewController") as! AddContactViewController
            addContactVC.modalPresentationStyle = .fullScreen
            addContactVC.isEditingContact = true
            addContactVC.contact = contact
            addContactVC.index = indexPath.row
            self?.present(addContactVC, animated: true)
            
            completionHandler(true)
        }
        edit.backgroundColor = #colorLiteral(red: 0.1189827248, green: 0.6536024213, blue: 1, alpha: 1)
        edit.image = UIImage(named: "editContact")!

        let send = UIContextualAction(style: .normal, title: "") { action, view, completionHandler in
            
            
            
            completionHandler(true)
        }
        send.image = UIImage(named: "sendAction")!
        send.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.6745098039, blue: 0.3490196078, alpha: 1)
        
        let trash = UIContextualAction(style: .normal,
                                       title: "") { (action, view, completionHandler) in
            AlertManager.share.confirmDeleteContact(self, indexPath)
            completionHandler(true)
        }
        
        trash.backgroundColor = .systemRed
        trash.image = UIImage(named: "Trash")!
        
        let configuration = UISwipeActionsConfiguration(actions: [send, edit, trash])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
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
