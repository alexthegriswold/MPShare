//
//  DeleteButton.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/8/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

final class DeleteButton: UIButton {
    
    weak var delegate: DeleteButtonActionDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTitleColor(UIColor.black, for: .normal)
        self.setTitleColor(UIColor.lightGray, for: .highlighted)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.regular)
        self.setTitle("Delete", for: .normal)
        self.titleLabel?.textAlignment = .center
        self.addTarget(self, action: #selector(DeleteButton.didTap), for: .touchUpInside)
        
    }
    
    @objc func didTap() {
        if self.currentTitle != nil {
            delegate?.didTapDelete()
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.sendActions(for: UIControlEvents.touchUpInside)
        
        
        
        UIView.transition(with: self,
                          duration: 0.10,
                          options: [.transitionCrossDissolve, .allowUserInteraction],
                          animations: { self.isHighlighted = true },
                          completion: nil)
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIView.transition(with: self,
                          duration: 0.35,
                          options: [.transitionCrossDissolve, .allowUserInteraction],
                          animations: { self.isHighlighted = false },
                          completion: nil)
    }
}

protocol DeleteButtonActionDelegate: class {
    func didTapDelete()
}
