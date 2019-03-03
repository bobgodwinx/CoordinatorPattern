//
//  ViewItemViewModelType.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 03.03.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ViewItemViewModelType {
    var datasource: Driver<[CollectionRow]> { get }
}
