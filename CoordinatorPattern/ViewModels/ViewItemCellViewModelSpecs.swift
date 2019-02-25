//
//  ViewItemCellViewModelSpecs.swift
//  CoordinatorPatternTests
//
//  Created by Bob Godwin Obi on 24.02.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import Foundation
import XCTest
import Quick
import Nimble
import RxTest
import RxSwift
import RxCocoa
@testable import CoordinatorPattern

class ViewItemCellViewModelSpecs: QuickSpec {
    override func spec() {
        
        var sut: ViewItemCellViewModel!
        var viewItem: ViewItem!
        var scheduler: TestScheduler!
        
        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
            viewItem = dummyData()[0]
            sut = ViewItemCellViewModel(viewItem)
        }
        
        afterEach {
            scheduler = nil
            viewItem = nil
            sut = nil
        }
        
        describe("imageURL") {
            it("should not be empty") {
                expect(sut.imageURL).toNot(beNil())
            }
            
            it("should be a Type of `URL.self`") {
                expect(sut.imageURL).to(beAKindOf(URL.self))
            }
            
            it("absoluteString should match the string we provided"){
                let urlString = "https://i.ebayimg.com/00/s/NzY4WDEwMjQ=/z/Z-QAAOSwjfpcHOSV/$_27.jpg"
                /// assert the result
                expect(sut.imageURL?.absoluteString) == urlString
            }
            
            it("absoluteString should not have thumbnailURL suffix `$_2.jpg`"){
                let suffix = "$_2.jpg"
                /// assert the result
                expect(sut.imageURL?.absoluteString.hasSuffix(suffix)).to(beFalse())
            }
            
            it("absoluteString should have the correct suffix `$_27.jpg`"){
                let suffix = "$_27.jpg"
                /// assert the result
                expect(sut.imageURL?.absoluteString.hasSuffix(suffix)).to(beTrue())
            }
        }
        
        describe("thumbnailURL") {
            
            it("should be a Type of `URL.self`") {
                /// observe events
                let recordedEvent = scheduler.record(source: sut.thumbnailURL)
                /// start our scheduler
                scheduler.start()
                let url = recordedEvent.events.first!.value.element!
                /// assert the result
                expect(url).to(beAKindOf(URL.self))
            }
            
            it("should not be empty") {
                /// observe events
                let recordedEvent = scheduler.record(source: sut.thumbnailURL)
                /// start our scheduler
                scheduler.start()
                let url = recordedEvent.events.first!.value.element!
                /// assert the result
                expect(url?.absoluteString).toNot(beNil())
            }
            
            it("absoluteString should match the string we provided"){
                /// observe events
                let recordedEvent = scheduler.record(source: sut.thumbnailURL)
                /// start our scheduler
                scheduler.start()
                let urlString = "https://i.ebayimg.com/00/s/NzY4WDEwMjQ=/z/Z-QAAOSwjfpcHOSV/$_2.jpg"
                let url = recordedEvent.events.first!.value.element!
                /// assert the result
                expect(url?.absoluteString) == urlString
            }
            
            it("absoluteString should not have imageURL suffix `$_27.jpg`"){
                /// observe events
                let recordedEvent = scheduler.record(source: sut.thumbnailURL)
                /// start our scheduler
                scheduler.start()
                let suffix = "$_27.jpg"
                let url = recordedEvent.events.first!.value.element!
                /// assert the result
                expect(url?.absoluteString.hasSuffix(suffix)).to(beFalse())
            }
            
            it("absoluteString should have the correct suffix `$_2.jpg`"){
                /// observe events
                let recordedEvent = scheduler.record(source: sut.thumbnailURL)
                /// start our scheduler
                scheduler.start()
                let suffix = "$_2.jpg"
                let url = recordedEvent.events.first!.value.element!
                /// assert the result
                expect(url?.absoluteString.hasSuffix(suffix)).to(beTrue())
            }
        }
    }
}
