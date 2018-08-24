//
//  WireFrame.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/4/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class WireFrame: UIButton {
    
    weak var delegate: WireFrameActionDelegate? = nil
    var fingerDidLift = false
    
    var timer = Timer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setImage(#imageLiteral(resourceName: "wireFrame"), for: .normal)
        self.addTarget(self, action: #selector(WireFrame.tapped), for: .touchDown)
        self.addTarget(self, action: #selector(WireFrame.liftedFinger), for: .touchUpInside)
    }
    
    @objc func tapped() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(WireFrame.twoSeconds), userInfo: nil, repeats: false)
    }
    
    @objc func twoSeconds() {
        delegate?.didHoldOnWireFrame()
    }
    
    @objc func liftedFinger() {
        timer.invalidate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol WireFrameActionDelegate: class {
    func didHoldOnWireFrame()
}
