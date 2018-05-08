//
//  ButtonView.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/8/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class ButtonView: UIButton {
    
    let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))
    
    weak var delegate: ButtonViewActionDelegate? = nil
    
    weak var textingDelegate: SubmitButtonActionDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //self.alpha = 0.90
        self.clipsToBounds = true
        self.layer.cornerRadius = 30.5
        self.frame.size = CGSize(width: 255, height: 61)
        //self.setTitle("Tap to Text", for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 35.0, weight: UIFont.Weight.regular)
        self.titleLabel?.textColor = UIColor.red
        self.alpha = 1
        blur.frame = self.bounds
        blur.clipsToBounds = true
        blur.isUserInteractionEnabled = false
        self.insertSubview(blur, at: 0)
        
        self.addTarget(self, action: #selector(ButtonView.didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        
        //print("yooo")
        
        if self.titleLabel?.text != nil {
            
            //print((self.titleLabel?.text)!)
            delegate?.didTapButton(name: (self.titleLabel?.text)!)
            textingDelegate?.didTapSubmitButton()
            
        } else {
            print("WHAT ARE YOU DOING!? This button needs a name.")
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
    
    func animation() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            //self.alpha = 1
        }, completion: nil)
    }
    
}

protocol ButtonViewActionDelegate: class {
    func didTapButton(name: String)
}

protocol SubmitButtonActionDelegate: class {
    func didTapSubmitButton()
}

