//
//  NetworkServiceSpecBehavior.swift
//  CoordinatorPatternTests
//
//  Created by Bob Godwin Obi on 27.12.18.
//  Copyright © 2018 Bob Godwin Obi. All rights reserved.
//

import Foundation
import XCTest
import Quick
import Nimble
import RxTest
import RxSwift
import RxCocoa
@testable import CoordinatorPattern

struct NetworkServiceContext {
    let sut: NetworkService
    let scheduler: TestScheduler
    let logger: TestLogger
    let session: MockURLSession
}

class NetworkServiceSpecBehavior: Quick.Behavior<NetworkServiceContext> {
    override class func spec(_ aContext: @escaping () ->NetworkServiceContext) {
        var sut: NetworkService!
        var scheduler: TestScheduler!
        var logger: TestLogger!
        var session: MockURLSession!
        var request: Observable<NetworkResponse>!
        var response: TestableObserver<NetworkResponse>!
        
        beforeEach {
            let cxt = aContext()
            scheduler = cxt.scheduler
            logger = cxt.logger
            session = cxt.session
            sut = cxt.sut
        }
        
        afterEach {
            scheduler = nil
            logger = nil
            session = nil
            sut = nil
            request = nil
        }
        
        /// We're going to be using a dummy data from ebay
        /// most especially the m.mobile.de which is really
        /// a fast API to just get images of a specific car
        /// listing. I used this API a lot this is why I know
        /// almost everything behind the scene. However I
        /// change it later to gitHub API in the future.
        /// but for now we use this:
        /// https://m.mobile.de/svc/a/262183162
        
        describe("GET") {
            it("set HTTP method") {
                request = sut.request(path: "262183162", httpMethod: .GET, parameters: nil)
                _ = scheduler.record(source: request)
                scheduler.start()
                expect(session).requestMethod.to(match(HTTPMethod.GET.rawValue))
            }
            
            it("append URL encoded, if has parameters") {
                let parameters = "262183162"
                request = sut.request(path: "svc/a", httpMethod: .GET, parameters: parameters)
                _ = scheduler.record(source: request)
                scheduler.start()
                let expectedRequestURL = "https://m.mobile.de/svc/a/262183162"
                expect(session).requestURL.to(match(expectedRequestURL) )
            }
            
            it("append nothing, if no parameters") {
                request = sut.request(path: "svc/a", httpMethod: .GET, parameters: nil)
                _ = scheduler.record(source: request)
                scheduler.start()
                let expectedRequestURL = "https://m.mobile.de/svc/a"
                expect(session).requestURL.to(match(expectedRequestURL))
            }
            
            it("contains the expected URLPathComponets") {
                let parameters = "262183162"
                request = sut.request(path: "svc/a", httpMethod: .GET, parameters: parameters)
                _ = scheduler.record(source: request)
                scheduler.start()
                let urlComponents = ["/", "svc", "a", "262183162"]
                let expectedRequestURL = "https://m.mobile.de/svc/a"
                expect(session).requestURL.to(match(expectedRequestURL))
                expect(session).urlComponents == urlComponents
            }
            
            it("contains no body") {
                request = sut.request(path: "262183162", httpMethod: .GET, parameters: nil)
                _ = scheduler.record(source: request)
                scheduler.start()
                expect(session).requestBody.to(beNil())
            }
        }
        
        describe("Call") {
            it("make the urlRequest by calling #function with name") {
                let path = "svc/a"
                let parameter = "262183162"
                let functionName = "response(for:)"
                request = sut.request(path: path, httpMethod: .GET, parameters: parameter)
                _ = scheduler.record(source: request)
                scheduler.start()
                expect(logger).to(haveEntry(for: functionName, at: 0))
            }
        }
        
        describe("Response") {
            
            afterEach {
                response = nil
            }
            
            it("output data") {
                session.data = "hello, World!".data(using: .utf8)!
                request = sut.request(path: "foo", httpMethod: .GET, parameters: nil)
                response = scheduler.record(source: request)
                scheduler.start()
                expect(response).to(match(data: "hello, World!"))
            }
            
            func match(data expectedData: String) -> Predicate<TestableObserver<NetworkResponse>> {
                return matchFirstNext {response in
                    let responseString = String(data: response, encoding: .utf8)
                    return PredicateResult(bool: responseString == expectedData,
                                           message: .expectedCustomValueTo(responseString.asString(), expectedData))
                }
            }
        }
    }
}
