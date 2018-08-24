//
//  PrintingView.swift
//  MPShare
//
//  Created by Alexander Griswold on 10/17/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class PrintingView: UIView {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 48, weight: UIFont.Weight.bold)
        label.textColor = UIColor.black
        label.text = "Your Image"
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let imageShadow: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.20
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowRadius = 13
        view.layer.shouldRasterize = true
        return view
    }()
    
    let printInputView = PrintInputView()
    
    var viewModel: PrintingViewModel
    
    init(frame: CGRect, viewModel: PrintingViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.loadImage()
        [titleLabel, imageShadow, imageView, printInputView].forEach { addSubview($0) }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 50, y: 185, width: 577, height: 398)
        imageShadow.frame = imageView.frame
        imageShadow.layer.shadowPath = UIBezierPath(rect: imageView.bounds).cgPath
        titleLabel.frame = CGRect(x: 50, y: 106, width: 300, height: 54)
        printInputView.frame.origin = CGPoint(x: 681, y: 248)
    }
    
    func loadImage() {
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let documentsPath = docDir.path.appending("/")
        
        let imageUrl = documentsPath + viewModel.imageUrl + ".jpg"
        
        imageView.image = UIImage(contentsOfFile: imageUrl)
    }
}
