//
//  TextingManager.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/8/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class TextManager: NSObject, XMLParserDelegate {
    
    //MARK: Realm
    let realm = try! Realm()
    
    //MARK: Twilio
    let url:String = "https://api.twilio.com/2010-04-01/Accounts/AC295d6b704a7cf1c6d1441410a884b13d/Messages"
    let username = "AC295d6b704a7cf1c6d1441410a884b13d"
    let password = "9e933cabcd8d983e61286cb1bbf630dd"
    
    //MARK: XMLParserDelegate
    var twilioResponse = [String: String?]()
    var key: String?
    
    //sending helper variables
    var timer = Timer()
    var imageNames = [String]()
    let phoneNumber: String
    
    init(imageNames: [String], phoneNumber: String) {
        
        self.imageNames = imageNames
        self.phoneNumber = phoneNumber
        
        super.init()
        
        self.checkImageLinks()
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(TextManager.checkImageLinks), userInfo: nil, repeats: true)
    }
    
    //check if any of the images are ready to text
    @objc func checkImageLinks() {
        
        for image in imageNames {
            if !checkImageLink(imageName: image) {
                return
            }
        }
        
        print("down here")
        
        if isConnected() {
            
            for i in 0..<imageNames.count {
                let withText: Bool = i == (imageNames.count - 1) ? true : false
                self.sendTextWithImage(imageName: imageNames[i], recipient: self.phoneNumber, withText: withText)
            }

        } else {
            for i in 0..<imageNames.count {
                let message = TextMessage()
                message.imageName = imageNames[i]
                message.recipient = self.phoneNumber
                
                if i == imageNames.count - 1 {
                    message.lastImage = true
                }
            }
        }
        
        imageNames.removeAll()
        timer.invalidate()
    }
    
    //checks to see if the image is uploaded to Amazon
    func checkImageLink(imageName: String) -> Bool {
        let imageUrl = self.realm.objects(ImageURL.self).filter("imageName == '\(imageName)'").first
        
        if let imageUrl = imageUrl {
            return imageUrl.uploaded
        } else {
            return false
        }
        
    }
    
    func isConnected() -> Bool {
        guard let manager = NetworkReachabilityManager() else { return false }
        return manager.isReachable
    }
   
    func sendTextWithImage(imageName: String, recipient: String, withText: Bool) {

        var data = [String : String]()
        let imageLink: String = "https://mobilepicshare.s3.amazonaws.com/\(imageName)"
        
        if withText {
            let phoneNumber: String = "+1\(recipient)"
            data = [
                "To" : phoneNumber,
                "From" : "+17867131512",
                "Body" : "Hey! Thanks for checking out the Mobilepic Photobooth app!",
                "MediaUrl": imageLink,
            ]
        } else {
            let phoneNumber: String = "+1\(recipient)"
            data = ["To" : phoneNumber, "From" : "+17867131512", "MediaUrl": imageLink]
        }
        
        Alamofire.request(url, method: .post, parameters: data)
            .authenticate(user: username, password: password)
            .responseString { response in
                
                
                let xml = XMLParser(data: response.data!)
                xml.delegate = self
                xml.parse()
        }
    }
    
    
    //MARK: XML Parsing Delegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print("Element: ", elementName)
        
        if self.key == nil {
            self.key = elementName
        } else {
            twilioResponse[elementName] = nil
            key = nil
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if let key = self.key {
            twilioResponse[key] = string
            self.key = nil
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print(twilioResponse)
        print(twilioResponse["Status"])
    }
}

