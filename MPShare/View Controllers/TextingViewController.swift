//
//  TextingViewController.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/8/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class TextingViewController: UIViewController, UIViewControllerTransitioningDelegate, SubmitButtonActionDelegate /*AlertViewControllerDelegate*/ {
    
    private var textingViewModel: TextingViewModel
    
    //buttons and views
    let backButton = BackButton()
    let textingView: TextingView


    init(viewModel: TextingViewModel) {
        self.textingViewModel = viewModel
        self.textingView = TextingView(frame: .zero, imageCount: 1, imageUrls: viewModel.imageNames)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.addTarget(self, action: #selector(TextingViewController.didTapBack), for: .touchUpInside)
        
        //add subviews
        view.addSubview(textingView)
        view.addSubview(backButton)
        
        //setup delegates
        textingView.pinPadView.submitButton.textingDelegate = self
    }
    
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textingView.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        backButton.frame = CGRect(x: 30, y: 30, width: 100, height: 34)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func getImage(with fileName: String) -> UIImage {
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let documentsPath = docDir.path.appending("/")
        
        let imageUrl = documentsPath + fileName + ".jpg"
        
        return UIImage(contentsOfFile: imageUrl)!
    }
    
    func didTapSubmitButton() {
        if textingView.phoneNumber.characters.count == 10  {
            let keyboardInput = textingView.phoneNumber
        
            var imageNames = [String]()
        
            for imageName in textingViewModel.imageNames {
                imageNames.append(imageName)
            }
            
            let textManager = TextManager(imageNames: imageNames, phoneNumber: keyboardInput)
            //let alertViewModel = AlertViewModel(phrase: "I'm sending your pic now!\n You'll have it soon!")
            //let alertViewController = AlertViewController(viewModel: alertViewModel)
            //alertViewController.delegate = self
            //alertViewController.modalPresentationStyle = .formSheet
            //self.present(alertViewController, animated: true, completion: nil)
            
            textingView.phoneNumber = ""
            textingView.pinPadText.text = ""
        }
    }
    
    func didDismissAlert() {
        self.navigationController?.popViewController(animated: true)
    }
}

