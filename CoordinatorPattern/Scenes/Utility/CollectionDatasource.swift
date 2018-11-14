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

/// Defines the `blueprint`
/// for a `Row` within the
/// `UICollectionViewController`
protocol CollectionRow {
    var configureCell: (UICollectionViewCell) -> Void { get }
    static var cellIdentifier: String {get}
    static var nibName: String { get }
}
/// a shorthand for `cellIdentifier`
extension CollectionRow {
    var cellId: String { return Self.cellIdentifier }
}

/// Registers a `CollectionRow.Type` to the
/// `UICollectionViewController`
extension UICollectionView {
    func register(_ rows: [CollectionRow.Type]) {
        rows.forEach { register($0) }
    }
    
    func register(_ row: CollectionRow.Type) {
        let nib = UINib(nibName: row.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: row.cellIdentifier)
    }
}
