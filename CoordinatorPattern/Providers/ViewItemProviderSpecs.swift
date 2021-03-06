//
//  ViewItemProviderSpecs.swift
//  CoordinatorPatternTests
//
//  Created by Bob Godwin Obi on 18.02.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxTest
import RxSwift
import RxCocoa
@testable import CoordinatorPattern

class ViewItemProviderSpecs: QuickSpec {
    override func spec() {
        
        var sut: ViewItemProvider!
        var mockAPI: MockAPIClient!
        var logger: TestLogger!
        var scheduler: TestScheduler!
        
        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
            logger = TestLogger()
            mockAPI = MockAPIClient(scheduler, logger)
            sut = ViewItemProvider(mockAPI)
        }
        
        afterEach {
            sut = nil
            mockAPI = nil
            logger = nil
            scheduler = nil
        }
        
        itBehavesLike(ViewItemProviderSpecBehavior.self) {
            ViewItemProviderContext(sut: sut, scheduler: scheduler, logger: logger)
        }
    }
}

class MockAPIClient: BaseMock, ViewItemAPI {
    
    func fetchViewItems(with id: String) -> Observable<[ViewItem]> {
        logger.entry(id)
        
        return scheduler
            .createColdObservable([Recorded.next(10, dummyData())])
            .asObservable()
    }
}

func dummyData() -> [ViewItem] {
    let path = Bundle.main.path(forResource: "dummyData", ofType: "json")!
    let data = try! Data(contentsOf: URL(fileURLWithPath: path))
    let decoder = JSONDecoder()
    
    let items = try! decoder.decode(ItemContainer.self, from: data)
    return items.images
}
