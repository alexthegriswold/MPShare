//
//  PhotoSetSectionController.swift
//  MPShare
//
//  Created by Alexander Griswold on 5/2/18.
//  Copyright © 2018 com.Mobilepic. All rights reserved.
//

import UIKit
import IGListKit

final class PhotoSetBindableSectionController: ListBindingSectionController<ListDiffable>, ListBindingSectionControllerDataSource, ListBindingSectionControllerSelectionDelegate, UICollectionViewDelegate  {
    
    //for the view transitions
    weak var delegate: PhotoSetSectionControllerDelegate? = nil
    
    override init() {
        super.init()
        dataSource = self
        selectionDelegate = self
        
        let _ = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(PhotoSetBindableSectionController.updateTime), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTime() {
        collectionContext?.performBatch(animated: false, updates: {
            (batchContext) in
            batchContext.reload(in: self, at: IndexSet(integer: 0))
        }, completion: nil)
        
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
        guard let photoSet = object as? PhotoSet else { return [] }
        
        var viewModels = [ListDiffable]()
        var imageName = "blankImage"
        
        if let firstImageName = photoSet.imagesNames.first {
            imageName = firstImageName
        }
        
        viewModels.append(PhotoSetHeaderViewModel(photoSetID: photoSet.photoSetID, date: photoSet.timeReceived))
        viewModels.append(PhotoSetViewModel(imageUrl: imageName, photoSetID: photoSet.photoSetID, photoSet: photoSet))
        
        return viewModels
    }
   
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell & ListBindable {
        let cellClass: AnyClass
        
        if viewModel is PhotoSetHeaderViewModel {
            cellClass = PhotoSetHeaderCell.self
        } else {
            cellClass = PhotoSetCell.self
        }
        
        guard let cell = collectionContext?.dequeueReusableCell(of: cellClass, for: self, at: index) as? UICollectionViewCell & ListBindable
            else { fatalError() }
        
        return cell
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { return .zero }
        if viewModel is PhotoSetHeaderViewModel {
            return CGSize(width: width, height: 53.0)
        } else {
            return CGSize(width: width, height: 400.0)
        }
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didSelectItemAt index: Int, viewModel: Any) {
        guard let viewModel = viewModel as? PhotoSetViewModel else { return }
        
        delegate?.didTapCell(viewModelObject: viewModel, section: sectionController.section)
    }
}

protocol PhotoSetSectionControllerDelegate: class {
    func didTapCell(viewModelObject: PhotoSetViewModel, section: Int)
}
