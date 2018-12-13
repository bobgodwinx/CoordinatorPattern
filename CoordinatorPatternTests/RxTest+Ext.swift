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

extension TestScheduler {
    
    /// Builds testable observer for s specific observable sequence,
    /// binds it's results and sets up disposal.
    ///
    /// - parameter source: Observable sequence to observe.
    /// - returns: Observer that records all events for observable sequence.
    func record<O: ObservableConvertibleType>(source: O) -> TestableObserver<O.Element> {
        let observer = self.createObserver(O.Element.self)
        let disposable = source.asObservable().bind(to: observer)
        self.scheduleAt(100000) {
            disposable.dispose()
        }
        return observer
    }
}
