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
