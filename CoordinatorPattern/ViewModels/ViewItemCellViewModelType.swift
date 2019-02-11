//
//  ViewItemCellViewModelType.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 11.02.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ViewItemCellViewModelType {
    var thumbnailURL: Driver<URL?> { get }
    var imageURL: URL? { get }
}
