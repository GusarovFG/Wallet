//
//  MnemonicViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 03.05.2022.
//

import UIKit

class MnemonicViewController: UIViewController {
    
    private var mnemonicPhrase: [String] = ["Дверь", "Будущее", "Слово", "Криптовалюта", "Деньги", "Музыка", "Компьютер", "Плавание", "Кошелек", "Дизайн", "Дом", "Яблоко"]
    private var secureMnemonicPhrase: [String] = []
    private let indexes: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    private var hide = true

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var hydeButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var copyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mnemonicPhrase.shuffle()
        self.secureMnemonicPhrase = self.mnemonicPhrase
        secureMnemonic()
        self.continueButton.isEnabled = false
        self.copyLabel.alpha = 0
        
        self.copyLabel.layer.cornerRadius = 8
        
        self.hydeButton.layer.cornerRadius = 15
        self.hydeButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        self.copyButton.layer.cornerRadius = 15
        self.copyButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        self.collectionView.register(UINib(nibName: "MnemonicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mnemonicCell")
    }
    
    private func secureMnemonic() {
        self.secureMnemonicPhrase.removeAll()
        
        for word in self.mnemonicPhrase {
            var secureWord = ""
            for _ in word {
                secureWord += "*"
            }
            self.secureMnemonicPhrase.append(secureWord)
        }
    }
    
    @IBAction func hydeButtonPressed(_ sender: UIButton) {
        if self.hide {
            self.secureMnemonicPhrase = self.mnemonicPhrase
            self.hide.toggle()
            sender.setImage(UIImage(named: "EyeCross")!, for: .normal)
            self.collectionView.reloadData()
        } else {
            secureMnemonic()
            self.hide.toggle()
            sender.setImage(UIImage(named: "Eye2")!, for: .normal)
            self.collectionView.reloadData()
            
        }
    }
    
    @IBAction func checkBoxPressed(_ sender: UIButton) {
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
    @IBAction func copyButtonPressed(_ sender: Any) {

        UIView.animate(withDuration: 1) {
            self.copyLabel.alpha = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            UIView.animate(withDuration: 1) {
                self.copyLabel.alpha = 0
            }
            
        }
        
        UIPasteboard.general.string = self.mnemonicPhrase.joined(separator: ", ")
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mnemonicSegue" {
            let vc = segue.destination as! VerifyMnemonicViewController
            vc.mnemonicPhrase = self.mnemonicPhrase
        }
    }
    
}

extension MnemonicViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mnemonicCell", for: indexPath) as! MnemonicCollectionViewCell
        let mnemonicWord = self.secureMnemonicPhrase[indexPath.row]
        
        cell.mnemonicWord.text = "\(self.indexes[indexPath.row]). \(mnemonicWord)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 178, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print(self.secureMnemonicPhrase)
    }
}
