//
//  MainImageView.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/8/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class SelectionView: UIView {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 13
        return view
    }()
    
    let outerView: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.20
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowRadius = 13
        view.layer.shouldRasterize = true
        return view
    }()
    
    let textButton: ButtonView = {
        let button = ButtonView()
        button.setTitle("Tap to text", for: .normal)
        return button
    }()
    let printButton: ButtonView = {
        let button = ButtonView()
        button.setTitle("Tap to print", for: .normal)
        return button
    }()
    
    init(frame: CGRect, imageUrl: String) {
        super.init(frame: frame)
    
        [outerView, imageView, textButton, printButton].forEach { addSubview($0) }
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 87, y: 87, width: 850, height: 566)
        outerView.frame = imageView.frame
        outerView.layer.shadowPath = UIBezierPath(rect: imageView.bounds).cgPath
        
        //I may need to change these to go farther below the screen
        textButton.frame.origin = CGPoint(x: 169, y: 685.5)
        printButton.frame.origin = CGPoint(x: 598, y: 685.5)
    }
    
    func setImage(imageUrl: String) {
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let documentsPath = docDir.path.appending("/")
        
        let imageUrl = documentsPath + imageUrl + ".jpg"
        imageView.image = UIImage(contentsOfFile: imageUrl)
    }
}

