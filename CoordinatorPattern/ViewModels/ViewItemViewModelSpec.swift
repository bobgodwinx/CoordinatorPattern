//
//  ViewItemViewModelSpec.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 17.03.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxTest
import RxSwift
import RxCocoa
@testable import CoordinatorPattern

class ViewItemViewModelSpec: QuickSpec {
    
    override func spec() {
        var sut: ViewItemViewModel!
        var mockViewItemProvider: MockViewItemProvider!
        var scheduler: TestScheduler!
        
        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
            mockViewItemProvider = MockViewItemProvider(scheduler)
            sut = ViewItemViewModel(mockViewItemProvider)
        }
        
        afterEach {
            scheduler = nil
            mockViewItemProvider = nil
            sut = nil
        }
    }
}


class MockViewItemProvider: BaseMock, ViewItemProviderType {
    
    lazy var sinkEvents = scheduler.createObserver(String.self)
    
    var items: Observable<[ViewItemCellViewModelType]> {
        let _items = dummyData().map { ViewItemCellViewModel($0) }
        return scheduler.just(_items).asObservable()
    }
    
    var isFetching: Observable<Bool> {
        return scheduler
            .createColdObservable([Recorded.next(0, false),
                                   Recorded.next(10, true),
                                   Recorded.next(20, false)])
            .asObservable()
    }
    
    var sink: AnyObserver<String> {
        return sinkEvents.asObserver()
    }
}
