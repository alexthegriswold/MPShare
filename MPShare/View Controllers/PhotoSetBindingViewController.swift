//
//  PhotoSetBindableViewController.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit
import IGListKit
import RealmSwift

final class PhotoSetBindingViewController: UIViewController, ListAdapterDataSource, PhotoSetSectionControllerDelegate, WireFrameActionDelegate, UIScrollViewDelegate, SettingsDeleteButtonDelegate, SettingsPrinterDelegate {
    
    var printer: UIPrinter? = nil
    
    var imageCount = 1
    
    //MARK: Views
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let instructionView = InstructionView(frame: .zero)
    
    //MARK: IGListKitAdapert
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    //MARK: Data Source
    var photoSets = [Any]()
    
    //MARK: Realm
    let realm = try! Realm()
    
    //var realm: Realm
    var photoSetData: Results<PhotoSet>!
    
    /*
    //peertalk
    let ptManager = PTManager()
    */
 
    /*
    //handles all of the image saving
    var imageHandler = ImageHandler(imageCount: 1)
    */
 
    //handles all of the aws stuff
    var awsManager = AWSManager()
    var usbPhotoSet = USBPhotoSet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the PTManager
        ptManager.delegate = self
        ptManager.connect(portNumber: PORT_NUMBER)
        
        //hide the navigation bar
        self.navigationController?.navigationBar.isHidden = true
        
        //add views
        view.addSubview(collectionView)
        view.addSubview(instructionView)
        
        //configure collectionView
        collectionView.backgroundColor = UIColor(white: 1, alpha: 1)
        collectionView.showsVerticalScrollIndicator = false
        
        //initialize realm
        photoSetData = realm.objects(PhotoSet.self)
        
        //MARK: Test the Realm Stuff
        //sort the realm data from newest to oldest
        let sortedPhotoSets = photoSetData.sorted(byKeyPath: "timeReceived", ascending: false)
        
        //change
        //push realm data into data source (for IGListKit)
        for photoSet in sortedPhotoSets {
            
            var imageNames = [String]()
            for imageURLS in photoSet.images {
                imageNames.append(imageURLS.imageName)
            }
            
            let newPhotoSet = PhotoSetModel(photoSetID: photoSet.photoSetID, imagesNames: imageNames, timeReceived: photoSet.timeReceived)
            photoSets.append(newPhotoSet)
        }
        
        //add the header
        let mainHeader = MainHeaderModel(text: "MobilePic")
        photoSets.insert(mainHeader, at: 0)
        
        //this ads the two images
        //these are only used for testing
        for photoSet in imageHandler.getTestData() {
            photoSets.append(photoSet)
        }
        
        adapter.collectionView = collectionView
        adapter.dataSource = self //the data source must be set after the data is initialized
        adapter.scrollViewDelegate = self
        
        //wireframe Delegate
        instructionView.instructionViewPanel.wireFrame.delegate = self
    }
    
    func didTapDeleteButton() {
        deleteAllPhotoSets()
    }
    
    func deleteAllPhotoSets() {
        for photoSet in photoSets {
            if let photoSetModel = photoSet as? PhotoSetModel {
                
                imageHandler.deletePhotoSetFromDirectory(photoSetModel: photoSetModel)
                
                if photoSets.count > 1 {
                    photoSets.remove(at: 1)
                }
            }
        }
        
        //Delete all records
        try! realm.write {
            realm.deleteAll()
        }
        
        //updates the view
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        instructionView.frame = CGRect(x: 0, y: 0, width: 410, height: 768)
    }
    
    //hides the status bar from the app
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    // MARK: ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        
        return photoSets as! [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        if object is MainHeaderModel {
            let sectionController = MainHeaderSectionController()
            return sectionController
        } else {
            let sectionController = PhotoSetBindableSectionController()
            sectionController.delegate = self
            return sectionController
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
    
    //MARK: WireframeActionDelegate
    func didHoldOnWireFrame() {
        
        let settingsViewModel = SettingsViewModel(isConnected: ptManager.isConnected)
        let settingsViewController = SettingsViewController(viewModel: settingsViewModel)
        settingsViewController.modalPresentationStyle = .pageSheet
        settingsViewController.settingsView.delegate = self
        settingsViewController.printerDelegate = self
        present(settingsViewController, animated: true, completion: { _ in
        })
    }
    
    //MARK: SettingsPrinterDelegate
    func didSelectPrinter(printer: UIPrinter) {
        self.printer = printer
    }
    
    //MARK: PhotoSetSectionControllerDelegate
    func didTapCell(viewModelObject: PhotoSetViewModel, section: Int) {
        
        
        let textingModel = TextingViewModel(phoneNumber: "", imageNames: viewModelObject.photoSetModel.imagesNames)
        let viewController = TextingViewController(viewModel: textingModel)
        self.navigationController?.pushViewController(viewController, animated: true)
        
        
        /*
         let newModel = MainImageViewModel(collageUrl: viewModelObject.imageUrl, photoSet: viewModelObject.photoSetModel)
         let position = 138 + ((section - 1) * 453) - Int(collectionView.contentOffset.y)
         
         let mainImageViewController = MainImageViewController(viewModel: newModel, printer: printer)
         mainImageViewController.transitioningDelegate = self
         
         transition.setImage(imageName: newModel.collageUrl)
         transition.setPosition(position: position)
         dismissTransistion.setImage(imageName: newModel.collageUrl)
         dismissTransistion.setPosition(position: position)
         dismissTransistion.setViewModel(viewModel: viewModelObject)
         
         
         
         present(mainImageViewController, animated: true, completion: nil)
         */
    }
}

extension PhotoSetBindingViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            guard let _ = dismissed as? MainImageViewController else {
                return nil
            }
            return dismissTransistion
    }
}

extension PhotoSetBindingViewController: PTManagerDelegate {
    
    func peertalk(shouldAcceptDataOfType type: UInt32) -> Bool {
        return true
    }
    
    func peertalk(didReceiveData data: Data, ofType type: UInt32) {
        
        print("HEY")
        
        if type == PTType.image.rawValue {
            
            print("receveived image")
            let image = UIImage(data: data)
            if let image = image {
                self.usbPhotoSet.addImage(image: image)
                
                if self.usbPhotoSet.images.count == imageCount {
                    
                    for image in self.usbPhotoSet.images {
                        imageHandler.addImage(image: image)
                    }
                    
                    let photoSet = imageHandler.createPhotoSet()
                    photoSets.insert(photoSet, at: 1)
                    let realmPhotoSet = imageHandler.createRealmPhotoSet(photoSet: photoSet)
                    
                    //gets everything ready for another go
                    imageHandler.resetObject()
                    try! realm.write {
                        realm.add(realmPhotoSet)
                    }
                    DispatchQueue.main.async {
                        self.adapter.performUpdates(animated: true, completion: nil)
                    }
                    
                    self.usbPhotoSet.removeAllImages()
                }
                
                ptManager.sendObject(object: 1, type: PTType.number.rawValue)
            }
        }
    }
    
    func peertalk(didChangeConnection connected: Bool) {
        print("Connection: \(connected)")
        
        if connected == false {
            //change
            if usbPhotoSet.isFull == false {
                usbPhotoSet.removeAllImages()
                
            }
        }
    }
    
}


