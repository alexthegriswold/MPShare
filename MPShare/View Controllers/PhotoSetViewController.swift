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

class PhotoSetViewController: UIViewController, ListAdapterDataSource, UIScrollViewDelegate, PhotoSetSectionControllerDelegate {
    
    //MARK: Views
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    //MARK: Realm
    let realm = try! Realm()
    var photoSetData: Results<RealmPhotoSet>!

    //MARK: IGListKitAdapert
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    //MARK: Data Source
    var photoSets = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide the navigation bar
        self.navigationController?.navigationBar.isHidden = true
        
        //configure collectionView
        collectionView.backgroundColor = UIColor(white: 1, alpha: 1)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        
        getRealmData()
        
        //add the header
        let mainHeader = MainHeaderModel(text: "MobilePic")
        photoSets.insert(mainHeader, at: 0)
        
        adapter.collectionView = collectionView
        adapter.dataSource = self //the data source must be set after the data is initialized
        adapter.scrollViewDelegate = self
   
    }
    
    func saveImageToDocumentDirectory(image: UIImage, imageName: String) {
        
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let imageURL = docDir.appendingPathComponent("\(imageName)")
        
        do {
            try imageData?.write(to: imageURL)
            print("saving to: ", imageURL)
        } catch let error as NSError {
            print(error)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
    }
    
    //gets the sorted realm data and pushes it to the photoset array 
    func getRealmData() {
        photoSetData = realm.objects(RealmPhotoSet.self)
        
        //sort the realm data from newest to oldest
        //let sortedPhotoSets = photoSetData.sorted(byKeyPath: "timeReceived", ascending: false)
    }
    
    //MARK: Navigation
    func didTapCell(viewModelObject: PhotoSetViewModel, section: Int) {
        //transistion
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

