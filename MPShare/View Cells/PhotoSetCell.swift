//
//  PhotoSetViewCell.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit
import IGListKit

final class PhotoSetCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        return view
    }()
    
    let outerView = UIView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(outerView)
        contentView.addSubview(imageView)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 420, y: 0, width: 540, height: 369)
        imageView.layer.cornerRadius = 10
        outerView.frame = imageView.frame
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 0.15
        outerView.layer.shadowOffset = CGSize(width: 0, height: 5)
        outerView.layer.shadowRadius = 13
        outerView.layer.shadowPath = UIBezierPath(rect: outerView.bounds).cgPath
        outerView.layer.shouldRasterize = true
    }
}

extension PhotoSetCell: ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? PhotoSetViewModel else { return }
        
        DispatchQueue.main.async {
            let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let documentsPath = docDir.path.appending("/")
            let imageUrl = documentsPath + viewModel.imageUrl + ".jpg"
            self.imageView.image = UIImage(contentsOfFile: imageUrl)
        }
    }
}
