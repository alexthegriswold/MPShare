//
//  InstructionViewPanel.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/4/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class InstructionViewPanel: UIView, UIScrollViewDelegate {
    
    fileprivate let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.image = #imageLiteral(resourceName: "instructionViewBackground1")
        view.layer.cornerRadius = 15
        return view
    }()
    
    fileprivate let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 68, weight: UIFont.Weight.bold)
        label.text = "Tap your picture"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = UIColor.white
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    let wireFrame = WireFrame()
    
    //MARK: Animated Label
    var wordAnimator = WordAnimator(animateTime: 4.0, doesRepeat: true)
    var animatedLabels = [AnimatedLabel]()
    
    var phrase1 = AnimatedLabel(phrases: "Tap your\n image on\n the right", containerWidth: 335, yPosition: 65, fontSize: 60.0)
    var phrase2 = AnimatedLabel(phrases: "I'll text\n and print\n it for you", containerWidth: 335, yPosition: 65, fontSize: 60.0)
    
    let scrollView = UIScrollView()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.animatedLabels.append(phrase1)
        self.animatedLabels.append(phrase2)
        self.wordAnimator.setAnimatedLabels(animatedLabels: animatedLabels)
        wordAnimator.startAnimating()
        
        self.addSubview(imageView)
        self.addSubview(wireFrame)
        for label in animatedLabels {
            for line in label.lines {
                for character in line {
                    self.addSubview(character)
                }
            }
        }
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 0, y: 0, width: 335, height: 690)
        textLabel.frame = CGRect(x: 0, y: 74, width: 335, height: 200)
        
        wireFrame.frame = CGRect(x: 16, y: 350, width: 303, height: 203)
        
        /*
         UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2, delay: 5, options: [.curveEaseInOut, .repeat], animations: {
         self.wireFrame.frame = CGRect(x: 16, y: 350, width: 288, height: 193)
         }, completion: nil)
         */
        
    }
}
