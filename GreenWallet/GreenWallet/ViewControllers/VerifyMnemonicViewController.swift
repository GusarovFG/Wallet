//
//  VerifyMnemonicViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 03.05.2022.
//

import UIKit

class VerifyMnemonicViewController: UIViewController {
    
    var mnemonicPhrase: [String] = []
    private let indexes: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    private var verifyedMnemonicPhrase: [String] = []
    private var selectPhrase: [String] = []
    private var selectIndex = 0
    private let alert = AlertService()
    
    @IBOutlet weak var veryfyCollectionView: UICollectionView!
    @IBOutlet weak var selectCollectionView: UICollectionView!
    @IBOutlet weak var errorLabel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.errorLabel.alpha = 0
        self.errorLabel.isHidden = true
        
        self.veryfyCollectionView.register(UINib(nibName: "MnemonicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mnemonicCell")
        self.selectCollectionView.register(UINib(nibName: "MnemonicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mnemonicCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for i in 0..<self.mnemonicPhrase.count {
            if i < 6 {
                self.verifyedMnemonicPhrase.append(self.mnemonicPhrase[i])
            } else {
                self.verifyedMnemonicPhrase.append("")
                self.selectPhrase.append(self.mnemonicPhrase[i])
            }
        }
        print(verifyedMnemonicPhrase)
        print(selectPhrase)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func mainButtonPressed(_ sender: Any) {
        if self.verifyedMnemonicPhrase == self.mnemonicPhrase {
            let alertVC = self.alert.alert()
            self.present(alertVC, animated: true, completion: nil)
        } else {
            self.errorLabel.isHidden = false
            UIView.animate(withDuration: 1) {
                self.errorLabel.alpha = 1
            }
        }
    }
    
    @IBAction func clouseErrorLabel(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.errorLabel.alpha = 0
        }
        self.errorLabel.isHidden = true
    }
    
}

extension VerifyMnemonicViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.veryfyCollectionView:
            return self.verifyedMnemonicPhrase.count
        case self.selectCollectionView:
            return self.selectPhrase.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mnemonicCell", for: indexPath) as! MnemonicCollectionViewCell
        
        
        switch collectionView {
        case self.veryfyCollectionView:
            cell.mnemonicWord.text = "\(self.indexes[indexPath.row]). \(self.verifyedMnemonicPhrase[indexPath.row])"
            if indexPath > [0,5] && cell.mnemonicWord.text != "\(self.indexes[indexPath.row]). " {
                cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                cell.mnemonicWord.tintColor = .white
            } else {
                cell.backgroundColor = .systemBackground
            }
            return cell
        case self.selectCollectionView:
            cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
            cell.mnemonicWord.text = "\(self.selectPhrase[indexPath.row])"
            cell.mnemonicWord.tintColor = .white
            return cell
        default:
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case self.veryfyCollectionView:
            if indexPath > [0,5] {
                self.selectIndex = indexPath.row
                if self.verifyedMnemonicPhrase[indexPath.row] != "" {
                    self.selectPhrase.append(self.verifyedMnemonicPhrase[indexPath.row])
                    self.verifyedMnemonicPhrase.remove(at: indexPath.row)
                    self.verifyedMnemonicPhrase.insert("", at: indexPath.row)
                    
                    self.veryfyCollectionView.reloadData()
                    self.selectCollectionView.reloadData()
                }
            }
        case self.selectCollectionView:
            if self.selectIndex >= 6 {
                self.verifyedMnemonicPhrase.remove(at: self.selectIndex)
                self.verifyedMnemonicPhrase.insert(self.selectPhrase[indexPath.row], at: self.selectIndex)
                
                self.selectPhrase.remove(at: indexPath.row)
                
                self.veryfyCollectionView.reloadData()
                self.selectCollectionView.reloadData()
                
                self.selectIndex = 0
            }
            
        default:
            break
        }
        
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        switch collectionView {
    //        case self.veryfyCollectionView:
    //            return CGSize(width: 178, height: 50)
    //        case self.selectCollectionView:
    //            return CGSize(width: 178, height: 50)
    //        default:
    //            return CGSize(width: 178, height: 50)
    //        }
    //    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        10
    //    }
}
