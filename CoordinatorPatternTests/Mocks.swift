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

extension Expectation where T == MockURLSession {
    var requestHeaders: Expectation<[String: String]> {
        return transform { session in
            session?.request?.allHTTPHeaderFields
        }
    }
    var requestMethod: Expectation<String> {
        return transform { session in
            session?.request?.httpMethod
        }
    }
    var requestURL: Expectation<String> {
        return transform { session in
            session?.request?.url?.absoluteString
        }
    }
    var urlComponents: Expectation<[String]> {
        return transform { session in
            session?.request?.url?.pathComponents
        }
    }
    var requestBody: Expectation<[String: Any]> {
        return transform { session in
            guard let body = session?.request?.httpBody else {
                return nil
            }
            return try JSONSerialization.jsonObject(with: body, options: .allowFragments) as? [String: Any]
        }
    }
}
