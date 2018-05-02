//
//  MainHeaderModel.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import IGListKit

final class MainHeaderModel: ListDiffable {
    
    let text: String
    
    init(text: String) {
        self.text = text
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return text as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? MainHeaderModel else { return false }
        return text == object.text
    }
}
