//
//  PhotoSetHeaderCell.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit
import IGListKit

final class PhotoSetHeaderCell: UICollectionViewCell {
    fileprivate let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(timeLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        timeLabel.frame = CGRect(x: 454, y: 10, width: 614, height: 40)
    }
    
    func calculateTheTime(photoSetDate: Date) -> String{
        let currentTime = Date()
        let seconds = currentTime.timeIntervalSince(photoSetDate)
        let totalMinutes = Int(seconds/60)
        let hours = Int(totalMinutes/60)
        let minutes = totalMinutes - (hours * 60)
        
        var timeString: String
        
        let hourString: String = hours == 1 ? "HOUR" : "HOURS"
        let minuteString: String = minutes == 1 ? "MINUTE" : "MINUTES"
        
        timeString = "\(hours) " + "\(hourString) " + "AND " + "\(minutes) " + "\(minuteString) AGO"
        
        return timeString
    }
    
}

extension PhotoSetHeaderCell: ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let ViewModel = viewModel as? PhotoSetHeaderViewModel else { return }
        
        timeLabel.text = calculateTheTime(photoSetDate: ViewModel.date)
    }
}
