//
//  PinPadButton.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/8/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

final class PinPadButton: UIButton {
    
    weak var delegate: PinPadButtonActionDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 41
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 40.0, weight: UIFont.Weight.regular)
        self.backgroundColor = UIColor.black
        
        self.addTarget(self, action: #selector(PinPadButton.didTap), for: .touchUpInside)
        
    }
    
    @objc func didTap() {
        if self.currentTitle != nil {
            delegate?.didTapButton(index: self.currentTitle!)
        } else {
            print("Button doens't have a value")
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setText(text: String) {
        self.setTitle(text, for: .normal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.sendActions(for: UIControlEvents.touchUpInside)
        
        
        
        UIView.transition(with: self,
                          duration: 0.10,
                          options: [.transitionCrossDissolve, .allowUserInteraction],
                          animations: { self.isHighlighted = true
                            self.setBackgroundColor(color: UIColor.lightGray, forState: .highlighted) },
                          completion: nil)
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIView.transition(with: self,
                          duration: 0.35,
                          options: [.transitionCrossDissolve, .allowUserInteraction],
                          animations: { self.isHighlighted = false },
                          completion: nil)
    }
    
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
    
}

protocol PinPadButtonActionDelegate: class {
    func didTapButton(index: String)
}
