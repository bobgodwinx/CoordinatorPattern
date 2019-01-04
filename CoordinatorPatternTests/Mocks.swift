//
//  Mocks.swift
//  CoordinatorPatternTests
//
//  Created by Bob Godwin Obi on 03.01.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import UIKit
import XCTest
import Quick
import Nimble
import RxTest
import RxSwift
@testable import CoordinatorPattern

class BaseMock {
    
    let scheduler: TestScheduler
    let logger: TestLogger
    
    init(_ scheduler: TestScheduler, _ logger: TestLogger = TestLogger()) {
        self.scheduler = scheduler
        self.logger = logger
    }
}

//MARK: Mock - URLSessionType
class MockURLSession:BaseMock, URLSessionType {
    var request: URLRequest? = nil
    
    var data: Data = Data()
    var headerFields: [String: String]? = nil
    var statusCode: Int = 200
    var sessionError: Swift.Error? = nil
    
    func response(for request: URLRequest) -> Observable<DataTaskResponseType> {
        self.request = request
        let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: headerFields)!
        
        if let error = sessionError {
            return scheduler.error(error).asObservable()
        }
        logger.entry(request)
        return scheduler.just((response, data)).asObservable()
    }
}
