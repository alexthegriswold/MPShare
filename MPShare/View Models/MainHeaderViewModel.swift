//
//  MainHeaderViewModel.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import Foundation
import IGListKit

final class MainHeaderViewModel {
    let text: String
    
    init(text: String) {
        self.text = text
    }
    
}

extension MainHeaderViewModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return text as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? MainHeaderViewModel else { return false }
        
        return text == object.text
    }
}
