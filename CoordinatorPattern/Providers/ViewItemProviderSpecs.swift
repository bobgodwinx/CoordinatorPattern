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
        
        beforeEach {
            /// setup
        }
        
        afterEach {
            /// tear down
        }
    }
}

func dummyData() -> [ViewItem] {
    let path = Bundle.main.path(forResource: "ViewItems", ofType: "json")!
    let data = try! Data(contentsOf: URL(fileURLWithPath: path))
    let decoder = JSONDecoder()
    
    let items = try! decoder.decode(ItemContainer.self, from: data)
    return items.images
}
