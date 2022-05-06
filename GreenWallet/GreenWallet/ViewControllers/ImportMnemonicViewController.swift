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
        
        for _ in 0..<countOfItems {
            self.mnemonicPhrase.append("")
        }
        
        self.collectionView.register(UINib(nibName: "ImportMnemonicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImportMnemonicCollectionViewCell")
        
        setuptermsLabel()
        registerFromKeyBoardNotifications()
        self.scrollView.isScrollEnabled = false
        self.continueButton.backgroundColor = #colorLiteral(red: 0.6106664538, green: 0.6106664538, blue: 0.6106664538, alpha: 1)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
    }
    
    private func registerFromKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        
        self.scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrame.height - 100)
    }
    
    @objc private func keyboardWillHide() {
        self.scrollView.contentOffset = CGPoint.zero
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
            
            for _ in 0...5 {
                self.mnemonicPhrase.removeLast()
            }
            for _ in 0...5 {
                self.mnemonicPhrase.remove(at: 6)
            }
            
            self.scrollView.isScrollEnabled = false
            self.scrollView.setContentOffset(.zero, animated: true)
            self.collectionView.reloadData()
            self.bottomConstraint.constant = self.bottomConstraint.constant - (50 * 6)
        } else {
            self.countOfItems = 24
            
            for _ in 0...5 {
                self.mnemonicPhrase.insert("", at: 6)
            }
            for _ in 0...5 {
                self.mnemonicPhrase.insert("", at: 18)
            }
            
            self.scrollView.isScrollEnabled = true
            self.collectionView.reloadData()
            self.bottomConstraint.constant = self.bottomConstraint.constant + (50 * 6)
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
            
            self.continueButton.backgroundColor = #colorLiteral(red: 0.6106664538, green: 0.6106664538, blue: 0.6106664538, alpha: 1)
            self.continueButton.isEnabled = false
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "spinner", bundle: .main)
        let spinnerVC = storyboard.instantiateViewController(withIdentifier: "spinner") as! SprinnerViewController
        
        self.present(spinnerVC, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            self.alertView.backgroundColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 1)
            self.alertLabel.text = "Проверьте правильность введенной комбинации слов"
            self.collectionView.visibleCells.forEach { cell in
                cell.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                let storyboard = UIStoryboard(name: "Alert", bundle: .main)
                let spinnerVC = storyboard.instantiateViewController(withIdentifier: "AllertImportViewController") as! AllertWalletViewController
                
                self.present(spinnerVC, animated: true, completion: nil)
                
            }
        }
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
        
        let mnemonicWord = self.mnemonicPhrase[indexPath.row]
        if mnemonicWord == "" {
            cell.cellTextLabel.placeholder = "\(indexPath.row + 1)."
            cell.cellTextLabel.text = mnemonicWord
            cell.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        } else {
            cell.cellTextLabel.text = mnemonicWord
        }
        
        let dicimalCharacters = CharacterSet.decimalDigits
        let dicimalRange = cell.cellTextLabel.text?.rangeOfCharacter(from: dicimalCharacters)
        
        if dicimalRange != nil {
            cell.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
        } else {
            cell.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
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
                
                let dicimalCharacters = CharacterSet.decimalDigits
                let dicimalRange = cell.cellTextLabel.text?.rangeOfCharacter(from: dicimalCharacters)
                
                if dicimalRange != nil {
                    cell.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
                } else {
                    cell.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                }
                

                
                for i in 0..<self.mnemonicPhrase.count  {
                    if self.mnemonicPhrase[i] == cell.cellTextLabel.text   {
                        cell.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
                        self.collectionView.cellForItem(at: [0,i])?.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
                        print(self.mnemonicPhrase)
                        self.errorLabel.isHidden = false
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
            self.errorLabel.isHidden = true
            if cell.cellTextLabel.text!.contains(" ") || cell.cellTextLabel.text!.contains("-") {
                cell.cellTextLabel.text = ""
                self.mnemonicPhrase.remove(at: indexPath.row)
                self.mnemonicPhrase.insert("", at: indexPath.row)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 178, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
}

extension ImportMnemonicViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == (self.countOfItems - 1) {
            textField.resignFirstResponder()
        } else {
            let nextCell = self.collectionView?.cellForItem(at: IndexPath.init(row: textField.tag + 1, section: 0)) as! ImportMnemonicCollectionViewCell
            if let nextField = nextCell.cellTextLabel {
                nextField.becomeFirstResponder()
            }
        }
        
        return true
    }
}

