//
//  ImageSceneViewModel.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 20.03.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class ImageSceneViewModel: ImageSceneViewModelType {
    let imageURL: Driver<URL?>
    
    init(_ viewItemRow: ViewItemRow) {
        
        imageURL = Driver
            .just(viewItemRow)
            .map { $0.imageURL }
    }
}
