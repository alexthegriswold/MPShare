//
//  TextingViewModel.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/8/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class TextingViewModel {
    
    var phoneNumber: String
    var imageNames = [String]()
    
    init(phoneNumber: String, imageNames: [String]) {
        self.phoneNumber = phoneNumber
        self.imageNames = imageNames
    }
}

