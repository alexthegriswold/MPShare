//
//  TextMessage.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/9/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import RealmSwift

class TextMessage: Object  {
    
    @objc dynamic var imageName = "" //the name of the image
    @objc dynamic var recipient = ""  //the phone number to send it to
    @objc dynamic var lastImage = false //the name of the image
    
    
}
