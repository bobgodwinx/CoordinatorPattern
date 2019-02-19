//
//  ViewItemProviderSpecBehavior.swift
//  CoordinatorPatternTests
//
//  Created by Bob Godwin Obi on 19.02.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxTest
import RxSwift
import RxCocoa
@testable import CoordinatorPattern

struct ViewItemProviderContext {
    let sut: ViewItemProvider
    let scheduler: TestScheduler
    let logger: TestLogger
}


class ViewItemProviderSpecBehavior: Quick.Behavior<ViewItemProviderContext> {
    override class func spec(_ context: @escaping () -> ViewItemProviderContext ) {
        var sut: ViewItemProvider!
        var scheduler: TestScheduler!
        var logger: TestLogger!
        
        beforeEach {
            let cxt = context()
            sut = cxt.sut
            scheduler = cxt.scheduler
            logger = cxt.logger
        }
        
        afterEach {
            sut = nil
            scheduler = nil
            logger = nil
        }
        
    }
}
