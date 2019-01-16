//
//  NetworkServiceSpecs.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 27.11.18.
//  Copyright © 2018 Bob Godwin Obi. All rights reserved.
//

import XCTest
import Quick
import Nimble
import RxTest
import RxSwift
@testable import CoordinatorPattern

class NetworkServiceSpecs: QuickSpec {
    override func spec() {
        var sut: NetworkService!
        var mockSession: MockURLSession!
        var scheduler: TestScheduler!
        var logger: TestLogger!
        var request: Observable<NetworkResponse>!
        
        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
            logger = TestLogger()
            mockSession = MockURLSession(scheduler, logger)
            sut = NetworkService(baseURLString: "https://m.mobile.de", urlSession: mockSession)
        }
        
        afterEach {
            sut = nil
            mockSession = nil
            scheduler = nil
            logger = nil
        }
        
        itBehavesLike(NetworkServiceSpecBehavior.self) {
            NetworkServiceContext(sut: sut, scheduler: scheduler, logger: logger, session: mockSession)
        }
    }
}


