//
//  ImageReceiver.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit
import RealmSwift

class ImageReceiver: NSObject, PTManagerDelegate {
    
    //MARK: Peertalk
    let ptManager = PTManager()
    let usbPhotoSet = USBPhotoSet()
    let imageHandler = ImageHandler(imageCount: 1)
    let imageCount = 1
    
    //MARK: Realm
    let realm = try! Realm()
    
    weak var delegate: ImageReceiverDelegate? = nil
    
    override init() {
        super.init()
        
        // Setup the PTManager
        ptManager.delegate = self
        ptManager.connect(portNumber: PORT_NUMBER)
        
        saveImage(image: #imageLiteral(resourceName: "test"))
        
    }
    
    func saveImage(image: UIImage) {
        
        self.usbPhotoSet.addImage(image: image)
        
        if self.usbPhotoSet.images.count == imageCount {
            
            for image in self.usbPhotoSet.images {
                imageHandler.addImage(image: image)
            }
            
            let photoSet = imageHandler.createPhotoSet()
            delegate?.didReceivePhotoSet(photoSet: photoSet)
            let realmPhotoSet = imageHandler.createRealmPhotoSet(photoSet: photoSet)
            
            //gets everything ready for another go
            imageHandler.resetObject()
            try! realm.write {
                realm.add(realmPhotoSet)
            }
            
            self.usbPhotoSet.removeAllImages()
        }
    }
    
    func peertalk(shouldAcceptDataOfType type: UInt32) -> Bool {
        return true
    }
    
    func peertalk(didReceiveData data: Data, ofType type: UInt32) {
        
        if type == PTType.image.rawValue {
            
            print("receveived image")
            let image = UIImage(data: data)
            if let image = image {
                saveImage(image: image)
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

protocol ImageReceiverDelegate: class {
    func didReceivePhotoSet(photoSet: PhotoSet)
}


