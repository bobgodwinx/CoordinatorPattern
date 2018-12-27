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
    /// Todo: implement a `MockURLSession`
    let session: MockURLSession
}
