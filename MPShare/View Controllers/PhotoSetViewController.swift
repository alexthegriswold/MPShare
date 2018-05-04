//
//  ViewController.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit
import RealmSwift
import IGListKit

class PhotoSetViewController: UIViewController, ListAdapterDataSource, UIScrollViewDelegate, PhotoSetSectionControllerDelegate, ImageReceiverDelegate {
    
    //MARK: Views
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let instructionView = InstructionView(frame: .zero)
    
    //MARK: IGListKitAdapert
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    //MARK: Data Source
    var photoSets = [Any]()
    
    //MARK: Image Receiver
    var imageReceiver = ImageReceiver()
    
    //MARK: Realm Manager
    var realmManager = RealmManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageReceiver.delegate = self
        
        //hide the navigation bar
        self.navigationController?.navigationBar.isHidden = true
        
        //configure collectionView
        collectionView.backgroundColor = UIColor(white: 1, alpha: 1)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        view.addSubview(instructionView)
        
        //add the header
        let mainHeader = MainHeaderModel(text: "MobilePic")
        photoSets.insert(mainHeader, at: 0)
        
        let sortedPhotoSets = realmManager.getSortedData()
        for photoSet in sortedPhotoSets {
            photoSets.append(photoSet)
        }
        
        adapter.collectionView = collectionView
        adapter.dataSource = self //the data source must be set after the data is initialized
        adapter.scrollViewDelegate = self
   
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        instructionView.frame = CGRect(x: 0, y: 0, width: 410, height: 768)
    }
    

    //MARK: Navigation
    func didTapCell(viewModelObject: PhotoSetViewModel, section: Int) {
        //transistion
    }
    
    //hides the status bar from the app
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: Image Receiver Delegate Method
    func didReceivePhotoSet(photoSet: PhotoSet) {
        photoSets.insert(photoSet, at: 1)
        DispatchQueue.main.async {
            self.adapter.performUpdates(animated: true, completion: nil)
        }
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

