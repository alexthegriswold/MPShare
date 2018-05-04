//
//  MainHeaderCell.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit
import IGListKit

final class MainHeaderCell: UICollectionViewCell {
    
    
    fileprivate let largeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 41, weight: UIFont.Weight.bold)
        label.textColor = UIColor.black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(largeLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        largeLabel.frame = CGRect(x: 454, y: 39, width: 614, height: 47)
    }
    
}

extension MainHeaderCell: ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let ViewModel = viewModel as? MainHeaderViewModel else { return }
        
        largeLabel.text = ViewModel.text
    }
}
