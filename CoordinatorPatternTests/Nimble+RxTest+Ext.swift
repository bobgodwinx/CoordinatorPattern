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

public extension Nimble.Expectation {
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
    
    func matchNext<T>(_ matcher: @escaping ([Recorded<Event<T>>]) -> PredicateResult) -> Predicate<TestableObserver<T>> {
        return Predicate {actual in
            guard let source = try actual.evaluate() else {
                return PredicateResult.evaluationFailed
            }
            
            let nextEvents = source.events.filter { $0.value.element != nil }
            guard !nextEvents.isEmpty else {
                return PredicateResult.emptyNextEvents
            }
            return matcher(nextEvents)
        }
    }
    
    func matchFirstNext<T>(_ matcher: @escaping (T) -> PredicateResult) -> Predicate<TestableObserver<T>> {
        return matchNext {events in
            guard let element = events.first?.value.element else {
                return PredicateResult.emptyNextEvents
            }
            return matcher(element)
        }
    }
    
    func matchFirstNext<T>(_ matcher: @escaping ([T]) -> PredicateResult) -> Predicate<TestableObserver<[T]>> {
        return matchNext { events in
            guard let value = events.first?.value.element else {
                return PredicateResult.emptyNextEvents
            }
            return matcher(value)
        }
    }
    
    func matchError<T>(_ matcher: @escaping (Recorded<Event<T>>) -> PredicateResult) -> Predicate<TestableObserver<T>> {
        return Predicate {actual in
            guard let source = try actual.evaluate() else {
                return PredicateResult.evaluationFailed
            }
            let errorEvents = source.events.filter { $0.value.isError }
            guard let error = errorEvents.first else {
                return PredicateResult(bool: false, message: .fail("did not error"))
            }
            return matcher(error)
        }
    }
    
    func error<T>() -> Predicate<TestableObserver<T>> {
        return matchError {_ in PredicateResult(bool: true, message: .fail("did not error")) }
    }
    
    func error<T>(at expectedTime: TestTime) -> Predicate<TestableObserver<T>> {
        return matchError {
            PredicateResult(bool: $0.time == expectedTime,
                            message: .expectedCustomValueTo("error @ <\(expectedTime)>", "@ <\($0.time)>"))
        }
    }
    
    func error<T, E: Error>(with expectedError: E) -> Predicate<TestableObserver<T>> where E: Equatable {
        return matchError {
            let actualError = $0.value.error
            return PredicateResult(bool: actualError?.is(expectedError) ?? false,
                                   message: .expectedCustomValueTo("error <\(expectedError)>", "<\(actualError.asString())>"))
        }
    }
}
