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
        var mockEndpoint: MockEndpoint!
        
        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
            logger = TestLogger()
            mockService = MockNetworking(scheduler, logger)
            mockEndpoint = MockEndpoint(parameters: "\(262183162)")
            sut = APIClient(networkService: mockService)
        }
        
        afterEach {
            logger = nil
            scheduler = nil
            mockService = nil
            mockEndpoint = nil
            sut = nil
        }
        
        it("Should make the Networking call when requested") {
            _ = scheduler.record(source: sut.request(mockEndpoint))
            scheduler.start()
            let functionName = "request(path:httpMethod:parameters:)"
            expect(logger).to(haveEntry(for: functionName, at: 0))
        }
        
        it("It make the Networking call when requested") {
            _ = scheduler.record(source: sut.request(mockEndpoint))
            scheduler.start()
            let path = "svc/a"
            let parameter = "262183162"
            let functionName = "request(path:httpMethod:parameters:)"
            expect(logger).to(haveEntry(for: functionName, at: 0, with: path, parameter))
        }
    }
}


class MockNetworking: BaseMock, Networking {
    func request(path: String, httpMethod method: HTTPMethod, parameters: NetworkParams?) -> Observable<NetworkResponse> {
        logger.entry(path, parameters)
        return scheduler.just(Data()).asObservable()
    }
}

extension String: Response {}

struct MockEndpoint: Resource {
    typealias Response = ResponseArray<String>
    
    var path: String { return "svc/a" }
    var method: HTTPMethod { return HTTPMethod.GET }
    var parameters: String?
    
    init(parameters: String?) {
        self.parameters = parameters
    }
    
    func parse(networkResponse response: NetworkResponse) throws -> ResponseArray<String> {
        return ResponseArray(content: [])
    }
}

