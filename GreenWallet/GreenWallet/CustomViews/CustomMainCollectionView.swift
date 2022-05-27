//
//  CustomMainCollectionView.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 27.05.2022.
//

import UIKit

class CustomMainCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !(__CGSizeEqualToSize(bounds.size,self.intrinsicContentSize)){
            self.invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
