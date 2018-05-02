//
//  PhotoSet.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import IGListKit

final class PhotoSetModel: ListDiffable {
    
    let photoSetID: String
    var imagesNames = [String]()
    let timeReceived: Date
    
    init(photoSetID: String, imagesNames: [String], timeReceived: Date) {
        self.photoSetID = photoSetID
        self.imagesNames = imagesNames
        self.timeReceived = timeReceived
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return photoSetID as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? PhotoSetModel else { return false }
        return photoSetID == object.photoSetID
    }
}
