//
//  ViewItemViewModel.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 03.03.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ViewItemViewModel: ViewItemViewModelType {
    /// datasource consumed by the
    /// `ViewItemSceneController` UICollectionView
    let datasource: Driver<[CollectionRow]>
    /// init requires a `ViewItemProviderType`
    init(_ provider: ViewItemProviderType) {
        ///This is where the magic happens :-)
        /// we start with a specific ID
        /// in this example. Later we make it
        /// searchable so the user can add
        /// search inputs by themselves. 
        provider.sink.onNext("262183162")
        /// trnasforming `ViewItemCellViewModelType`
        /// into `ViewItemRow`
        datasource = provider
            .items
            .map { viewItems in viewItems.map { ViewItemRow($0) }}
            .asDriver(onErrorJustReturn: [])
    }
}
