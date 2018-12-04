//
//  Foundation+Ext.swift
//  CoordinatorPatternTests
//
//  Created by Bob Godwin Obi on 04.12.18.
//  Copyright © 2018 Bob Godwin Obi. All rights reserved.
//

import Foundation

extension Optional {
    /// Returns a debug description of an optional value
    /// - returns: String describing the element value if not nil.
    /// Otherwise, returns "nil"
    func asString() -> String {
        guard let s = self else { return "nil" }
        return String(describing: s)
    }
}

extension Optional where Wrapped: Equatable {
    func match(_ another: Wrapped) -> Bool {
        guard self != nil else {
            return true
        }
        return self == another
    }
}

extension Swift.Error {
    func `is`<E: Swift.Error>(_ another: E) -> Bool where E: Equatable {
        guard let err = self as? E else { return false }
        return err == another
    }
}

extension String {
    func match(pattern regex: String) -> Bool {
        return range(of: regex, options: .regularExpression) != nil
    }
}
