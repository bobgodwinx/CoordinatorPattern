//
//  CollectionDatasource.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 13.11.18.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol CollectionRow {
    var configureCell: (UICollectionViewCell) -> Void { get }
    static var cellIdentifier: String {get}
    static var nibName: String { get }
}
