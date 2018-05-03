//
//  RealmManager.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager: NSObject {
    
    //MARK: Realm
    let realm = try! Realm()
    var photoSetData: Results<RealmPhotoSet>!
    
    override init() {
        super.init()
        
        //initialize realm
        photoSetData = realm.objects(RealmPhotoSet.self)
        
    }
    
    func getSortedData() -> [PhotoSet] {
        
        var photoSets = [PhotoSet]()
        //sort the realm data from newest to oldest
        let sortedPhotoSets = photoSetData.sorted(byKeyPath: "timeReceived", ascending: false)
        
        //push realm data into data source (for IGListKit)
        for photoSet in sortedPhotoSets {
            
            var imageNames = [String]()
            for imageURLS in photoSet.images {
                imageNames.append(imageURLS.imageName)
            }
            
            let newPhotoSet = PhotoSet(photoSetID: photoSet.photoSetID, imagesNames: imageNames, timeReceived: photoSet.timeReceived)
            
            photoSets.append(newPhotoSet)
        }
        
        return photoSets
    }
}
