//
//  AlertView.swift
//  MPShare
//
//  Created by Alexander Griswold on 8/24/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class AlertView: UIView {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 80, weight: UIFont.Weight.bold)
        label.textColor = UIColor.black
        label.text = "YAY!"
        label.textAlignment = .center
        return label
    }()
    
    var subtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.light)
        label.textColor = UIColor.black
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    var textButton = ButtonWithRoundedEdges(size: CGSize(width: 175, height: 54), title: "Send Text")
    
    var homeButton = ButtonWithRoundedEdges(size: CGSize(width: 175, height: 54), title: "Awesome")
    
    weak var delegate: AlertViewButtonDelegate? = nil
    
    var alertViewModel: AlertViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: 540, height: 768)
        self.backgroundColor = UIColor.white
        self.addSubview(titleLabel)
        self.addSubview(subtitle)
        //self.addSubview(textButton)
        self.addSubview(homeButton)
        
        textButton.addTarget(self, action: #selector(AlertView.didTapText), for: .touchUpInside)
        homeButton.addTarget(self, action: #selector(AlertView.didTapHome), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        titleLabel.frame = CGRect(x: 0, y: 58, width: 540, height: 80)
        subtitle.frame = CGRect(x: 40, y: 254, width: 440, height: 113)
        //textButton.frame.origin = CGPoint(x: 62, y: 504)
        homeButton.frame.origin = CGPoint(x: 182.5, y: 504)
    }
    
    @objc func didTapText() {
        
        delegate?.didTapText()
    }
    
    @objc func didTapHome() {
        delegate?.didTapHome()
    }
    
    func setViewModel(viewModel: AlertViewModel) {
        self.alertViewModel = viewModel
        self.subtitle.text = viewModel.phrase
    }
    
}

protocol AlertViewButtonDelegate: class {
    func didTapText()
    func didTapHome()
}
