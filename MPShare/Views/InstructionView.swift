//
//  InstructionView.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/4/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class InstructionView: UIView {
    
    //text view
    //panel
    
    let panel: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 24, y: 39, width: 335, height: 690)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red:0.35, green:0.78, blue:0.98, alpha:1.0)
        return view
    }()
    
    let outerView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 10
        view.layer.shouldRasterize = true
        
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(outerView)
        self.addSubview(panel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        outerView.frame = panel.frame
        outerView.layer.shadowPath = UIBezierPath(rect: panel.bounds).cgPath
        
    }
    
}
