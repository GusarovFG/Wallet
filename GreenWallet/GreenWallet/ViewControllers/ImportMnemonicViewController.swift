//
//  ImportMnemonicViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 05.05.2022.
//

import UIKit

class ImportMnemonicViewController: UIViewController {
    
    private var mnemonicPhrase: [String] = []
    private var countOfItems = 12
    private var checkBoxPress = false
    private var frameY: CGFloat = 0
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        for _ in 0..<countOfItems {
            self.mnemonicPhrase.append("")
        }
        
        self.collectionView.register(UINib(nibName: "ImportMnemonicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImportMnemonicCollectionViewCell")
        
        setuptermsLabel()
        registerFromKeyBoardNotifications()
        self.scrollView.isScrollEnabled = false
        self.continueButton.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        self.continueButton.isEnabled = false
        self.segmentedControl.setTitleTextAttributes([.foregroundColor: #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1), .font: UIFont(name: "Helvetica-Bold", size: 18.0) ], for: .selected)
        self.segmentedControl.setTitleTextAttributes([.foregroundColor: #colorLiteral(red: 0.2784313725, green: 0.2784313725, blue: 0.2784313725, alpha: 1) ], for: .normal)
        self.termsLabel.addRangeGesture(stringRange: "условиями пользования") {
            let url = URL(string: "https://devushka.ru/upload/posts/a1797083197722a6b1ab8e2f4beb2b08.jpg")
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!, options: [:])
            }
        }
    }
    
    
    private func localization() {
        self.titleLabel.text = LocalizationManager.share.translate?.result.list.import_mnemonics.import_mnemonics_title
        self.descriptionLabel.text = LocalizationManager.share.translate?.result.list.import_mnemonics.import_mnemonics_description
        self.alertLabel.text = LocalizationManager.share.translate?.result.list.import_mnemonics.import_mnemonics_warning
        self.continueButton.setTitle(LocalizationManager.share.translate?.result.list.all.next_btn, for: .normal)
        self.errorLabel.text = LocalizationManager.share.translate?.result.list.import_mnemonics.import_mnemonics_same_words_error
        self.termsLabel.text = LocalizationManager.share.translate?.result.list.all.agreement_with_terms_of_use_chekbox
        
    }
    
    
    
    private func registerFromKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom)
        self.scrollView.setContentOffset(bottomOffset, animated: false)
        self.scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrame.height - 100)
        self.scrollView.isScrollEnabled = true
    }
    
    @objc private func keyboardWillHide() {
        self.scrollView.contentOffset = CGPoint.zero
        if self.countOfItems == 12 {
            self.scrollView.isScrollEnabled = false
        }
    }
    
    
    
    private func setuptermsLabel() {
        let prefixString = "Я соглашаюсь с  "
        let infixAttributedString = NSAttributedString(
            string: "условиями пользования",
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)]
        )
        
        let attributedString = NSMutableAttributedString(string: prefixString)
        attributedString.append(infixAttributedString)
        
        self.termsLabel.attributedText = attributedString
    }
    
    @IBAction func segmentedControlIsChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.countOfItems = 12
            
            for _ in 0...11 {
                self.mnemonicPhrase.removeLast()
            }
            
            
            self.scrollView.isScrollEnabled = false
            self.scrollView.setContentOffset(.zero, animated: true)
            self.collectionView.reloadData()
            self.bottomConstraint.constant = self.bottomConstraint.constant - (55 * 6)
        } else {
            self.countOfItems = 24
            
            for _ in 0...11 {
                self.mnemonicPhrase.insert("", at: 12)
            }
            
            
            self.scrollView.isScrollEnabled = true
            
            self.collectionView.reloadData()
            self.bottomConstraint.constant = self.bottomConstraint.constant + (55 * 6)
        }
    }
    
    @IBAction func checkBoxButtonPressed(_ sender: UIButton) {
        if sender.imageView?.image != UIImage(systemName: "checkmark.square.fill") {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            sender.tintColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            sender.backgroundColor = .white
            sender.imageView?.layer.cornerRadius = 5
            
            self.checkBoxPress = true
            self.collectionView.reloadData()
            
            if self.mnemonicPhrase.filter({$0 == ""}).count == 0 {
                self.continueButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                self.continueButton.isEnabled = true
            }
            
        } else {
            sender.setImage(UIImage(systemName: "squareshape.fill"), for: .normal)
            sender.imageView?.layer.cornerRadius = 5
            sender.tintColor = .white
            
            self.checkBoxPress = false
            
            self.continueButton.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
            self.continueButton.isEnabled = false
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        
        
        for i in 0..<self.mnemonicPhrase.count{
            if self.mnemonicPhrase.filter({$0 == self.mnemonicPhrase[i]}).count > 2 {
                self.alertView.backgroundColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 1)
                self.alertLabel.text = LocalizationManager.share.translate?.result.list.import_mnemonics.import_mnemonics_wrong_words_error
                self.collectionView.visibleCells.forEach { cell in
                    cell.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
                    
                }
            } else {
                
                
            }
        }
        
        
        
    }
    @IBAction func tapHideKeyBoard(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("HideCellKeyboard"), object: nil)
        self.view.frame.origin.y = 0
    }
}

extension ImportMnemonicViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.countOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImportMnemonicCollectionViewCell", for: indexPath) as! ImportMnemonicCollectionViewCell
        
        cell.cellTextLabel.tag = indexPath.row
        cell.cellTextLabel.delegate = self
        cell.controller = self
        
        
        
        let mnemonicWord = self.mnemonicPhrase[indexPath.row]
        if mnemonicWord == "" {
            cell.cellTextLabel.placeholder = "\(indexPath.row + 1)."
            cell.cellTextLabel.text = mnemonicWord
            cell.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        } else {
            cell.cellTextLabel.text = mnemonicWord
        }
        
        if cell.cellTextLabel.text == "" && self.checkBoxPress {
            cell.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
        } else {
            cell.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        }
        
        if self.mnemonicPhrase.count == 24 && self.mnemonicPhrase.filter({$0 == ""}).count == 12 {
            if indexPath >= [0,6], indexPath <= [0,11] {
                cell.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
            } else if indexPath >= [0,18], indexPath <= [0,23] {
                cell.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
            }
        }
        
        cell.appendInPhrase = { [unowned self] in
            
            if cell.cellTextLabel.text != "" {
                self.errorLabel.isHidden = true
                
                for i in 0..<self.mnemonicPhrase.count  {
                    if self.mnemonicPhrase[i] == cell.cellTextLabel.text   {
                        self.collectionView.cellForItem(at: [0,i])?.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
                        cell.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
                        self.errorLabel.isHidden = false
                    } else {
                        cell.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                        self.continueButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                        self.continueButton.isEnabled = true
                    }
                }
                if self.countOfItems == 12 || self.countOfItems == 24 {
                    if self.mnemonicPhrase.filter({$0 == ""}).count == 0 && self.checkBoxPress {
                        self.continueButton.isEnabled = true
                        self.continueButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                    } else {
                        self.continueButton.isEnabled = false
                        self.continueButton.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
                    }
                }
                
                
                self.mnemonicPhrase.remove(at: indexPath.row)
                self.mnemonicPhrase.insert(cell.cellTextLabel.text ?? "", at: indexPath.row)
            } else {
                self.mnemonicPhrase.remove(at: indexPath.row)
                self.mnemonicPhrase.insert("", at: indexPath.row)
                cell.cellTextLabel.placeholder = "\(indexPath.row + 1)."
                cell.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            }
        }
        
        cell.endEditing = { [unowned self] in
            if self.countOfItems == 12 || self.countOfItems == 24 {
                if self.mnemonicPhrase.filter({$0 == ""}).count == 0 && self.checkBoxPress && cell.cellTextLabel.text != "" && cell.cellTextLabel.text != " " {
                    self.continueButton.isEnabled = true
                    self.continueButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                } else {
                    self.continueButton.isEnabled = false
                    self.continueButton.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
                }
            }
        }
        
        if self.countOfItems == 24 {
            if cell.cellTextLabel.text == "" {
                cell.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
            } else {
                
                cell.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            }
        }
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 178, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
}

extension ImportMnemonicViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        if textField.tag == (self.countOfItems - 1) {
            textField.resignFirstResponder()
            self.view.frame.origin.y = 0
        } else {
            let nextCell = self.collectionView?.cellForItem(at: IndexPath.init(row: textField.tag + 1, section: 0)) as! ImportMnemonicCollectionViewCell
            if let nextField = nextCell.cellTextLabel {
                nextField.becomeFirstResponder()
                if self.countOfItems == 24 {
                    if textField.tag >= 5 && textField.tag <= 10 || textField.tag > 16 {
                        self.view.frame.origin.y -= nextCell.frame.height
                        
                    } else if textField.tag == 11 {
                        self.view.frame.origin.y = 0
                    }
                    
                } else {
                    return true
                }
            }
        }
        
        return true
    }
}

