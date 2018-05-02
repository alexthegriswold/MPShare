//
//  PeertalkPhotoSet.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class USBPhotoSet: NSObject {
    
    var images = [UIImage]()
    var isFull = false
    
    override init() {
        
    }
    
    func addImage(image: UIImage) {
        images.append(image)
    }
    
    func removeAllImages() {
        images.removeAll()
        isFull = false
    }
}
