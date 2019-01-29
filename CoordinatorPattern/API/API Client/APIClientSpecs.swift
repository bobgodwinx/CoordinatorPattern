//
//  APIClientSpecs.swift
//  CoordinatorPatternTests
//
//  Created by Bob Godwin Obi on 28.01.19.
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

class APIClientSpecs: QuickSpec {
    override func spec() {
        
        var sut: APIClient!
        var logger: TestLogger!
        var scheduler: TestScheduler!
        var mockService: MockNetworking!
        
        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
            logger = TestLogger()
            mockService = MockNetworking(scheduler, logger)
            sut = APIClient(networkService: mockService)
        }
        
        afterEach {
            logger = nil
            scheduler = nil
            mockService = nil
            sut = nil
        }
    }
}


class MockNetworking: BaseMock, Networking {
    func request(path: String, httpMethod method: HTTPMethod, parameters: NetworkParams?) -> Observable<NetworkResponse> {
        logger.entry(path, parameters)
        return scheduler.just(Data()).asObservable()
    }
}
