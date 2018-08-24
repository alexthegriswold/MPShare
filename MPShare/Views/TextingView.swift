//
//  TextingView.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/8/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit

class TextingView: UIView, PinPadButtonActionDelegate, DeleteButtonActionDelegate {
    
    
    let collageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        return view
    }()
    let collageShadow = UIView(frame: .zero)
    
    let image1View: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        return view
    }()
    let image1Shadow = UIView(frame: .zero)
    
    let image2View: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        return view
    }()
    let image2Shadow = UIView(frame: .zero)
    
    let image3View: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        return view
    }()
    let image3Shadow = UIView(frame: .zero)
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 48, weight: UIFont.Weight.bold)
        label.text = "Your Photo"
        return label
    }()
    
    let pinPadText: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.thin)
        label.text = "Enter Number"
        label.textAlignment = .center
        return label
    }()
    
    let pinPadView = PinPadView(frame: .zero)
    var phoneNumber = ""
    var imageCount: Int
    
    init(frame: CGRect, imageCount: Int, imageUrls: [String]) {
        
        self.imageCount = imageCount
        super.init(frame: frame)
    
        //adds the four images to the view
        if imageUrls.count == 1 {
            self.addImageWithShawdowToView(imageView: collageView, shadowView: collageShadow)
            self.setImage(imageUrl: imageUrls[0], imageView: collageView)
            
        } else if imageUrls.count == 4 {
            self.addImageWithShawdowToView(imageView: collageView, shadowView: collageShadow)
            self.addImageWithShawdowToView(imageView: image1View, shadowView: image1Shadow)
            self.addImageWithShawdowToView(imageView: image2View, shadowView: image2Shadow)
            self.addImageWithShawdowToView(imageView: image3View, shadowView: image3Shadow)
        }
        
        pinPadView.buttons.forEach { $0.delegate = self }
        pinPadView.deleteButton.delegate = self
        
        [pinPadView, titleLabel, pinPadText].forEach { addSubview($0) }
        
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(imageUrl: String, imageView: UIImageView) {
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let documentsPath = docDir.path.appending("/")
        
        let imageUrl = documentsPath + imageUrl + ".jpg"
        imageView.image = UIImage(contentsOfFile: imageUrl)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        let leftPoint = 50
        let rightPoint = 350
        let topPoint = 185
        let bottomPoint = 398
        let width = 277
        let height = 185
        
        if imageCount == 1 {
            let collageRect = CGRect(x: leftPoint, y: topPoint, width: 577, height: 398)
            layoutImageWithShadow(frame: collageRect, alexTest: collageView, shadowView: collageShadow)
            
        } else if imageCount == 4 {
            let collageRect = CGRect(x: leftPoint, y: topPoint, width: width, height: height)
            let image1Rect = CGRect(x: rightPoint, y: topPoint, width: width, height: height)
            let image2Rect = CGRect(x: leftPoint, y: bottomPoint, width: width, height: height)
            let image3Rect = CGRect(x: rightPoint, y: bottomPoint, width: width, height: height)
            
            layoutImageWithShadow(frame: collageRect, alexTest: collageView, shadowView: collageShadow)
            layoutImageWithShadow(frame: image1Rect, alexTest: image1View, shadowView: image1Shadow)
            layoutImageWithShadow(frame: image2Rect, alexTest: image2View, shadowView: image2Shadow)
            layoutImageWithShadow(frame: image3Rect, alexTest: image3View, shadowView: image3Shadow)
        }
        
        
        pinPadView.frame = CGRect(x: 681, y: 188, width: 294, height: 479)
        
        titleLabel.frame = CGRect(x: 50, y: 106, width: 300, height: 54)
        
        pinPadText.frame = CGRect(x: 681, y: 95, width: 294, height: 55)
        
    }
    
    private func layoutImageWithShadow(frame: CGRect, alexTest: UIImageView, shadowView: UIView) {
        alexTest.frame = frame
        alexTest.layer.cornerRadius = 5
        shadowView.clipsToBounds = false
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.20
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 10)
        shadowView.layer.shadowRadius = 13
        shadowView.layer.shadowPath = UIBezierPath(rect: alexTest.frame).cgPath
        shadowView.layer.shouldRasterize = false
    }
    
    private func addImageWithShawdowToView(imageView: UIImageView, shadowView: UIView) {
        self.addSubview(shadowView)
        self.addSubview(imageView)
    }
    
    func didTapButton(index: String) {
        if phoneNumber.count < 10 {
            if phoneNumber == "" {
                phoneNumber = index
                displayNumber(phoneNumber: phoneNumber)
                pinPadText.text = phoneNumber
            } else {
                phoneNumber.append(index)
                displayNumber(phoneNumber: phoneNumber)
            }
            
            if phoneNumber.count == 10 {
                print("Phone Number: ", phoneNumber)
            }
        }
    }
    
    func didTapDelete() {
        if phoneNumber.count > 0 {
            
            phoneNumber.remove(at: phoneNumber.index(before: phoneNumber.endIndex))
            displayNumber(phoneNumber: phoneNumber)
            
            if phoneNumber.characters.count == 0 {
                pinPadText.text = "Enter Number"
            }
        }
    }
    
    
    //probably should move this to the model
    func displayNumber(phoneNumber:String) {
        if phoneNumber.count < 4 {
            pinPadText.text = phoneNumber
        }
        if phoneNumber.count > 3 {
            let areaCode = String(phoneNumber.prefix(3))
            if phoneNumber.count < 8 {
                let middleNumbers = String(phoneNumber.suffix(phoneNumber.count - 3))
                pinPadText.text = areaCode + "-" + middleNumbers
            }
            else if phoneNumber.count > 7 {
                let start = phoneNumber.index(phoneNumber.startIndex, offsetBy: 3)
                let end = phoneNumber.index(phoneNumber.startIndex, offsetBy: 6)
                let range = start..<end
                let middleNumbers = phoneNumber.substring(with: range)
                let endNumbers = String(phoneNumber.suffix(phoneNumber.count - 6))
                
                pinPadText.text = "(" + areaCode + ") " + middleNumbers + "-" + endNumbers
                
            }
        }
    }
    
    func sendPhoneNumber() -> String {
        if phoneNumber.count == 10 {
            return phoneNumber
        } else {
            print("Not a real phone number")
            return "9547896903"
        }
    }
}
