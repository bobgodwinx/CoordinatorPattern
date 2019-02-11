//
//  ViewItemCellViewModel.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 11.02.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewItemCellViewModel: ViewItemCellViewModelType {
    let thumbnailURL: Driver<URL?>
    let imageURL: URL?
    
    init(_ viewItem: ViewItem) {
        
        thumbnailURL = Driver
            .just(viewItem)
            .map { URL(string: $0.thumbnail) }
        
        imageURL = URL(string: viewItem.image)
    }
}
