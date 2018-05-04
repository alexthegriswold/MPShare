//
//  InstructionView.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/4/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class NewInstructionView: UIView {
    
    //text view
    //panel
    
    let upperPanel: UIView = {
        let view = UIView()
        
        //24 left
        //64 right
        
        
        view.frame = CGRect(x: 44, y: 39, width: 335, height: 325.5)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red:0.35, green:0.78, blue:0.98, alpha:1.0)
        return view
    }()
    
    let lowerPanel: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 44, y: 403.5, width: 335, height: 325.5)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red:1.00, green:0.18, blue:0.33, alpha:1.0)
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
    
    let logoView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logoWhite"))
        let size = 230.0
        imageView.frame = CGRect(x: (335 - size)/2, y: 60.0, width: size, height: size)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: Animated Label
    var wordAnimator = WordAnimator(animateTime: 3.0, doesRepeat: true)
    var animatedLabels = [AnimatedLabel]()
    
    var phrase1 = AnimatedLabel(phrases: "Tap your\n image on\n the right", containerWidth: 335, yPosition: 65, fontSize: 55.0)
    var phrase2 = AnimatedLabel(phrases: "I'll share\n your image\n for you", containerWidth: 335, yPosition: 65, fontSize: 55.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.animatedLabels.append(phrase1)
        self.animatedLabels.append(phrase2)
        self.wordAnimator.setAnimatedLabels(animatedLabels: animatedLabels)
        wordAnimator.startAnimating()
        
        self.addSubview(outerView)
        self.addSubview(upperPanel)
        self.addSubview(lowerPanel)
        self.upperPanel.addSubview(logoView)
        
        for label in animatedLabels {
            for line in label.lines {
                for character in line {
                    self.lowerPanel.addSubview(character)
                }
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        outerView.frame = upperPanel.frame
        outerView.layer.shadowPath = UIBezierPath(rect: upperPanel.bounds).cgPath
        
    }
    
}
