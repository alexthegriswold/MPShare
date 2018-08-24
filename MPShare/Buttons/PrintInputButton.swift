//
//  PrintInputButton.swift
//  MPShare
//
//  Created by Alexander Griswold on 8/24/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class PrintInputButton: UIButton {
    
    let minus: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.frame.size = CGSize(width: 55, height: 4.5)
        view.layer.cornerRadius = view.frame.height/2
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let plus: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.frame.size = CGSize(width: 4.5, height: 55)
        view.layer.cornerRadius = view.frame.width/2
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var isPlus = false
    var isMinus = false
    
    weak var delegate: PrintInputButtonDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        self.frame.size = CGSize(width: 81, height: 81)
        self.layer.cornerRadius = 40.5
        self.backgroundColor = UIColor.darkGray
        
        self.addSubview(minus)
        self.addSubview(plus)
        
        minus.alpha = 0
        plus.alpha = 0
        
        self.addTarget(self, action: #selector(PrintInputButton.didTap), for: .touchUpInside)
        
    }
    
    @objc func didTap() {
        if isPlus == true {
            delegate?.didTapButton(button: "plus")
        } else if isMinus == true {
            delegate?.didTapButton(button: "minus")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        minus.frame.origin = CGPoint(x: 13, y: 38.25)
        plus.frame.origin = CGPoint(x: 38.25, y: 13)
        
    }
    
    func makePlus() {
        isMinus = false
        isPlus = true
        minus.alpha = 1
        plus.alpha = 1
    }
    
    func makeMinus() {
        isMinus = true
        isPlus = false
        minus.alpha = 1
        plus.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

protocol PrintInputButtonDelegate: class {
    func didTapButton(button: String)
}
