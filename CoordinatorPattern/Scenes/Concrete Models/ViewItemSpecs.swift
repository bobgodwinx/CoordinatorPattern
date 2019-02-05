//
//  ViewItemSpecs.swift
//  CoordinatorPatternTests
//
//  Created by Bob Godwin Obi on 05.02.19.
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

class ViewItemSpecs: QuickSpec {
    override func spec() {
        var data: Data!
        var JSONSting: String!
        
        beforeEach {
            JSONSting = """
                {
                    "images": [
                    {
                    "uri": "i.ebayimg.com/00/s/NzY4WDEwMjQ=/z/Z-QAAOSwjfpcHOSV/$",
                    "set": "fe4cfedffdffffffff"
                    }
                    ]
                }
            """
            data = JSONSting.data(using: .utf8)
        }
        
        afterEach {
            data = nil
            JSONSting = nil
        }
        
        it("Contains a valid ViewItem Model Container") {
            let decoder = JSONDecoder()
            let items = try! decoder.decode(ItemContainer.self, from: data)
            expect(items.images).to(beAKindOf(Array<ViewItem>.self))
        }
        
        it("Decoded the image property correctly") {
            let decoder = JSONDecoder()
            let items = try! decoder.decode(ItemContainer.self, from: data)
            let viewItem = items.images[0]
            let expectedString = "https://i.ebayimg.com/00/s/NzY4WDEwMjQ=/z/Z-QAAOSwjfpcHOSV/$_27.jpg"
            expect(viewItem.image).to(equal(expectedString))
        }
        
        it("Decoded the thumbnail property correctly") {
            let decoder = JSONDecoder()
            let items = try! decoder.decode(ItemContainer.self, from: data)
            let viewItem = items.images[0]
            let expectedString = "https://i.ebayimg.com/00/s/NzY4WDEwMjQ=/z/Z-QAAOSwjfpcHOSV/$_2.jpg"
            expect(viewItem.thumbnail).to(equal(expectedString))
        }
    }
}
