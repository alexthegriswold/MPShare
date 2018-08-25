//
//  SelectionViewModel.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/8/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class SelectionViewModel {
    let imageUrl: String
    let photoSet: PhotoSet
    
    init(imageUrl: String, photoSet: PhotoSet) {
        self.imageUrl = imageUrl
        self.photoSet = photoSet
    }
}
