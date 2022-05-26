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
    private var selectIndex = 6
    private var errorVarify = false
    private var firstWord = true
    private let alert = AlertService()
    
    @IBOutlet weak var pleaseLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var veryfyCollectionView: UICollectionView!
    @IBOutlet weak var selectCollectionView: UICollectionView!
    @IBOutlet weak var errorLabel: UIView!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var errorTitle: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
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
        self.selectPhrase.shuffle()
        
        print(verifyedMnemonicPhrase)
        print(selectPhrase)
    }
    
    private func localization() {
        self.titleLabel.text = LocalizationManager.share.translate?.result.list.mnemonic_phrase_verification.mnemonic_phrase_verification_title
        self.discriptionLabel.text = LocalizationManager.share.translate?.result.list.mnemonic_phrase_verification.mnemonic_phrase_verification_description
        self.pleaseLabel.text = LocalizationManager.share.translate?.result.list.mnemonic_phrase_verification.mnemonic_phrase_verification_task
        self.continueButton.setTitle(LocalizationManager.share.translate?.result.list.all.next_btn, for: .normal)
        self.errorTitle.text = LocalizationManager.share.translate?.result.list.mnemonic_phrase_verification.mnemonic_phrase_verification_error
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func mainButtonPressed(_ sender: Any) {
        if self.verifyedMnemonicPhrase == self.mnemonicPhrase {
            let storyboard = UIStoryboard(name: "Alert", bundle: .main)
            let spinnerVC = storyboard.instantiateViewController(withIdentifier: "AllertWalletViewController") as! AllertWalletViewController
            
            self.present(spinnerVC, animated: true, completion: nil)
        } else {
            self.errorLabel.isHidden = false
            UIView.animate(withDuration: 1) {
                self.errorLabel.alpha = 1
                self.errorVarify = true
                self.veryfyCollectionView.visibleCells.forEach({$0.layer.borderColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157) })
                self.veryfyCollectionView.visibleCells.forEach({$0.backgroundColor = .systemBackground })
                self.veryfyCollectionView.reloadData()
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                UIView.animate(withDuration: 1) {
                    self.errorLabel.alpha = 0
                    self.veryfyCollectionView.visibleCells.forEach({$0.layer.borderColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1) })
                    
                    self.verifyedMnemonicPhrase.removeAll()
                    self.selectPhrase.removeAll()
                    for i in 0..<self.mnemonicPhrase.count {
                        if i < 6 {
                            self.verifyedMnemonicPhrase.append(self.mnemonicPhrase[i])
                        } else {
                            
                            self.verifyedMnemonicPhrase.append("")
                            self.selectPhrase.append(self.mnemonicPhrase[i])
                            self.selectPhrase.shuffle()
                            self.errorVarify = false
                            self.veryfyCollectionView.reloadData()
                            self.selectCollectionView.reloadData()
                        }
                    }
                }
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
        cell.tag = indexPath.row
        
        switch collectionView {
        case self.veryfyCollectionView:
            cell.mnemonicWord.text = "\(self.indexes[indexPath.row]). \(self.verifyedMnemonicPhrase[indexPath.row])"
            if self.errorVarify {
                cell.mnemonicWord.textColor = #colorLiteral(red: 1, green: 0.2360929251, blue: 0.1714096665, alpha: 0.8980392157)
                
            } else {
                cell.mnemonicWord.textColor = .white
            }
            if indexPath > [0,5] && cell.mnemonicWord.text != "\(self.indexes[indexPath.row]). " {
                
                cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                cell.mnemonicWord.tintColor = .white
            } else if indexPath == [0,self.selectIndex] && self.firstWord && cell.mnemonicWord.text == "\(self.indexes[indexPath.row]). " {
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
                let cell = self.veryfyCollectionView.cellForItem(at: indexPath) as! MnemonicCollectionViewCell
                cell.backgroundColor = #colorLiteral(red: 0.2681596875, green: 0.717217505, blue: 0.4235975146, alpha: 1)
                self.selectIndex = indexPath.row
                if self.verifyedMnemonicPhrase[indexPath.row] != "" {
                    self.selectPhrase.append(self.verifyedMnemonicPhrase[indexPath.row])
                    self.verifyedMnemonicPhrase.remove(at: indexPath.row)
                    self.verifyedMnemonicPhrase.insert("", at: indexPath.row)
                    self.firstWord = false
                    self.veryfyCollectionView.reloadData()
                    self.selectCollectionView.reloadData()
                    
                }
            }
        case self.selectCollectionView:
            let cell = self.veryfyCollectionView.cellForItem(at: indexPath) as! MnemonicCollectionViewCell
            if self.selectIndex >= 6 {
                
                
                self.verifyedMnemonicPhrase.remove(at: self.selectIndex)
                self.verifyedMnemonicPhrase.insert(self.selectPhrase[indexPath.row], at: self.selectIndex)
                
                self.selectPhrase.remove(at: indexPath.row)
                if self.selectIndex < 12 {
                    self.selectIndex += 1
                    
                } else {
                    self.selectIndex = 6
                }
                
                self.veryfyCollectionView.reloadData()
                self.selectCollectionView.reloadData()
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
