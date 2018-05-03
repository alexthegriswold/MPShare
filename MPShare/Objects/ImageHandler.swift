//
//  ImageHandler.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit
import RealmSwift

class ImageHandler: NSObject {
    
    
    private var images = [UIImage]()
    private var names = [String]()
    var baseString: String?
    var currentImage = 0
    //MARK: Realm
    let realm = try! Realm()
    let awsManager = AWSManager()
    let imageCount: Int
    
    
    init(imageCount: Int) {
        self.imageCount = imageCount
        super.init()
        
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
    
    func deleteImageFromDocumentDirectory(imageName: String) {
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let imageURL = docDir.appendingPathComponent("\(imageName)")
        let fileManager = FileManager.default
        
        do {
            try fileManager.removeItem(at: imageURL)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
    
    
    //returns 1 if the images have been saved. 0 if not
    func addImage(image: UIImage) {
        self.images.append(image)
        if self.images.count == 1 {
            self.baseString = getDateString()
        }
        
        self.saveImage(image: image)
    }
    
    func saveImage(image: UIImage) {
        if let baseString = self.baseString {
            let imageName = baseString + "-\(currentImage).jpg"
            names.append(imageName)
            self.saveImageToDocumentDirectory(image: image, imageName: imageName)
            let imageURL = ImageURL()
            imageURL.imageName = imageName
            
            print("Saving : ", imageName)
            
            try! realm.write {
                realm.add(imageURL)
            }
            
            if let imageData = UIImageJPEGRepresentation(image, 1.0) {
                awsManager.uploadImage(with: imageData, name: imageName)
            } else {
                print("Image to data conversion failed")
            }
            
            currentImage += 1
        }
    }
    
    func createPhotoSet() -> PhotoSet {
        print("If this is the last thing. We crashed here")
        
        guard let baseString = self.baseString else {fatalError()}
        
        return PhotoSet(photoSetID: baseString, imagesNames: names, timeReceived: Date())
    }
    
    func createRealmPhotoSet(photoSet: PhotoSet) -> RealmPhotoSet {
        //this copies a regular object and turns it into a realm object
        //this can go in ImageHandler
        let realmPhotoSet = RealmPhotoSet()
        realmPhotoSet.photoSetID = photoSet.photoSetID
        var imageURLS = [ImageURL]()
        
        for imageName in photoSet.imagesNames {
            let imageURL = ImageURL()
            imageURL.imageName = imageName
            imageURLS.append(imageURL)
        }
        
        for imageURL in imageURLS {
            realmPhotoSet.images.append(imageURL)
        }
        
        realmPhotoSet.timeReceived = photoSet.timeReceived
        
        return realmPhotoSet
    }
    
    //I want to be able to safely name images
    func getDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyyHHmmss"
        let dateString = formatter.string(from: Date())
        return dateString
    }
    
    func resetObject() {
        images.removeAll()
        names.removeAll()
    }
    
    /*
    func getTestData() -> [PhotoSetModel] {
        let myDate = Date.init()
        var photoSets = [PhotoSetModel]()
        addTestDataToDocuments()
        
        let imageNames1 = ["testImage1", "testImage3", "testImage2", "testCollage1"]
        let imageNames2 = ["testCollage2", "testCollage2", "testCollage2", "testCollage2"]
        
        let photoSet = PhotoSetModel(photoSetID: "testCollage1", imagesNames: imageNames1, timeReceived: myDate)
        let photoSet2 = PhotoSetModel(photoSetID: "testCollage2", imagesNames: imageNames2, timeReceived: myDate)
        
        photoSets.append(photoSet)
        photoSets.append(photoSet2)
        
        return photoSets
    }
    
    private func addTestDataToDocuments() {
        saveImageToDocumentDirectory(image: #imageLiteral(resourceName: "testImage1"), imageName: "testImage1")
        saveImageToDocumentDirectory(image: #imageLiteral(resourceName: "testImage3"), imageName: "testImage2")
        saveImageToDocumentDirectory(image: #imageLiteral(resourceName: "testImage2"), imageName: "testImage3")
        saveImageToDocumentDirectory(image: #imageLiteral(resourceName: "testCollage1"), imageName: "testCollage1")
        saveImageToDocumentDirectory(image: #imageLiteral(resourceName: "TestCollage2"), imageName: "testCollage2")
    }
 */
 
    func deletePhotoSetFromDirectory(photoSetModel: PhotoSet) {
        
        for imageName in photoSetModel.imagesNames {
            deleteImageFromDocumentDirectory(imageName: imageName)
        }
    }
}
