//
//  WordAnimator.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/4/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class WordAnimator: NSObject {
    
    
    var currentIndex = 0
    var nextIndex = 1
    var animateTime = 3.0
    var wordSpeed = 0.030
    var animating = true
    var doesRepeat: Bool
    
    var animatedLabels = [AnimatedLabel]()
    
    //requires labels to be initiated
    init(animateTime: Double, doesRepeat: Bool) {
        
        self.animateTime = animateTime
        self.doesRepeat = doesRepeat
        
        super.init()
    }
    
    func setAnimatedLabels(animatedLabels: [AnimatedLabel]) {
        self.animatedLabels = animatedLabels
    }
    
    
    
    func shrink(labels: [UILabel]) {
        
        var time = 0.0
        for label in labels {
            var when = DispatchTime.now() + time // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.shrinkAndDisappear(letter: label)
            }
            time = time + self.wordSpeed
        }
    }
    
    func grow(labels: [UILabel]) {
        var time = 0.04
        for label in labels {
            var when = DispatchTime.now() + time // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.appearAndGrow(letter: label)
            }
            time = time + self.wordSpeed
        }
    }
    
    func animate() {
        
        
        if self.animatedLabels.count == 1 {
            for line in self.animatedLabels[0].lines {
                var time = 0.0
                var when = DispatchTime.now() + time // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.shrink(labels: line)
                }
                time += self.wordSpeed
            }
            
            for line in self.animatedLabels[0].lines {
                var time = 1.0
                var when = DispatchTime.now() + time // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.grow(labels: line)
                }
                time += self.wordSpeed
            }
            
            let when = DispatchTime.now() + animateTime // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                
                if self.animating == true {
                    if self.doesRepeat == true {
                        self.animate()
                    }
                    
                }
                
            }
        }
        
        
        if self.animatedLabels.count > 1 {
            
            let labelsCount = self.animatedLabels.count
            
            for line in self.animatedLabels[self.currentIndex].lines {
                var time = 0.0
                var when = DispatchTime.now() + time // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.shrink(labels: line)
                }
                time += self.wordSpeed
            }
            
            for line in self.animatedLabels[self.nextIndex].lines {
                var time = 0.0
                var when = DispatchTime.now() + time // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.grow(labels: line)
                }
                time += self.wordSpeed
            }
            
            self.currentIndex = self.nextIndex
            
            self.nextIndex += 1
            
            if self.nextIndex == self.animatedLabels.count {
                self.nextIndex = 0
            }
            
            
            let when = DispatchTime.now() + animateTime // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                
                if self.animating == true {
                    if self.doesRepeat == true {
                        self.animate()
                    }
                }
                
            }
        }
    }
    
    func startAnimating() {
        //make the first one visible
        //make all others not visible
        
        animating = true
        for line in self.animatedLabels[0].lines {
            for label in line {
                self.shrinkAndDisappearNoAnimate(letter: label)
            }
        }
        
        for line in self.animatedLabels[0].lines {
            self.grow(labels: line)
        }
        
        self.currentIndex = 0
        self.nextIndex = 1
        
        
        for index in 1..<self.animatedLabels.count {
            self.animatedLabels[index].hideLabel()
        }
        
        
        var when = DispatchTime.now() + animateTime // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            if self.doesRepeat == true {
                self.animate()
            }
            
        }
        
        
    }
    
    func stopAnimating() {
        animating = false
        
    }
    
    
    func shrinkAndDisappear(letter: UILabel) {
        let scale = CGFloat(0.4)
        let height = letter.frame.height
        let width = letter.frame.width
        let originalTransform = letter.transform
        let scaledTransform = originalTransform.scaledBy(x: scale, y: scale)
        let heightDifference = height - (height * scale)
        let widthDifference = width - (width * scale)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: widthDifference, y: heightDifference)
        
        UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
            letter.transform = scaledAndTranslatedTransform
            letter.alpha = 0.0
            
        }, completion: { _ in
            letter.alpha = 0
            //letter.transform = scaledTransform.translatedBy(x: 36.0, y: -66.0)
            
        })
    }
    
    func shrinkAndDisappearNoAnimate(letter: UILabel) {
        let scale = CGFloat(0.4)
        let height = letter.frame.height
        let width = letter.frame.width
        let originalTransform = letter.transform
        let scaledTransform = originalTransform.scaledBy(x: scale, y: scale)
        let heightDifference = height - (height * scale)
        let widthDifference = width - (width * scale)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: widthDifference, y: heightDifference)
        letter.transform = scaledAndTranslatedTransform
        letter.alpha = 0.0
    }
    
    func appearAndGrow(letter: UILabel) {
        letter.alpha = 1
        
        UIView.animate(withDuration: 0.1, animations: {
            letter.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        })
    }
}
