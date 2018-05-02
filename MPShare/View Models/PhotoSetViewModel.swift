//
//  PhotoSetViewModel.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import Foundation
import IGListKit

final class PhotoSetViewModel {
    
    let imageUrl: String
    let photoSetID: String
    let photoSet: PhotoSet
    
    init(imageUrl: String, photoSetID: String, photoSet: PhotoSet) {
        self.imageUrl = imageUrl
        self.photoSetID = photoSetID
        self.photoSet = photoSet
    }
    
}

extension PhotoSetViewModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return photoSetID as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? PhotoSetViewModel else { return false }
        
        return self.photoSetID == object.photoSetID
    }
}
