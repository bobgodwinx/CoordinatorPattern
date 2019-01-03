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
