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
        //let nib = UINib(nibName: row.nibName, bundle: nil)
        //register(nib, forCellWithReuseIdentifier: row.cellIdentifier)
        
        //TODO: Cleanup hardcoded `ViewItemCell.self`
        register(ViewItemCell.self, forCellWithReuseIdentifier: row.cellIdentifier)
    }
}

/// `CollectionDatasource` conforms to `RxCollectionViewDataSource` requirements
class CollectionDatasource: NSObject, UICollectionViewDataSource, RxCollectionViewDataSourceType, SectionedViewDataSourceType {
    typealias Element = [CollectionRow]
    
    private var _model: [CollectionRow] = []
    
    func model(at indexPath: IndexPath) throws -> Any {
        return _model[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, observedEvent: Event<[CollectionRow]>) {
        Binder(self) {datasource, items in
            datasource._model = items
            collectionView.reloadData()
            /// This is to avoid stale data
            /// on some cells even after
            /// calling reloadData or the
            /// collectionView phenomenon of flash
            /// on screen which is because adding cells
            /// is in the layoutSubviews method.
            collectionView.setNeedsLayout()
            collectionView.layoutIfNeeded()
            }
            .on(observedEvent)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = _model[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellId, for: indexPath)
        item.configureCell(cell)
        return cell
    }
}
