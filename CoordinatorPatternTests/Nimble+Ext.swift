//
//  Nimble+Ext.swift
//  CoordinatorPatternTests
//
//  Created by Bob Godwin Obi on 04.12.18.
//  Copyright © 2018 Bob Godwin Obi. All rights reserved.
//

import Nimble

extension PredicateResult {
    static var evaluationFailed: PredicateResult {
        return PredicateResult(status: .fail, message: .fail("failed to evaluate expression"))
    }
    
    static func isEqual<T: Equatable>(actual: T?, expected: T?) -> PredicateResult {
        return PredicateResult(bool: actual == expected,
                               message: .expectedCustomValueTo("get <\(expected.asString())>", "<\(actual.asString())>"))
    }
    
    static var notEnoughNextEvents: PredicateResult {
        return PredicateResult(bool: false, message: .fail("did not get enough next events"))
    }
}
