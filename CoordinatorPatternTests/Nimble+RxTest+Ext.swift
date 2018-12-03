//
//  Nimble+RxTest+Ext.swift
//  CoordinatorPatternTests
//
//  Created by Bob Godwin Obi on 03.12.18.
//  Copyright © 2018 Bob Godwin Obi. All rights reserved.
//

import RxSwift
import RxTest
import Nimble

extension Nimble.Expectation {
    func to(_ matcher: (Expression<T>, FailureMessage) throws -> (Bool)) {
        let msg = FailureMessage()
        do {
            let pass = try matcher(expression, msg)
            verify(pass, msg)
        } catch let error {
            msg.actualValue = "an unexpected error thrown: <\(error)>"
            verify(false, msg)
        }
    }
}
