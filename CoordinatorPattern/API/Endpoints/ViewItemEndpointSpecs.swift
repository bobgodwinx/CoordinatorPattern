//
//  ViewItemEndpointSpecs.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 08.02.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxTest
import RxSwift
import RxCocoa
@testable import CoordinatorPattern

class ViewItemEndpointSpecs: QuickSpec {
    override func spec() {
        var sut: ViewItemEndpoint!
        
        beforeEach {
            sut = ViewItemEndpoint(parameters: "262183162")
        }
        
        afterEach {
            sut = nil
        }
        
        it("Should have the correct path") {
            let path = "svc/a"
            expect(sut.path).to(equal(path))
        }
        
        it("Should have the correct parameters") {
            let param = "262183162"
            expect(sut.parameters).to(equal(param))
        }
        
        it("Should have the correct HTTPMethod.GET") {
            let method = HTTPMethod.GET
            expect(sut.method).to(equal(method))
        }
    }
}
