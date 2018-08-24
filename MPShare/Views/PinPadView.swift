//
//  PinPadView.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/8/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

final class PinPadView: UIView {
    
    var buttons = [PinPadButton]()
    var submitButton = ButtonView()
    
    var deleteButton = DeleteButton(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for index in 0...9 {
            let button = PinPadButton()
            button.setText(text: String(index))
            buttons.append(button)
            self.addSubview(buttons[index])
            print(index)
        }
        
        submitButton.backgroundColor = UIColor.black
        submitButton.setTitle("Send", for: .normal)
        
        
        
        self.addSubview(deleteButton)
        
        self.addSubview(submitButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        //size and spacing stuff
        let buttonDiameter = 82
        let xSpacingBetweenButtons = 24
        let ySpacingBetweenButtons = 20
        
        let xSpacing = buttonDiameter + xSpacingBetweenButtons
        let ySpacing = buttonDiameter + ySpacingBetweenButtons
        var xPoint = 0
        var yPoint = 0
        
        for index in 0...9 {
            
            if index != 0 {
                var column = index % 3
                let row = Int((index - 1)/3)
                //modulo 3 goes to 0
                if column == 0 {
                    column = 3
                }
                
                xPoint = (column - 1) * xSpacing //column - 1 so that range is 0...2
                yPoint = (row) * ySpacing //range is 0...2 by default
                
            } else {
                
                xPoint = xSpacing * 1
                yPoint = ySpacing * 3
            }
            
            buttons[index].frame = CGRect(x: xPoint, y: yPoint, width: buttonDiameter, height: buttonDiameter)
        }
        
        xPoint = xSpacing * 2
        yPoint = ySpacing * 3
        deleteButton.frame = CGRect(x: xPoint, y: yPoint, width: buttonDiameter, height: buttonDiameter)
        
        xPoint = xSpacing * 1
        yPoint = ySpacing * 4
        submitButton.frame.origin = CGPoint(x: 19.5, y: CGFloat(yPoint) + 10)
        
        
    }
}
