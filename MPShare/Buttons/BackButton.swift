//
//  BackButton.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/8/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class BackButton: UIButton {
    
    let path = UIBezierPath()
    let fillLayer = CAShapeLayer();
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTitle("Back", for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        let yOffset = 4.0
        
        //front left
        path.move(to: CGPoint(x: 6, y: 56 + yOffset))
        //top left left
        path.addLine(to: CGPoint(x: 50, y: 100 + yOffset))
        //top left center
        //path.addLine(to: CGPoint(x: 56, y: 94))
        path.addCurve(to: CGPoint(x: 62, y: 88 + yOffset), controlPoint1: CGPoint(x: 58, y: 108 + yOffset), controlPoint2: CGPoint(x: 70, y: 96 + yOffset))
        //top left right
        path.addLine(to: CGPoint(x: 62, y: 88 + yOffset))
        //center
        path.addLine(to: CGPoint(x: 24, y: 50 + yOffset))
        //bottom right left
        path.addLine(to: CGPoint(x: 62, y: 12 + yOffset))
        
        path.addCurve(to: CGPoint(x: 50, y: 0 + yOffset), controlPoint1: CGPoint(x: 70, y: 4 + yOffset), controlPoint2: CGPoint(x: 58, y: -8 + yOffset))
        path.addLine(to: CGPoint(x: 50, y: 0 + yOffset))
        //front right
        path.addLine(to: CGPoint(x: 6, y: 44 + yOffset))
        path.addCurve(to: CGPoint(x: 6, y: 56 + yOffset), controlPoint1: CGPoint(x: 2, y: 48 + yOffset), controlPoint2: CGPoint(x: 2, y: 52 + yOffset))
        
        path.apply(CGAffineTransform.init(scaleX: 0.3, y: 0.3))
        
        path.fill()
        UIColor.clear.set()
        
        
        fillLayer.path = path.cgPath;
        fillLayer.fillColor = UIColor.black.cgColor
        self.layer.addSublayer(fillLayer)
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.sendActions(for: UIControlEvents.touchUpInside)
        
        let animcolor = CABasicAnimation(keyPath: "fillColor")
        animcolor.fromValue = UIColor.black.cgColor
        animcolor.toValue = UIColor.white.cgColor
        animcolor.duration = 0.1;
        animcolor.repeatCount = 0;
        animcolor.isRemovedOnCompletion = false
        animcolor.fillMode = kCAFillModeForwards
        fillLayer.add(animcolor, forKey: "fillColor")
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let animcolor = CABasicAnimation(keyPath: "fillColor")
        animcolor.toValue = UIColor.black.cgColor
        animcolor.fromValue = UIColor.white.cgColor
        animcolor.duration = 0.35;
        animcolor.repeatCount = 0;
        fillLayer.add(animcolor, forKey: "fillColor")
        
    }
    
    
}
