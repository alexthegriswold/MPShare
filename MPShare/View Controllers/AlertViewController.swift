//
//  AlertViewController.swift
//  MPShare
//
//  Created by Alexander Griswold on 8/24/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController, AlertViewButtonDelegate {
    
    private var viewModel: AlertViewModel
    
    weak var delegate: AlertViewControllerDelegate? = nil
    
    let alertView = AlertView(frame: .zero)
    
    init(viewModel: AlertViewModel) {
        self.viewModel = viewModel
        alertView.setViewModel(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        
        self.view.addSubview(alertView)
        self.alertView.delegate = self
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(AlertViewController.didSwipeDown))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func didSwipeDown() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: AlertViewButtonDelegate
    func didTapText() {
        print("hey")
        //dismiss(animated: true, completion: nil)
    }
    
    func didTapHome() {
        dismiss(animated: true) {
            self.delegate?.didDismissAlert()
        }
    }
}

protocol AlertViewControllerDelegate: class {
    func didDismissAlert()
}
