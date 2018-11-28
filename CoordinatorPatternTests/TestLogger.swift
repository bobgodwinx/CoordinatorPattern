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
