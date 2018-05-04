//
//  AnimatedLabel.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/4/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import Foundation
import UIKit

class AnimatedLabel: NSObject {
    
    var lines = [[UILabel]]()
    var containerWidth: CGFloat
    let yPosition: CGFloat
    var currentLine = 0
    var fontSize: CGFloat
    let lineSpacing: Int
    
    //each line of the label is an array object
    
    //the init needs a y value
    //frame width
    //and the string
    init(phrases: String, containerWidth: CGFloat, yPosition: CGFloat, fontSize: CGFloat ) {
        
        
        self.fontSize = fontSize
        self.lineSpacing = Int(fontSize)
        self.containerWidth = containerWidth
        self.yPosition = yPosition
        
        super.init()
        
        //separate phrases by a /n
        let arrayofPhrases = phrases.components(separatedBy: "\n ")
        
        //create a label for each phrase
        for phrase in arrayofPhrases {
            let newYPosition = yPosition + CGFloat(lineSpacing * currentLine)
            currentLine += 1
            let line = self.createLabel(word: phrase, yPosition: newYPosition)
            self.lines.append(line)
            
        }
    }
    
    
    func calculateLineWidth(word: String) -> CGFloat {
        var labelWidth = CGFloat(0.0)
        let characters = Array(word.characters)
        
        for character in characters {
            let label = UILabel()
            label.text = String(character)
            label.font = UIFont.systemFont(ofSize: self.fontSize, weight: UIFont.Weight.bold)
            let size = label.sizeThatFits(label.frame.size)
            labelWidth += size.width
        }
        
        return labelWidth
    }
    
    
    func createLabel(word: String, yPosition: CGFloat) -> [UILabel] {
        let characters = Array(word.characters)
        var characterLabels = [UILabel]()
        let lineWidth = calculateLineWidth(word: word)
        var xPosition = (self.containerWidth - lineWidth)/2
        
        
        
        for character in characters {
            
            let label = UILabel()
            label.text = String(character)
            label.font = UIFont.systemFont(ofSize: self.fontSize, weight: UIFont.Weight.bold)
            let size = label.sizeThatFits(label.frame.size)
            
            label.frame = CGRect(x: xPosition, y: yPosition, width: size.width, height: size.height)
            xPosition += size.width
            
            label.textColor = UIColor.white
            characterLabels.append(label)
            
        }
        
        return characterLabels
    }
    
    
    func calculateWidth(phrase: [UILabel]) -> CGFloat {
        var labelWidth = CGFloat(0.0)
        for character in phrase {
            labelWidth += character.frame.size.width
        }
        
        return labelWidth
    }
    
    func returnLabel() -> [[UILabel]] {
        return lines
    }
    
    func hideLabel() {
        for line in self.lines {
            for character in line {
                character.alpha = 0
            }
        }
    }
    
    func showLabel() {
        for line in self.lines {
            for character in line {
                character.alpha = 1
            }
        }
    }
}
