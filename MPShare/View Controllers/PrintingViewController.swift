//
//  PrintingViewController.swift
//  MPShare
//
//  Created by Alexander Griswold on 10/20/17.
//  Copyright © 2017 com.example. All rights reserved.
//
import UIKit

class PrintingViewController: UIViewController, UIViewControllerTransitioningDelegate, PrintInputViewDelegate, AlertViewControllerDelegate {
    
    let printingView: PrintingView
    let backButton = BackButton()
    
    private var viewModel: PrintingViewModel?
    
    var printer: UIPrinter?
    
    var printCount = 1
    
    init(viewModel: PrintingViewModel, printer: UIPrinter?) {
        
        printingView = PrintingView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.printer = printer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.addTarget(self, action: #selector(PrintingViewController.didTapBack), for: .touchUpInside)
        [printingView, backButton].forEach { view.addSubview($0) }
        printingView.printInputView.delegate = self
    }
    
    func didTapSubmit(printNumber: Int) {
        printImage(number: printNumber)
        
        if printer == nil {
            let printMessage = "There is no printer connected!\nLet my attendant know!"
            let alert = UIAlertController(title: "No Printer", message: printMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok!", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let seconds = String(20 + ((printNumber - 1) * 10))
            let printMessage = "Your photos will be ready in approximately " + seconds + " seconds."
            let alertViewModel = AlertViewModel(phrase: printMessage)
            let alertViewController = AlertViewController(viewModel: alertViewModel)
            alertViewController.delegate = self
            alertViewController.modalPresentationStyle = .formSheet
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        printingView.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        backButton.frame = CGRect(x: 30, y: 30, width: 100, height: 34)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func printImage(number: Int) {
        
        let printController = UIPrintInteractionController.shared
        var images = [UIImage]()
        
        for _ in 0..<number {
            images.append(getImage(url: (viewModel?.imageUrl)!))
        }
        
        printController.printingItems = images
        
        let printInfo = UIPrintInfo.printInfo()
        printInfo.jobName = "Image"
        printInfo.outputType = .photo
        
        printController.printInfo = printInfo
        
        if let printer = printer {
            printController.print(to: printer, completionHandler: nil)
        }
    }
    
    func getImage(url: String) -> UIImage {
        
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let documentsPath = docDir.path.appending("/")
        
        let imageUrl = documentsPath + url + ".jpg"
        
        return UIImage(contentsOfFile: imageUrl)!
        
    }
    
    func didDismissAlert() {
        self.navigationController?.popViewController(animated: true)
    }
}
