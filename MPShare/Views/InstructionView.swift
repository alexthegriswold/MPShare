//
//  InstructionView.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/4/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class InstructionView: UIView {
    
    let instructionViewPanel = InstructionViewPanel(frame: .zero)
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
        
        [outerView, instructionViewPanel].forEach { addSubview($0) }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        instructionViewPanel.frame = CGRect(x: 44, y: 39, width: 335, height: 690)
        outerView.frame = instructionViewPanel.frame
        outerView.layer.shadowPath = UIBezierPath(rect: instructionViewPanel.bounds).cgPath
    }
}
