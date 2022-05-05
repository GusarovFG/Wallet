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
    
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var termsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0..<countOfItems {
            self.mnemonicPhrase.append("")
        }
        
        self.collectionView.register(UINib(nibName: "ImportMnemonicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImportMnemonicCollectionViewCell")
        
        setuptermsLabel()
        
        self.scrollView.isScrollEnabled = false
        self.continueButton.backgroundColor = #colorLiteral(red: 0.6106664538, green: 0.6106664538, blue: 0.6106664538, alpha: 1)
        self.continueButton.isEnabled = false
        self.errorLabel.isHidden = true
        
        self.termsLabel.addRangeGesture(stringRange: "условиями пользования") {
            let url = URL(string: "https://devushka.ru/upload/posts/a1797083197722a6b1ab8e2f4beb2b08.jpg")
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!, options: [:])
            }
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
            
            for _ in 0...5 {
                self.mnemonicPhrase.removeLast()
                print(self.mnemonicPhrase)

            }
            for _ in 0...5 {
                self.mnemonicPhrase.remove(at: 6)
                print(self.mnemonicPhrase)

            }
            
            
            self.scrollView.isScrollEnabled = false
            self.scrollView.setContentOffset(.zero, animated: true)
            self.collectionView.reloadData()
            self.bottomConstraint.constant = self.bottomConstraint.constant - (50 * 6)
            
//            print(self.mnemonicPhrase)
//            print(self.mnemonicPhrase.count)
        } else {
            self.countOfItems = 24
            
            for _ in 0...5 {
                self.mnemonicPhrase.insert("", at: 6)
                print(self.mnemonicPhrase)
            }
            for _ in 0...5 {
                self.mnemonicPhrase.insert("", at: 18)
                print(self.mnemonicPhrase)

            }
            
            
            self.scrollView.isScrollEnabled = true
            self.collectionView.reloadData()
            self.bottomConstraint.constant = self.bottomConstraint.constant + (50 * 6)

//            print(self.mnemonicPhrase)
//            print(self.mnemonicPhrase.count)
            
        }
    }
    
    @IBAction func checkBoxButtonPressed(_ sender: UIButton) {
        if sender.imageView?.image != UIImage(systemName: "checkmark.square.fill") {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            sender.tintColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            sender.backgroundColor = .white
            sender.imageView?.layer.cornerRadius = 5
            
            self.continueButton.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            self.continueButton.isEnabled = true
        } else {
            sender.setImage(UIImage(systemName: "squareshape.fill"), for: .normal)
            sender.imageView?.layer.cornerRadius = 5
            sender.tintColor = .white
            
            self.continueButton.backgroundColor = #colorLiteral(red: 0.6106664538, green: 0.6106664538, blue: 0.6106664538, alpha: 1)
            self.continueButton.isEnabled = false
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ImportMnemonicViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.countOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImportMnemonicCollectionViewCell", for: indexPath) as! ImportMnemonicCollectionViewCell
        let mnemonicWord = self.mnemonicPhrase[indexPath.row]
        if mnemonicWord == "" {
            cell.cellTextLabel.placeholder = "\(indexPath.row + 1)."
            cell.cellTextLabel.text = mnemonicWord
        } else {
            cell.cellTextLabel.text = mnemonicWord
        }
        
        let dicimalCharacters = CharacterSet.decimalDigits
        let dicimalRange = cell.cellTextLabel.text?.rangeOfCharacter(from: dicimalCharacters
        )
        if dicimalRange != nil {
            cell.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
        } else {
            cell.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
        }
        
        cell.appendInPhrase = { [unowned self] in
            if cell.cellTextLabel.text != "" {
                self.mnemonicPhrase.remove(at: indexPath.row)
                
                let dicimalCharacters = CharacterSet.decimalDigits
                let dicimalRange = cell.cellTextLabel.text?.rangeOfCharacter(from: dicimalCharacters
                )
                
                if dicimalRange != nil {
                    cell.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
                } else {
                    cell.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                }
                self.mnemonicPhrase.insert(cell.cellTextLabel.text ?? "", at: indexPath.row)
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

