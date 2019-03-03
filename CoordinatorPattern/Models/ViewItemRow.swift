//
//  ViewItemRow.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 03.03.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct ViewItemRow: CollectionRow {
    /// xib nib-name
    static var nibName: String { return "ViewItemCell" }
    /// reuseableIdentifier
    static var cellIdentifier: String { return "view-item-cell" }
    /// Setup closure
    let configureCell: (UICollectionViewCell) -> Void
    /// image-url for the detail-VC
    let imageURL: URL?
    
    init(_ model: ViewItemCellViewModelType) {
        
        imageURL = model.imageURL
        configureCell = {
            guard let cell = $0 as? ViewItemCell else { return }
            /// cell-binding
            cell.bind(model)
        }
    }
}
