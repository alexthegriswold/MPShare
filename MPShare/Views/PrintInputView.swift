//
//  PrintInputView.swift
//  MPShare
//
//  Created by Alexander Griswold on 8/24/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class PrintInputView: UIView, PrintInputButtonDelegate {
    
    var printNumberInt = 1
    var printLimit = 6
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 29, weight: UIFont.Weight.regular)
        label.textColor = UIColor.darkGray
        label.text = "HOW MANY COPIES?"
        label.textAlignment = .center
        return label
    }()
    
    let printNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 81, weight: UIFont.Weight.thin)
        label.textColor = UIColor.black
        label.text = "1"
        label.textAlignment = .center
        return label
    }()
    
    let minusButton: PrintInputButton = {
        let button = PrintInputButton()
        button.makeMinus()
        return button
    }()
    
    let plusButton: PrintInputButton = {
        let button = PrintInputButton()
        button.makePlus()
        return button
    }()
    let submitButton: ButtonView = {
        let button = ButtonView()
        button.setTitle("Submit", for: .normal)
        return button
    }()
    
    weak var delegate: PrintInputViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame.size = CGSize(width: 294, height: 308)
        [title, printNumber, minusButton, plusButton, submitButton].forEach { addSubview($0) }
        
        submitButton.addTarget(self, action: #selector(PrintInputView.tappedSubmit), for: .touchUpInside)
        self.minusButton.delegate = self
        self.plusButton.delegate = self
    }
    
    @objc func tappedSubmit() {
        delegate?.didTapSubmit(printNumber: printNumberInt)
    }
    
    func didTapButton(button: String) {
        if button == "minus" {
            if printNumberInt > 1 {
                printNumberInt -= 1
                printNumber.text = String(printNumberInt)
            }
        } else if button == "plus" {
            if printNumberInt <= (printLimit - 1) {
                printNumberInt += 1
                printNumber.text = String(printNumberInt)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        title.frame = CGRect(x: 0, y: 0, width: Int(self.frame.width), height: 31)
        printNumber.frame = CGRect(x: 0, y: 96, width: Int(self.frame.width), height: 81)
        minusButton.frame.origin = CGPoint(x: 0, y: 96)
        plusButton.frame.origin = CGPoint(x: 211, y: 96)
        submitButton.frame.origin = CGPoint(x: 19.5, y: 247)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol PrintInputViewDelegate: class {
    func didTapSubmit(printNumber: Int)
}
