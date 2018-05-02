//
//  ViewController.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit
import RealmSwift

class PhotoSetViewController: UIViewController {
    
    //MARK: Realm
    let realm = try! Realm()
    var photoSetData: Results<RealmPhotoSet>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        getRealmData()
        
        
        
        
        
    }
    
    func getRealmData() {
        photoSetData = realm.objects(RealmPhotoSet.self)
        
        //MARK: Test the Realm Stuff
        //sort the realm data from newest to oldest
        let sortedPhotoSets = photoSetData.sorted(byKeyPath: "timeReceived", ascending: false)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

