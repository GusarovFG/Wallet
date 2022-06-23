//
//  Extensions.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 25.04.2022.
//

import UIKit

extension UILabel {
    typealias MethodHandler = () -> Void
    func addRangeGesture(stringRange: String, function: @escaping MethodHandler) {
        RangeGestureRecognizer.stringRange = stringRange
        RangeGestureRecognizer.function = function
        self.isUserInteractionEnabled = true
        let tapgesture: UITapGestureRecognizer = RangeGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapgesture)
    }
    
    @objc func tappedOnLabel(_ gesture: RangeGestureRecognizer) {
        guard let text = self.text else { return }
        let stringRange = (text as NSString).range(of: RangeGestureRecognizer.stringRange ?? "")
        if gesture.didTapAttributedTextInLabel(label: self, inRange: stringRange) {
            guard let existedFunction = RangeGestureRecognizer.function else { return }
            existedFunction()
        }
    }
}

extension UITextField {
    func bottomCorner() {
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 2, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = #colorLiteral(red: 0.3578948975, green: 0.3578948975, blue: 0.3578948975, alpha: 1)
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}


extension UIStackView {
    func removeAllSubviews() {
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
}

extension UIView {
    func buttonStroke(_ color: CGColor) {
        let bottomLine = CALayer()
            
            bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 2, width: self.frame.size.width, height: 1)
            bottomLine.backgroundColor = color
            self.layer.addSublayer(bottomLine)
        }
    
}

extension UITextView {

    func numberOfLines() -> Int{
        if let fontUnwrapped = self.font{
            return Int(self.contentSize.height / fontUnwrapped.lineHeight)
        }
        return 0
    }
}

extension Array {
    func split() -> [[Element]] {
        let ct = self.count
        let half = ct / 2
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half ..< ct]
        return [Array(leftSplit), Array(rightSplit)]
    }
}

extension Formatter {
    static let avoidNotation: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 8
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
}

extension FloatingPoint {
    var avoidNotation: String {
        return Formatter.avoidNotation.string(for: self) ?? ""
    }
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
