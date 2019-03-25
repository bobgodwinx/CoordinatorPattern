//
//  ImageSeceneViewModelSpecs.swift
//  CoordinatorPatternTests
//
//  Created by Bob Godwin Obi on 21.03.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import UIKit
import Quick
import Nimble
import RxTest
import RxSwift
import RxCocoa
@testable import CoordinatorPattern

class ImageSeceneViewModelSpecs: QuickSpec {
    override func spec() {
        var sut: ImageSceneViewModel!
        var mockViewItemCellViewModel: MockViewItemCellViewModel!
        var row: ViewItemRow!
        var scheduler: TestScheduler!
        
        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
            mockViewItemCellViewModel = MockViewItemCellViewModel(scheduler)
            row = ViewItemRow(mockViewItemCellViewModel)
            sut = ImageSceneViewModel(row)
        }
        
        afterEach {
            scheduler = nil
            mockViewItemCellViewModel = nil
            row = nil
            sut = nil
        }
        
        describe("ImageScene ViewModel") {
            it("image url should be a Type of `URL.self`") {
                /// observe events
                let recoredEvent = scheduler.record(source: sut.imageURL)
                /// start our scheduler
                scheduler.start()
                let url = recoredEvent.events.first!.value.element!
                /// assert the result
                expect(url).to(beAKindOf(URL.self))
            }
            
            it("image url string should not be empty") {
                /// observe events
                let recoredEvent = scheduler.record(source: sut.imageURL)
                /// start our scheduler
                scheduler.start()
                let url = recoredEvent.events.first!.value.element!
                /// assert the result
                expect(url?.absoluteString).toNot(beNil())
            }
            
            it("image url string should match the string we provided"){
                /// observe events
                let recoredEvent = scheduler.record(source: sut.imageURL)
                /// start our scheduler
                scheduler.start()
                let urlString = "https://i.ebayimg.com/00/s/NzY4WDEwMjQ=/z/Z-QAAOSwjfpcHOSV/$_27.jpg"
                let url = recoredEvent.events.first!.value.element!
                /// assert the result
                expect(url?.absoluteString) == urlString
            }
            
            it("image url string should have the correct suffix `$_27.jpg`"){
                /// observe events
                let recoredEvent = scheduler.record(source: sut.imageURL)
                /// start our scheduler
                scheduler.start()
                let suffix = "$_27.jpg"
                let url = recoredEvent.events.first!.value.element!
                /// assert the result
                expect(url?.absoluteString.hasSuffix(suffix)).to(beTrue())
            }
        }
    }
}


class MockViewItemCellViewModel: BaseMock, ViewItemCellViewModelType {
    
    var thumbnailURL: Driver<URL?> {
        let urlString = "https://i.ebayimg.com/00/s/NzY4WDEwMjQ=/z/Z-QAAOSwjfpcHOSV/$_2.jpg"
        let url = URL(string: urlString)
        return scheduler.just(url).asDriver(onErrorJustReturn: url)
    }
    
    var imageURL: URL? {
        let urlString = "https://i.ebayimg.com/00/s/NzY4WDEwMjQ=/z/Z-QAAOSwjfpcHOSV/$_27.jpg"
        return URL(string: urlString)
    }
}
