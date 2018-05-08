//
//  SelectionViewController.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/8/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController, ButtonViewActionDelegate {

    let selectionView: SelectionView
    
    private var viewModel: SelectionViewModel
    
    var printer: UIPrinter?
    
    init(viewModel: SelectionViewModel, printer: UIPrinter?) {
        self.viewModel = viewModel
        self.printer = printer
        selectionView = SelectionView(frame: .zero, imageUrl: self.viewModel.imageUrl)
        selectionView.setImage(imageUrl: viewModel.imageUrl)
        super.init(nibName: nil, bundle: nil)
        
        selectionView.printButton.delegate = self
        selectionView.textButton.delegate = self
    }
    
    let backButton = BackButton()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add targets
        backButton.addTarget(self, action: #selector(SelectionViewController.didTapBack), for: .touchUpInside)
        
        //add subview
        self.view.addSubview(selectionView)
        self.view.addSubview(backButton)
    }
    
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        selectionView.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        backButton.frame = CGRect(x: 30, y: 30, width: 100, height: 34)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    func didTapButton(name: String) {
    
        print(name)
        /*
        if name == "Tap to text" {
            let photoSet = viewModel.photoSet
            
            
            //change
            let textingViewModel = TextingViewModel(phoneNumber: "", imageNames: photoSet.imagesNames)
            let viewController = TextingViewController(viewModel: textingViewModel)
            viewController.transitioningDelegate = self
            present(viewController, animated: true, completion: nil)
        } else if name == "Tap to print" {
            
            let printingViewModel = PrintingViewModel(collageUrl: (viewModel?.collageUrl)!)
            let viewController = PrintingViewController(viewModel: printingViewModel, printer: printer)
            viewController.transitioningDelegate = self
            present(viewController, animated: true, completion: nil)
        }
 */
    }
 
}


