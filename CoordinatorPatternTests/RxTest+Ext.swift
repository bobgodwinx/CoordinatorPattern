//
//  RxTest+Ext.swift
//  CoordinatorPatternTests
//
//  Created by Bob Godwin Obi on 13.12.18.
//  Copyright © 2018 Bob Godwin Obi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxSwift
import RxTest

extension Event {
    /// Sequence terminated with an error.
    /// case error(Swift.Error)
    /// on an Observable Sequence
    var isError: Bool {
        switch self {
        case .error: return true
        default: return false
        }
    }
}
