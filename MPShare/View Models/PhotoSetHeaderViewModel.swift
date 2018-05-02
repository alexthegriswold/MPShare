//
//  PhotoSetHeaderViewModel.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import Foundation
import IGListKit

final class PhotoSetHeaderViewModel {
    let photoSetID: String
    let date: Date
    
    init(photoSetID: String, date: Date) {
        self.photoSetID = photoSetID
        self.date = date
    }
    
}

extension PhotoSetHeaderViewModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return photoSetID as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? PhotoSetHeaderViewModel else { return false }
        
        return object.photoSetID == object.photoSetID
    }
}
