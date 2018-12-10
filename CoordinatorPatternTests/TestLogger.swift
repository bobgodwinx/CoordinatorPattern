//
//  TestLogger.swift
//  CoordinatorPatternTests
//
//  Created by Bob Godwin Obi on 28.11.18.
//  Copyright © 2018 Bob Godwin Obi. All rights reserved.
//

import Foundation
import Nimble

protocol Parameter {
    func equal(_ another: Parameter) -> Bool
}

extension Parameter where Self: Equatable {
    func equal(_ another: Parameter) -> Bool {
        guard let obj = another as? Self else { return false }
        return obj == self
    }
}

/// A type-erased parameter.
struct AnyParameter: Parameter {
    private let value: Any
    init(_ value: Any) {
        self.value = value
    }
    
    func equal(_ another: Parameter) -> Bool {
        guard let me = value as? Parameter else { return false }
        return another.equal(me)
    }
}

//MARK: Extensions
extension Dictionary: Parameter {
    func equal(_ another: Parameter) -> Bool {
        guard let obj = another as? Dictionary else { return false }
        return NSDictionary(dictionary: obj).isEqual(to: self)
    }
}
extension URLRequest: Parameter {}
extension String: Parameter {}

class TestLogger {
    
    struct Call {
        let parameters: [Parameter?]
        let name: String
        let time: Int
    }
    
    private var clock: Int = 0
    fileprivate var logBook: [Call] = []
    
    func entry(_ args: Parameter?..., functionName: String = #function) {
        defer {
            clock += 1
        }
        let call = Call(parameters: args, name: functionName, time: clock)
        logBook.append(call)
    }
    
    func calls(for functionName: String, at: Int? = nil) -> [Call] {
        let all = logBook.filter { $0.name == functionName }
        guard let clock = at else {
            return all
        }
        return all.filter { $0.time == clock }
    }
}

func haveEntry(for functionName: String, at time: Int? = nil) -> Predicate<TestLogger> {
    return haveEntry(for: functionName, at: time, with: [])
}

func haveEntry(for functionname: String, at time: Int? = nil, with args: Parameter?...) -> Predicate<TestLogger> {
    return haveEntry(for: functionname, at: time, with: args)
}

func haveEntry(for functionName: String, at time: Int? = nil, with args: [Parameter?]) -> Predicate<TestLogger> {
    return Predicate { actual in
        guard let logger = try actual.evaluate() else {
            return PredicateResult.evaluationFailed
        }
        let matchingCalls = logger.logBook.filter {
            $0.name == functionName
        }
        guard !matchingCalls.isEmpty else {
            return PredicateResult(bool: false,
                                   message: .expectedTo("call <\(functionName)>"))
        }
        let aCall: TestLogger.Call?
        if let t = time {
            aCall = matchingCalls.filter { $0.time == t }.first
        }
        else {
            aCall = matchingCalls.first
        }
        guard let call = aCall else {
            return PredicateResult(bool: false,
                                   message: .expectedTo("call at <\(time.asString())>"))
        }
        // Match parameters
        guard !args.isEmpty else { return PredicateResult(bool: true, message: .fail("match function call")) }
        guard args.count == call.parameters.count else {
            return PredicateResult(bool: false, message: .expectedTo("match parameters"))
        }
        func match(_ lhs: Parameter?, _ rhs: Parameter?) -> Bool {
            switch (lhs, rhs) {
            case (nil, nil): return true
            case (nil, _), (_, nil):
                return false
            default:
                guard lhs!.equal(rhs!) else { return false }
                return true
            }
        }
        for (lhs, rhs) in zip(call.parameters, args) {
            guard match(lhs, rhs) else {
                return PredicateResult(bool: false,
                                       message: .expectedCustomValueTo("call <\(functionName)> with [\(rhs.asString())]", "[\(lhs.asString())]"))
            }
            continue
        }
        return PredicateResult(bool: true, message: .fail("match call"))
    }
}

func ==(lhs: Expectation<Parameter>, rhs: Parameter) {
    lhs.to { actualExpression, failureMessage in
        guard let parameter = try actualExpression.evaluate() else {
            failureMessage.stringValue = "failed to evaluate expression"
            return false
        }
        failureMessage.postfixMessage = "match <\(rhs)>"
        failureMessage.actualValue = "<\(parameter)>"
        return parameter.equal(rhs)
    }
}
