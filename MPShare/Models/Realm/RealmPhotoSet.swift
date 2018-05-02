//
//  RealmPhotoSet.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import RealmSwift

class RealmPhotoSet: Object  {
    
    //change
    @objc dynamic var photoSetID = "" //just the date (with seconds)
    let images = List<ImageURL>()
    @objc dynamic var timeReceived = Date() //time the photo was saved
    
}
