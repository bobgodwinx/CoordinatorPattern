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
    }
}
