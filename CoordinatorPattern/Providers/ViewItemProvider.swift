//
//  ViewItemProvider.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 31.05.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa

final class ViewItemProvider: ViewItemProviderType {
    
    let items: Observable<[ViewItemCellViewModelType]>
    let isFetching: Observable<Bool>
    let sink: AnyObserver<String>
    
    private let _fetchingActivity = ActivityIndicator()
    private let _listingIdSink = ReplaySubject<String>.create(bufferSize: 1)
    
    init(_ client: ViewItemAPI) {
        
        self.items = _listingIdSink
            .flatMap(client.fetchViewItems(with:))
            .map { $0.map { ViewItemCellViewModel($0) } }
            .trackActivity(_fetchingActivity)
            .share(replay: 1)
        
        self.isFetching = _fetchingActivity.asObservable()
        self.sink = _listingIdSink.asObserver()
    }
}
