//
//  ImageURL.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import RealmSwift

class ImageURL: Object  {
    
    @objc dynamic var imageName = "" //the name of the image
    @objc dynamic var uploaded = false  //if the image has been uploaded to AWS
    
}
