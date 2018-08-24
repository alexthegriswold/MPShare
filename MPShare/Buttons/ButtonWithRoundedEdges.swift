//
//  ButtonWithRoundedEdges.swift
//  MPShare
//
//  Created by Alexander Griswold on 8/24/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class ButtonWithRoundedEdges: UIButton {
    
    init(size: CGSize, title: String) {
        
        super.init(frame: .zero)
        
        self.clipsToBounds = true
        self.frame.size = size
        self.layer.cornerRadius = self.frame.size.height/2
        self.backgroundColor = UIColor.black
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.medium)
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
                            self.setBackgroundColor(color: UIColor.white, forState: .highlighted) },
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
