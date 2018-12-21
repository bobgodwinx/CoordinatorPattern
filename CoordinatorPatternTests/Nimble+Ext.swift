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
    
    static var emptyNextEvents: PredicateResult {
        return PredicateResult(bool: false, message: .fail("events were empty"))
    }
    
    static var expectedToError: PredicateResult {
        return PredicateResult(bool: false, message: .fail("did not error"))
    }
    
    static var erroredAsExpected: PredicateResult {
        return PredicateResult(bool: true, message: .fail("did error as expected"))
    }
}

extension Expectation {
    func transform<U>(_ closure: @escaping (T?) throws -> U?) -> Expectation<U> {
        let exp = expression.cast(closure)
        return Expectation<U>(expression: exp)
    }
}

func equalNil<T>() -> Predicate<T?> {
    return Predicate {actual in
        guard let value = try actual.evaluate() else {
            return PredicateResult.evaluationFailed
        }
        return PredicateResult(bool: value == nil,
                               message: .expectedActualValueTo("equal <nil>"))
    }
}

func == (lhs: Expectation<[String: Any]>, rhs: [String: Any]) {
    lhs.to(Predicate { actual in
        guard let dict = try actual.evaluate() else {
            return PredicateResult.evaluationFailed
        }
        let nsDict = NSDictionary(dictionary: dict)
        return PredicateResult(bool: nsDict.isEqual(to: rhs),
                               message: .expectedCustomValueTo(String(describing: rhs), String(describing: nsDict)))
    })
}

func match<T: Equatable>(_ expectedValue: T) -> Predicate<T?> {
    return Predicate { actual in
        guard let value = try actual.evaluate() else {
            return PredicateResult.evaluationFailed
        }
        return PredicateResult(bool: value == expectedValue,
                               message: .expectedCustomValueTo("match <\(expectedValue)>", "<\(value.asString())>"))
    }
}
