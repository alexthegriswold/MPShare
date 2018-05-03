//
//  AWSManager.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

//
//  AWSManager.swift
//  MobilePicShare2
//
//  Created by Alexander Griswold on 1/11/18.
//  Copyright © 2018 com.example. All rights reserved.
//

import Foundation
import AWSS3
import AWSCognito
import RealmSwift

class AWSManager: NSObject {
    
    let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let transferUtility = AWSS3TransferUtility.default()
    var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
    let realm = try! Realm()
    
    override init() {
        super.init()

        self.completionHandler = { (task, error) -> Void in
            DispatchQueue.main.async(execute: {
                if let error = error {
                    print("Failed with error: \(error)")
                    //self.statusLabel.text = "Failed"
                    print("failed")
                }
                    
                else{
                    print("success:", task.key)
                    
                    let key = task.key
                    
                    //this is broken. Not the way to do it
                    //gets the image url from the realm database and then filters it out.
                    let imageURL = self.realm.objects(ImageURL.self).filter("imageName == '\(key)'")
                    
                    print("Key: ", key)
                    
                    print(imageURL.count)
                    
                    
                    //if we got something back
                    if imageURL.count > 0 {
                        
                        //write to the first one
                        try! self.realm.write {
                            imageURL[0].uploaded = true
                        }
                    }
                    
                    //self.statusLabel.text = "Success"
                }
            })
        }
        
        
        //var imageData = UIImageJPEGRepresentation(#imageLiteral(resourceName: "collage"), 1.0)
        //self.uploadImage(with: imageData!, name: "Collage2.jpg")
        
        //imageData = UIImageJPEGRepresentation(#imageLiteral(resourceName: "collage"), 1.0)
        //self.uploadImage(with: imageData!, name: "Collage3.jpg")
    }
    
    func configure() {
        let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "us-east-1:8076fbc0-5bf7-4727-8ff9-ec2c2fb2c5eb")
        let configuration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: credentialProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let cognitoId = credentialProvider.identityId
        
        if let id = cognitoId {
            print("ID: \(id)")
        }
        
        
    }
    
    func uploadImage(with data: Data, name: String) {
        let expression = AWSS3TransferUtilityUploadExpression()
        
        
        transferUtility.uploadData(
            data,
            bucket: S3BucketName,
            key: name,
            contentType: "image/jpeg",
            expression: expression,
            completionHandler: completionHandler).continueWith { (task) -> AnyObject! in
                if let error = task.error {
                    print("Error: \(error.localizedDescription)")
                    
                    DispatchQueue.main.async {
                        print("Failed")
                        //self.statusLabel.text = "Failed"
                    }
                }
                
                if let _ = task.result {
                    
                    
                    //print("Completed upload for image: ", name)
                    // Do something with uploadTask.
                }
                
                return nil;
        }
    }
}

