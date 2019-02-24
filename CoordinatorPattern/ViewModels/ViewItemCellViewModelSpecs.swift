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
    }
}
