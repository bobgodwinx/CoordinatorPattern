//
//  ViewItemProviderSpecBehavior.swift
//  CoordinatorPatternTests
//
//  Created by Bob Godwin Obi on 19.02.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxTest
import RxSwift
import RxCocoa
@testable import CoordinatorPattern

struct ViewItemProviderContext {
    let sut: ViewItemProvider
    let scheduler: TestScheduler
    let logger: TestLogger
}


class ViewItemProviderSpecBehavior: Quick.Behavior<ViewItemProviderContext> {
    override class func spec(_ context: @escaping () -> ViewItemProviderContext ) {
        var sut: ViewItemProvider!
        var scheduler: TestScheduler!
        var logger: TestLogger!
        
        beforeEach {
            let cxt = context()
            sut = cxt.sut
            scheduler = cxt.scheduler
            logger = cxt.logger
        }
        
        afterEach {
            sut = nil
            scheduler = nil
            logger = nil
        }
        
        it("Should return an Array of ViewItemCellViewModelType") {
            SharingScheduler.mock(scheduler: scheduler) {
                /// trigger a call
                scheduler.drive(sut.sink, with: [Recorded.next(0, "262183162")])
                /// observe events
                let recoredEvent = scheduler.record(source: sut.items)
                /// start our scheduler
                scheduler.start()
                let items = recoredEvent.events.first!.value.element!
                /// assert the result
                expect(items).to(beAKindOf(Array<ViewItemCellViewModelType>.self))
            }
        }
        
        it("Should return an Array the is not empty()") {
            SharingScheduler.mock(scheduler: scheduler) {
                /// trigger a call
                scheduler.drive(sut.sink, with: [Recorded.next(0, "262183162")])
                /// observe events
                let recoredEvent = scheduler.record(source: sut.items)
                /// start our scheduler
                scheduler.start()
                let items = recoredEvent.events.first!.value.element!
                /// assert the result
                expect(items.isEmpty).to(beFalse())
            }
        }
        
        it("Should return an Array with count that equals 14") {
            SharingScheduler.mock(scheduler: scheduler) {
                /// trigger a call
                scheduler.drive(sut.sink, with: [Recorded.next(0, "262183162")])
                /// observe events
                let recoredEvent = scheduler.record(source: sut.items)
                /// start our scheduler
                scheduler.start()
                let items = recoredEvent.events.first!.value.element!
                /// assert the result
                expect(items.count).to(equal(14))
            }
        }
        
        it("Should have zero event when there is no given-id ") {
            SharingScheduler.mock(scheduler: scheduler) {
                let recoredEvent = scheduler.record(source: sut.items)
                /// start our scheduler
                scheduler.start()
                /// assert the result
                expect(recoredEvent.events.count).to(equal(0))
            }
        }
        
        it("Should call `fetchViewItems(with:)` function with the correct given-id") {
            SharingScheduler.mock(scheduler: scheduler) {
                /// trigger a call
                scheduler.drive(sut.sink, with: [Recorded.next(0, "262183162")])
                _ = scheduler.record(source: sut.items)
                scheduler.start()
                /// assert the result
                expect(logger).to(haveEntry(for: "fetchViewItems(with:)", with: "262183162"))
            }
        }
        
    }
}
